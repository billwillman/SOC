using UnityEngine;
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
            base.OnNetworkDespawn();
        }
    }
}
