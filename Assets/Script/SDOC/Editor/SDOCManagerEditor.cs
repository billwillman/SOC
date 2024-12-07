using UnityEditor;
using UnityEngine;

namespace SDOC
{
    [CustomEditor(typeof(SDOCManager))]
    public class SDOCManagerEditor: Editor
    {
        public override void OnInspectorGUI() {
            base.OnInspectorGUI();
            var mgr = this.target as SDOCManager;
            if (mgr == null)
                return;
            if (Application.isPlaying) {
                int width, height;
                mgr.GetDepthWidthAndHeight(out width, out height);
                EditorGUILayout.LabelField("【实例i地址】", mgr.pSDOCInstance.ToString());
                EditorGUILayout.LabelField("【深度图大小】", string.Format("{0:D} x {1:D}", width, height));
                EditorGUILayout.LabelField("【使用内存大小】", mgr.GetUsedMemorySize().ToString());
                if (GUILayout.Button("保存DepthMap")) {
                    string fileName = "depthMap.png";
                    fileName = System.IO.Path.GetFullPath(fileName).Replace("\\", "/");
                    mgr.SaveDetphToFileName(fileName);
                }
            }
        }
    }
}
