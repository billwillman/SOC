using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using XLua;

namespace SOC.GamePlay
{

    [LuaCallCSharp]
    public class GameStart : MonoBehaviour
    {

        public static GameStart Instance = null;
        private LuaFunction m_LuaUpdateFunc = null;

        [DoNotGen]
        public bool m_DS_OutputOldLogHandle = true;

        // Start is called before the first frame update
        void Awake() {
            DontDestroyOnLoad(this.gameObject);
            m_LuaLoaderCallBack = new LuaEnv.CustomLoader(OnLuaFileLoad);
            Instance = this;
        }

        private void Start() {
            ServerAttachLogFile();
            ResourceMgr.Instance.LoadConfigs(OnResConfigResult, this, true);
        }

        void OnResConfigResult(bool isOk) {
            if (isOk) {
                OnInit();
            } else {
#if UNITY_EDITOR
                // 编辑器模式一定会成功
                OnInit();
#endif
            }
        }

        void OnInit() {
            InitLuaEnv();
        }

        void ServerAttachLogFile() {
            if (IsDS) {
                // DS才能才存储
                m_LogFileWriter = new LogFileWriter("dsRuntimeLog", m_DS_OutputOldLogHandle);
            }
        }

        // 初始化Lua环境
        void InitLuaEnv() {
            // 1.初始化Lua环境
            m_LuaEnv = new LuaEnv();
            m_LuaEnv.AddLoader(m_LuaLoaderCallBack);
            // 2.调用Lua 入口函数
            Lua_DoMain();
        }

        public static bool IsDS {
            get {
#if UNITY_EDITOR
                var subTarget = UnityEditor.EditorUserBuildSettings.standaloneBuildSubtarget;
                bool isServer = (subTarget == UnityEditor.StandaloneBuildSubtarget.Server);
                return isServer;
#else
#if UNITY_SERVER
            return true;
#else
            return false; 
#endif
#endif
            }
        }

        [XLua.Hotfix]
        // 初始化NetCode的Lua全局变量
        void InitNetCodeLuaGlobalVars(LuaTable _MOE) {
#if UNITY_EDITOR
            _MOE.Set<string, bool>("IsEditor", true);
#else
            _MOE.Set<string, bool>("IsEditor", false);
#endif
            _MOE.Set<string, bool>("IsDS", IsDS); // 是否是DS 
        }

        void Lua_DoMain() {
            if (m_LuaEnv != null) {
                // 优先加载Preload.lua
                byte[] lua = ResourceMgr.Instance.LoadBytes("Resources/@Lua/Preload.lua.bytes");
                System.Object[] result =  m_LuaEnv.DoString(lua);
                LuaTable _MOE = result[0] as LuaTable;
                try {
                    InitNetCodeLuaGlobalVars(_MOE);
                } finally {
                    _MOE.Dispose();
                }
                //--
                lua = ResourceMgr.Instance.LoadBytes("Resources/@Lua/Main.lua.bytes");
                if (lua != null) {
                   m_LuaEnv.DoString(lua);
                    LuaFunction MainFunc = m_LuaEnv.Global.Get<LuaFunction>("Main");
                    if (MainFunc != null) {
                        try {
                            MainFunc.Call();
                        } finally {
                            MainFunc.Dispose();
                        }
                    }
                    m_LuaUpdateFunc = m_LuaEnv.Global.Get<LuaFunction>("Update");
                }
            }
        }

        [DoNotGen]
        public static LuaEnv EnvLua {
            get {
                if (Instance != null) {
                    return Instance.m_LuaEnv;
                }
                return null;
            }
        }

        private void Update() {
            TimerMgr.Instance.ScaleTick(Time.deltaTime);
            TimerMgr.Instance.UnScaleTick(Time.unscaledDeltaTime);
            if (m_LuaUpdateFunc != null) {
                m_LuaUpdateFunc.Call(Time.deltaTime);
            }
        }

        private void OnDestroy() {
            if (m_LuaEnv != null) {
                var QuitGame = m_LuaEnv.Global.Get<LuaFunction>("QuitGame");
                if (QuitGame != null) {
                    try {
                        QuitGame.Call();
                    } finally {
                        QuitGame.Dispose();
                    }
                }
                if (m_LuaUpdateFunc != null) {
                    m_LuaUpdateFunc.Dispose();
                    m_LuaUpdateFunc = null;
                }
                m_LuaEnv.Dispose();
                m_LuaEnv = null;
            }

            // 日志写入文件
            if (m_LogFileWriter != null) {
                m_LogFileWriter.Dispose();
                m_LogFileWriter = null;
            }
                
        }

        private static string[] _cLuaRootPathFormats = {
            "Resources/@Lua/{0}.lua.bytes",
            "Resources/@Lua/_BehaviourTree/{0}.lua.bytes"
        };

        private byte[] OnLuaFileLoad(ref string filepath) {
            filepath = filepath.Replace(".", "/");
            foreach (var pathFormat in _cLuaRootPathFormats) {
                string luaPath = string.Format(pathFormat, filepath);
                byte[] ret = ResourceMgr.Instance.LoadBytes(luaPath, ResourceCacheType.rctRefAdd);
                if (ret != null)
                    return ret;
            }
            return null;
        }

        private LuaEnv m_LuaEnv = null;
        private LuaEnv.CustomLoader m_LuaLoaderCallBack = null;
        private LogFileWriter m_LogFileWriter = null;
    }
}
