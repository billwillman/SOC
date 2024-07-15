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
        Destroyed = 4,
        FixedUpdate = 5,
    }

    [LuaCallCSharp]
    public class ILuaBinder : BaseMonoBehaviour
    {
        public string LuaPath = string.Empty;
        public MonoBehaviour SelfTarget = null;

        // LuaEvent_MonoEvent ��int����GC
        private Dictionary<int, LuaFunction> m_LuaEventMap = null;
        private LuaTable m_LuaSelf = null;
        private LuaTable m_LuaClass = null;
        private Dictionary<string, LuaFunction> m_LuaCustomFuncs = null;

        // ��Ҫ��ȡ��Lua�ķ���
        [DoNotGen]
        public string[] CustomLuaFunctionName = null;

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
            DisposeCustomLuaFuncs();
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
                    InitCustomLuaFuncs();
                }
            }
        }

        [DoNotGen]
        void InitCustomLuaFuncs()
        {
            if (CustomLuaFunctionName == null || m_LuaSelf == null)
                return;
            for (int i = 0; i < CustomLuaFunctionName.Length; ++i)
            {
                string funcName = CustomLuaFunctionName[i];
                if (!string.IsNullOrEmpty(funcName))
                {
                    LuaFunction func = m_LuaSelf.Get<LuaFunction>(funcName);
                    if (func != null)
                    {
                        if (m_LuaCustomFuncs == null)
                            m_LuaCustomFuncs = new Dictionary<string, LuaFunction>();
                        m_LuaCustomFuncs[funcName] = func;
                    }
                }
            }
               
        }

        [DoNotGen]
        void DisposeCustomLuaFuncs()
        {
            if (m_LuaCustomFuncs == null)
                return;
            foreach(var iter in m_LuaCustomFuncs)
            {
                if (iter.Value != null)
                    iter.Value.Dispose();
            }
            m_LuaCustomFuncs.Clear();
            m_LuaCustomFuncs.TrimExcess();
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

        [DoNotGen]

        private void FixedUpdate()
        {
            if (CallLuaFunc(LuaEvent_MonoEventType.FixedUpdate))
            {
                OnFixedUpdate();
            }
        }

        protected override void OnInternalDestroyed() {
            if (CallLuaFunc(LuaEvent_MonoEventType.Destroyed)) {
                OnDestroyed();
            }
            DoDestroyLuaObject();
        }

        [DoNotGen]
        public virtual void OnStart() { }
        [DoNotGen]
        public virtual void OnDestroyed() { }
        [DoNotGen]
        public virtual void OnUpdate() { }
		[DoNotGen]
        public virtual void OnAwake() { }
        [DoNotGen]
        public virtual void OnFixedUpdate() { }
    }
}
