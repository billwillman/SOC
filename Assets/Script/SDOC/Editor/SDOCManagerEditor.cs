using UnityEditor;
using UnityEngine;

namespace SDOC
{
    [CustomEditor(typeof(SDOCManager))]
    public class SDOCManagerEditor: Editor
    {
        public override void OnInspectorGUI() {
            base.OnInspectorGUI();
        }
    }
}
