using System.Runtime.InteropServices;
using System.IO;
using UnityEngine;
using UnityEditor;

namespace SDOC
{
    public unsafe class SDOCMeshExportWindow : EditorWindow
    {
        [MenuItem("Tools/SDOC Mesh Export")]
        public static void OpenWindow() {
            var wnd = EditorWindow.GetWindow<SDOCMeshExportWindow>();
            wnd.Show();
        }

        private Mesh m_TargetMesh = null;

        private void OnGUI() {
            EditorGUILayout.BeginVertical();
            m_TargetMesh = EditorGUILayout.ObjectField("阻挡Mesh", m_TargetMesh, typeof(Mesh), false) as Mesh;
            if (m_TargetMesh != null) {
                string assetPath = AssetDatabase.GetAssetPath(m_TargetMesh);
                if (string.IsNullOrEmpty(assetPath))
                    return;
                if (GUILayout.Button("生成SDOC Mesh数据")) {
                    Vector3[] verts = m_TargetMesh.vertices;
                    int[] indexs = m_TargetMesh.triangles;
                    float[] targetVertexs = new float[verts.Length * 3];
                    ushort[] targetIndexs = new ushort[indexs.Length];
                    for (int i = 0; i < verts.Length; ++i) {
                        int idx = i * 3;
                        targetVertexs[idx++] = verts[i].x;
                        targetVertexs[idx++] = verts[i].y;
                        targetVertexs[idx++] = verts[i].z;
                    }
                    for (int i = 0; i < indexs.Length; ++i) {
                        targetIndexs[i] = (ushort)indexs[i];
                    }
                    // Unity的MESH是顺时针正面，UE是逆时针正面, 所以counterClockWise=false
                    int outSize;
                    fixed (float* pVert = targetVertexs) {
                        fixed (ushort* pIndex = targetIndexs) {
                            ushort* compressData = SDOCHelper.sdocMeshBake(&outSize, pVert, pIndex, (ushort)targetVertexs.Length, (ushort)targetIndexs.Length, 15, true, false, 0);
                            if (compressData != null && outSize > 0) {
                                SDOCMeshData sdoMeshData = new SDOCMeshData(compressData, outSize);
                                string targetAssetPath = Path.ChangeExtension(assetPath, ".asset");
                                AssetDatabase.CreateAsset(sdoMeshData, targetAssetPath);
                                AssetDatabase.SaveAssets();
                                AssetDatabase.Refresh();
                            }
                        }
                    }
                }
            }
            EditorGUILayout.EndVertical();
        }
    }
}
