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
                EditorGUILayout.LabelField("�����ͼ��С��", string.Format("{0:D} x {1:D}", width, height));
                EditorGUILayout.LabelField("��ʹ���ڴ��С��", mgr.GetUsedMemorySize().ToString());
            }
        }
    }
}
