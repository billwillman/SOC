using UnityEngine;

namespace SDOC
{
    public unsafe class SDOCManager : MonoBehaviour
    {
        private void* m_pSDOCInstance = null;

        // 这个需要根据相机fov设置
        public uint m_Width = 1024;
        public uint m_Height = 576;
        public float m_NearPlane = 0.3f;
        // ---------------

        protected void DestroySDOCInstance()
        {
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

        void OnEnable()
        {
            if (m_pSDOCInstance != null)
                return;
            m_pSDOCInstance = SDOCHelper.CreateInstance(m_Width, m_Height, m_NearPlane);
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
