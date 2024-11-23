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
        public static extern bool sdocQueryOccludeeMesh(void* pSDOC, float* vertices, ushort* indices, uint nVert, uint nIdx, float* localToWorld, bool enableBackfaceCull, float* worldAABB);
        [DllImport("libSDOC.quic")]
        public static extern bool sdocQueryOccludees(void* pSDOC, float* bbox, uint nMesh, bool* results);
        [DllImport("libSDOC.quic")]
        public static extern bool sdocQueryOccludees_OBB(void* pSDOC, float* bbox, uint nMesh, bool* results);
        [DllImport("libSDOC.quic")]
        public static extern bool sdocSet(void* pSDOC, uint ID, uint configValue);
        [DllImport("libSDOC.quic")]
        public static extern bool sdocSync(void * pSDOC, uint id, void *param);
        [DllImport("libSDOC.quic")]
        public static extern ushort* sdocMeshBake(int* outputCompressSize, float *vertices, ushort *indices, uint nVert, uint nIdx,  float quadAngle, bool enableBackfaceCull, bool counterClockWise, int SquareTerrainAxisPoints);
        [DllImport("libSDOC.quic")]
        public static extern bool sdocMeshLod(float* vertices, ushort* indices, uint& nVert, uint& nIdx, int modelId, uint targetFaceNum, bool saveModel);
        [DllImport("libSDOC.quic")]
        public static extern void sdocRenderBakedOccluder(void * pSDOC, ushort *compressedModel, float *localToWorld);
#endif
    }
}
