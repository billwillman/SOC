using System;
using Unity.Collections;
using Unity.Collections.LowLevel.Unsafe;
using UnityEngine;

namespace SDOC
{
    [Serializable]
    public unsafe class SDOCMeshData : ScriptableObject
    {
        public NativeArray<ushort> Data;

        public bool IsVaildData() {
            bool ret = Data.IsCreated && Data.Length > 0;
            return ret;
        }

        public ushort* ReadOnlyDataPtr {
            get {
                if (!IsVaildData())
                    return null;
                return (ushort*)Data.GetUnsafeReadOnlyPtr();
            }
        }

        public void Init(ushort* buf, int size) {
            if (buf != null && size > 0) {
                int num = size / 2;
                Dispose();
                Data = new NativeArray<ushort>(num, Allocator.Persistent);
                ushort* target = (ushort*)Data.GetUnsafePtr();
                Buffer.MemoryCopy(buf, target, size, size);
            }
        }

        public void Dispose() {
            if (Data.IsCreated) {
                Data.Dispose();
            }
        }
    }
}
