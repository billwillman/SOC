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
                EditorGUILayout.LabelField("��ʵ��i��ַ��", mgr.pSDOCInstance.ToString());
                EditorGUILayout.LabelField("�����ͼ��С��", string.Format("{0:D} x {1:D}", width, height));
                EditorGUILayout.LabelField("��ʹ���ڴ��С��", mgr.GetUsedMemorySize().ToString());
                if (GUILayout.Button("����DepthMap")) {
                    string fileName = "depthMap.png";
                    fileName = System.IO.Path.GetFullPath(fileName).Replace("\\", "/");
                    mgr.SaveDetphToFileName(fileName);
                }
            }
        }
    }
}
