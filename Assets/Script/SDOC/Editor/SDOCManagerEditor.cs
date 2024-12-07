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
                EditorGUILayout.LabelField("【深度图大小】", string.Format("{0:D} x {1:D}", width, height));
                EditorGUILayout.LabelField("【使用内存大小】", mgr.GetUsedMemorySize().ToString());
            }
        }
    }
}
