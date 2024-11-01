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
        List<Transform> bones = new List<Transform>();
        AddBoneToList(bones, rootNode);
        
        string name = gameObj.name;
        ExportPosition(dir, name, bones);
        ExportRotation(dir, name, bones);
        ExportBoneLink(dir, name, bones);

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
        Vector3[] positions = new Vector3[bones.Count];
        for (int i = 0; i < positions.Length; ++i) {
            positions[i] = bones[i].position;
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

    static void ExportRotation(string dir, string name, List<Transform> bones) {
        string fileName = dir + "/" + name + "_rots.json";
        Vector3[] rotAngles = new Vector3[bones.Count];
        for (int i = 0; i < rotAngles.Length; ++i) {
            rotAngles[i] = bones[i].eulerAngles;
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
}
