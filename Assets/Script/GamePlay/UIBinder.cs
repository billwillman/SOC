using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.EventSystems;
using XLua;

namespace SOC.GamePlay
{
    [XLua.LuaCallCSharp]
    public sealed class UIBinder : BaseMonoBehaviour
    {
        public UIBehaviour[] m_BindControls = null;

        public void InitRegisterControls(LuaTable lua)
        {
            if (lua != null && m_BindControls != null)
            {
                LuaTable bp = lua.Get<LuaTable>("bp");
                if (bp != null) {
                    for (int i = 0; i < m_BindControls.Length; ++i) {
                        var control = m_BindControls[i];
                        if (control != null) {
                            bp.Set<string, UIBehaviour>(control.gameObject.name, control);
                            Button btn;
                        }
                    }
                }
            }
        }
    }
}