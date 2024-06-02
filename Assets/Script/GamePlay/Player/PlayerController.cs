using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace SOC.GamePlay.Player
{
    // ��������DS��ͨ���ã���NetCode RPC������
    [XLua.LuaCallCSharp]
    public class MoePlayerController : ILuaBinder
    {
        public MoePlayerInput Input;
        public MoeCharacterController Character;
    }
}
