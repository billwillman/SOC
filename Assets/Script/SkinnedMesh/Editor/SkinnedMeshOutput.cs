using System;
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
    }
}
