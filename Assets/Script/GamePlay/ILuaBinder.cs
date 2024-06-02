using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using XLua;

namespace SOC.GamePlay
{
    public enum LuaEvent_MonoEventType
    {
        None = 0,
        Awake = 1,
        Start = 2,
        Update = 3,
        Destroyed = 4
    }

    [LuaCallCSharp]
    public class ILuaBinder : MonoBehaviour
    {
        public string LuaPath = string.Empty;
        public MonoBehaviour SelfTarget = null;

        // LuaEvent_MonoEvent ��int����GC
        private Dictionary<int, LuaFunction> m_LuaEventMap = null;
        private LuaTable m_LuaSelf = null;
        private bool m_IsDestroyed = false;
        
        // ����LuaPath��ȡ��ӦLUA�Ķ���ʵ����Ȼ��ֵ
        [DoNotGen]
        private void RegisterLuaSelf(LuaTable self) {
            m_LuaSelf = self;
        }

        public void RegisterLuaEvent(int evtType, LuaFunction func) {
            if (m_LuaEventMap == null)
                m_LuaEventMap = new Dictionary<int, LuaFunction>();
            m_LuaEventMap[evtType] = func;
        }

        public System.Object[] CallCustomLuaFunc(int evtType, System.Object[] param) {
            if (m_LuaEventMap == null)
                return null;
            LuaFunction func;
            if (m_LuaEventMap.TryGetValue((int)evtType, out func) && func != null) {
                return func.Call(param);
            }
            return null;
        }

        [DoNotGen]
        private bool CallLuaFunc(LuaEvent_MonoEventType evtType) {
            if (m_LuaEventMap == null)
                return true;
            LuaFunction func;
            if (m_LuaEventMap.TryGetValue((int)evtType, out func) && func != null) {
                return func.Func<LuaTable, bool>(m_LuaSelf);
            }
            return true;
        }

        [DoNotGen]
        private void Awake() {
            // ����Lua
            if (CallLuaFunc(LuaEvent_MonoEventType.Awake)) {
                OnAwake();
            }
        }

        [DoNotGen]

        private void Start() {
            if (CallLuaFunc(LuaEvent_MonoEventType.Start)) {
                OnStart();
            }
        }

        [DoNotGen]

        private void Update() {
            if (CallLuaFunc(LuaEvent_MonoEventType.Update)) {
                OnUpdate();
            }
        }

        // OnApplicationQuit ������OnDestroy, ������֤GameStart��OnDestroy������
        [DoNotGen]
        private void OnApplicationQuit() {
            DoDestroy();
        }

        [DoNotGen]
        void DoDestroy() {
            if (m_IsDestroyed)
                return;
            m_IsDestroyed = true;
            if (CallLuaFunc(LuaEvent_MonoEventType.Destroyed)) {
                OnDestroyed();
            }
            if (m_LuaEventMap != null) {
                var iter = m_LuaEventMap.GetEnumerator();
                while (iter.MoveNext()) {
                    var func = iter.Current.Value;
                    if (func != null) {
                        func.Dispose();
                    }
                }
                iter.Dispose();
                m_LuaEventMap.Clear();
            }
            if (m_LuaSelf != null) {
                m_LuaSelf.Dispose();
                m_LuaSelf = null;
            }
        }

        [DoNotGen]

        private void OnDestroy() {
            DoDestroy();
        }

        [DoNotGen]
        public virtual void OnStart() { }
        [DoNotGen]
        public virtual void OnDestroyed() { }
        [DoNotGen]
        public virtual void OnUpdate() { }
        public virtual void OnAwake() { }
    }
}
