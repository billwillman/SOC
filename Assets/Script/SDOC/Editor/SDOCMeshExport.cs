using UnityEngine;
using UnityEditor;

namespace SDOC
{
    public class SDOCMeshExportWindow : EditorWindow
    {
        [MenuItem("Tools/SDOC Mesh Export")]
        public static void OpenWindow() {
            var wnd = EditorWindow.GetWindow<SDOCMeshExportWindow>();
            wnd.Show();
        }

        private Mesh m_TargetMesh = null;

        private void OnGUI() {
            EditorGUILayout.BeginVertical();
            m_TargetMesh = EditorGUILayout.ObjectField("阻挡Mesh", m_TargetMesh, typeof(Mesh), true) as Mesh;
            if (GUILayout.Button("生成SDOC Mesh数据")) {

            }
            EditorGUILayout.EndVertical();
        }
    }
}
