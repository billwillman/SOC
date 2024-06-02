#if USE_UNI_LUA
using LuaAPI = UniLua.Lua;
using RealStatePtr = UniLua.ILuaState;
using LuaCSFunction = UniLua.CSharpFunctionDelegate;
#else
using LuaAPI = XLua.LuaDLL.Lua;
using RealStatePtr = System.IntPtr;
using LuaCSFunction = XLua.LuaDLL.lua_CSFunction;
#endif

using XLua;
using System.Collections.Generic;


namespace XLua.CSObjectWrap
{
    using Utils = XLua.Utils;
    public class ResourceMgrWrap 
    {
        public static void __Register(RealStatePtr L)
        {
			ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
			System.Type type = typeof(ResourceMgr);
			Utils.BeginObjectRegister(type, L, translator, 0, 46, 3, 0);
			
			Utils.RegisterFunc(L, Utils.METHOD_IDX, "LoadConfigs", _m_LoadConfigs);
			Utils.RegisterFunc(L, Utils.METHOD_IDX, "LoadScene", _m_LoadScene);
			Utils.RegisterFunc(L, Utils.METHOD_IDX, "LoadSceneAsync", _m_LoadSceneAsync);
			Utils.RegisterFunc(L, Utils.METHOD_IDX, "CloseScene", _m_CloseScene);
			Utils.RegisterFunc(L, Utils.METHOD_IDX, "CreateGameObject", _m_CreateGameObject);
			Utils.RegisterFunc(L, Utils.METHOD_IDX, "InstantiateGameObj", _m_InstantiateGameObj);
			Utils.RegisterFunc(L, Utils.METHOD_IDX, "OnDestroyInstObject", _m_OnDestroyInstObject);
			Utils.RegisterFunc(L, Utils.METHOD_IDX, "DestroyInstGameObj", _m_DestroyInstGameObj);
			Utils.RegisterFunc(L, Utils.METHOD_IDX, "CoroutneAudioClipABUnloadFalse", _m_CoroutneAudioClipABUnloadFalse);
			Utils.RegisterFunc(L, Utils.METHOD_IDX, "CoroutineEndFrameABUnloadFalse", _m_CoroutineEndFrameABUnloadFalse);
			Utils.RegisterFunc(L, Utils.METHOD_IDX, "ABUnloadTrue", _m_ABUnloadTrue);
			Utils.RegisterFunc(L, Utils.METHOD_IDX, "ABUnloadFalse", _m_ABUnloadFalse);
			Utils.RegisterFunc(L, Utils.METHOD_IDX, "DestroyObject", _m_DestroyObject);
			Utils.RegisterFunc(L, Utils.METHOD_IDX, "LoadPrefab", _m_LoadPrefab);
			Utils.RegisterFunc(L, Utils.METHOD_IDX, "LoadPrefabAsync", _m_LoadPrefabAsync);
			Utils.RegisterFunc(L, Utils.METHOD_IDX, "CreateGameObjectAsync", _m_CreateGameObjectAsync);
			Utils.RegisterFunc(L, Utils.METHOD_IDX, "LoadTexture", _m_LoadTexture);
			Utils.RegisterFunc(L, Utils.METHOD_IDX, "LoadTextureAsync", _m_LoadTextureAsync);
			Utils.RegisterFunc(L, Utils.METHOD_IDX, "LoadMaterial", _m_LoadMaterial);
			Utils.RegisterFunc(L, Utils.METHOD_IDX, "LoadMaterialAsync", _m_LoadMaterialAsync);
			Utils.RegisterFunc(L, Utils.METHOD_IDX, "LoadAudioClip", _m_LoadAudioClip);
			Utils.RegisterFunc(L, Utils.METHOD_IDX, "LoadAudioClipAsync", _m_LoadAudioClipAsync);
			Utils.RegisterFunc(L, Utils.METHOD_IDX, "LoadBytes", _m_LoadBytes);
			Utils.RegisterFunc(L, Utils.METHOD_IDX, "LoadText", _m_LoadText);
			Utils.RegisterFunc(L, Utils.METHOD_IDX, "LoadTextAsync", _m_LoadTextAsync);
			Utils.RegisterFunc(L, Utils.METHOD_IDX, "LoadAnimationClip", _m_LoadAnimationClip);
			Utils.RegisterFunc(L, Utils.METHOD_IDX, "LoadAnimationClipAsync", _m_LoadAnimationClipAsync);
			Utils.RegisterFunc(L, Utils.METHOD_IDX, "LoadAniController", _m_LoadAniController);
			Utils.RegisterFunc(L, Utils.METHOD_IDX, "LoadAniControllerAsync", _m_LoadAniControllerAsync);
			Utils.RegisterFunc(L, Utils.METHOD_IDX, "LoadShader", _m_LoadShader);
			Utils.RegisterFunc(L, Utils.METHOD_IDX, "LoadShaderAsync", _m_LoadShaderAsync);
			Utils.RegisterFunc(L, Utils.METHOD_IDX, "LoadFont", _m_LoadFont);
			Utils.RegisterFunc(L, Utils.METHOD_IDX, "LoadFontAsync", _m_LoadFontAsync);
			Utils.RegisterFunc(L, Utils.METHOD_IDX, "PreLoadAndBuildAssetBundleShaders", _m_PreLoadAndBuildAssetBundleShaders);
			Utils.RegisterFunc(L, Utils.METHOD_IDX, "PreLoadAssetBundle", _m_PreLoadAssetBundle);
			Utils.RegisterFunc(L, Utils.METHOD_IDX, "DestroySprites", _m_DestroySprites);
			Utils.RegisterFunc(L, Utils.METHOD_IDX, "DestroyObjects", _m_DestroyObjects);
			Utils.RegisterFunc(L, Utils.METHOD_IDX, "LoadSprites", _m_LoadSprites);
			Utils.RegisterFunc(L, Utils.METHOD_IDX, "LoadSpritesAsync", _m_LoadSpritesAsync);
			Utils.RegisterFunc(L, Utils.METHOD_IDX, "LoadScriptableObject", _m_LoadScriptableObject);
			Utils.RegisterFunc(L, Utils.METHOD_IDX, "LoadScriptableObjectAsync", _m_LoadScriptableObjectAsync);
			Utils.RegisterFunc(L, Utils.METHOD_IDX, "UnloadUnUsed", _m_UnloadUnUsed);
			Utils.RegisterFunc(L, Utils.METHOD_IDX, "OnApplicationQuit", _m_OnApplicationQuit);
			Utils.RegisterFunc(L, Utils.METHOD_IDX, "AutoUpdateClear", _m_AutoUpdateClear);
			Utils.RegisterFunc(L, Utils.METHOD_IDX, "GetABShaderFileNameByName", _m_GetABShaderFileNameByName);
			Utils.RegisterFunc(L, Utils.METHOD_IDX, "GetAssetBundleFileName", _m_GetAssetBundleFileName);
			
			
			Utils.RegisterFunc(L, Utils.GETTER_IDX, "AssetLoader", _g_get_AssetLoader);
            Utils.RegisterFunc(L, Utils.GETTER_IDX, "ResLoader", _g_get_ResLoader);
            Utils.RegisterFunc(L, Utils.GETTER_IDX, "IsQuitApp", _g_get_IsQuitApp);
            
			
			
			Utils.EndObjectRegister(type, L, translator, null, null,
			    null, null, null);

		    Utils.BeginClassRegister(type, L, __CreateInstance, 1, 0, 0);
			
			
            
			
			
			
			Utils.EndClassRegister(type, L, translator);
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int __CreateInstance(RealStatePtr L)
        {
            
			try {
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
				if(LuaAPI.lua_gettop(L) == 1)
				{
					
					var gen_ret = new ResourceMgr();
					translator.Push(L, gen_ret);
                    
					return 1;
				}
				
			}
			catch(System.Exception gen_e) {
				return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
			}
            return LuaAPI.luaL_error(L, "invalid arguments to ResourceMgr constructor!");
            
        }
        
		
        
		
        
        
        
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_LoadConfigs(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
                ResourceMgr gen_to_be_invoked = (ResourceMgr)translator.FastGetCSObj(L, 1);
            
            
			    int gen_param_count = LuaAPI.lua_gettop(L);
            
                if(gen_param_count == 4&& translator.Assignable<System.Action<bool>>(L, 2)&& translator.Assignable<UnityEngine.MonoBehaviour>(L, 3)&& LuaTypes.LUA_TBOOLEAN == LuaAPI.lua_type(L, 4)) 
                {
                    System.Action<bool> _OnFinish = translator.GetDelegate<System.Action<bool>>(L, 2);
                    UnityEngine.MonoBehaviour _async = (UnityEngine.MonoBehaviour)translator.GetObject(L, 3, typeof(UnityEngine.MonoBehaviour));
                    bool _isThreadMode = LuaAPI.lua_toboolean(L, 4);
                    
                    gen_to_be_invoked.LoadConfigs( _OnFinish, _async, _isThreadMode );
                    
                    
                    
                    return 0;
                }
                if(gen_param_count == 3&& translator.Assignable<System.Action<bool>>(L, 2)&& translator.Assignable<UnityEngine.MonoBehaviour>(L, 3)) 
                {
                    System.Action<bool> _OnFinish = translator.GetDelegate<System.Action<bool>>(L, 2);
                    UnityEngine.MonoBehaviour _async = (UnityEngine.MonoBehaviour)translator.GetObject(L, 3, typeof(UnityEngine.MonoBehaviour));
                    
                    gen_to_be_invoked.LoadConfigs( _OnFinish, _async );
                    
                    
                    
                    return 0;
                }
                if(gen_param_count == 2&& translator.Assignable<System.Action<bool>>(L, 2)) 
                {
                    System.Action<bool> _OnFinish = translator.GetDelegate<System.Action<bool>>(L, 2);
                    
                    gen_to_be_invoked.LoadConfigs( _OnFinish );
                    
                    
                    
                    return 0;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
            return LuaAPI.luaL_error(L, "invalid arguments to ResourceMgr.LoadConfigs!");
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_LoadScene(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
                ResourceMgr gen_to_be_invoked = (ResourceMgr)translator.FastGetCSObj(L, 1);
            
            
                
                {
                    string _sceneName = LuaAPI.lua_tostring(L, 2);
                    bool _isAdd = LuaAPI.lua_toboolean(L, 3);
                    
                        var gen_ret = gen_to_be_invoked.LoadScene( _sceneName, _isAdd );
                        LuaAPI.lua_pushboolean(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_LoadSceneAsync(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
                ResourceMgr gen_to_be_invoked = (ResourceMgr)translator.FastGetCSObj(L, 1);
            
            
			    int gen_param_count = LuaAPI.lua_gettop(L);
            
                if(gen_param_count == 6&& (LuaAPI.lua_isnil(L, 2) || LuaAPI.lua_type(L, 2) == LuaTypes.LUA_TSTRING)&& LuaTypes.LUA_TBOOLEAN == LuaAPI.lua_type(L, 3)&& translator.Assignable<System.Action<UnityEngine.AsyncOperation, bool>>(L, 4)&& LuaTypes.LUA_TBOOLEAN == LuaAPI.lua_type(L, 5)&& LuaTypes.LUA_TNUMBER == LuaAPI.lua_type(L, 6)) 
                {
                    string _sceneName = LuaAPI.lua_tostring(L, 2);
                    bool _isAdd = LuaAPI.lua_toboolean(L, 3);
                    System.Action<UnityEngine.AsyncOperation, bool> _onProcess = translator.GetDelegate<System.Action<UnityEngine.AsyncOperation, bool>>(L, 4);
                    bool _isLoadedActive = LuaAPI.lua_toboolean(L, 5);
                    int _priority = LuaAPI.xlua_tointeger(L, 6);
                    
                        var gen_ret = gen_to_be_invoked.LoadSceneAsync( _sceneName, _isAdd, _onProcess, _isLoadedActive, _priority );
                        LuaAPI.lua_pushboolean(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                if(gen_param_count == 5&& (LuaAPI.lua_isnil(L, 2) || LuaAPI.lua_type(L, 2) == LuaTypes.LUA_TSTRING)&& LuaTypes.LUA_TBOOLEAN == LuaAPI.lua_type(L, 3)&& translator.Assignable<System.Action<UnityEngine.AsyncOperation, bool>>(L, 4)&& LuaTypes.LUA_TBOOLEAN == LuaAPI.lua_type(L, 5)) 
                {
                    string _sceneName = LuaAPI.lua_tostring(L, 2);
                    bool _isAdd = LuaAPI.lua_toboolean(L, 3);
                    System.Action<UnityEngine.AsyncOperation, bool> _onProcess = translator.GetDelegate<System.Action<UnityEngine.AsyncOperation, bool>>(L, 4);
                    bool _isLoadedActive = LuaAPI.lua_toboolean(L, 5);
                    
                        var gen_ret = gen_to_be_invoked.LoadSceneAsync( _sceneName, _isAdd, _onProcess, _isLoadedActive );
                        LuaAPI.lua_pushboolean(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                if(gen_param_count == 4&& (LuaAPI.lua_isnil(L, 2) || LuaAPI.lua_type(L, 2) == LuaTypes.LUA_TSTRING)&& LuaTypes.LUA_TBOOLEAN == LuaAPI.lua_type(L, 3)&& translator.Assignable<System.Action<UnityEngine.AsyncOperation, bool>>(L, 4)) 
                {
                    string _sceneName = LuaAPI.lua_tostring(L, 2);
                    bool _isAdd = LuaAPI.lua_toboolean(L, 3);
                    System.Action<UnityEngine.AsyncOperation, bool> _onProcess = translator.GetDelegate<System.Action<UnityEngine.AsyncOperation, bool>>(L, 4);
                    
                        var gen_ret = gen_to_be_invoked.LoadSceneAsync( _sceneName, _isAdd, _onProcess );
                        LuaAPI.lua_pushboolean(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
            return LuaAPI.luaL_error(L, "invalid arguments to ResourceMgr.LoadSceneAsync!");
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_CloseScene(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
                ResourceMgr gen_to_be_invoked = (ResourceMgr)translator.FastGetCSObj(L, 1);
            
            
                
                {
                    string _sceneName = LuaAPI.lua_tostring(L, 2);
                    
                    gen_to_be_invoked.CloseScene( _sceneName );
                    
                    
                    
                    return 0;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_CreateGameObject(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
                ResourceMgr gen_to_be_invoked = (ResourceMgr)translator.FastGetCSObj(L, 1);
            
            
			    int gen_param_count = LuaAPI.lua_gettop(L);
            
                if(gen_param_count == 2&& (LuaAPI.lua_isnil(L, 2) || LuaAPI.lua_type(L, 2) == LuaTypes.LUA_TSTRING)) 
                {
                    string _fileName = LuaAPI.lua_tostring(L, 2);
                    
                        var gen_ret = gen_to_be_invoked.CreateGameObject( _fileName );
                        translator.Push(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                if(gen_param_count == 3&& (LuaAPI.lua_isnil(L, 2) || LuaAPI.lua_type(L, 2) == LuaTypes.LUA_TSTRING)&& LuaTypes.LUA_TNUMBER == LuaAPI.lua_type(L, 3)) 
                {
                    string _fileName = LuaAPI.lua_tostring(L, 2);
                    float _delayDestroyTime = (float)LuaAPI.lua_tonumber(L, 3);
                    
                        var gen_ret = gen_to_be_invoked.CreateGameObject( _fileName, _delayDestroyTime );
                        translator.Push(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                if(gen_param_count == 4&& (LuaAPI.lua_isnil(L, 2) || LuaAPI.lua_type(L, 2) == LuaTypes.LUA_TSTRING)&& translator.Assignable<UnityEngine.Vector3>(L, 3)&& translator.Assignable<UnityEngine.Quaternion>(L, 4)) 
                {
                    string _fileName = LuaAPI.lua_tostring(L, 2);
                    UnityEngine.Vector3 _position;translator.Get(L, 3, out _position);
                    UnityEngine.Quaternion _rotation;translator.Get(L, 4, out _rotation);
                    
                        var gen_ret = gen_to_be_invoked.CreateGameObject( _fileName, _position, _rotation );
                        translator.Push(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                if(gen_param_count == 5&& (LuaAPI.lua_isnil(L, 2) || LuaAPI.lua_type(L, 2) == LuaTypes.LUA_TSTRING)&& translator.Assignable<UnityEngine.Vector3>(L, 3)&& translator.Assignable<UnityEngine.Quaternion>(L, 4)&& LuaTypes.LUA_TNUMBER == LuaAPI.lua_type(L, 5)) 
                {
                    string _fileName = LuaAPI.lua_tostring(L, 2);
                    UnityEngine.Vector3 _position;translator.Get(L, 3, out _position);
                    UnityEngine.Quaternion _rotation;translator.Get(L, 4, out _rotation);
                    float _delayDestroyTime = (float)LuaAPI.lua_tonumber(L, 5);
                    
                        var gen_ret = gen_to_be_invoked.CreateGameObject( _fileName, _position, _rotation, _delayDestroyTime );
                        translator.Push(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
            return LuaAPI.luaL_error(L, "invalid arguments to ResourceMgr.CreateGameObject!");
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_InstantiateGameObj(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
                ResourceMgr gen_to_be_invoked = (ResourceMgr)translator.FastGetCSObj(L, 1);
            
            
			    int gen_param_count = LuaAPI.lua_gettop(L);
            
                if(gen_param_count == 2&& translator.Assignable<UnityEngine.GameObject>(L, 2)) 
                {
                    UnityEngine.GameObject _orgObj = (UnityEngine.GameObject)translator.GetObject(L, 2, typeof(UnityEngine.GameObject));
                    
                        var gen_ret = gen_to_be_invoked.InstantiateGameObj( _orgObj );
                        translator.Push(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                if(gen_param_count == 3&& translator.Assignable<UnityEngine.GameObject>(L, 2)&& LuaTypes.LUA_TNUMBER == LuaAPI.lua_type(L, 3)) 
                {
                    UnityEngine.GameObject _orgObj = (UnityEngine.GameObject)translator.GetObject(L, 2, typeof(UnityEngine.GameObject));
                    float _delayDestroyTime = (float)LuaAPI.lua_tonumber(L, 3);
                    
                        var gen_ret = gen_to_be_invoked.InstantiateGameObj( _orgObj, _delayDestroyTime );
                        translator.Push(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                if(gen_param_count == 4&& translator.Assignable<UnityEngine.GameObject>(L, 2)&& translator.Assignable<UnityEngine.Vector3>(L, 3)&& translator.Assignable<UnityEngine.Quaternion>(L, 4)) 
                {
                    UnityEngine.GameObject _orgObj = (UnityEngine.GameObject)translator.GetObject(L, 2, typeof(UnityEngine.GameObject));
                    UnityEngine.Vector3 _position;translator.Get(L, 3, out _position);
                    UnityEngine.Quaternion _rotation;translator.Get(L, 4, out _rotation);
                    
                        var gen_ret = gen_to_be_invoked.InstantiateGameObj( _orgObj, _position, _rotation );
                        translator.Push(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                if(gen_param_count == 5&& translator.Assignable<UnityEngine.GameObject>(L, 2)&& translator.Assignable<UnityEngine.Vector3>(L, 3)&& translator.Assignable<UnityEngine.Quaternion>(L, 4)&& LuaTypes.LUA_TNUMBER == LuaAPI.lua_type(L, 5)) 
                {
                    UnityEngine.GameObject _orgObj = (UnityEngine.GameObject)translator.GetObject(L, 2, typeof(UnityEngine.GameObject));
                    UnityEngine.Vector3 _position;translator.Get(L, 3, out _position);
                    UnityEngine.Quaternion _rotation;translator.Get(L, 4, out _rotation);
                    float _delayDestroyTime = (float)LuaAPI.lua_tonumber(L, 5);
                    
                        var gen_ret = gen_to_be_invoked.InstantiateGameObj( _orgObj, _position, _rotation, _delayDestroyTime );
                        translator.Push(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
            return LuaAPI.luaL_error(L, "invalid arguments to ResourceMgr.InstantiateGameObj!");
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_OnDestroyInstObject(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
                ResourceMgr gen_to_be_invoked = (ResourceMgr)translator.FastGetCSObj(L, 1);
            
            
			    int gen_param_count = LuaAPI.lua_gettop(L);
            
                if(gen_param_count == 2&& LuaTypes.LUA_TNUMBER == LuaAPI.lua_type(L, 2)) 
                {
                    int _instID = LuaAPI.xlua_tointeger(L, 2);
                    
                    gen_to_be_invoked.OnDestroyInstObject( _instID );
                    
                    
                    
                    return 0;
                }
                if(gen_param_count == 2&& translator.Assignable<UnityEngine.GameObject>(L, 2)) 
                {
                    UnityEngine.GameObject _instObj = (UnityEngine.GameObject)translator.GetObject(L, 2, typeof(UnityEngine.GameObject));
                    
                    gen_to_be_invoked.OnDestroyInstObject( _instObj );
                    
                    
                    
                    return 0;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
            return LuaAPI.luaL_error(L, "invalid arguments to ResourceMgr.OnDestroyInstObject!");
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_DestroyInstGameObj(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
                ResourceMgr gen_to_be_invoked = (ResourceMgr)translator.FastGetCSObj(L, 1);
            
            
			    int gen_param_count = LuaAPI.lua_gettop(L);
            
                if(gen_param_count == 3&& translator.Assignable<UnityEngine.GameObject>(L, 2)&& LuaTypes.LUA_TBOOLEAN == LuaAPI.lua_type(L, 3)) 
                {
                    UnityEngine.GameObject _obj = (UnityEngine.GameObject)translator.GetObject(L, 2, typeof(UnityEngine.GameObject));
                    bool _isImm = LuaAPI.lua_toboolean(L, 3);
                    
                    gen_to_be_invoked.DestroyInstGameObj( _obj, _isImm );
                    
                    
                    
                    return 0;
                }
                if(gen_param_count == 2&& translator.Assignable<UnityEngine.GameObject>(L, 2)) 
                {
                    UnityEngine.GameObject _obj = (UnityEngine.GameObject)translator.GetObject(L, 2, typeof(UnityEngine.GameObject));
                    
                    gen_to_be_invoked.DestroyInstGameObj( _obj );
                    
                    
                    
                    return 0;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
            return LuaAPI.luaL_error(L, "invalid arguments to ResourceMgr.DestroyInstGameObj!");
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_CoroutneAudioClipABUnloadFalse(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
                ResourceMgr gen_to_be_invoked = (ResourceMgr)translator.FastGetCSObj(L, 1);
            
            
                
                {
                    UnityEngine.AudioClip _clip = (UnityEngine.AudioClip)translator.GetObject(L, 2, typeof(UnityEngine.AudioClip));
                    UnityEngine.MonoBehaviour _parent = (UnityEngine.MonoBehaviour)translator.GetObject(L, 3, typeof(UnityEngine.MonoBehaviour));
                    
                    gen_to_be_invoked.CoroutneAudioClipABUnloadFalse( _clip, _parent );
                    
                    
                    
                    return 0;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_CoroutineEndFrameABUnloadFalse(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
                ResourceMgr gen_to_be_invoked = (ResourceMgr)translator.FastGetCSObj(L, 1);
            
            
			    int gen_param_count = LuaAPI.lua_gettop(L);
            
                if(gen_param_count == 4&& translator.Assignable<UnityEngine.Object>(L, 2)&& translator.Assignable<UnityEngine.MonoBehaviour>(L, 3)&& LuaTypes.LUA_TBOOLEAN == LuaAPI.lua_type(L, 4)) 
                {
                    UnityEngine.Object _obj = (UnityEngine.Object)translator.GetObject(L, 2, typeof(UnityEngine.Object));
                    UnityEngine.MonoBehaviour _parent = (UnityEngine.MonoBehaviour)translator.GetObject(L, 3, typeof(UnityEngine.MonoBehaviour));
                    bool _unMySelf = LuaAPI.lua_toboolean(L, 4);
                    
                    gen_to_be_invoked.CoroutineEndFrameABUnloadFalse( _obj, _parent, _unMySelf );
                    
                    
                    
                    return 0;
                }
                if(gen_param_count == 3&& translator.Assignable<UnityEngine.Object>(L, 2)&& translator.Assignable<UnityEngine.MonoBehaviour>(L, 3)) 
                {
                    UnityEngine.Object _obj = (UnityEngine.Object)translator.GetObject(L, 2, typeof(UnityEngine.Object));
                    UnityEngine.MonoBehaviour _parent = (UnityEngine.MonoBehaviour)translator.GetObject(L, 3, typeof(UnityEngine.MonoBehaviour));
                    
                    gen_to_be_invoked.CoroutineEndFrameABUnloadFalse( _obj, _parent );
                    
                    
                    
                    return 0;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
            return LuaAPI.luaL_error(L, "invalid arguments to ResourceMgr.CoroutineEndFrameABUnloadFalse!");
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_ABUnloadTrue(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
                ResourceMgr gen_to_be_invoked = (ResourceMgr)translator.FastGetCSObj(L, 1);
            
            
                
                {
                    UnityEngine.Object _target = (UnityEngine.Object)translator.GetObject(L, 2, typeof(UnityEngine.Object));
                    
                    gen_to_be_invoked.ABUnloadTrue( _target );
                    
                    
                    
                    return 0;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_ABUnloadFalse(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
                ResourceMgr gen_to_be_invoked = (ResourceMgr)translator.FastGetCSObj(L, 1);
            
            
			    int gen_param_count = LuaAPI.lua_gettop(L);
            
                if(gen_param_count == 3&& translator.Assignable<UnityEngine.Object[]>(L, 2)&& LuaTypes.LUA_TBOOLEAN == LuaAPI.lua_type(L, 3)) 
                {
                    UnityEngine.Object[] _targets = (UnityEngine.Object[])translator.GetObject(L, 2, typeof(UnityEngine.Object[]));
                    bool _unMySelf = LuaAPI.lua_toboolean(L, 3);
                    
                    gen_to_be_invoked.ABUnloadFalse( _targets, _unMySelf );
                    
                    
                    
                    return 0;
                }
                if(gen_param_count == 2&& translator.Assignable<UnityEngine.Object[]>(L, 2)) 
                {
                    UnityEngine.Object[] _targets = (UnityEngine.Object[])translator.GetObject(L, 2, typeof(UnityEngine.Object[]));
                    
                    gen_to_be_invoked.ABUnloadFalse( _targets );
                    
                    
                    
                    return 0;
                }
                if(gen_param_count == 3&& translator.Assignable<UnityEngine.Object>(L, 2)&& LuaTypes.LUA_TBOOLEAN == LuaAPI.lua_type(L, 3)) 
                {
                    UnityEngine.Object _target = (UnityEngine.Object)translator.GetObject(L, 2, typeof(UnityEngine.Object));
                    bool _unMySelf = LuaAPI.lua_toboolean(L, 3);
                    
                        var gen_ret = gen_to_be_invoked.ABUnloadFalse( _target, _unMySelf );
                        LuaAPI.lua_pushboolean(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                if(gen_param_count == 2&& translator.Assignable<UnityEngine.Object>(L, 2)) 
                {
                    UnityEngine.Object _target = (UnityEngine.Object)translator.GetObject(L, 2, typeof(UnityEngine.Object));
                    
                        var gen_ret = gen_to_be_invoked.ABUnloadFalse( _target );
                        LuaAPI.lua_pushboolean(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
            return LuaAPI.luaL_error(L, "invalid arguments to ResourceMgr.ABUnloadFalse!");
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_DestroyObject(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
                ResourceMgr gen_to_be_invoked = (ResourceMgr)translator.FastGetCSObj(L, 1);
            
            
			    int gen_param_count = LuaAPI.lua_gettop(L);
            
                if(gen_param_count == 3&& translator.Assignable<UnityEngine.Object>(L, 2)&& LuaTypes.LUA_TBOOLEAN == LuaAPI.lua_type(L, 3)) 
                {
                    UnityEngine.Object _obj = (UnityEngine.Object)translator.GetObject(L, 2, typeof(UnityEngine.Object));
                    bool _isUnloadAsset = LuaAPI.lua_toboolean(L, 3);
                    
                    gen_to_be_invoked.DestroyObject( _obj, _isUnloadAsset );
                    
                    
                    
                    return 0;
                }
                if(gen_param_count == 2&& translator.Assignable<UnityEngine.Object>(L, 2)) 
                {
                    UnityEngine.Object _obj = (UnityEngine.Object)translator.GetObject(L, 2, typeof(UnityEngine.Object));
                    
                    gen_to_be_invoked.DestroyObject( _obj );
                    
                    
                    
                    return 0;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
            return LuaAPI.luaL_error(L, "invalid arguments to ResourceMgr.DestroyObject!");
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_LoadPrefab(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
                ResourceMgr gen_to_be_invoked = (ResourceMgr)translator.FastGetCSObj(L, 1);
            
            
                
                {
                    string _fileName = LuaAPI.lua_tostring(L, 2);
                    ResourceCacheType _cacheType;translator.Get(L, 3, out _cacheType);
                    
                        var gen_ret = gen_to_be_invoked.LoadPrefab( _fileName, _cacheType );
                        translator.Push(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_LoadPrefabAsync(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
                ResourceMgr gen_to_be_invoked = (ResourceMgr)translator.FastGetCSObj(L, 1);
            
            
			    int gen_param_count = LuaAPI.lua_gettop(L);
            
                if(gen_param_count == 5&& (LuaAPI.lua_isnil(L, 2) || LuaAPI.lua_type(L, 2) == LuaTypes.LUA_TSTRING)&& translator.Assignable<System.Action<float, bool, UnityEngine.GameObject>>(L, 3)&& translator.Assignable<ResourceCacheType>(L, 4)&& LuaTypes.LUA_TNUMBER == LuaAPI.lua_type(L, 5)) 
                {
                    string _fileName = LuaAPI.lua_tostring(L, 2);
                    System.Action<float, bool, UnityEngine.GameObject> _onProcess = translator.GetDelegate<System.Action<float, bool, UnityEngine.GameObject>>(L, 3);
                    ResourceCacheType _cacheType;translator.Get(L, 4, out _cacheType);
                    int _priority = LuaAPI.xlua_tointeger(L, 5);
                    
                        var gen_ret = gen_to_be_invoked.LoadPrefabAsync( _fileName, _onProcess, _cacheType, _priority );
                        LuaAPI.lua_pushboolean(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                if(gen_param_count == 4&& (LuaAPI.lua_isnil(L, 2) || LuaAPI.lua_type(L, 2) == LuaTypes.LUA_TSTRING)&& translator.Assignable<System.Action<float, bool, UnityEngine.GameObject>>(L, 3)&& translator.Assignable<ResourceCacheType>(L, 4)) 
                {
                    string _fileName = LuaAPI.lua_tostring(L, 2);
                    System.Action<float, bool, UnityEngine.GameObject> _onProcess = translator.GetDelegate<System.Action<float, bool, UnityEngine.GameObject>>(L, 3);
                    ResourceCacheType _cacheType;translator.Get(L, 4, out _cacheType);
                    
                        var gen_ret = gen_to_be_invoked.LoadPrefabAsync( _fileName, _onProcess, _cacheType );
                        LuaAPI.lua_pushboolean(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
            return LuaAPI.luaL_error(L, "invalid arguments to ResourceMgr.LoadPrefabAsync!");
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_CreateGameObjectAsync(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
                ResourceMgr gen_to_be_invoked = (ResourceMgr)translator.FastGetCSObj(L, 1);
            
            
			    int gen_param_count = LuaAPI.lua_gettop(L);
            
                if(gen_param_count == 4&& (LuaAPI.lua_isnil(L, 2) || LuaAPI.lua_type(L, 2) == LuaTypes.LUA_TSTRING)&& translator.Assignable<System.Action<float, bool, UnityEngine.GameObject>>(L, 3)&& LuaTypes.LUA_TNUMBER == LuaAPI.lua_type(L, 4)) 
                {
                    string _fileName = LuaAPI.lua_tostring(L, 2);
                    System.Action<float, bool, UnityEngine.GameObject> _onProcess = translator.GetDelegate<System.Action<float, bool, UnityEngine.GameObject>>(L, 3);
                    int _priority = LuaAPI.xlua_tointeger(L, 4);
                    
                        var gen_ret = gen_to_be_invoked.CreateGameObjectAsync( _fileName, _onProcess, _priority );
                        LuaAPI.lua_pushboolean(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                if(gen_param_count == 3&& (LuaAPI.lua_isnil(L, 2) || LuaAPI.lua_type(L, 2) == LuaTypes.LUA_TSTRING)&& translator.Assignable<System.Action<float, bool, UnityEngine.GameObject>>(L, 3)) 
                {
                    string _fileName = LuaAPI.lua_tostring(L, 2);
                    System.Action<float, bool, UnityEngine.GameObject> _onProcess = translator.GetDelegate<System.Action<float, bool, UnityEngine.GameObject>>(L, 3);
                    
                        var gen_ret = gen_to_be_invoked.CreateGameObjectAsync( _fileName, _onProcess );
                        LuaAPI.lua_pushboolean(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                if(gen_param_count == 5&& (LuaAPI.lua_isnil(L, 2) || LuaAPI.lua_type(L, 2) == LuaTypes.LUA_TSTRING)&& LuaTypes.LUA_TNUMBER == LuaAPI.lua_type(L, 3)&& translator.Assignable<System.Action<float, bool, UnityEngine.GameObject>>(L, 4)&& LuaTypes.LUA_TNUMBER == LuaAPI.lua_type(L, 5)) 
                {
                    string _fileName = LuaAPI.lua_tostring(L, 2);
                    float _delayDestroyTime = (float)LuaAPI.lua_tonumber(L, 3);
                    System.Action<float, bool, UnityEngine.GameObject> _onProcess = translator.GetDelegate<System.Action<float, bool, UnityEngine.GameObject>>(L, 4);
                    int _priority = LuaAPI.xlua_tointeger(L, 5);
                    
                        var gen_ret = gen_to_be_invoked.CreateGameObjectAsync( _fileName, _delayDestroyTime, _onProcess, _priority );
                        LuaAPI.lua_pushboolean(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                if(gen_param_count == 4&& (LuaAPI.lua_isnil(L, 2) || LuaAPI.lua_type(L, 2) == LuaTypes.LUA_TSTRING)&& LuaTypes.LUA_TNUMBER == LuaAPI.lua_type(L, 3)&& translator.Assignable<System.Action<float, bool, UnityEngine.GameObject>>(L, 4)) 
                {
                    string _fileName = LuaAPI.lua_tostring(L, 2);
                    float _delayDestroyTime = (float)LuaAPI.lua_tonumber(L, 3);
                    System.Action<float, bool, UnityEngine.GameObject> _onProcess = translator.GetDelegate<System.Action<float, bool, UnityEngine.GameObject>>(L, 4);
                    
                        var gen_ret = gen_to_be_invoked.CreateGameObjectAsync( _fileName, _delayDestroyTime, _onProcess );
                        LuaAPI.lua_pushboolean(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
            return LuaAPI.luaL_error(L, "invalid arguments to ResourceMgr.CreateGameObjectAsync!");
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_LoadTexture(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
                ResourceMgr gen_to_be_invoked = (ResourceMgr)translator.FastGetCSObj(L, 1);
            
            
                
                {
                    string _fileName = LuaAPI.lua_tostring(L, 2);
                    ResourceCacheType _cacheType;translator.Get(L, 3, out _cacheType);
                    
                        var gen_ret = gen_to_be_invoked.LoadTexture( _fileName, _cacheType );
                        translator.Push(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_LoadTextureAsync(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
                ResourceMgr gen_to_be_invoked = (ResourceMgr)translator.FastGetCSObj(L, 1);
            
            
			    int gen_param_count = LuaAPI.lua_gettop(L);
            
                if(gen_param_count == 5&& (LuaAPI.lua_isnil(L, 2) || LuaAPI.lua_type(L, 2) == LuaTypes.LUA_TSTRING)&& translator.Assignable<System.Action<float, bool, UnityEngine.Texture>>(L, 3)&& translator.Assignable<ResourceCacheType>(L, 4)&& LuaTypes.LUA_TNUMBER == LuaAPI.lua_type(L, 5)) 
                {
                    string _fileName = LuaAPI.lua_tostring(L, 2);
                    System.Action<float, bool, UnityEngine.Texture> _onProcess = translator.GetDelegate<System.Action<float, bool, UnityEngine.Texture>>(L, 3);
                    ResourceCacheType _cacheType;translator.Get(L, 4, out _cacheType);
                    int _priority = LuaAPI.xlua_tointeger(L, 5);
                    
                        var gen_ret = gen_to_be_invoked.LoadTextureAsync( _fileName, _onProcess, _cacheType, _priority );
                        LuaAPI.lua_pushboolean(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                if(gen_param_count == 4&& (LuaAPI.lua_isnil(L, 2) || LuaAPI.lua_type(L, 2) == LuaTypes.LUA_TSTRING)&& translator.Assignable<System.Action<float, bool, UnityEngine.Texture>>(L, 3)&& translator.Assignable<ResourceCacheType>(L, 4)) 
                {
                    string _fileName = LuaAPI.lua_tostring(L, 2);
                    System.Action<float, bool, UnityEngine.Texture> _onProcess = translator.GetDelegate<System.Action<float, bool, UnityEngine.Texture>>(L, 3);
                    ResourceCacheType _cacheType;translator.Get(L, 4, out _cacheType);
                    
                        var gen_ret = gen_to_be_invoked.LoadTextureAsync( _fileName, _onProcess, _cacheType );
                        LuaAPI.lua_pushboolean(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
            return LuaAPI.luaL_error(L, "invalid arguments to ResourceMgr.LoadTextureAsync!");
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_LoadMaterial(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
                ResourceMgr gen_to_be_invoked = (ResourceMgr)translator.FastGetCSObj(L, 1);
            
            
                
                {
                    string _fileName = LuaAPI.lua_tostring(L, 2);
                    ResourceCacheType _cacheType;translator.Get(L, 3, out _cacheType);
                    
                        var gen_ret = gen_to_be_invoked.LoadMaterial( _fileName, _cacheType );
                        translator.Push(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_LoadMaterialAsync(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
                ResourceMgr gen_to_be_invoked = (ResourceMgr)translator.FastGetCSObj(L, 1);
            
            
			    int gen_param_count = LuaAPI.lua_gettop(L);
            
                if(gen_param_count == 5&& (LuaAPI.lua_isnil(L, 2) || LuaAPI.lua_type(L, 2) == LuaTypes.LUA_TSTRING)&& translator.Assignable<System.Action<float, bool, UnityEngine.Material>>(L, 3)&& translator.Assignable<ResourceCacheType>(L, 4)&& LuaTypes.LUA_TNUMBER == LuaAPI.lua_type(L, 5)) 
                {
                    string _fileName = LuaAPI.lua_tostring(L, 2);
                    System.Action<float, bool, UnityEngine.Material> _onProcess = translator.GetDelegate<System.Action<float, bool, UnityEngine.Material>>(L, 3);
                    ResourceCacheType _cacheType;translator.Get(L, 4, out _cacheType);
                    int _priority = LuaAPI.xlua_tointeger(L, 5);
                    
                        var gen_ret = gen_to_be_invoked.LoadMaterialAsync( _fileName, _onProcess, _cacheType, _priority );
                        LuaAPI.lua_pushboolean(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                if(gen_param_count == 4&& (LuaAPI.lua_isnil(L, 2) || LuaAPI.lua_type(L, 2) == LuaTypes.LUA_TSTRING)&& translator.Assignable<System.Action<float, bool, UnityEngine.Material>>(L, 3)&& translator.Assignable<ResourceCacheType>(L, 4)) 
                {
                    string _fileName = LuaAPI.lua_tostring(L, 2);
                    System.Action<float, bool, UnityEngine.Material> _onProcess = translator.GetDelegate<System.Action<float, bool, UnityEngine.Material>>(L, 3);
                    ResourceCacheType _cacheType;translator.Get(L, 4, out _cacheType);
                    
                        var gen_ret = gen_to_be_invoked.LoadMaterialAsync( _fileName, _onProcess, _cacheType );
                        LuaAPI.lua_pushboolean(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
            return LuaAPI.luaL_error(L, "invalid arguments to ResourceMgr.LoadMaterialAsync!");
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_LoadAudioClip(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
                ResourceMgr gen_to_be_invoked = (ResourceMgr)translator.FastGetCSObj(L, 1);
            
            
                
                {
                    string _fileName = LuaAPI.lua_tostring(L, 2);
                    ResourceCacheType _cacheType;translator.Get(L, 3, out _cacheType);
                    
                        var gen_ret = gen_to_be_invoked.LoadAudioClip( _fileName, _cacheType );
                        translator.Push(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_LoadAudioClipAsync(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
                ResourceMgr gen_to_be_invoked = (ResourceMgr)translator.FastGetCSObj(L, 1);
            
            
			    int gen_param_count = LuaAPI.lua_gettop(L);
            
                if(gen_param_count == 5&& (LuaAPI.lua_isnil(L, 2) || LuaAPI.lua_type(L, 2) == LuaTypes.LUA_TSTRING)&& translator.Assignable<System.Action<float, bool, UnityEngine.AudioClip>>(L, 3)&& translator.Assignable<ResourceCacheType>(L, 4)&& LuaTypes.LUA_TNUMBER == LuaAPI.lua_type(L, 5)) 
                {
                    string _fileName = LuaAPI.lua_tostring(L, 2);
                    System.Action<float, bool, UnityEngine.AudioClip> _onProcess = translator.GetDelegate<System.Action<float, bool, UnityEngine.AudioClip>>(L, 3);
                    ResourceCacheType _cacheType;translator.Get(L, 4, out _cacheType);
                    int _priority = LuaAPI.xlua_tointeger(L, 5);
                    
                        var gen_ret = gen_to_be_invoked.LoadAudioClipAsync( _fileName, _onProcess, _cacheType, _priority );
                        LuaAPI.lua_pushboolean(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                if(gen_param_count == 4&& (LuaAPI.lua_isnil(L, 2) || LuaAPI.lua_type(L, 2) == LuaTypes.LUA_TSTRING)&& translator.Assignable<System.Action<float, bool, UnityEngine.AudioClip>>(L, 3)&& translator.Assignable<ResourceCacheType>(L, 4)) 
                {
                    string _fileName = LuaAPI.lua_tostring(L, 2);
                    System.Action<float, bool, UnityEngine.AudioClip> _onProcess = translator.GetDelegate<System.Action<float, bool, UnityEngine.AudioClip>>(L, 3);
                    ResourceCacheType _cacheType;translator.Get(L, 4, out _cacheType);
                    
                        var gen_ret = gen_to_be_invoked.LoadAudioClipAsync( _fileName, _onProcess, _cacheType );
                        LuaAPI.lua_pushboolean(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
            return LuaAPI.luaL_error(L, "invalid arguments to ResourceMgr.LoadAudioClipAsync!");
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_LoadBytes(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
                ResourceMgr gen_to_be_invoked = (ResourceMgr)translator.FastGetCSObj(L, 1);
            
            
			    int gen_param_count = LuaAPI.lua_gettop(L);
            
                if(gen_param_count == 3&& (LuaAPI.lua_isnil(L, 2) || LuaAPI.lua_type(L, 2) == LuaTypes.LUA_TSTRING)&& translator.Assignable<ResourceCacheType>(L, 3)) 
                {
                    string _fileName = LuaAPI.lua_tostring(L, 2);
                    ResourceCacheType _cacheType;translator.Get(L, 3, out _cacheType);
                    
                        var gen_ret = gen_to_be_invoked.LoadBytes( _fileName, _cacheType );
                        LuaAPI.lua_pushstring(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                if(gen_param_count == 2&& (LuaAPI.lua_isnil(L, 2) || LuaAPI.lua_type(L, 2) == LuaTypes.LUA_TSTRING)) 
                {
                    string _fileName = LuaAPI.lua_tostring(L, 2);
                    
                        var gen_ret = gen_to_be_invoked.LoadBytes( _fileName );
                        LuaAPI.lua_pushstring(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
            return LuaAPI.luaL_error(L, "invalid arguments to ResourceMgr.LoadBytes!");
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_LoadText(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
                ResourceMgr gen_to_be_invoked = (ResourceMgr)translator.FastGetCSObj(L, 1);
            
            
			    int gen_param_count = LuaAPI.lua_gettop(L);
            
                if(gen_param_count == 3&& (LuaAPI.lua_isnil(L, 2) || LuaAPI.lua_type(L, 2) == LuaTypes.LUA_TSTRING)&& translator.Assignable<ResourceCacheType>(L, 3)) 
                {
                    string _fileName = LuaAPI.lua_tostring(L, 2);
                    ResourceCacheType _cacheType;translator.Get(L, 3, out _cacheType);
                    
                        var gen_ret = gen_to_be_invoked.LoadText( _fileName, _cacheType );
                        LuaAPI.lua_pushstring(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                if(gen_param_count == 2&& (LuaAPI.lua_isnil(L, 2) || LuaAPI.lua_type(L, 2) == LuaTypes.LUA_TSTRING)) 
                {
                    string _fileName = LuaAPI.lua_tostring(L, 2);
                    
                        var gen_ret = gen_to_be_invoked.LoadText( _fileName );
                        LuaAPI.lua_pushstring(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
            return LuaAPI.luaL_error(L, "invalid arguments to ResourceMgr.LoadText!");
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_LoadTextAsync(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
                ResourceMgr gen_to_be_invoked = (ResourceMgr)translator.FastGetCSObj(L, 1);
            
            
			    int gen_param_count = LuaAPI.lua_gettop(L);
            
                if(gen_param_count == 5&& (LuaAPI.lua_isnil(L, 2) || LuaAPI.lua_type(L, 2) == LuaTypes.LUA_TSTRING)&& translator.Assignable<System.Action<float, bool, UnityEngine.TextAsset>>(L, 3)&& translator.Assignable<ResourceCacheType>(L, 4)&& LuaTypes.LUA_TNUMBER == LuaAPI.lua_type(L, 5)) 
                {
                    string _fileName = LuaAPI.lua_tostring(L, 2);
                    System.Action<float, bool, UnityEngine.TextAsset> _onProcess = translator.GetDelegate<System.Action<float, bool, UnityEngine.TextAsset>>(L, 3);
                    ResourceCacheType _cacheType;translator.Get(L, 4, out _cacheType);
                    int _priority = LuaAPI.xlua_tointeger(L, 5);
                    
                        var gen_ret = gen_to_be_invoked.LoadTextAsync( _fileName, _onProcess, _cacheType, _priority );
                        LuaAPI.lua_pushboolean(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                if(gen_param_count == 4&& (LuaAPI.lua_isnil(L, 2) || LuaAPI.lua_type(L, 2) == LuaTypes.LUA_TSTRING)&& translator.Assignable<System.Action<float, bool, UnityEngine.TextAsset>>(L, 3)&& translator.Assignable<ResourceCacheType>(L, 4)) 
                {
                    string _fileName = LuaAPI.lua_tostring(L, 2);
                    System.Action<float, bool, UnityEngine.TextAsset> _onProcess = translator.GetDelegate<System.Action<float, bool, UnityEngine.TextAsset>>(L, 3);
                    ResourceCacheType _cacheType;translator.Get(L, 4, out _cacheType);
                    
                        var gen_ret = gen_to_be_invoked.LoadTextAsync( _fileName, _onProcess, _cacheType );
                        LuaAPI.lua_pushboolean(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                if(gen_param_count == 3&& (LuaAPI.lua_isnil(L, 2) || LuaAPI.lua_type(L, 2) == LuaTypes.LUA_TSTRING)&& translator.Assignable<System.Action<float, bool, UnityEngine.TextAsset>>(L, 3)) 
                {
                    string _fileName = LuaAPI.lua_tostring(L, 2);
                    System.Action<float, bool, UnityEngine.TextAsset> _onProcess = translator.GetDelegate<System.Action<float, bool, UnityEngine.TextAsset>>(L, 3);
                    
                        var gen_ret = gen_to_be_invoked.LoadTextAsync( _fileName, _onProcess );
                        LuaAPI.lua_pushboolean(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
            return LuaAPI.luaL_error(L, "invalid arguments to ResourceMgr.LoadTextAsync!");
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_LoadAnimationClip(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
                ResourceMgr gen_to_be_invoked = (ResourceMgr)translator.FastGetCSObj(L, 1);
            
            
                
                {
                    string _fileName = LuaAPI.lua_tostring(L, 2);
                    ResourceCacheType _cacheType;translator.Get(L, 3, out _cacheType);
                    
                        var gen_ret = gen_to_be_invoked.LoadAnimationClip( _fileName, _cacheType );
                        translator.Push(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_LoadAnimationClipAsync(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
                ResourceMgr gen_to_be_invoked = (ResourceMgr)translator.FastGetCSObj(L, 1);
            
            
			    int gen_param_count = LuaAPI.lua_gettop(L);
            
                if(gen_param_count == 5&& (LuaAPI.lua_isnil(L, 2) || LuaAPI.lua_type(L, 2) == LuaTypes.LUA_TSTRING)&& translator.Assignable<System.Action<float, bool, UnityEngine.AnimationClip>>(L, 3)&& translator.Assignable<ResourceCacheType>(L, 4)&& LuaTypes.LUA_TNUMBER == LuaAPI.lua_type(L, 5)) 
                {
                    string _fileName = LuaAPI.lua_tostring(L, 2);
                    System.Action<float, bool, UnityEngine.AnimationClip> _onProcess = translator.GetDelegate<System.Action<float, bool, UnityEngine.AnimationClip>>(L, 3);
                    ResourceCacheType _cacheType;translator.Get(L, 4, out _cacheType);
                    int _priority = LuaAPI.xlua_tointeger(L, 5);
                    
                        var gen_ret = gen_to_be_invoked.LoadAnimationClipAsync( _fileName, _onProcess, _cacheType, _priority );
                        LuaAPI.lua_pushboolean(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                if(gen_param_count == 4&& (LuaAPI.lua_isnil(L, 2) || LuaAPI.lua_type(L, 2) == LuaTypes.LUA_TSTRING)&& translator.Assignable<System.Action<float, bool, UnityEngine.AnimationClip>>(L, 3)&& translator.Assignable<ResourceCacheType>(L, 4)) 
                {
                    string _fileName = LuaAPI.lua_tostring(L, 2);
                    System.Action<float, bool, UnityEngine.AnimationClip> _onProcess = translator.GetDelegate<System.Action<float, bool, UnityEngine.AnimationClip>>(L, 3);
                    ResourceCacheType _cacheType;translator.Get(L, 4, out _cacheType);
                    
                        var gen_ret = gen_to_be_invoked.LoadAnimationClipAsync( _fileName, _onProcess, _cacheType );
                        LuaAPI.lua_pushboolean(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
            return LuaAPI.luaL_error(L, "invalid arguments to ResourceMgr.LoadAnimationClipAsync!");
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_LoadAniController(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
                ResourceMgr gen_to_be_invoked = (ResourceMgr)translator.FastGetCSObj(L, 1);
            
            
                
                {
                    string _fileName = LuaAPI.lua_tostring(L, 2);
                    ResourceCacheType _cacheType;translator.Get(L, 3, out _cacheType);
                    
                        var gen_ret = gen_to_be_invoked.LoadAniController( _fileName, _cacheType );
                        translator.Push(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_LoadAniControllerAsync(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
                ResourceMgr gen_to_be_invoked = (ResourceMgr)translator.FastGetCSObj(L, 1);
            
            
			    int gen_param_count = LuaAPI.lua_gettop(L);
            
                if(gen_param_count == 5&& (LuaAPI.lua_isnil(L, 2) || LuaAPI.lua_type(L, 2) == LuaTypes.LUA_TSTRING)&& translator.Assignable<System.Action<float, bool, UnityEngine.RuntimeAnimatorController>>(L, 3)&& translator.Assignable<ResourceCacheType>(L, 4)&& LuaTypes.LUA_TNUMBER == LuaAPI.lua_type(L, 5)) 
                {
                    string _fileName = LuaAPI.lua_tostring(L, 2);
                    System.Action<float, bool, UnityEngine.RuntimeAnimatorController> _onProcess = translator.GetDelegate<System.Action<float, bool, UnityEngine.RuntimeAnimatorController>>(L, 3);
                    ResourceCacheType _cacheType;translator.Get(L, 4, out _cacheType);
                    int _priority = LuaAPI.xlua_tointeger(L, 5);
                    
                        var gen_ret = gen_to_be_invoked.LoadAniControllerAsync( _fileName, _onProcess, _cacheType, _priority );
                        LuaAPI.lua_pushboolean(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                if(gen_param_count == 4&& (LuaAPI.lua_isnil(L, 2) || LuaAPI.lua_type(L, 2) == LuaTypes.LUA_TSTRING)&& translator.Assignable<System.Action<float, bool, UnityEngine.RuntimeAnimatorController>>(L, 3)&& translator.Assignable<ResourceCacheType>(L, 4)) 
                {
                    string _fileName = LuaAPI.lua_tostring(L, 2);
                    System.Action<float, bool, UnityEngine.RuntimeAnimatorController> _onProcess = translator.GetDelegate<System.Action<float, bool, UnityEngine.RuntimeAnimatorController>>(L, 3);
                    ResourceCacheType _cacheType;translator.Get(L, 4, out _cacheType);
                    
                        var gen_ret = gen_to_be_invoked.LoadAniControllerAsync( _fileName, _onProcess, _cacheType );
                        LuaAPI.lua_pushboolean(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
            return LuaAPI.luaL_error(L, "invalid arguments to ResourceMgr.LoadAniControllerAsync!");
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_LoadShader(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
                ResourceMgr gen_to_be_invoked = (ResourceMgr)translator.FastGetCSObj(L, 1);
            
            
                
                {
                    string _fileName = LuaAPI.lua_tostring(L, 2);
                    ResourceCacheType _cacheType;translator.Get(L, 3, out _cacheType);
                    
                        var gen_ret = gen_to_be_invoked.LoadShader( _fileName, _cacheType );
                        translator.Push(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_LoadShaderAsync(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
                ResourceMgr gen_to_be_invoked = (ResourceMgr)translator.FastGetCSObj(L, 1);
            
            
			    int gen_param_count = LuaAPI.lua_gettop(L);
            
                if(gen_param_count == 5&& (LuaAPI.lua_isnil(L, 2) || LuaAPI.lua_type(L, 2) == LuaTypes.LUA_TSTRING)&& translator.Assignable<System.Action<float, bool, UnityEngine.Shader>>(L, 3)&& translator.Assignable<ResourceCacheType>(L, 4)&& LuaTypes.LUA_TNUMBER == LuaAPI.lua_type(L, 5)) 
                {
                    string _fileName = LuaAPI.lua_tostring(L, 2);
                    System.Action<float, bool, UnityEngine.Shader> _onProcess = translator.GetDelegate<System.Action<float, bool, UnityEngine.Shader>>(L, 3);
                    ResourceCacheType _cacheType;translator.Get(L, 4, out _cacheType);
                    int _priority = LuaAPI.xlua_tointeger(L, 5);
                    
                        var gen_ret = gen_to_be_invoked.LoadShaderAsync( _fileName, _onProcess, _cacheType, _priority );
                        LuaAPI.lua_pushboolean(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                if(gen_param_count == 4&& (LuaAPI.lua_isnil(L, 2) || LuaAPI.lua_type(L, 2) == LuaTypes.LUA_TSTRING)&& translator.Assignable<System.Action<float, bool, UnityEngine.Shader>>(L, 3)&& translator.Assignable<ResourceCacheType>(L, 4)) 
                {
                    string _fileName = LuaAPI.lua_tostring(L, 2);
                    System.Action<float, bool, UnityEngine.Shader> _onProcess = translator.GetDelegate<System.Action<float, bool, UnityEngine.Shader>>(L, 3);
                    ResourceCacheType _cacheType;translator.Get(L, 4, out _cacheType);
                    
                        var gen_ret = gen_to_be_invoked.LoadShaderAsync( _fileName, _onProcess, _cacheType );
                        LuaAPI.lua_pushboolean(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
            return LuaAPI.luaL_error(L, "invalid arguments to ResourceMgr.LoadShaderAsync!");
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_LoadFont(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
                ResourceMgr gen_to_be_invoked = (ResourceMgr)translator.FastGetCSObj(L, 1);
            
            
                
                {
                    string _fileName = LuaAPI.lua_tostring(L, 2);
                    ResourceCacheType _cacheType;translator.Get(L, 3, out _cacheType);
                    
                        var gen_ret = gen_to_be_invoked.LoadFont( _fileName, _cacheType );
                        translator.Push(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_LoadFontAsync(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
                ResourceMgr gen_to_be_invoked = (ResourceMgr)translator.FastGetCSObj(L, 1);
            
            
			    int gen_param_count = LuaAPI.lua_gettop(L);
            
                if(gen_param_count == 5&& (LuaAPI.lua_isnil(L, 2) || LuaAPI.lua_type(L, 2) == LuaTypes.LUA_TSTRING)&& translator.Assignable<System.Action<float, bool, UnityEngine.Font>>(L, 3)&& translator.Assignable<ResourceCacheType>(L, 4)&& LuaTypes.LUA_TNUMBER == LuaAPI.lua_type(L, 5)) 
                {
                    string _fileName = LuaAPI.lua_tostring(L, 2);
                    System.Action<float, bool, UnityEngine.Font> _onProcess = translator.GetDelegate<System.Action<float, bool, UnityEngine.Font>>(L, 3);
                    ResourceCacheType _cacheType;translator.Get(L, 4, out _cacheType);
                    int _priority = LuaAPI.xlua_tointeger(L, 5);
                    
                        var gen_ret = gen_to_be_invoked.LoadFontAsync( _fileName, _onProcess, _cacheType, _priority );
                        LuaAPI.lua_pushboolean(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                if(gen_param_count == 4&& (LuaAPI.lua_isnil(L, 2) || LuaAPI.lua_type(L, 2) == LuaTypes.LUA_TSTRING)&& translator.Assignable<System.Action<float, bool, UnityEngine.Font>>(L, 3)&& translator.Assignable<ResourceCacheType>(L, 4)) 
                {
                    string _fileName = LuaAPI.lua_tostring(L, 2);
                    System.Action<float, bool, UnityEngine.Font> _onProcess = translator.GetDelegate<System.Action<float, bool, UnityEngine.Font>>(L, 3);
                    ResourceCacheType _cacheType;translator.Get(L, 4, out _cacheType);
                    
                        var gen_ret = gen_to_be_invoked.LoadFontAsync( _fileName, _onProcess, _cacheType );
                        LuaAPI.lua_pushboolean(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
            return LuaAPI.luaL_error(L, "invalid arguments to ResourceMgr.LoadFontAsync!");
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_PreLoadAndBuildAssetBundleShaders(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
                ResourceMgr gen_to_be_invoked = (ResourceMgr)translator.FastGetCSObj(L, 1);
            
            
			    int gen_param_count = LuaAPI.lua_gettop(L);
            
                if(gen_param_count == 4&& (LuaAPI.lua_isnil(L, 2) || LuaAPI.lua_type(L, 2) == LuaTypes.LUA_TSTRING)&& translator.Assignable<System.Action>(L, 3)&& LuaTypes.LUA_TNUMBER == LuaAPI.lua_type(L, 4)) 
                {
                    string _abFileName = LuaAPI.lua_tostring(L, 2);
                    System.Action _onEnd = translator.GetDelegate<System.Action>(L, 3);
                    int _priority = LuaAPI.xlua_tointeger(L, 4);
                    
                        var gen_ret = gen_to_be_invoked.PreLoadAndBuildAssetBundleShaders( _abFileName, _onEnd, _priority );
                        LuaAPI.lua_pushboolean(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                if(gen_param_count == 3&& (LuaAPI.lua_isnil(L, 2) || LuaAPI.lua_type(L, 2) == LuaTypes.LUA_TSTRING)&& translator.Assignable<System.Action>(L, 3)) 
                {
                    string _abFileName = LuaAPI.lua_tostring(L, 2);
                    System.Action _onEnd = translator.GetDelegate<System.Action>(L, 3);
                    
                        var gen_ret = gen_to_be_invoked.PreLoadAndBuildAssetBundleShaders( _abFileName, _onEnd );
                        LuaAPI.lua_pushboolean(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                if(gen_param_count == 2&& (LuaAPI.lua_isnil(L, 2) || LuaAPI.lua_type(L, 2) == LuaTypes.LUA_TSTRING)) 
                {
                    string _abFileName = LuaAPI.lua_tostring(L, 2);
                    
                        var gen_ret = gen_to_be_invoked.PreLoadAndBuildAssetBundleShaders( _abFileName );
                        LuaAPI.lua_pushboolean(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
            return LuaAPI.luaL_error(L, "invalid arguments to ResourceMgr.PreLoadAndBuildAssetBundleShaders!");
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_PreLoadAssetBundle(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
                ResourceMgr gen_to_be_invoked = (ResourceMgr)translator.FastGetCSObj(L, 1);
            
            
			    int gen_param_count = LuaAPI.lua_gettop(L);
            
                if(gen_param_count == 5&& (LuaAPI.lua_isnil(L, 2) || LuaAPI.lua_type(L, 2) == LuaTypes.LUA_TSTRING)&& translator.Assignable<System.Type>(L, 3)&& translator.Assignable<System.Action>(L, 4)&& LuaTypes.LUA_TNUMBER == LuaAPI.lua_type(L, 5)) 
                {
                    string _abFileName = LuaAPI.lua_tostring(L, 2);
                    System.Type _type = (System.Type)translator.GetObject(L, 3, typeof(System.Type));
                    System.Action _onEnd = translator.GetDelegate<System.Action>(L, 4);
                    int _priority = LuaAPI.xlua_tointeger(L, 5);
                    
                        var gen_ret = gen_to_be_invoked.PreLoadAssetBundle( _abFileName, _type, _onEnd, _priority );
                        LuaAPI.lua_pushboolean(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                if(gen_param_count == 4&& (LuaAPI.lua_isnil(L, 2) || LuaAPI.lua_type(L, 2) == LuaTypes.LUA_TSTRING)&& translator.Assignable<System.Type>(L, 3)&& translator.Assignable<System.Action>(L, 4)) 
                {
                    string _abFileName = LuaAPI.lua_tostring(L, 2);
                    System.Type _type = (System.Type)translator.GetObject(L, 3, typeof(System.Type));
                    System.Action _onEnd = translator.GetDelegate<System.Action>(L, 4);
                    
                        var gen_ret = gen_to_be_invoked.PreLoadAssetBundle( _abFileName, _type, _onEnd );
                        LuaAPI.lua_pushboolean(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                if(gen_param_count == 3&& (LuaAPI.lua_isnil(L, 2) || LuaAPI.lua_type(L, 2) == LuaTypes.LUA_TSTRING)&& translator.Assignable<System.Type>(L, 3)) 
                {
                    string _abFileName = LuaAPI.lua_tostring(L, 2);
                    System.Type _type = (System.Type)translator.GetObject(L, 3, typeof(System.Type));
                    
                        var gen_ret = gen_to_be_invoked.PreLoadAssetBundle( _abFileName, _type );
                        LuaAPI.lua_pushboolean(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
            return LuaAPI.luaL_error(L, "invalid arguments to ResourceMgr.PreLoadAssetBundle!");
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_DestroySprites(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
                ResourceMgr gen_to_be_invoked = (ResourceMgr)translator.FastGetCSObj(L, 1);
            
            
			    int gen_param_count = LuaAPI.lua_gettop(L);
            
                if(gen_param_count == 3&& translator.Assignable<UnityEngine.Sprite[]>(L, 2)&& LuaTypes.LUA_TBOOLEAN == LuaAPI.lua_type(L, 3)) 
                {
                    UnityEngine.Sprite[] _sprites = (UnityEngine.Sprite[])translator.GetObject(L, 2, typeof(UnityEngine.Sprite[]));
                    bool _isUnloadAsset = LuaAPI.lua_toboolean(L, 3);
                    
                    gen_to_be_invoked.DestroySprites( _sprites, _isUnloadAsset );
                    
                    
                    
                    return 0;
                }
                if(gen_param_count == 2&& translator.Assignable<UnityEngine.Sprite[]>(L, 2)) 
                {
                    UnityEngine.Sprite[] _sprites = (UnityEngine.Sprite[])translator.GetObject(L, 2, typeof(UnityEngine.Sprite[]));
                    
                    gen_to_be_invoked.DestroySprites( _sprites );
                    
                    
                    
                    return 0;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
            return LuaAPI.luaL_error(L, "invalid arguments to ResourceMgr.DestroySprites!");
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_DestroyObjects(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
                ResourceMgr gen_to_be_invoked = (ResourceMgr)translator.FastGetCSObj(L, 1);
            
            
			    int gen_param_count = LuaAPI.lua_gettop(L);
            
                if(gen_param_count == 3&& translator.Assignable<UnityEngine.Object[]>(L, 2)&& LuaTypes.LUA_TBOOLEAN == LuaAPI.lua_type(L, 3)) 
                {
                    UnityEngine.Object[] _objs = (UnityEngine.Object[])translator.GetObject(L, 2, typeof(UnityEngine.Object[]));
                    bool _isUnloadAsset = LuaAPI.lua_toboolean(L, 3);
                    
                    gen_to_be_invoked.DestroyObjects( _objs, _isUnloadAsset );
                    
                    
                    
                    return 0;
                }
                if(gen_param_count == 2&& translator.Assignable<UnityEngine.Object[]>(L, 2)) 
                {
                    UnityEngine.Object[] _objs = (UnityEngine.Object[])translator.GetObject(L, 2, typeof(UnityEngine.Object[]));
                    
                    gen_to_be_invoked.DestroyObjects( _objs );
                    
                    
                    
                    return 0;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
            return LuaAPI.luaL_error(L, "invalid arguments to ResourceMgr.DestroyObjects!");
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_LoadSprites(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
                ResourceMgr gen_to_be_invoked = (ResourceMgr)translator.FastGetCSObj(L, 1);
            
            
                
                {
                    string _fileName = LuaAPI.lua_tostring(L, 2);
                    
                        var gen_ret = gen_to_be_invoked.LoadSprites( _fileName );
                        translator.Push(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_LoadSpritesAsync(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
                ResourceMgr gen_to_be_invoked = (ResourceMgr)translator.FastGetCSObj(L, 1);
            
            
			    int gen_param_count = LuaAPI.lua_gettop(L);
            
                if(gen_param_count == 4&& (LuaAPI.lua_isnil(L, 2) || LuaAPI.lua_type(L, 2) == LuaTypes.LUA_TSTRING)&& translator.Assignable<System.Action<float, bool, UnityEngine.Object[]>>(L, 3)&& LuaTypes.LUA_TNUMBER == LuaAPI.lua_type(L, 4)) 
                {
                    string _fileName = LuaAPI.lua_tostring(L, 2);
                    System.Action<float, bool, UnityEngine.Object[]> _onProcess = translator.GetDelegate<System.Action<float, bool, UnityEngine.Object[]>>(L, 3);
                    int _priority = LuaAPI.xlua_tointeger(L, 4);
                    
                        var gen_ret = gen_to_be_invoked.LoadSpritesAsync( _fileName, _onProcess, _priority );
                        LuaAPI.lua_pushboolean(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                if(gen_param_count == 3&& (LuaAPI.lua_isnil(L, 2) || LuaAPI.lua_type(L, 2) == LuaTypes.LUA_TSTRING)&& translator.Assignable<System.Action<float, bool, UnityEngine.Object[]>>(L, 3)) 
                {
                    string _fileName = LuaAPI.lua_tostring(L, 2);
                    System.Action<float, bool, UnityEngine.Object[]> _onProcess = translator.GetDelegate<System.Action<float, bool, UnityEngine.Object[]>>(L, 3);
                    
                        var gen_ret = gen_to_be_invoked.LoadSpritesAsync( _fileName, _onProcess );
                        LuaAPI.lua_pushboolean(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
            return LuaAPI.luaL_error(L, "invalid arguments to ResourceMgr.LoadSpritesAsync!");
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_LoadScriptableObject(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
                ResourceMgr gen_to_be_invoked = (ResourceMgr)translator.FastGetCSObj(L, 1);
            
            
                
                {
                    string _fileName = LuaAPI.lua_tostring(L, 2);
                    ResourceCacheType _cacheType;translator.Get(L, 3, out _cacheType);
                    
                        var gen_ret = gen_to_be_invoked.LoadScriptableObject( _fileName, _cacheType );
                        translator.Push(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_LoadScriptableObjectAsync(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
                ResourceMgr gen_to_be_invoked = (ResourceMgr)translator.FastGetCSObj(L, 1);
            
            
			    int gen_param_count = LuaAPI.lua_gettop(L);
            
                if(gen_param_count == 5&& (LuaAPI.lua_isnil(L, 2) || LuaAPI.lua_type(L, 2) == LuaTypes.LUA_TSTRING)&& translator.Assignable<ResourceCacheType>(L, 3)&& translator.Assignable<System.Action<float, bool, UnityEngine.ScriptableObject>>(L, 4)&& LuaTypes.LUA_TNUMBER == LuaAPI.lua_type(L, 5)) 
                {
                    string _fileName = LuaAPI.lua_tostring(L, 2);
                    ResourceCacheType _cacheType;translator.Get(L, 3, out _cacheType);
                    System.Action<float, bool, UnityEngine.ScriptableObject> _onProcess = translator.GetDelegate<System.Action<float, bool, UnityEngine.ScriptableObject>>(L, 4);
                    int _priority = LuaAPI.xlua_tointeger(L, 5);
                    
                        var gen_ret = gen_to_be_invoked.LoadScriptableObjectAsync( _fileName, _cacheType, _onProcess, _priority );
                        LuaAPI.lua_pushboolean(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                if(gen_param_count == 4&& (LuaAPI.lua_isnil(L, 2) || LuaAPI.lua_type(L, 2) == LuaTypes.LUA_TSTRING)&& translator.Assignable<ResourceCacheType>(L, 3)&& translator.Assignable<System.Action<float, bool, UnityEngine.ScriptableObject>>(L, 4)) 
                {
                    string _fileName = LuaAPI.lua_tostring(L, 2);
                    ResourceCacheType _cacheType;translator.Get(L, 3, out _cacheType);
                    System.Action<float, bool, UnityEngine.ScriptableObject> _onProcess = translator.GetDelegate<System.Action<float, bool, UnityEngine.ScriptableObject>>(L, 4);
                    
                        var gen_ret = gen_to_be_invoked.LoadScriptableObjectAsync( _fileName, _cacheType, _onProcess );
                        LuaAPI.lua_pushboolean(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
            return LuaAPI.luaL_error(L, "invalid arguments to ResourceMgr.LoadScriptableObjectAsync!");
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_UnloadUnUsed(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
                ResourceMgr gen_to_be_invoked = (ResourceMgr)translator.FastGetCSObj(L, 1);
            
            
                
                {
                    
                    gen_to_be_invoked.UnloadUnUsed(  );
                    
                    
                    
                    return 0;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_OnApplicationQuit(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
                ResourceMgr gen_to_be_invoked = (ResourceMgr)translator.FastGetCSObj(L, 1);
            
            
                
                {
                    
                    gen_to_be_invoked.OnApplicationQuit(  );
                    
                    
                    
                    return 0;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_AutoUpdateClear(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
                ResourceMgr gen_to_be_invoked = (ResourceMgr)translator.FastGetCSObj(L, 1);
            
            
                
                {
                    
                    gen_to_be_invoked.AutoUpdateClear(  );
                    
                    
                    
                    return 0;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_GetABShaderFileNameByName(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
                ResourceMgr gen_to_be_invoked = (ResourceMgr)translator.FastGetCSObj(L, 1);
            
            
                
                {
                    string _shaderName = LuaAPI.lua_tostring(L, 2);
                    
                        var gen_ret = gen_to_be_invoked.GetABShaderFileNameByName( _shaderName );
                        LuaAPI.lua_pushstring(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_GetAssetBundleFileName(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
                ResourceMgr gen_to_be_invoked = (ResourceMgr)translator.FastGetCSObj(L, 1);
            
            
                
                {
                    string _fileName = LuaAPI.lua_tostring(L, 2);
                    
                        var gen_ret = gen_to_be_invoked.GetAssetBundleFileName( _fileName );
                        LuaAPI.lua_pushstring(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
        }
        
        
        
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _g_get_AssetLoader(RealStatePtr L)
        {
		    try {
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
			
                ResourceMgr gen_to_be_invoked = (ResourceMgr)translator.FastGetCSObj(L, 1);
                translator.Push(L, gen_to_be_invoked.AssetLoader);
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            return 1;
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _g_get_ResLoader(RealStatePtr L)
        {
		    try {
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
			
                ResourceMgr gen_to_be_invoked = (ResourceMgr)translator.FastGetCSObj(L, 1);
                translator.Push(L, gen_to_be_invoked.ResLoader);
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            return 1;
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _g_get_IsQuitApp(RealStatePtr L)
        {
		    try {
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
			
                ResourceMgr gen_to_be_invoked = (ResourceMgr)translator.FastGetCSObj(L, 1);
                LuaAPI.lua_pushboolean(L, gen_to_be_invoked.IsQuitApp);
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            return 1;
        }
        
        
        
		
		
		
		
    }
}
