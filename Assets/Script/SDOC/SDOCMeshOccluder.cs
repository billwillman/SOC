using UnityEngine;

namespace SDOC
{
    public unsafe class SDOCMeshOccluder : MonoBehaviour
    {
        public ScriptableObject m_TargetMesh = null;
        private ushort* m_OccluderMesh = null;

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
