using System;
using System;
using UnityEngine;

namespace SDOC
{
    [Serializable]
    public unsafe class SDOCMeshData : ScriptableObject
    {
        public ushort[] Data = null;
        public SDOCMeshData(ushort* buf, int size) {
            if (buf != null && size > 0) {
                int num = size / 2;
                Data = new ushort[num];
                fixed(ushort* target = Data) {
                    Buffer.MemoryCopy(buf, target, size, size);
                }
            }
        }
    }
}
