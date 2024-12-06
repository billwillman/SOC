using UnityEngine;

namespace SDOC
{
    public unsafe class SDOCMeshOccluder : MonoBehaviour
    {
        private SDOCMeshData m_TargetMesh = null;
        // ´æ´¢µÄAsset
        public TextAsset m_SDOCMeshAsset = null;

        public SDOCMeshData SDOCMesh {
            get {
                return m_TargetMesh;
            }
            set {
                if (m_TargetMesh == value)
                    return;
                DestroyData();
                m_TargetMesh = value;
                if (m_TargetMesh != null)
                    m_TargetMesh.AddRef();
            }
        }

        public void SDOCRender(void* pSDOCInstance) {
            if (pSDOCInstance == null || m_SDOCMeshAsset == null)
                return;
            if (m_TargetMesh == null && SDOCManager.Instance != null) {
                this.SDOCMesh = SDOCManager.Instance.LoadMeshData(m_SDOCMeshAsset);
            }
            if ((m_TargetMesh == null || !m_TargetMesh.IsVaildData())) {
                return;
            }
            ushort* pOccluderMesh = m_TargetMesh.ReadOnlyDataPtr;
            if (pOccluderMesh != null) {
                Matrix4x4 mat = transform.localToWorldMatrix;
                SDOCHelper.sdocRenderBakedOccluder(pSDOCInstance, pOccluderMesh, &mat.m00);
            }
        }

        void DestroyData() {
            if (m_TargetMesh != null) {
                if (m_TargetMesh.DecRef()) {
                    m_TargetMesh.Dispose();
                    if (SDOCManager.Instance != null) {
                        SDOCManager.Instance.RemoveMeshData(m_SDOCMeshAsset);
                    }
                }
                m_TargetMesh = null;
            }
        }

        private void OnDestroy() {
            DestroyData();
        }

        private void OnApplicationQuit() {
            DestroyData();
        }
    }
}
