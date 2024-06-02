using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using XLua;

namespace SOC.GamePlay.Player
{
    [LuaCallCSharp]
    public class GameStart : MonoBehaviour
    {

        public static GameStart Instance = null;

        // Start is called before the first frame update
        void Awake() {
            DontDestroyOnLoad(this.gameObject);
            m_LuaLoaderCallBack = new LuaEnv.CustomLoader(OnLuaFileLoad);
            Instance = this;
        }

        private void Start() {
            ResourceMgr.Instance.LoadConfigs(OnResConfigResult, this, true);
        }

        void OnResConfigResult(bool isOk) {
            if (isOk) {
                OnInit();
            } else {
#if UNITY_EDITOR
                // �༭��ģʽһ����ɹ�
                OnInit();
#endif
            }
        }

        void OnInit() {
            InitLuaEnv();
        }

        // ��ʼ��Lua����
        void InitLuaEnv() {
            // 1.��ʼ��Lua����
            m_LuaEnv = new LuaEnv();
            m_LuaEnv.AddLoader(m_LuaLoaderCallBack);
            // 2.����Lua ��ں���
            Lua_DoMain();
        }

        [XLua.Hotfix]
        // ��ʼ��NetCode��Luaȫ�ֱ���
        void InitNetCodeLuaGlobalVars(LuaTable _MOE) {
#if UNITY_EDITOR
            _MOE.Set<string, bool>("IsEditor", true);
#else
            _MOE.Set<string, bool>("IsEditor", false);
#endif
#if UNITY_SERVER
            _MOE.Set<string, bool>("IsDS", true);
#else
            _MOE.Set<string, bool>("IsDS", false); // �Ƿ���DS
#endif
        }

        void Lua_DoMain() {
            if (m_LuaEnv != null) {
                byte[] lua = ResourceMgr.Instance.LoadBytes("Resources/Lua/Main.lua.bytes");
                if (lua != null) {
                    System.Object[] result = m_LuaEnv.DoString(lua);
                    if (result != null && result.Length > 0) {
                        LuaTable _MOE = result[0] as LuaTable;
                        if (_MOE != null) {
                            try {
                                InitNetCodeLuaGlobalVars(_MOE);
                                LuaFunction MainFunc = m_LuaEnv.Global.Get<LuaFunction>("Main");
                                if (MainFunc != null) {
                                    try {
                                        MainFunc.Call();
                                    } finally {
                                        MainFunc.Dispose();
                                    }
                                }
                            } finally {
                                _MOE.Dispose();
                            }
                        }
                    }
                }
            }
        }

        private void OnDestroy() {
            if (m_LuaEnv != null) {
                m_LuaEnv.Dispose();
                m_LuaEnv = null;
            }
        }

        private byte[] OnLuaFileLoad(ref string filepath) {
            string luaPath = string.Format("Resources/Lua/{0}.lua.bytes", filepath);
            byte[] ret = ResourceMgr.Instance.LoadBytes(luaPath);
            return ret;
        }

        private LuaEnv m_LuaEnv = null;
        private LuaEnv.CustomLoader m_LuaLoaderCallBack = null;
    }
}
