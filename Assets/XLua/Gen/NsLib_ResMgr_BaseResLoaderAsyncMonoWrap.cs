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
    public class NsLibResMgrBaseResLoaderAsyncMonoWrap 
    {
        public static void __Register(RealStatePtr L)
        {
			ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
			System.Type type = typeof(NsLib.ResMgr.BaseResLoaderAsyncMono);
			Utils.BeginObjectRegister(type, L, translator, 0, 14, 1, 0);
			
			Utils.RegisterFunc(L, Utils.METHOD_IDX, "ClearAllResources", _m_ClearAllResources);
			Utils.RegisterFunc(L, Utils.METHOD_IDX, "ClearAllLoadingAsync", _m_ClearAllLoadingAsync);
			Utils.RegisterFunc(L, Utils.METHOD_IDX, "_OnLoadFail", _m__OnLoadFail);
			Utils.RegisterFunc(L, Utils.METHOD_IDX, "OnDestroyObj", _m_OnDestroyObj);
			Utils.RegisterFunc(L, Utils.METHOD_IDX, "LoadFontAsync", _m_LoadFontAsync);
			Utils.RegisterFunc(L, Utils.METHOD_IDX, "LoadAniControllerAsync", _m_LoadAniControllerAsync);
			Utils.RegisterFunc(L, Utils.METHOD_IDX, "LoadMainTextureAsync", _m_LoadMainTextureAsync);
			Utils.RegisterFunc(L, Utils.METHOD_IDX, "LoadMaterialAsync", _m_LoadMaterialAsync);
			Utils.RegisterFunc(L, Utils.METHOD_IDX, "_OnPrefabLoaded", _m__OnPrefabLoaded);
			Utils.RegisterFunc(L, Utils.METHOD_IDX, "_OnShaderLoaded", _m__OnShaderLoaded);
			Utils.RegisterFunc(L, Utils.METHOD_IDX, "_OnTextureLoaded", _m__OnTextureLoaded);
			Utils.RegisterFunc(L, Utils.METHOD_IDX, "_OnAniControlLoaded", _m__OnAniControlLoaded);
			Utils.RegisterFunc(L, Utils.METHOD_IDX, "_OnMaterialLoaded", _m__OnMaterialLoaded);
			Utils.RegisterFunc(L, Utils.METHOD_IDX, "_OnFontLoaded", _m__OnFontLoaded);
			
			
			Utils.RegisterFunc(L, Utils.GETTER_IDX, "UUID", _g_get_UUID);
            
			
			
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
					
					var gen_ret = new NsLib.ResMgr.BaseResLoaderAsyncMono();
					translator.Push(L, gen_ret);
                    
					return 1;
				}
				
			}
			catch(System.Exception gen_e) {
				return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
			}
            return LuaAPI.luaL_error(L, "invalid arguments to NsLib.ResMgr.BaseResLoaderAsyncMono constructor!");
            
        }
        
		
        
		
        
        
        
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_ClearAllResources(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
                NsLib.ResMgr.BaseResLoaderAsyncMono gen_to_be_invoked = (NsLib.ResMgr.BaseResLoaderAsyncMono)translator.FastGetCSObj(L, 1);
            
            
                
                {
                    
                    gen_to_be_invoked.ClearAllResources(  );
                    
                    
                    
                    return 0;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_ClearAllLoadingAsync(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
                NsLib.ResMgr.BaseResLoaderAsyncMono gen_to_be_invoked = (NsLib.ResMgr.BaseResLoaderAsyncMono)translator.FastGetCSObj(L, 1);
            
            
                
                {
                    UnityEngine.Object _obj = (UnityEngine.Object)translator.GetObject(L, 2, typeof(UnityEngine.Object));
                    
                        var gen_ret = gen_to_be_invoked.ClearAllLoadingAsync( _obj );
                        LuaAPI.lua_pushboolean(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m__OnLoadFail(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
                NsLib.ResMgr.BaseResLoaderAsyncMono gen_to_be_invoked = (NsLib.ResMgr.BaseResLoaderAsyncMono)translator.FastGetCSObj(L, 1);
            
            
                
                {
                    ulong _subID = LuaAPI.lua_touint64(L, 2);
                    
                    gen_to_be_invoked._OnLoadFail( _subID );
                    
                    
                    
                    return 0;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_OnDestroyObj(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
                NsLib.ResMgr.BaseResLoaderAsyncMono gen_to_be_invoked = (NsLib.ResMgr.BaseResLoaderAsyncMono)translator.FastGetCSObj(L, 1);
            
            
                
                {
                    UnityEngine.Object _obj = (UnityEngine.Object)translator.GetObject(L, 2, typeof(UnityEngine.Object));
                    
                        var gen_ret = gen_to_be_invoked.OnDestroyObj( _obj );
                        LuaAPI.lua_pushboolean(L, gen_ret);
                    
                    
                    
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
            
            
                NsLib.ResMgr.BaseResLoaderAsyncMono gen_to_be_invoked = (NsLib.ResMgr.BaseResLoaderAsyncMono)translator.FastGetCSObj(L, 1);
            
            
			    int gen_param_count = LuaAPI.lua_gettop(L);
            
                if(gen_param_count == 4&& (LuaAPI.lua_isnil(L, 2) || LuaAPI.lua_type(L, 2) == LuaTypes.LUA_TSTRING)&& translator.Assignable<UnityEngine.TextMesh>(L, 3)&& LuaTypes.LUA_TNUMBER == LuaAPI.lua_type(L, 4)) 
                {
                    string _fileName = LuaAPI.lua_tostring(L, 2);
                    UnityEngine.TextMesh _obj = (UnityEngine.TextMesh)translator.GetObject(L, 3, typeof(UnityEngine.TextMesh));
                    int _loadPriority = LuaAPI.xlua_tointeger(L, 4);
                    
                        var gen_ret = gen_to_be_invoked.LoadFontAsync( _fileName, _obj, _loadPriority );
                        LuaAPI.lua_pushboolean(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                if(gen_param_count == 3&& (LuaAPI.lua_isnil(L, 2) || LuaAPI.lua_type(L, 2) == LuaTypes.LUA_TSTRING)&& translator.Assignable<UnityEngine.TextMesh>(L, 3)) 
                {
                    string _fileName = LuaAPI.lua_tostring(L, 2);
                    UnityEngine.TextMesh _obj = (UnityEngine.TextMesh)translator.GetObject(L, 3, typeof(UnityEngine.TextMesh));
                    
                        var gen_ret = gen_to_be_invoked.LoadFontAsync( _fileName, _obj );
                        LuaAPI.lua_pushboolean(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
            return LuaAPI.luaL_error(L, "invalid arguments to NsLib.ResMgr.BaseResLoaderAsyncMono.LoadFontAsync!");
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_LoadAniControllerAsync(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
                NsLib.ResMgr.BaseResLoaderAsyncMono gen_to_be_invoked = (NsLib.ResMgr.BaseResLoaderAsyncMono)translator.FastGetCSObj(L, 1);
            
            
			    int gen_param_count = LuaAPI.lua_gettop(L);
            
                if(gen_param_count == 4&& (LuaAPI.lua_isnil(L, 2) || LuaAPI.lua_type(L, 2) == LuaTypes.LUA_TSTRING)&& translator.Assignable<UnityEngine.Animator>(L, 3)&& LuaTypes.LUA_TNUMBER == LuaAPI.lua_type(L, 4)) 
                {
                    string _fileName = LuaAPI.lua_tostring(L, 2);
                    UnityEngine.Animator _obj = (UnityEngine.Animator)translator.GetObject(L, 3, typeof(UnityEngine.Animator));
                    int _loadPriority = LuaAPI.xlua_tointeger(L, 4);
                    
                        var gen_ret = gen_to_be_invoked.LoadAniControllerAsync( _fileName, _obj, _loadPriority );
                        LuaAPI.lua_pushboolean(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                if(gen_param_count == 3&& (LuaAPI.lua_isnil(L, 2) || LuaAPI.lua_type(L, 2) == LuaTypes.LUA_TSTRING)&& translator.Assignable<UnityEngine.Animator>(L, 3)) 
                {
                    string _fileName = LuaAPI.lua_tostring(L, 2);
                    UnityEngine.Animator _obj = (UnityEngine.Animator)translator.GetObject(L, 3, typeof(UnityEngine.Animator));
                    
                        var gen_ret = gen_to_be_invoked.LoadAniControllerAsync( _fileName, _obj );
                        LuaAPI.lua_pushboolean(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
            return LuaAPI.luaL_error(L, "invalid arguments to NsLib.ResMgr.BaseResLoaderAsyncMono.LoadAniControllerAsync!");
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_LoadMainTextureAsync(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
                NsLib.ResMgr.BaseResLoaderAsyncMono gen_to_be_invoked = (NsLib.ResMgr.BaseResLoaderAsyncMono)translator.FastGetCSObj(L, 1);
            
            
			    int gen_param_count = LuaAPI.lua_gettop(L);
            
                if(gen_param_count == 5&& (LuaAPI.lua_isnil(L, 2) || LuaAPI.lua_type(L, 2) == LuaTypes.LUA_TSTRING)&& translator.Assignable<UnityEngine.SpriteRenderer>(L, 3)&& LuaTypes.LUA_TBOOLEAN == LuaAPI.lua_type(L, 4)&& LuaTypes.LUA_TNUMBER == LuaAPI.lua_type(L, 5)) 
                {
                    string _fileName = LuaAPI.lua_tostring(L, 2);
                    UnityEngine.SpriteRenderer _renderer = (UnityEngine.SpriteRenderer)translator.GetObject(L, 3, typeof(UnityEngine.SpriteRenderer));
                    bool _isMatInst = LuaAPI.lua_toboolean(L, 4);
                    int _loadPriority = LuaAPI.xlua_tointeger(L, 5);
                    
                        var gen_ret = gen_to_be_invoked.LoadMainTextureAsync( _fileName, _renderer, _isMatInst, _loadPriority );
                        LuaAPI.lua_pushboolean(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                if(gen_param_count == 4&& (LuaAPI.lua_isnil(L, 2) || LuaAPI.lua_type(L, 2) == LuaTypes.LUA_TSTRING)&& translator.Assignable<UnityEngine.SpriteRenderer>(L, 3)&& LuaTypes.LUA_TBOOLEAN == LuaAPI.lua_type(L, 4)) 
                {
                    string _fileName = LuaAPI.lua_tostring(L, 2);
                    UnityEngine.SpriteRenderer _renderer = (UnityEngine.SpriteRenderer)translator.GetObject(L, 3, typeof(UnityEngine.SpriteRenderer));
                    bool _isMatInst = LuaAPI.lua_toboolean(L, 4);
                    
                        var gen_ret = gen_to_be_invoked.LoadMainTextureAsync( _fileName, _renderer, _isMatInst );
                        LuaAPI.lua_pushboolean(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                if(gen_param_count == 3&& (LuaAPI.lua_isnil(L, 2) || LuaAPI.lua_type(L, 2) == LuaTypes.LUA_TSTRING)&& translator.Assignable<UnityEngine.SpriteRenderer>(L, 3)) 
                {
                    string _fileName = LuaAPI.lua_tostring(L, 2);
                    UnityEngine.SpriteRenderer _renderer = (UnityEngine.SpriteRenderer)translator.GetObject(L, 3, typeof(UnityEngine.SpriteRenderer));
                    
                        var gen_ret = gen_to_be_invoked.LoadMainTextureAsync( _fileName, _renderer );
                        LuaAPI.lua_pushboolean(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                if(gen_param_count == 5&& (LuaAPI.lua_isnil(L, 2) || LuaAPI.lua_type(L, 2) == LuaTypes.LUA_TSTRING)&& translator.Assignable<UnityEngine.MeshRenderer>(L, 3)&& LuaTypes.LUA_TBOOLEAN == LuaAPI.lua_type(L, 4)&& LuaTypes.LUA_TNUMBER == LuaAPI.lua_type(L, 5)) 
                {
                    string _fileName = LuaAPI.lua_tostring(L, 2);
                    UnityEngine.MeshRenderer _renderer = (UnityEngine.MeshRenderer)translator.GetObject(L, 3, typeof(UnityEngine.MeshRenderer));
                    bool _isMatInst = LuaAPI.lua_toboolean(L, 4);
                    int _loadPriority = LuaAPI.xlua_tointeger(L, 5);
                    
                        var gen_ret = gen_to_be_invoked.LoadMainTextureAsync( _fileName, _renderer, _isMatInst, _loadPriority );
                        LuaAPI.lua_pushboolean(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                if(gen_param_count == 4&& (LuaAPI.lua_isnil(L, 2) || LuaAPI.lua_type(L, 2) == LuaTypes.LUA_TSTRING)&& translator.Assignable<UnityEngine.MeshRenderer>(L, 3)&& LuaTypes.LUA_TBOOLEAN == LuaAPI.lua_type(L, 4)) 
                {
                    string _fileName = LuaAPI.lua_tostring(L, 2);
                    UnityEngine.MeshRenderer _renderer = (UnityEngine.MeshRenderer)translator.GetObject(L, 3, typeof(UnityEngine.MeshRenderer));
                    bool _isMatInst = LuaAPI.lua_toboolean(L, 4);
                    
                        var gen_ret = gen_to_be_invoked.LoadMainTextureAsync( _fileName, _renderer, _isMatInst );
                        LuaAPI.lua_pushboolean(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                if(gen_param_count == 3&& (LuaAPI.lua_isnil(L, 2) || LuaAPI.lua_type(L, 2) == LuaTypes.LUA_TSTRING)&& translator.Assignable<UnityEngine.MeshRenderer>(L, 3)) 
                {
                    string _fileName = LuaAPI.lua_tostring(L, 2);
                    UnityEngine.MeshRenderer _renderer = (UnityEngine.MeshRenderer)translator.GetObject(L, 3, typeof(UnityEngine.MeshRenderer));
                    
                        var gen_ret = gen_to_be_invoked.LoadMainTextureAsync( _fileName, _renderer );
                        LuaAPI.lua_pushboolean(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
            return LuaAPI.luaL_error(L, "invalid arguments to NsLib.ResMgr.BaseResLoaderAsyncMono.LoadMainTextureAsync!");
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_LoadMaterialAsync(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
                NsLib.ResMgr.BaseResLoaderAsyncMono gen_to_be_invoked = (NsLib.ResMgr.BaseResLoaderAsyncMono)translator.FastGetCSObj(L, 1);
            
            
			    int gen_param_count = LuaAPI.lua_gettop(L);
            
                if(gen_param_count == 4&& (LuaAPI.lua_isnil(L, 2) || LuaAPI.lua_type(L, 2) == LuaTypes.LUA_TSTRING)&& translator.Assignable<UnityEngine.SpriteRenderer>(L, 3)&& LuaTypes.LUA_TNUMBER == LuaAPI.lua_type(L, 4)) 
                {
                    string _fileName = LuaAPI.lua_tostring(L, 2);
                    UnityEngine.SpriteRenderer _renderer = (UnityEngine.SpriteRenderer)translator.GetObject(L, 3, typeof(UnityEngine.SpriteRenderer));
                    int _loadPriority = LuaAPI.xlua_tointeger(L, 4);
                    
                        var gen_ret = gen_to_be_invoked.LoadMaterialAsync( _fileName, _renderer, _loadPriority );
                        LuaAPI.lua_pushboolean(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                if(gen_param_count == 3&& (LuaAPI.lua_isnil(L, 2) || LuaAPI.lua_type(L, 2) == LuaTypes.LUA_TSTRING)&& translator.Assignable<UnityEngine.SpriteRenderer>(L, 3)) 
                {
                    string _fileName = LuaAPI.lua_tostring(L, 2);
                    UnityEngine.SpriteRenderer _renderer = (UnityEngine.SpriteRenderer)translator.GetObject(L, 3, typeof(UnityEngine.SpriteRenderer));
                    
                        var gen_ret = gen_to_be_invoked.LoadMaterialAsync( _fileName, _renderer );
                        LuaAPI.lua_pushboolean(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                if(gen_param_count == 4&& (LuaAPI.lua_isnil(L, 2) || LuaAPI.lua_type(L, 2) == LuaTypes.LUA_TSTRING)&& translator.Assignable<UnityEngine.MeshRenderer>(L, 3)&& LuaTypes.LUA_TNUMBER == LuaAPI.lua_type(L, 4)) 
                {
                    string _fileName = LuaAPI.lua_tostring(L, 2);
                    UnityEngine.MeshRenderer _renderer = (UnityEngine.MeshRenderer)translator.GetObject(L, 3, typeof(UnityEngine.MeshRenderer));
                    int _loadPriority = LuaAPI.xlua_tointeger(L, 4);
                    
                        var gen_ret = gen_to_be_invoked.LoadMaterialAsync( _fileName, _renderer, _loadPriority );
                        LuaAPI.lua_pushboolean(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                if(gen_param_count == 3&& (LuaAPI.lua_isnil(L, 2) || LuaAPI.lua_type(L, 2) == LuaTypes.LUA_TSTRING)&& translator.Assignable<UnityEngine.MeshRenderer>(L, 3)) 
                {
                    string _fileName = LuaAPI.lua_tostring(L, 2);
                    UnityEngine.MeshRenderer _renderer = (UnityEngine.MeshRenderer)translator.GetObject(L, 3, typeof(UnityEngine.MeshRenderer));
                    
                        var gen_ret = gen_to_be_invoked.LoadMaterialAsync( _fileName, _renderer );
                        LuaAPI.lua_pushboolean(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
            return LuaAPI.luaL_error(L, "invalid arguments to NsLib.ResMgr.BaseResLoaderAsyncMono.LoadMaterialAsync!");
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m__OnPrefabLoaded(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
                NsLib.ResMgr.BaseResLoaderAsyncMono gen_to_be_invoked = (NsLib.ResMgr.BaseResLoaderAsyncMono)translator.FastGetCSObj(L, 1);
            
            
                
                {
                    UnityEngine.GameObject _target = (UnityEngine.GameObject)translator.GetObject(L, 2, typeof(UnityEngine.GameObject));
                    ulong _subID = LuaAPI.lua_touint64(L, 3);
                    
                        var gen_ret = gen_to_be_invoked._OnPrefabLoaded( _target, _subID );
                        LuaAPI.lua_pushboolean(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m__OnShaderLoaded(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
                NsLib.ResMgr.BaseResLoaderAsyncMono gen_to_be_invoked = (NsLib.ResMgr.BaseResLoaderAsyncMono)translator.FastGetCSObj(L, 1);
            
            
                
                {
                    UnityEngine.Shader _target = (UnityEngine.Shader)translator.GetObject(L, 2, typeof(UnityEngine.Shader));
                    ulong _subID = LuaAPI.lua_touint64(L, 3);
                    
                        var gen_ret = gen_to_be_invoked._OnShaderLoaded( _target, _subID );
                        LuaAPI.lua_pushboolean(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m__OnTextureLoaded(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
                NsLib.ResMgr.BaseResLoaderAsyncMono gen_to_be_invoked = (NsLib.ResMgr.BaseResLoaderAsyncMono)translator.FastGetCSObj(L, 1);
            
            
                
                {
                    UnityEngine.Texture _target = (UnityEngine.Texture)translator.GetObject(L, 2, typeof(UnityEngine.Texture));
                    ulong _subID = LuaAPI.lua_touint64(L, 3);
                    
                        var gen_ret = gen_to_be_invoked._OnTextureLoaded( _target, _subID );
                        LuaAPI.lua_pushboolean(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m__OnAniControlLoaded(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
                NsLib.ResMgr.BaseResLoaderAsyncMono gen_to_be_invoked = (NsLib.ResMgr.BaseResLoaderAsyncMono)translator.FastGetCSObj(L, 1);
            
            
                
                {
                    UnityEngine.RuntimeAnimatorController _target = (UnityEngine.RuntimeAnimatorController)translator.GetObject(L, 2, typeof(UnityEngine.RuntimeAnimatorController));
                    ulong _subID = LuaAPI.lua_touint64(L, 3);
                    
                        var gen_ret = gen_to_be_invoked._OnAniControlLoaded( _target, _subID );
                        LuaAPI.lua_pushboolean(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m__OnMaterialLoaded(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
                NsLib.ResMgr.BaseResLoaderAsyncMono gen_to_be_invoked = (NsLib.ResMgr.BaseResLoaderAsyncMono)translator.FastGetCSObj(L, 1);
            
            
                
                {
                    UnityEngine.Material _target = (UnityEngine.Material)translator.GetObject(L, 2, typeof(UnityEngine.Material));
                    ulong _subID = LuaAPI.lua_touint64(L, 3);
                    
                        var gen_ret = gen_to_be_invoked._OnMaterialLoaded( _target, _subID );
                        LuaAPI.lua_pushboolean(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m__OnFontLoaded(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
                NsLib.ResMgr.BaseResLoaderAsyncMono gen_to_be_invoked = (NsLib.ResMgr.BaseResLoaderAsyncMono)translator.FastGetCSObj(L, 1);
            
            
                
                {
                    UnityEngine.Font _target = (UnityEngine.Font)translator.GetObject(L, 2, typeof(UnityEngine.Font));
                    ulong _subID = LuaAPI.lua_touint64(L, 3);
                    
                        var gen_ret = gen_to_be_invoked._OnFontLoaded( _target, _subID );
                        LuaAPI.lua_pushboolean(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
        }
        
        
        
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _g_get_UUID(RealStatePtr L)
        {
		    try {
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
			
                NsLib.ResMgr.BaseResLoaderAsyncMono gen_to_be_invoked = (NsLib.ResMgr.BaseResLoaderAsyncMono)translator.FastGetCSObj(L, 1);
                LuaAPI.xlua_pushinteger(L, gen_to_be_invoked.UUID);
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            return 1;
        }
        
        
        
		
		
		
		
    }
}
