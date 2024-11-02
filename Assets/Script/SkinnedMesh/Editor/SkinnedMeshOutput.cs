using System;
using System.IO;
using System.Collections.Generic;
using UnityEngine;
using UnityEditor;

public class SkinnedMeshOutput: Editor
{
    [MenuItem("Assets/SkinnedMesh(AI-FBX)/导出AI-FBX格式", validate = true)]
    public static bool IsCanOutput() {
        var gameObj = Selection.activeGameObject;
        if (!gameObj)
            return false;
        var objs = Selection.objects;
        if (objs != null && objs.Length >= 2)
            return false;
        if (gameObj.scene.IsValid())
            return false;
        SkinnedMeshRenderer skl = gameObj.GetComponentInChildren<SkinnedMeshRenderer>();
        return skl != null;
    }


    static void AddBoneToList(List<Transform> bones, Transform rootNode) {
        bones.Add(rootNode);
        for (int i = 0; i < rootNode.childCount; ++i) {
            var childNode = rootNode.GetChild(i);
            if (childNode != null)
                AddBoneToList(bones, childNode);
        }
    }

    [MenuItem("Assets/SkinnedMesh(AI-FBX)/导出AI-FBX格式")]
    public static void Output() {
        var gameObj = Selection.activeGameObject;
        if (!gameObj)
            return;
        string dir = AssetDatabase.GetAssetPath(gameObj);
        if (string.IsNullOrEmpty(dir))
            return;
        dir = Path.GetDirectoryName(dir);
        if (string.IsNullOrEmpty(dir))
            return;
        dir = dir.Replace("\\", "/");
        SkinnedMeshRenderer skl = gameObj.GetComponentInChildren<SkinnedMeshRenderer>();
        if (skl == null)
            return;
        var rootNode = skl.rootBone;
        if (rootNode == null)
            return;
        var sklParent = skl.gameObject.transform.parent;
        if (sklParent == null)
            return;
        bool isFound = false;
        while (rootNode != null) {
            if (rootNode.parent == sklParent) {
                isFound = true;
                break;
            }
            if (rootNode.parent == null)
                break;
            rootNode = rootNode.parent;
        }
        if (!isFound)
            return;
        // List<Transform> bones = new List<Transform>(skl.bones);
        List<Transform> bones = new List<Transform>();
        AddBoneToList(bones, rootNode);
        
        string name = gameObj.name;
        ExportPosition(dir, name, bones);
        ExportRotation(dir, name, bones);
        ExportScale(dir, name, bones);
        ExportBoneLink(dir, name, bones);
        ExportBoneVertexWeight(dir, name, bones, skl);

        AssetDatabase.Refresh();
    }

    static void ExportBoneLink(string dir, string name, List<Transform> bones) {
        string fileName = dir + "/" + name + "_parents.json";
        int[] boneLinks = new int[bones.Count];
        for (int i = 0; i < boneLinks.Length; ++i) {
            var bone = bones[i];
            if (bone.parent == null)
                boneLinks[i] = -1;
            else {
                int idx = bones.IndexOf(bone.parent);
                if (idx < 0)
                    boneLinks[i] = -1;
                else
                    boneLinks[i] = idx;
            }
        }
        
        string str = LitJson.JsonMapper.ToJson(boneLinks);
        byte[] buffer = System.Text.Encoding.ASCII.GetBytes(str);
        FileStream stream = new FileStream(fileName, FileMode.Create, FileAccess.Write);
        try {
            stream.Write(buffer, 0, buffer.Length);
        } finally {
            stream.Flush();
            stream.Close();
        }
    }

    static void ExportPosition(string dir, string name, List<Transform> bones) {
        string fileName = dir + "/" + name + "_joints.json";
        List<float[]> positions = new List<float[]>(bones.Count);
        for (int i = 0; i < bones.Count; ++i) {
            float[] vs = new float[3];
            vs[0] = bones[i].localPosition.x;
            vs[1] = bones[i].localPosition.y;
            vs[2] = bones[i].localPosition.z;
            positions.Add(vs);
        }
        string str = LitJson.JsonMapper.ToJson(positions);
        byte[] buffer = System.Text.Encoding.ASCII.GetBytes(str);
        FileStream stream = new FileStream(fileName, FileMode.Create, FileAccess.Write);
        try {
            stream.Write(buffer, 0, buffer.Length);
        } finally {
            stream.Flush();
            stream.Close();
        }
    }

    static void ExportScale(string dir, string name, List<Transform> bones) {
        string fileName = dir + "/" + name + "_scales.json";
        List<float[]> scales = new List<float[]>(bones.Count);
        for (int i = 0; i < bones.Count; ++i) {
            float[] vs = new float[3];
            vs[0] = bones[i].localScale.x;
            vs[1] = bones[i].localScale.y;
            vs[2] = bones[i].localScale.z;
            scales.Add(vs);
        }
        string str = LitJson.JsonMapper.ToJson(scales);
        byte[] buffer = System.Text.Encoding.ASCII.GetBytes(str);
        FileStream stream = new FileStream(fileName, FileMode.Create, FileAccess.Write);
        try {
            stream.Write(buffer, 0, buffer.Length);
        } finally {
            stream.Flush();
            stream.Close();
        }
    }

    static void ExportRotation(string dir, string name, List<Transform> bones) {
        string fileName = dir + "/" + name + "_rots.json";
        List<float[]> rotAngles = new List<float[]>(bones.Count);
        for (int i = 0; i < bones.Count; ++i) {
            float[] vs = new float[3];
            vs[0] = bones[i].localEulerAngles.x;
            vs[1] = bones[i].localEulerAngles.y;
            vs[2] = bones[i].localEulerAngles.z;
            rotAngles.Add(vs);
        }
        string str = LitJson.JsonMapper.ToJson(rotAngles);
        byte[] buffer = System.Text.Encoding.ASCII.GetBytes(str);
        FileStream stream = new FileStream(fileName, FileMode.Create, FileAccess.Write);
        try {
            stream.Write(buffer, 0, buffer.Length);
        } finally {
            stream.Flush();
            stream.Close();
        }
    }

    private static bool IsForceTextMode() {
        return UnityEditor.EditorSettings.serializationMode == SerializationMode.ForceText;
    }

    private static void FileStrReplace(string fileName, string oldStr, string newStr) {
        if (!System.IO.File.Exists(fileName))
            return;
        string str = System.IO.File.ReadAllText(fileName);
        str = str.Replace(oldStr, newStr);
        System.IO.File.WriteAllText(fileName, str);
    }

    static void ExportBoneVertexWeight(string dir, string name, List<Transform> bones, SkinnedMeshRenderer sklRender) {
        if (!IsForceTextMode()) {
            Debug.LogError("序列化方式不是ForceText, 关闭Read/Write方式失败");
            return;
        }
        string metaFileName = dir + "/" + name + ".fbx.meta";
        FileStrReplace(metaFileName, "isReadable: 0", "isReadable: 1");
        AssetDatabase.Refresh();
        try {
            var mesh = sklRender.sharedMesh;
            var boneWeights = mesh.boneWeights;
            var sklBones = sklRender.bones;
            Dictionary<Transform, int> sklBonesToIndexMap = new Dictionary<Transform, int>();
            for (int i = 0; i < sklBones.Length; ++i) {
                var trans = sklBones[i];
                int index = bones.IndexOf(trans);
                sklBonesToIndexMap.Add(trans, index);
            }
            FileStream logStream = new FileStream("vertexWeight.log", FileMode.Create, FileAccess.Write);
            Action<string> writeLog = (string log) =>
            {
                if (string.IsNullOrEmpty(log))
                    return;
                byte[] buffer = System.Text.Encoding.UTF8.GetBytes(log + "\n");
                logStream.Write(buffer, 0, buffer.Length);
                logStream.Flush();
            };
            List<List<float>> arr = new List<List<float>>(bones.Count);
            try {
                for (int boneIdx = 0; boneIdx < bones.Count; ++boneIdx) {
                    List<float> vertexWeightList = new List<float>(boneWeights.Length);
                    arr.Add(vertexWeightList);
                    for (int vertIdx = 0; vertIdx < boneWeights.Length; ++vertIdx) {
                        var boneWeight = boneWeights[vertIdx];
                        var boneIndex0 = sklBonesToIndexMap[sklBones[boneWeight.boneIndex0]];
                        var boneIndex1 = sklBonesToIndexMap[sklBones[boneWeight.boneIndex1]];
                        var boneIndex2 = sklBonesToIndexMap[sklBones[boneWeight.boneIndex2]];
                        var boneIndex3 = sklBonesToIndexMap[sklBones[boneWeight.boneIndex3]];
                        if (MathF.Abs(boneWeight.weight0) >= float.Epsilon && boneIndex0 == boneIdx) {
                            vertexWeightList.Add(boneWeight.weight0);
                            string log = string.Format("boneIndex: {0:D} vertexIndex: {1:D} vertexWeight: {2}", boneIdx, vertIdx, boneWeight.weight0.ToString());
                            Debug.Log(log);
                            writeLog(log);
                        } else if (MathF.Abs(boneWeight.weight1) >= float.Epsilon && boneIndex1 == boneIdx) {
                            vertexWeightList.Add(boneWeight.weight1);
                            string log = string.Format("boneIndex: {0:D} vertexIndex: {1:D} vertexWeight: {2}", boneIdx, vertIdx, boneWeight.weight1.ToString());
                            Debug.Log(log);
                            writeLog(log);
                        } else if (MathF.Abs(boneWeight.weight2) >= float.Epsilon && boneIndex2 == boneIdx) {
                            vertexWeightList.Add(boneWeight.weight2);
                            string log = string.Format("boneIndex: {0:D} vertexIndex: {1:D} vertexWeight: {2}", boneIdx, vertIdx, boneWeight.weight2.ToString());
                            Debug.Log(log);
                            writeLog(log);
                        } else if (MathF.Abs(boneWeight.weight3) >= float.Epsilon && boneIndex3 == boneIdx) {
                            vertexWeightList.Add(boneWeight.weight3);
                            string log = string.Format("boneIndex: {0:D} vertexIndex: {1:D} vertexWeight: {2}", boneIdx, vertIdx, boneWeight.weight3.ToString());
                            Debug.Log(log);
                            writeLog(log);
                        } else {
                            vertexWeightList.Add(0f);
                        }
                    }
                }
            } finally {
                logStream.Flush();
                logStream.Close();
            }
            string fileName = dir + "/" + name + "_mesh.json";
            string str = LitJson.JsonMapper.ToJson(arr);
            byte[] buffer = System.Text.Encoding.ASCII.GetBytes(str);
            FileStream stream = new FileStream(fileName, FileMode.Create, FileAccess.Write);
            try {
                stream.Write(buffer, 0, buffer.Length);
            } finally {
                stream.Flush();
                stream.Close();
            }
        } finally {
            FileStrReplace(metaFileName, "isReadable: 1", "isReadable: 0");
        }
        AssetDatabase.Refresh();
    }
}
