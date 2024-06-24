using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.EventSystems;
using XLua;

namespace SOC.GamePlay
{
    [XLua.LuaCallCSharp]
    [RequireComponent(typeof(ILuaBinder))]
    public sealed class UIBinder : BaseMonoBehaviour
    {
        public UIBehaviour[] m_BindControls = null;
        private ILuaBinder m_Lua = null;

        private void Awake()
        {
            m_Lua = GetComponent<ILuaBinder>();
        }

        private void InitRegisterControls()
        {
            if (GameStart.EnvLua != null && m_BindControls != null && m_Lua != null && m_Lua.LuaSelf != null)
            {
                LuaTable bp = m_Lua.LuaSelf.Get<LuaTable>("bp");
                if (bp != null) {
                    for (int i = 0; i < m_BindControls.Length; ++i) {
                        var control = m_BindControls[i];
                        if (control != null) {
                            bp.Set<string, UIBehaviour>(control.gameObject.name, control);
                        }
                    }
                }
            }
        }

        private void Start()
        {
            InitRegisterControls();
        }
    }
}
