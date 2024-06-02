using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Unity.Netcode;

namespace SOC.GamePlay.Player
{
    // ��������DS��ͨ���ã���NetCode RPC������
    [XLua.LuaCallCSharp]
    public class MoePlayerController : NetworkBehaviour
    {
        public MoePlayerInput Input;
        public MoeCharacterController Character;
    }
}
