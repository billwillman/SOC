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
        private Dictionary<string, UIBehaviour> m_BindControlsMap = null;

        private void Awake()
        {
            m_Lua = GetComponent<ILuaBinder>();
        }

        private void InitRegisterControls()
        {
            if (GameStart.EnvLua != null && m_BindControls != null && m_Lua != null && m_Lua.LuaSelf != null)
            {
                m_BindControlsMap = new Dictionary<string, UIBehaviour>(m_BindControls.Length);
                for (int i = 0; i < m_BindControls.Length; ++i)
                {
                    var control = m_BindControls[i];
                    if (control != null)
                    {
                        InitRegisterControl(control);
                    }
                    m_Lua.LuaSelf.SetInPath<Dictionary<string, UIBehaviour>>("bp", m_BindControlsMap);
                }
            }
        }

        private bool InitRegisterControl(UIBehaviour control)
        {
            if (control == null)
                return false;
            string name = control.gameObject.name;
            m_BindControlsMap[name] = control;
            return true;
        }

        public bool UnRegisterControl(UIBehaviour control)
        {
            if (m_BindControlsMap == null)
                return false;
            string name = control.gameObject.name;
            UIBehaviour findControl;
            if (m_BindControlsMap.TryGetValue(name, out findControl))
            {
                if (findControl == control)
                {
                    m_BindControlsMap.Remove(name);
                    return true;
                }
            }
            return false;
        }

        private void Start()
        {
            InitRegisterControls();
        }
    }
}
