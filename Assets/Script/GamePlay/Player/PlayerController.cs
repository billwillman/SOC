using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace SOC.GamePlay.Player
{
    // 用来做和DS做通信用，和NetCode RPC关联用
    [XLua.LuaCallCSharp]
    public class MoePlayerController : ILuaBinder
    {
        public MoePlayerInput Input;
        public MoeCharacterController Character;
    }
}
