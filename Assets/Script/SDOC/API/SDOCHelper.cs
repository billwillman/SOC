using System;
using System.Runtime.InteropServices;
using UnityEngine;

namespace SDOC
{

    public static unsafe class SDOCHelper
    {
#if UNITY_STANDALONE_WIN || UNITY_EDITOR_WIN
        [DllImport("libSDOC.quic")]
        public static extern void* sdocInit(uint width, uint height, float nearPlane);
        [DllImport("libSDOC.quic")]
        public static extern bool sdocStartNewFrame(void* pSDOC, float* ViewPos, float* ViewDir, float* ViewProj);
        [DllImport("libSDOC.quic")]
        public static extern void sdocRenderOccluder(void* pSDOC, float* vertices, ushort* indices, uint nVert, uint nIdx, float* localToWorld, bool enableBackfaceCull);
        [DllImport("libSDOC.quic")]
        public static extern bool sdocSet(void* pSDOC, uint ID, uint configValue);
#endif
    }
}
