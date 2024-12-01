using UnityEngine;

namespace SDOC
{
    public unsafe class SDOCMeshOccluder : MonoBehaviour
    {
        public SDOCMeshData m_TargetMesh = null;
        private ushort* m_OccluderMesh = null;

        public ushort* OccluderMesh {
            get {
                return m_OccluderMesh;
            }
        }

        protected void DestroyOccluderMesh() {
            if (m_OccluderMesh == null)
                return;
            m_OccluderMesh = SDOCHelper.sdocMeshBake((int*)m_OccluderMesh, null, null, 0, 0, 0, false, false, 0);
        }

        private void OnApplicationQuit() {
            DestroyOccluderMesh();
        }

        private void OnDestroy() {
            DestroyOccluderMesh();
        }
    }
}
