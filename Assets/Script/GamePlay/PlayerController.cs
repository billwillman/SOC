using UnityEngine;
using Unity.Netcode;

namespace SOC.GamePlay
{
    [XLua.LuaCallCSharp]
    public class PlayerController : NetworkBehaviour
    {
        // Client��Server����ִ��
        [XLua.DoNotGen]
        public override void OnNetworkSpawn() {
            base.OnNetworkSpawn();
        }

        // Client��Server����ִ��
        [XLua.DoNotGen]
        public override void OnNetworkDespawn() {
            base.OnNetworkDespawn();
        }
    }
}
