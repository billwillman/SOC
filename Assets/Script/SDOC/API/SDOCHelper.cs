using System;
using System.Runtime.InteropServices;
using Unity.Collections;
using Unity.Collections.LowLevel.Unsafe;
using UnityEngine;

namespace SDOC
{

    public static unsafe class SDOCHelper
    {
        public static readonly uint SDOC_DestroySDOC = 240;
		public static readonly uint SDOC_Get_DepthBufferWidthHeight = 250;
		public static readonly uint SDOC_FlushSubmittedOccluder = 602;
		public static readonly uint SDOC_Get_Version = 212;
		public static readonly uint SDOC_Get_DepthMap = 252;
		public static readonly uint SDOC_Save_DepthMap = 256;
		public static readonly uint SDOC_Save_DepthMapPath = 257;
		public static readonly uint SDOC_Get_MemoryUsed = 270;

#if UNITY_STANDALONE_WIN || UNITY_EDITOR_WIN
		/*******************************************************************************************************************************
		 *   sdocInit
		 *   @brief
		 *       Initialize SDOC.
		 *   @param width
		 *       Depth buffer width, must be divisible by 64, 64 is selected for max possible performance,
		 *       in the range of [64, 65535), suggest not larger than 1024
		 *   @param height
		 *       Depth buffer height, must be divisible by 8, in the range of [8, 65535), recommend 256
		 *   @param nearPlane
		 *       Near clip plane.
		 *   @return
		 *       TRUE if initialized successfully.
		*******************************************************************************************************************************/
		[DllImport("libSDOC.quic", CallingConvention = CallingConvention.Cdecl)]
        public static extern void* sdocInit(uint width, uint height, float nearPlane);


    /*******************************************************************************************************************************
	 *   sdocStartNewFrame
	 *   @brief
	 *       Start new frame
	 *   @param ViewPos
	 *       Camera Position, an array of three floats.
	 *   @param ViewDir
	 *       Camera view direction, an array of three floats. if set to (0, 0, 0) this frame would be treated as critical frame and render in full mode
	 *   @param ViewProj
	 *       The view-projection matrix which points to a 4x4 matrix.
	 *       ViewProj equals to View * Projection.
	 *   @return
	 *       TRUE if SDOC starts a new frame.
	*******************************************************************************************************************************/
        [DllImport("libSDOC.quic", CallingConvention = CallingConvention.Cdecl)]
        public static extern bool sdocStartNewFrame(void* pSDOC, float* ViewPos, float* ViewDir, float* ViewProj);


    /*******************************************************************************************************************************
	 *   sdocRenderOccluder
	 *   @brief
	 *       Submit occluder to SDOC. 
	 *   @param vertices
	 *       Occluder vertices array, the vertex should be arranged in order XYZ.
	 *   @param indices
	 *       Occluder indices array. Each three indices make up a triangle.
	 *   @param nVert
	 *       Number of vertices.
	 *   @param nIdx
	 *       Number of indices.
	 *   @param localToWorld
	 *       A 4x4 matrix which transforms occluder from local coordinator to world coordinator.
	 *       No need to set if the occluder has already converted to the world coordinate.
	 *   @param enableBackfaceCull
	 *       true if backface enable, otherwise false
	 *   @return
	 *       void
	 *   Assumption: vertices != nullptr && indices != nullptr && nVert != 0 && nIdx != 0
	*******************************************************************************************************************************/
        [DllImport("libSDOC.quic", CallingConvention = CallingConvention.Cdecl)]
        public static extern void sdocRenderOccluder(void* pSDOC, float* vertices, ushort* indices, uint nVert, uint nIdx, float* localToWorld, bool enableBackfaceCull);


	/*******************************************************************************************************************************
	 *   sdocQueryOccludeeMesh
	//parameters same as sdocRenderOccluder except
	//worldAABB: expect 6 element float array, represent occludee mesh's world AABB MinMax
	//SDOC would calculate meshMinExtent if input is nullptr
	//if localToWorld is identity 4x4 matrix, developers could just set the passing parameter to be null to fast the process
	*******************************************************************************************************************************/
        [DllImport("libSDOC.quic", CallingConvention = CallingConvention.Cdecl)]
        public static extern bool sdocQueryOccludeeMesh(void* pSDOC, float* vertices, ushort* indices, uint nVert, uint nIdx, float* localToWorld, bool enableBackfaceCull, float* worldAABB);

	/*******************************************************************************************************************************
	 *   sdocQueryOccludees
	 *   @brief
	 *       Query occludees' visibility by world coordinate axis-aligned bounding box(AABB) collections.
	 *   @details
	 *       Batch query visibility of bounding box collections. The visibility results will be returned by results array.
	 *   @param bbox
	 *       Bounding box collections. The data of bbox should be arranged in the following order:
	 *       minX, minY, minZ, maxX, maxY, maxZ
	 * 
	 *   @param nMesh
	 *       Number of Occludees.
	 *   @param results
	 *       Used to return visibility results.
	 *   @return
	 *       TRUE if queried successfully.
	 *   Assumption: bbox != nullptr && nMesh > 0 && results != nullptr
	*******************************************************************************************************************************/
        [DllImport("libSDOC.quic", CallingConvention = CallingConvention.Cdecl)]
        public static extern bool sdocQueryOccludees(void* pSDOC, float* bbox, uint nMesh, bool* results);

	/*******************************************************************************************************************************
	 *   sdocQueryOccludees_OBB
	 *   @brief
	 *       Query occludees' visibility by world coordinate OBB collections.
	 *   @details
	 *       Batch query visibility of bounding box collections. The visibility results will be returned by results array.
	 *   @param bbox
	 *       bbox should contain 18 floats: four conner points + AABB min max point:
	 *       p0, p1, p2, p4, min(minX, minY, minZ), max(maxX, maxY, maxZ) where (p0, p1, p2), (p0, p2, p4), (p0, p4, p1) form counter-clock-wise triangle
	 *          2！！！！！！！！3
	 *         /|       /|
	 *        / |      / |
	 *       /  6-----/--7
	 *      0！！！！！！！！1  /
	 *      | /      | /
	 *      |/       |/
	 *      4！！！！！！！！5
	 *
	 *   @param nMesh
	 *       Number of Occludees.
	 *   @param results
	 *       Used to return visibility results.
	 *   @return
	 *       TRUE if queried successfully.
	 *   Assumption: bbox != nullptr && nMesh > 0 && results != nullptr
	*******************************************************************************************************************************/
        [DllImport("libSDOC.quic", CallingConvention = CallingConvention.Cdecl)]
        public static extern bool sdocQueryOccludees_OBB(void* pSDOC, float* bbox, uint nMesh, bool* results);

	/*******************************************************************************************************************************
	 *   sdocSet
	 *   @brief
	 *       Notify SDOC to change setting according to the specified ID & Value
	 *   @param id
	 *       SDOC_SetCCW:                        configValue = 0 or 1. Default 1. 0 would means the model is clockwise
	 *       SDOC_Set_UsePrevDepthBuffer:        configValue = 1,0, default set to 0,  set 1 to enable
	 *       SDOC_Set_UsePrevFrameOccluders:     indicate the first N occluders are same with previous frame
	 *       SDOC_RenderMode:                    configValue = 0,1,2,12340    0 stands for full mode, 1 stands for coherent mode, 2 stands for coherent fast mode. Default set to coherent fast mode(2). 12340 would toggle render type from pure mesh to meshline, meshpoint, line, point iteratively
	 *       SDOC_ShowCulled                     configValue = 0 or 1, default 0, 1 to reverse the query result.
	 *       SDOC_ShowOccludeeInDepthMap         configValue = 0 or 1, default 0, hide/show the occludee info in depth map.
	 *       SDOC_CaptureFrame:                  configValue=1, once set, SDOC would capture 1 frame
	 *       SDOC_DestroySDOC:                   configValue=1, once the value is set to 1, Destroy SDOC instance
	 *       SDOC_EnableOccluderPriorityQueue    configValue = 1/0, default 0, means priority queue not enabled, once enable, sdoc would render the occluders according to 3 queues, backface cull off occluders, backface cull on occluders, terrain occluders
	 *       SDOC_BackFaceCullOffOccluderFirst configValue = 0/1, default 1. Backface cull off occluders would be rendered first.
	 *       SDOC_FlushSubmittedOccluder          config value = 1,  once called, force all submitted occluders rendered. Called once per frame.
	 *   @return
	 *       TRUE if set successfully.
	*******************************************************************************************************************************/
        [DllImport("libSDOC.quic", CallingConvention = CallingConvention.Cdecl)]
        public static extern bool sdocSet(void* pSDOC, uint ID, uint configValue);


	/*******************************************************************************************************************************
	 *   sdocSync
	 *   @brief
	 *       Mainly used to get/set the info with specified ID and various input/output format
	 *   @param id
	 *       SDOC_Get_MemoryUsed to get the total memory used by SDOC, in the unit of KB, expect input param format unsigned int *
	 *       SDOC_Get_DepthBufferWidthHeight means get the width and height of occlusion buffer, expect input param format unsigned int *
	 *       SDOC_Get_DepthMap get occluder depth map of SDOC. expect input param format unsigned char*
	 *       SDOC_Save_DepthMapPath pre-set the depth map path going to be saved. Once saved the store path value would be reset to default.
	 *       SDOC_Save_DepthMap save depth map to a file, expect input param format unsigned char*
     *       SDOC_Get_Version    Get the SDOC version,  expect input param format unsigned int *
     *       SDOC_Set_CoherentModeSmallRotateDotAngleThreshold  expect input param format float *, if cross-frame view direction dot value smaller than this value,
	 *                                 camera is rotating small, default value: 0.9999f
	 *       SDOC_Set_CoherentModeLargeRotateDotAngleThreshold  expect input param format float *, if cross-frame view direction dot value smaller than this value,
	 *                                 camera is rotating large, default value: 0.9995f
	 *       SDOC_Reset_DepthMapWidthAndHeight  expect input param format unsigned int *, contain two value indicating width & height.
	 *       SDOC_SetPrintLogInGame, expect input param format unsigned int *, contain one value, if 1, store the msg else print in SDOC
	 *       SDOC_Get_Log  expect input param format char* with size of 256
	 *       SDOC_Set_FrameCaptureOutputPath expect input param format char* data
	 *       SDOC_Get_IsSameCamera expect input param format bool *, store true if the camera pose is same with previous frame
	 *       SDOC_BakeMeshSimplifyConfig  expect input an int array with 4 values to store
	 *		          SimplifyMeshDuringBake value= 0/others, 0 would disable mesh simplify and others would enable
	 *                TerrainGridControlMergeDuringBake config value = 0/1/2, default 2. 0/1/2 are corresponding to no grid guided merging/grid guided merging/grid guided aggressive merging.
	 *                TerrainRectangleAngle        configValue = [80, 89], default 88, for a quad if neighboring edge form angle not smaller than the configValue, the quad would be treated as rectangle
	 *                TerrainMergeAngle            configValue = [1, 10], default 3, if two rectangle have normal angle difference smaller than the configValue, the two rectangle could be merged
	 *       SDOC_GetOccluderPotentialVisibleSet expect an array of bool with occluder number + 1 to store whether the occluder is potentially visible and interleave or not.
	 *       SDOC_SetQueryTreeData: provide an array of uint16_t to SDOC to inform the tree information. If the occludee has sub occludees, the value would be sub number + 1; if the occludee is a sub occludee, the value should be 0; otherwise the value should be one
	 *       SDOC_Get_BakeData_QuadTriangleNum: provide any array of uint16, first/second would be used to store Quad/Triangle number, the coming 4 uint16 would store first 4 elements of baked data
	 *   @return
	 *       TRUE if sync successfully.
	*******************************************************************************************************************************/
        [DllImport("libSDOC.quic", CallingConvention = CallingConvention.Cdecl)]
        public static extern bool sdocSync(void * pSDOC, uint id, void *param);


	/*******************************************************************************************************************************
	 *   sdocMeshBake
	 *   @brief
	 *       Submit model mesh to SDOC for compression. Compress the input mesh with uint16_t precision for each x/y/z. Native function only.
	 *   @param outputCompressSize
	 *       the number of int used to contain compressed data
	 *   @param vertices
	 *       Occluder vertices array, the vertex should be arranged in order XYZ.
	 *   @param indices
	 *       Occluder indices array. Every three indices make up a triangle.
	 *   @param nVert
	 *       Number of vertices.
	 *   @param nIdx
	 *       Number of indices.
	 *   @param quadAngle
	 *       if two neighboring plane normal angle is smaller than QuadAngle, they might form a quad and eligible for quad rasterization
	 *       Extremely large two triangles might introduce error. For model with super large triangles, this quadAngle should be set to a small value such as 1.
	 *       Valid quad angle range [0, 15], nonzero value would be clamped to [1, 15], recommended value 15. Set to 0 would disable quad drawing & mesh simplification.
	 *   @param enableBackfaceCull
	 *       true if backface enable, otherwise false
	 *   @param counterClockWise
	 *       True if model in counter clock wise order(UE default), otherwise false
	 *   @param SquareTerrainAxisPoints
	 *       If the input model is a NxN grid terrain where N means the number of point on X/Y axis, set SquareTerrainAxisPoints = N, otherwise 0
	 *   @return
	 *       the compressed data with outputCompressSize amount of int
	 *   @warning
	 *       this function is thread safe. If bake_data is not null, developers should clear the bake data by  recalling  
	 *         "delete [] bake_data;" or 
	 *         "sdocMeshBake( (int*)  bake_data, null, null, 0, 0, 0, false, fale, 0);"   as calling "delete [] bake_data;" might fail in some game engines
	*******************************************************************************************************************************/
        [DllImport("libSDOC.quic", CallingConvention = CallingConvention.Cdecl)]
        public static extern ushort* sdocMeshBake(int* outputCompressSize, float *vertices, ushort *indices, uint nVert, uint nIdx,  float quadAngle, bool enableBackfaceCull, bool counterClockWise, int SquareTerrainAxisPoints);


	/*******************************************************************************************************************************
	 *   sdocMeshLod  
	 *   @brief
	 *       Submit model to SDOC for simplification
	 *   @param vertices
	 *       Occluder vertices array, the vertex should be arranged in order XYZ.
	 *   @param indices
	 *       Occluder indices array. Each three indices make up a triangle.
	 *   @param nVert
	 *       Number of vertices.
	 *   @param nIdx
	 *       Number of indices.
	 *   @param modelId
	 *       unique id of the model
	 *   @param targetFaceNum
	 *       target simplified mesh face num, please provide a reasonable target face number.
	 *   @param saveModel
	 *       save the model for reference, set to true only for debug purpose
	 *   @return
	 *       bool true if lod is successful
	 *   Assumption: vertices != nullptr && indices != nullptr && nVert != 0 && nIdx != 0
	 *   Warning: if return true, the output would update to vertices, indices, nvert, nIdx
	 *			  the correctness of mesh simplification is great related to simplify ratio. 
	 *            provide reasonable targetFaceNum to avoid the simplified model lose the shape.
	*******************************************************************************************************************************/
        [DllImport("libSDOC.quic", CallingConvention = CallingConvention.Cdecl)]
        public static extern bool sdocMeshLod(float* vertices, ushort* indices, uint* nVert, uint* nIdx, int modelId, uint targetFaceNum, bool saveModel);


	/*******************************************************************************************************************************
	 *   sdocRenderOccluder
	 *   @brief
	 *       Submit compressed occluder to SDOC.
	 *   @param localToWorld
	 *       A 4x4 matrix which transforms occluder from local coordinator to world coordinator.
	 *       No need to set if the occluder has already converted to the world coordinate.
	 *   @return
	 *       void
	*******************************************************************************************************************************/
        [DllImport("libSDOC.quic", CallingConvention = CallingConvention.Cdecl)]
        public static extern void sdocRenderBakedOccluder(void * pSDOC, ushort *compressedModel, float *localToWorld);
#endif

		public static bool DestroyInstance(void* pInstance)
        {
            if (pInstance == null)
                return false;
            return sdocSet(pInstance, SDOC_DestroySDOC, 1);
        }

        public static void* CreateInstance(uint width, uint height, float nearPlane)
        {
            if (nearPlane < 0f)
                return null;
            void* ret = sdocInit(width, height, nearPlane);
            return ret;
        }

		public static uint GetVersion(void* pInstance) {
			if (pInstance == null)
				return 0;
			uint ret;
			if (sdocSync(pInstance, SDOC_Get_Version, (void*)&ret))
				return ret;
			return 0;
		}

		public static uint GetUseMemorySize(void* pInstance) {
			if (pInstance == null)
				return 0;
			uint ret;
			if (sdocSync(pInstance, SDOC_Get_MemoryUsed, (void*)&ret))
				return ret;
			return 0;
        }

		public static void GetDepthWidthAndHeight(void* pInstance, out int width, out int height) {
			if (pInstance == null) {
				width = 0; height = 0;
				return;
            }
			NativeArray<int> buffer = new NativeArray<int>(2, Allocator.Temp, NativeArrayOptions.UninitializedMemory);
			try {
				sdocSync(pInstance, SDOC_Get_DepthBufferWidthHeight, buffer.GetUnsafePtr());
				width = buffer[0];
				height = buffer[1];
            } finally {
				buffer.Dispose();
            }
        }

		public static void SaveDepthMapToFile(string fileName, void* pInstance) {
			if (pInstance == null || string.IsNullOrEmpty(fileName))
				return;
			int width, height;
			GetDepthWidthAndHeight(pInstance, out width, out height);
			if (width <= 0 || height <= 0)
				return;
			IntPtr s = Marshal.StringToHGlobalAnsi(fileName);
			try {
				// 1.譜崔猟周兆
				sdocSync(pInstance, SDOC_Save_DepthMapPath, s.ToPointer());
				// 2.譜崔DepthData
				NativeArray<byte> buffer = new NativeArray<byte>(width * height, Allocator.Temp, NativeArrayOptions.UninitializedMemory);
				try {
					if (!sdocSync(pInstance, SDOC_Get_DepthMap, buffer.GetUnsafePtr())) {
						Debug.LogError("SDOC_Get_DepthMap: Error");
						return;
                    }
					if (!sdocSync(pInstance, SDOC_Save_DepthMap, buffer.GetUnsafePtr())) {
						Debug.LogError("SDOC_Save_DepthMap: Error");
						return;
                    }
                } finally {
					buffer.Dispose();

				}
			} finally {
				sdocSync(pInstance, SDOC_Save_DepthMapPath, null);
				Marshal.FreeHGlobal(s);
            }
        }
    }
}
