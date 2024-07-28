using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Unity.Netcode;

namespace SOC.GamePlay.Player
{
    // 加上这个可以在LUA覆写方法
    // 用来做和DS做通信用，和NetCode RPC关联用
    [XLua.LuaCallCSharp]
    public class MoePlayerController : NetworkBehaviour
    {
        public MoeCharacterController Character;
    }
}
