using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Unity.Netcode;

namespace SOC.GamePlay
{
    // 加上这个可以在LUA覆写方法
    [XLua.LuaCallCSharp]
    public class MoeCharacterController : NetworkBehaviour
    { }
}
