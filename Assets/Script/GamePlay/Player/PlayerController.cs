using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace SOC.GamePlay.Player
{
    // ��������DS��ͨ���ã���NetCode RPC������
    [XLua.LuaCallCSharp]
    public class PlayerController : ILuaBinder
    {
        public PlayerInput Input;
        public CharacterController Character;
    }
}
