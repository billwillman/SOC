using UnityEngine;
using Unity.Netcode;

namespace SOC.GamePlay
{
    public class PlayerController : NetworkBehaviour
    {
        // Client��Server����ִ��
        public override void OnNetworkSpawn() {
            base.OnNetworkSpawn();
        }

        // Client��Server����ִ��
        public override void OnNetworkDespawn() {
            base.OnNetworkDespawn();
        }
    }
}
