using System;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Rendering;

namespace SDOC
{
    public unsafe class SDOCManager : MonoBehaviour
    {
        private void* m_pSDOCInstance = null;

        private static SDOCManager m_SDOCManager = null;
        private Dictionary<int, SDOCMeshData> m_LoadedMeshData = new Dictionary<int, SDOCMeshData>();

        private ISDOCMeshOccludersProxy m_MeshOccludersProxy = new DefaultSDOCMeshProxy();

        internal SDOCMeshData LoadMeshData(TextAsset asset) {
            if (asset == null)
                return null;
            int instanceId = asset.GetInstanceID();
            SDOCMeshData ret;
            if (m_LoadedMeshData.TryGetValue(instanceId, out ret))
                return ret;
            ret = new SDOCMeshData();
            if (!ret.LoadFromTexAsset(asset))
                ret.Dispose();
            else {
                m_LoadedMeshData.Add(instanceId, ret);
                return ret;
            }
            return null;
        }

        internal void RemoveMeshData(TextAsset asset) {
            if (asset == null)
                return;
            int instanceId = asset.GetInstanceID();
            if (m_LoadedMeshData.ContainsKey(instanceId))
                m_LoadedMeshData.Remove(instanceId);
        }

        internal ISDOCMeshOccludersProxy MeshOccludersProxy {
            get {
                return m_MeshOccludersProxy;
            }
        }

        public void GetDepthWidthAndHeight(out int width, out int height) {
            if (m_pSDOCInstance == null) {
                width = 0;
                height = 0;
                return;
            }
            SDOCHelper.GetDepthWidthAndHeight(m_pSDOCInstance, out width, out height);
        }

        public uint GetUsedMemorySize() {
            if (m_pSDOCInstance == null) {
                return 0;
            }
            return SDOCHelper.GetUseMemorySize(m_pSDOCInstance);
        }

        public static SDOCManager Instance {
            get {
                return m_SDOCManager;
            }
        }

        private void Update() {
            if (m_pSDOCInstance == null || m_TargetCam == null)
                return;
            Vector3 viewPos = m_TargetCam.transform.position;
            Vector3 viewDir = m_TargetCam.transform.forward;
            Matrix4x4 mat = m_TargetCam.worldToCameraMatrix;
            if (SDOCHelper.sdocStartNewFrame(m_pSDOCInstance, &viewPos.x, &viewDir.x, &mat.m00)) {
                try {
                    if (m_MeshOccludersProxy != null) {
                        for (int i = 0; i < m_MeshOccludersProxy.Count; ++i) {
                            SDOCMeshOccluder occluder = m_MeshOccludersProxy[i];
                            if (occluder != null) {
                                occluder.SDOCRender(m_pSDOCInstance);
                            }
                        }
                    }
                } finally {
                    SDOCHelper.sdocSet(m_pSDOCInstance, SDOCHelper.SDOC_FlushSubmittedOccluder, 1);
                }
            }
        }


        // 这个需要根据相机fov设置
        public int m_MaxPixelWidth = 256;
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
            if (m_MaxPixelWidth > 0 && width > m_MaxPixelWidth) {
                width = (uint)m_MaxPixelWidth;
                height = (uint)Mathf.FloorToInt(m_MaxPixelWidth/m_TargetCam.aspect);
                int h = Mathf.FloorToInt((float)(height) / 8.0f) * 8; // 必须8的倍数
                if (height % 8 != 0)
                    h += 8;
                height = (uint)h;
            }

            Debug.LogFormat("【SDOCInstance】 width: {0:D} height: {1:D} newarClipPlane: {2}", width, height, m_TargetCam.nearClipPlane.ToString());
            m_pSDOCInstance = SDOCHelper.CreateInstance(width, height, m_TargetCam.nearClipPlane);
            ulong addr = (ulong)m_pSDOCInstance;
            Debug.LogFormat("【SDOCInstance】 {0}", addr.ToString());
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
