using UnityEngine;
using UnityEngine.Rendering;

namespace SDOC
{
    public unsafe class SDOCManager : MonoBehaviour
    {
        private void* m_pSDOCInstance = null;

        private static SDOCManager m_SDOCManager = null;

        public static SDOCManager Instance {
            get {
                return m_SDOCManager;
            }
        }
            

        // 这个需要根据相机fov设置
        public int m_MaxPixelHeight = 256;
        // ---------------

        public Camera m_TargetCam = null;

        protected void DestroySDOCInstance()
        {
            m_SDOCManager = null;
            if (m_pSDOCInstance == null)
                return;

            if (SDOCHelper.DestroyInstance(m_pSDOCInstance))
                m_pSDOCInstance = null;
        }

        // 释放Instance
        void OnDisable()
        {
            DestroySDOCInstance();
        }

        private void Awake() {
            DontDestroyOnLoad(this.gameObject);
            m_SDOCManager = this;
        }

        void OnEnable() {
            if (m_pSDOCInstance != null || m_TargetCam == null)
                return;

            uint width = (uint)m_TargetCam.scaledPixelWidth;
            uint height = (uint)m_TargetCam.scaledPixelHeight;
            if (m_MaxPixelHeight > 0 && height > m_MaxPixelHeight) {
                height = (uint)m_MaxPixelHeight;
                width = (uint)Mathf.FloorToInt(m_TargetCam.aspect * m_MaxPixelHeight);
            }

            m_pSDOCInstance = SDOCHelper.CreateInstance(width, height, m_TargetCam.nearClipPlane);
        }

        void OnApplicationQuit()
        {
            DestroySDOCInstance();
        }

        void OnDestroy()
        {
            DestroySDOCInstance();
        }
    }
}
