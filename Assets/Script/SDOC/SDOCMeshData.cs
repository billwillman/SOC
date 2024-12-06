using System;
using System.IO;
using Unity.Collections;
using Unity.Collections.LowLevel.Unsafe;
using UnityEngine;
using Utils;

namespace SDOC
{
    public unsafe class SDOCMeshData
    {
        private NativeArray<ushort> Data;
        private int refNum = 0;

        public void AddRef() {
            ++refNum;
        }


        public bool DecRef() {
            refNum = refNum > 0 ? refNum - 1 : 0;
            return refNum <= 0;
        }

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

        public void WriteStream(Stream stream) {
            if (stream == null || !Data.IsCreated)
                return;
            int num = Data.Length;
            FilePathMgr.GetInstance().WriteInt(stream, num);
            if (num > 0) {
                var byteData = Data.Reinterpret<ushort, byte>();
                stream.Write(byteData.AsReadOnlySpan());
            }
        }

        public bool LoadFromStream(Stream stream) {
            if (stream == null)
                return false;
            int num = FilePathMgr.GetInstance().ReadInt(stream);
            if (num < 0)
                return false;
            Dispose();
            Data = new NativeArray<ushort>();
            if (num == 0) {
                return true;
            }
            bool ret = stream.Read(Data.Reinterpret<ushort, byte>().AsSpan()) == num;
            return ret;
        }

        public bool LoadFromTexAsset(TextAsset asset) {
            if (asset == null)
                return false;
            NativeArray<byte> assetArr = asset.GetData<byte>();
            NativeArray<int> numArr = assetArr.GetSubArray(0, 4).Reinterpret<byte, int>();
            int num = numArr[0];
            if (num <= 0) {
                Dispose();
                return true;
            }
            NativeArray<ushort> dataArr = assetArr.GetSubArray(4, assetArr.Length - 4 + 1).Reinterpret<byte, ushort>();
            Init((ushort*)dataArr.GetUnsafePtr<ushort>(), num * 2);
            return true;
        }
    }
}
