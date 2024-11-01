using UnityEngine;
using UnityEditor;

public class SkinnedMeshOutput: Editor
{
    [MenuItem("Assets/SkinnedMesh(AI-FBX)/����AI-FBX��ʽ", validate = true)]
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
    [MenuItem("Assets/SkinnedMesh(AI-FBX)/����AI-FBX��ʽ")]
    public static void Output() {

    }
}
