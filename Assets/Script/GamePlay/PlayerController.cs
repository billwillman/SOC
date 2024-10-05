using UnityEngine;
using Unity.Netcode;

namespace SOC.GamePlay
{
    public class PlayerController : NetworkBehaviour
    {
        // Client和Server都会执行
        public override void OnNetworkSpawn() {
            base.OnNetworkSpawn();
        }

        // Client和Server都会执行
        public override void OnNetworkDespawn() {
            base.OnNetworkDespawn();
        }
    }
}
