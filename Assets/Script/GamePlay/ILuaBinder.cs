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

        // LuaEvent_MonoEvent 用int减少GC
        private Dictionary<int, LuaFunction> m_LuaEventMap = null;
        private LuaTable m_LuaSelf = null;
        private LuaTable m_LuaClass = null;
        private bool m_IsDestroyed = false;
        public LuaTable LuaSelf {
            get {
                return m_LuaSelf;
            }
        }

        public LuaTable LuaClass {
            get {
                return m_LuaClass;
            }
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
        void DoDestroyLuaObject() {
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
            if (m_LuaClass != null) {
                m_LuaClass.Dispose();
                m_LuaClass = null;
            }
        }

        [DoNotGen]
        void LoadLua() {
            DoDestroyLuaObject();
            if (string.IsNullOrEmpty(LuaPath) || SelfTarget == null)
                return;
            var env = GameStart.EnvLua;
            if (env == null)
                return;
            var rets = env.DoString(string.Format("require(\"{0}\")", LuaPath), SelfTarget.name);
            if (rets != null && rets.Length > 0) {
                LuaTable luaClass = rets[0] as LuaTable;
                if (luaClass != null) {
                    LuaFunction constructorFunc = luaClass.Get<LuaFunction>("New");
                    if (constructorFunc != null) {
                        m_LuaSelf = constructorFunc.Func<MonoBehaviour, LuaTable>(SelfTarget);
                        m_LuaClass = luaClass;
                    } else {
                        m_LuaSelf = luaClass;
                    }
                }
            }
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
            LoadLua();
            // 加载Lua
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

        // OnApplicationQuit 是优先OnDestroy, 这样保证GameStart的OnDestroy最后调用
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
            DoDestroyLuaObject();
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
