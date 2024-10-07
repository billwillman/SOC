using System;
using UnityEngine;
using Unity.Collections;
using Unity.Netcode;

namespace SOC.GamePlay
{
    [XLua.LuaCallCSharp]
    public class PlayerController : NetworkBehaviour
    {
        // Client和Server都会执行
        [XLua.DoNotGen]
        public override void OnNetworkSpawn() {
            base.OnNetworkSpawn();
        }

        // Client和Server都会执行
        [XLua.DoNotGen]
        public override void OnNetworkDespawn() {
            ClearAllEvents();
            base.OnNetworkDespawn();
        }

        public void ClearAllEvents() {
            onClientStrEvent = null;
            onClientIntEvent = null;
            onClientInt2Event = null;
            onClientInt3Event = null;
        }

        public void DispatchClientEvent(string eventName, string paramStr) {
            if (!IsServer)
                return;
            NativeArray<ulong> send = new NativeArray<ulong>(1, Allocator.Temp, NativeArrayOptions.UninitializedMemory);
            try {
                send[0] = this.OwnerClientId;
                ClientRpcParams clientRpcParams = new ClientRpcParams() {
                    Send = new ClientRpcSendParams() {
                        TargetClientIdsNativeArray = send
                    }
                };
                DispatchEvent_ClientRpc(eventName, paramStr, clientRpcParams);
            } finally {
                send.Dispose();
            }
        }

        public void DisptachClientEvent(string eventName, int intParam) {
            if (!IsServer)
                return;
            NativeArray<ulong> send = new NativeArray<ulong>(1, Allocator.Temp, NativeArrayOptions.UninitializedMemory);
            try {
                send[0] = this.OwnerClientId;
                ClientRpcParams clientRpcParams = new ClientRpcParams() {
                    Send = new ClientRpcSendParams() {
                        TargetClientIdsNativeArray = send
                    }
                };
                DispatchEvent_ClientRpc(eventName, intParam, clientRpcParams);
            } finally {
                send.Dispose();
            }
        }

        public void DisptachClientEvent(string eventName, int intParam1, int intParam2) {
            if (!IsServer)
                return;
            NativeArray<ulong> send = new NativeArray<ulong>(1, Allocator.Temp, NativeArrayOptions.UninitializedMemory);
            try {
                send[0] = this.OwnerClientId;
                ClientRpcParams clientRpcParams = new ClientRpcParams() {
                    Send = new ClientRpcSendParams() {
                        TargetClientIdsNativeArray = send
                    }
                };
                DispatchEvent_ClientRpc(eventName, intParam1, intParam2, clientRpcParams);
            } finally {
                send.Dispose();
            }
        }

        public void DisptachClientEvent(string eventName, int intParam1, int intParam2, int intParam3) {
            if (!IsServer)
                return;
            NativeArray<ulong> send = new NativeArray<ulong>(1, Allocator.Temp, NativeArrayOptions.UninitializedMemory);
            try {
                send[0] = this.OwnerClientId;
                ClientRpcParams clientRpcParams = new ClientRpcParams() {
                    Send = new ClientRpcSendParams() {
                        TargetClientIdsNativeArray = send
                    }
                };
                DispatchEvent_ClientRpc(eventName, intParam1, intParam2, intParam3, clientRpcParams);
            } finally {
                send.Dispose();
            }
        }

        [ClientRpc]
        // Server To Client
        protected void DispatchEvent_ClientRpc(string eventName, string paramStr, ClientRpcParams clientRpcParams) {
            if (onClientStrEvent != null)
                onClientStrEvent(eventName, paramStr);
        }

        [ClientRpc]
        protected void DispatchEvent_ClientRpc(string eventName, int intParam, ClientRpcParams clientRpcParams) {
            if (onClientIntEvent != null)
                onClientIntEvent(eventName, intParam);
        }
        [ClientRpc]
        protected void DispatchEvent_ClientRpc(string eventName, int intParam1, int intParam2, ClientRpcParams clientRpcParams) {
            if (onClientInt2Event != null)
                onClientInt2Event(eventName, intParam1, intParam2);
        }
        [ClientRpc]
        protected void DispatchEvent_ClientRpc(string eventName, int intParam1, int intParam2, int intParam3, ClientRpcParams clientRpcParams) {
            if (onClientInt3Event != null)
                onClientInt3Event(eventName, intParam1, intParam2, intParam3);
        }

        // ------------------------------ 外部设置 ------------------------
        public Action<string, string> onClientStrEvent {
            get; set;
        }

        public Action<string, int> onClientIntEvent {
            get; set;
        }
        public Action<string, int, int> onClientInt2Event {
            get; set;
        }
        public Action<string, int, int, int> onClientInt3Event {
            get; set;
        }
        // ----------------------------------------------------------------
    }
}
