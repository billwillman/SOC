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
    public class BaseResLoaderWrap 
    {
        public static void __Register(RealStatePtr L)
        {
			ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
			System.Type type = typeof(BaseResLoader);
			Utils.BeginObjectRegister(type, L, translator, 0, 23, 0, 0);
			
			Utils.RegisterFunc(L, Utils.METHOD_IDX, "ClearAllResources", _m_ClearAllResources);
			Utils.RegisterFunc(L, Utils.METHOD_IDX, "LoadMaterial", _m_LoadMaterial);
			Utils.RegisterFunc(L, Utils.METHOD_IDX, "ClearMaterials", _m_ClearMaterials);
			Utils.RegisterFunc(L, Utils.METHOD_IDX, "ClearMaterial", _m_ClearMaterial);
			Utils.RegisterFunc(L, Utils.METHOD_IDX, "LoadSprite", _m_LoadSprite);
			Utils.RegisterFunc(L, Utils.METHOD_IDX, "LoadGameObject", _m_LoadGameObject);
			Utils.RegisterFunc(L, Utils.METHOD_IDX, "ClearGameObject", _m_ClearGameObject);
			Utils.RegisterFunc(L, Utils.METHOD_IDX, "ClearMaterail", _m_ClearMaterail);
			Utils.RegisterFunc(L, Utils.METHOD_IDX, "ClearTexture", _m_ClearTexture);
			Utils.RegisterFunc(L, Utils.METHOD_IDX, "LoadTexture", _m_LoadTexture);
			Utils.RegisterFunc(L, Utils.METHOD_IDX, "ClearShader", _m_ClearShader);
			Utils.RegisterFunc(L, Utils.METHOD_IDX, "LoadShader", _m_LoadShader);
			Utils.RegisterFunc(L, Utils.METHOD_IDX, "ClearAudioClip", _m_ClearAudioClip);
			Utils.RegisterFunc(L, Utils.METHOD_IDX, "LoadAudioClip", _m_LoadAudioClip);
			Utils.RegisterFunc(L, Utils.METHOD_IDX, "ClearAnimationClip", _m_ClearAnimationClip);
			Utils.RegisterFunc(L, Utils.METHOD_IDX, "LoadAnimationClip", _m_LoadAnimationClip);
			Utils.RegisterFunc(L, Utils.METHOD_IDX, "ClearFont", _m_ClearFont);
			Utils.RegisterFunc(L, Utils.METHOD_IDX, "LoadFont", _m_LoadFont);
			Utils.RegisterFunc(L, Utils.METHOD_IDX, "ClearAniController", _m_ClearAniController);
			Utils.RegisterFunc(L, Utils.METHOD_IDX, "LoadAniController", _m_LoadAniController);
			Utils.RegisterFunc(L, Utils.METHOD_IDX, "GetResList", _m_GetResList);
			Utils.RegisterFunc(L, Utils.METHOD_IDX, "ClearMainTexture", _m_ClearMainTexture);
			Utils.RegisterFunc(L, Utils.METHOD_IDX, "LoadMainTexture", _m_LoadMainTexture);
			
			
			
			
			
			Utils.EndObjectRegister(type, L, translator, null, null,
			    null, null, null);

		    Utils.BeginClassRegister(type, L, __CreateInstance, 9, 0, 0);
			Utils.RegisterFunc(L, Utils.CLS_IDX, "InstantiateGameObj", _m_InstantiateGameObj_xlua_st_);
            Utils.RegisterFunc(L, Utils.CLS_IDX, "DestroyGameObj", _m_DestroyGameObj_xlua_st_);
            Utils.RegisterFunc(L, Utils.CLS_IDX, "CreateGameObject", _m_CreateGameObject_xlua_st_);
            
			
            Utils.RegisterObject(L, translator, Utils.CLS_IDX, "_cMainTex", BaseResLoader._cMainTex);
            Utils.RegisterObject(L, translator, Utils.CLS_IDX, "_cMainMat", BaseResLoader._cMainMat);
            Utils.RegisterObject(L, translator, Utils.CLS_IDX, "_cMat1", BaseResLoader._cMat1);
            Utils.RegisterObject(L, translator, Utils.CLS_IDX, "_cMat2", BaseResLoader._cMat2);
            Utils.RegisterObject(L, translator, Utils.CLS_IDX, "_cMat3", BaseResLoader._cMat3);
            
			
			
			
			Utils.EndClassRegister(type, L, translator);
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int __CreateInstance(RealStatePtr L)
        {
            
			try {
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
				if(LuaAPI.lua_gettop(L) == 1)
				{
					
					var gen_ret = new BaseResLoader();
					translator.Push(L, gen_ret);
                    
					return 1;
				}
				
			}
			catch(System.Exception gen_e) {
				return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
			}
            return LuaAPI.luaL_error(L, "invalid arguments to BaseResLoader constructor!");
            
        }
        
		
        
		
        
        
        
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_ClearAllResources(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
                BaseResLoader gen_to_be_invoked = (BaseResLoader)translator.FastGetCSObj(L, 1);
            
            
                
                {
                    
                    gen_to_be_invoked.ClearAllResources(  );
                    
                    
                    
                    return 0;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_LoadMaterial(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
                BaseResLoader gen_to_be_invoked = (BaseResLoader)translator.FastGetCSObj(L, 1);
            
            
			    int gen_param_count = LuaAPI.lua_gettop(L);
            
                if(gen_param_count == 3&& translator.Assignable<UnityEngine.MeshRenderer>(L, 2)&& (LuaAPI.lua_isnil(L, 3) || LuaAPI.lua_type(L, 3) == LuaTypes.LUA_TSTRING)) 
                {
                    UnityEngine.MeshRenderer _renderer = (UnityEngine.MeshRenderer)translator.GetObject(L, 2, typeof(UnityEngine.MeshRenderer));
                    string _fileName = LuaAPI.lua_tostring(L, 3);
                    
                        var gen_ret = gen_to_be_invoked.LoadMaterial( _renderer, _fileName );
                        LuaAPI.lua_pushboolean(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                if(gen_param_count == 3&& translator.Assignable<UnityEngine.SpriteRenderer>(L, 2)&& (LuaAPI.lua_isnil(L, 3) || LuaAPI.lua_type(L, 3) == LuaTypes.LUA_TSTRING)) 
                {
                    UnityEngine.SpriteRenderer _sprite = (UnityEngine.SpriteRenderer)translator.GetObject(L, 2, typeof(UnityEngine.SpriteRenderer));
                    string _fileName = LuaAPI.lua_tostring(L, 3);
                    
                        var gen_ret = gen_to_be_invoked.LoadMaterial( _sprite, _fileName );
                        LuaAPI.lua_pushboolean(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                if(gen_param_count == 3&& translator.Assignable<UnityEngine.Material>(L, 2)&& (LuaAPI.lua_isnil(L, 3) || LuaAPI.lua_type(L, 3) == LuaTypes.LUA_TSTRING)) 
                {
                    UnityEngine.Material _target = (UnityEngine.Material)translator.GetObject(L, 2, typeof(UnityEngine.Material));
                    string _fileName = LuaAPI.lua_tostring(L, 3);
                    
                        var gen_ret = gen_to_be_invoked.LoadMaterial( ref _target, _fileName );
                        LuaAPI.lua_pushboolean(L, gen_ret);
                    translator.Push(L, _target);
                        
                    
                    
                    
                    return 2;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
            return LuaAPI.luaL_error(L, "invalid arguments to BaseResLoader.LoadMaterial!");
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_ClearMaterials(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
                BaseResLoader gen_to_be_invoked = (BaseResLoader)translator.FastGetCSObj(L, 1);
            
            
                
                {
                    UnityEngine.MeshRenderer _renderer = (UnityEngine.MeshRenderer)translator.GetObject(L, 2, typeof(UnityEngine.MeshRenderer));
                    
                    gen_to_be_invoked.ClearMaterials( _renderer );
                    
                    
                    
                    return 0;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_ClearMaterial(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
                BaseResLoader gen_to_be_invoked = (BaseResLoader)translator.FastGetCSObj(L, 1);
            
            
                
                {
                    UnityEngine.SpriteRenderer _sprite = (UnityEngine.SpriteRenderer)translator.GetObject(L, 2, typeof(UnityEngine.SpriteRenderer));
                    
                    gen_to_be_invoked.ClearMaterial( _sprite );
                    
                    
                    
                    return 0;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_InstantiateGameObj_xlua_st_(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
            
                
                {
                    UnityEngine.GameObject _orgObj = (UnityEngine.GameObject)translator.GetObject(L, 1, typeof(UnityEngine.GameObject));
                    
                        var gen_ret = BaseResLoader.InstantiateGameObj( _orgObj );
                        translator.Push(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_LoadSprite(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
                BaseResLoader gen_to_be_invoked = (BaseResLoader)translator.FastGetCSObj(L, 1);
            
            
			    int gen_param_count = LuaAPI.lua_gettop(L);
            
                if(gen_param_count == 3&& translator.Assignable<UnityEngine.SpriteRenderer>(L, 2)&& (LuaAPI.lua_isnil(L, 3) || LuaAPI.lua_type(L, 3) == LuaTypes.LUA_TSTRING)) 
                {
                    UnityEngine.SpriteRenderer _sprite = (UnityEngine.SpriteRenderer)translator.GetObject(L, 2, typeof(UnityEngine.SpriteRenderer));
                    string _fileName = LuaAPI.lua_tostring(L, 3);
                    
                        var gen_ret = gen_to_be_invoked.LoadSprite( _sprite, _fileName );
                        LuaAPI.lua_pushboolean(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                if(gen_param_count == 4&& translator.Assignable<UnityEngine.SpriteRenderer>(L, 2)&& (LuaAPI.lua_isnil(L, 3) || LuaAPI.lua_type(L, 3) == LuaTypes.LUA_TSTRING)&& (LuaAPI.lua_isnil(L, 4) || LuaAPI.lua_type(L, 4) == LuaTypes.LUA_TSTRING)) 
                {
                    UnityEngine.SpriteRenderer _sprite = (UnityEngine.SpriteRenderer)translator.GetObject(L, 2, typeof(UnityEngine.SpriteRenderer));
                    string _fileName = LuaAPI.lua_tostring(L, 3);
                    string _spriteName = LuaAPI.lua_tostring(L, 4);
                    
                        var gen_ret = gen_to_be_invoked.LoadSprite( _sprite, _fileName, _spriteName );
                        LuaAPI.lua_pushboolean(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
            return LuaAPI.luaL_error(L, "invalid arguments to BaseResLoader.LoadSprite!");
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_LoadGameObject(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
                BaseResLoader gen_to_be_invoked = (BaseResLoader)translator.FastGetCSObj(L, 1);
            
            
                
                {
                    UnityEngine.GameObject _target = (UnityEngine.GameObject)translator.GetObject(L, 2, typeof(UnityEngine.GameObject));
                    string _fileName = LuaAPI.lua_tostring(L, 3);
                    
                        var gen_ret = gen_to_be_invoked.LoadGameObject( ref _target, _fileName );
                        LuaAPI.lua_pushboolean(L, gen_ret);
                    translator.Push(L, _target);
                        
                    
                    
                    
                    return 2;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_ClearGameObject(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
                BaseResLoader gen_to_be_invoked = (BaseResLoader)translator.FastGetCSObj(L, 1);
            
            
                
                {
                    UnityEngine.GameObject _target = (UnityEngine.GameObject)translator.GetObject(L, 2, typeof(UnityEngine.GameObject));
                    
                    gen_to_be_invoked.ClearGameObject( ref _target );
                    translator.Push(L, _target);
                        
                    
                    
                    
                    return 1;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_ClearMaterail(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
                BaseResLoader gen_to_be_invoked = (BaseResLoader)translator.FastGetCSObj(L, 1);
            
            
                
                {
                    UnityEngine.Material _target = (UnityEngine.Material)translator.GetObject(L, 2, typeof(UnityEngine.Material));
                    
                    gen_to_be_invoked.ClearMaterail( ref _target );
                    translator.Push(L, _target);
                        
                    
                    
                    
                    return 1;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_ClearTexture(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
                BaseResLoader gen_to_be_invoked = (BaseResLoader)translator.FastGetCSObj(L, 1);
            
            
			    int gen_param_count = LuaAPI.lua_gettop(L);
            
                if(gen_param_count == 2&& translator.Assignable<UnityEngine.Texture>(L, 2)) 
                {
                    UnityEngine.Texture _target = (UnityEngine.Texture)translator.GetObject(L, 2, typeof(UnityEngine.Texture));
                    
                    gen_to_be_invoked.ClearTexture( ref _target );
                    translator.Push(L, _target);
                        
                    
                    
                    
                    return 1;
                }
                if(gen_param_count == 3&& translator.Assignable<UnityEngine.MeshRenderer>(L, 2)&& (LuaAPI.lua_isnil(L, 3) || LuaAPI.lua_type(L, 3) == LuaTypes.LUA_TSTRING)) 
                {
                    UnityEngine.MeshRenderer _renderer = (UnityEngine.MeshRenderer)translator.GetObject(L, 2, typeof(UnityEngine.MeshRenderer));
                    string _matName = LuaAPI.lua_tostring(L, 3);
                    
                    gen_to_be_invoked.ClearTexture( _renderer, _matName );
                    
                    
                    
                    return 0;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
            return LuaAPI.luaL_error(L, "invalid arguments to BaseResLoader.ClearTexture!");
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_LoadTexture(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
                BaseResLoader gen_to_be_invoked = (BaseResLoader)translator.FastGetCSObj(L, 1);
            
            
			    int gen_param_count = LuaAPI.lua_gettop(L);
            
                if(gen_param_count == 3&& translator.Assignable<UnityEngine.Texture>(L, 2)&& (LuaAPI.lua_isnil(L, 3) || LuaAPI.lua_type(L, 3) == LuaTypes.LUA_TSTRING)) 
                {
                    UnityEngine.Texture _target = (UnityEngine.Texture)translator.GetObject(L, 2, typeof(UnityEngine.Texture));
                    string _fileName = LuaAPI.lua_tostring(L, 3);
                    
                        var gen_ret = gen_to_be_invoked.LoadTexture( ref _target, _fileName );
                        LuaAPI.lua_pushboolean(L, gen_ret);
                    translator.Push(L, _target);
                        
                    
                    
                    
                    return 2;
                }
                if(gen_param_count == 5&& translator.Assignable<UnityEngine.MeshRenderer>(L, 2)&& (LuaAPI.lua_isnil(L, 3) || LuaAPI.lua_type(L, 3) == LuaTypes.LUA_TSTRING)&& (LuaAPI.lua_isnil(L, 4) || LuaAPI.lua_type(L, 4) == LuaTypes.LUA_TSTRING)&& LuaTypes.LUA_TBOOLEAN == LuaAPI.lua_type(L, 5)) 
                {
                    UnityEngine.MeshRenderer _renderer = (UnityEngine.MeshRenderer)translator.GetObject(L, 2, typeof(UnityEngine.MeshRenderer));
                    string _fileName = LuaAPI.lua_tostring(L, 3);
                    string _matName = LuaAPI.lua_tostring(L, 4);
                    bool _isMatInst = LuaAPI.lua_toboolean(L, 5);
                    
                        var gen_ret = gen_to_be_invoked.LoadTexture( _renderer, _fileName, _matName, _isMatInst );
                        LuaAPI.lua_pushboolean(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                if(gen_param_count == 4&& translator.Assignable<UnityEngine.MeshRenderer>(L, 2)&& (LuaAPI.lua_isnil(L, 3) || LuaAPI.lua_type(L, 3) == LuaTypes.LUA_TSTRING)&& (LuaAPI.lua_isnil(L, 4) || LuaAPI.lua_type(L, 4) == LuaTypes.LUA_TSTRING)) 
                {
                    UnityEngine.MeshRenderer _renderer = (UnityEngine.MeshRenderer)translator.GetObject(L, 2, typeof(UnityEngine.MeshRenderer));
                    string _fileName = LuaAPI.lua_tostring(L, 3);
                    string _matName = LuaAPI.lua_tostring(L, 4);
                    
                        var gen_ret = gen_to_be_invoked.LoadTexture( _renderer, _fileName, _matName );
                        LuaAPI.lua_pushboolean(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
            return LuaAPI.luaL_error(L, "invalid arguments to BaseResLoader.LoadTexture!");
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_ClearShader(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
                BaseResLoader gen_to_be_invoked = (BaseResLoader)translator.FastGetCSObj(L, 1);
            
            
                
                {
                    UnityEngine.Shader _target = (UnityEngine.Shader)translator.GetObject(L, 2, typeof(UnityEngine.Shader));
                    
                    gen_to_be_invoked.ClearShader( ref _target );
                    translator.Push(L, _target);
                        
                    
                    
                    
                    return 1;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_LoadShader(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
                BaseResLoader gen_to_be_invoked = (BaseResLoader)translator.FastGetCSObj(L, 1);
            
            
                
                {
                    UnityEngine.Shader _target = (UnityEngine.Shader)translator.GetObject(L, 2, typeof(UnityEngine.Shader));
                    string _fileName = LuaAPI.lua_tostring(L, 3);
                    
                        var gen_ret = gen_to_be_invoked.LoadShader( ref _target, _fileName );
                        LuaAPI.lua_pushboolean(L, gen_ret);
                    translator.Push(L, _target);
                        
                    
                    
                    
                    return 2;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_ClearAudioClip(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
                BaseResLoader gen_to_be_invoked = (BaseResLoader)translator.FastGetCSObj(L, 1);
            
            
                
                {
                    UnityEngine.AudioClip _target = (UnityEngine.AudioClip)translator.GetObject(L, 2, typeof(UnityEngine.AudioClip));
                    
                    gen_to_be_invoked.ClearAudioClip( ref _target );
                    translator.Push(L, _target);
                        
                    
                    
                    
                    return 1;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_LoadAudioClip(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
                BaseResLoader gen_to_be_invoked = (BaseResLoader)translator.FastGetCSObj(L, 1);
            
            
                
                {
                    UnityEngine.AudioClip _target = (UnityEngine.AudioClip)translator.GetObject(L, 2, typeof(UnityEngine.AudioClip));
                    string _fileName = LuaAPI.lua_tostring(L, 3);
                    
                        var gen_ret = gen_to_be_invoked.LoadAudioClip( ref _target, _fileName );
                        LuaAPI.lua_pushboolean(L, gen_ret);
                    translator.Push(L, _target);
                        
                    
                    
                    
                    return 2;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_ClearAnimationClip(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
                BaseResLoader gen_to_be_invoked = (BaseResLoader)translator.FastGetCSObj(L, 1);
            
            
                
                {
                    UnityEngine.AnimationClip _target = (UnityEngine.AnimationClip)translator.GetObject(L, 2, typeof(UnityEngine.AnimationClip));
                    
                    gen_to_be_invoked.ClearAnimationClip( ref _target );
                    translator.Push(L, _target);
                        
                    
                    
                    
                    return 1;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_LoadAnimationClip(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
                BaseResLoader gen_to_be_invoked = (BaseResLoader)translator.FastGetCSObj(L, 1);
            
            
                
                {
                    UnityEngine.AnimationClip _target = (UnityEngine.AnimationClip)translator.GetObject(L, 2, typeof(UnityEngine.AnimationClip));
                    string _fileName = LuaAPI.lua_tostring(L, 3);
                    
                        var gen_ret = gen_to_be_invoked.LoadAnimationClip( ref _target, _fileName );
                        LuaAPI.lua_pushboolean(L, gen_ret);
                    translator.Push(L, _target);
                        
                    
                    
                    
                    return 2;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_ClearFont(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
                BaseResLoader gen_to_be_invoked = (BaseResLoader)translator.FastGetCSObj(L, 1);
            
            
                
                {
                    UnityEngine.TextMesh _textMesh = (UnityEngine.TextMesh)translator.GetObject(L, 2, typeof(UnityEngine.TextMesh));
                    
                    gen_to_be_invoked.ClearFont( _textMesh );
                    
                    
                    
                    return 0;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_LoadFont(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
                BaseResLoader gen_to_be_invoked = (BaseResLoader)translator.FastGetCSObj(L, 1);
            
            
                
                {
                    UnityEngine.TextMesh _textMesh = (UnityEngine.TextMesh)translator.GetObject(L, 2, typeof(UnityEngine.TextMesh));
                    string _fileName = LuaAPI.lua_tostring(L, 3);
                    
                        var gen_ret = gen_to_be_invoked.LoadFont( _textMesh, _fileName );
                        LuaAPI.lua_pushboolean(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_ClearAniController(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
                BaseResLoader gen_to_be_invoked = (BaseResLoader)translator.FastGetCSObj(L, 1);
            
            
                
                {
                    UnityEngine.Animator _target = (UnityEngine.Animator)translator.GetObject(L, 2, typeof(UnityEngine.Animator));
                    
                    gen_to_be_invoked.ClearAniController( _target );
                    
                    
                    
                    return 0;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_LoadAniController(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
                BaseResLoader gen_to_be_invoked = (BaseResLoader)translator.FastGetCSObj(L, 1);
            
            
                
                {
                    UnityEngine.Animator _target = (UnityEngine.Animator)translator.GetObject(L, 2, typeof(UnityEngine.Animator));
                    string _fileName = LuaAPI.lua_tostring(L, 3);
                    
                        var gen_ret = gen_to_be_invoked.LoadAniController( _target, _fileName );
                        LuaAPI.lua_pushboolean(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_DestroyGameObj_xlua_st_(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
            
                
                {
                    UnityEngine.GameObject _obj = (UnityEngine.GameObject)translator.GetObject(L, 1, typeof(UnityEngine.GameObject));
                    
                    BaseResLoader.DestroyGameObj( _obj );
                    
                    
                    
                    return 0;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_GetResList(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
                BaseResLoader gen_to_be_invoked = (BaseResLoader)translator.FastGetCSObj(L, 1);
            
            
                
                {
                    
                        var gen_ret = gen_to_be_invoked.GetResList(  );
                        translator.Push(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_ClearMainTexture(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
                BaseResLoader gen_to_be_invoked = (BaseResLoader)translator.FastGetCSObj(L, 1);
            
            
                
                {
                    UnityEngine.MeshRenderer _renderer = (UnityEngine.MeshRenderer)translator.GetObject(L, 2, typeof(UnityEngine.MeshRenderer));
                    
                    gen_to_be_invoked.ClearMainTexture( _renderer );
                    
                    
                    
                    return 0;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_LoadMainTexture(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
                BaseResLoader gen_to_be_invoked = (BaseResLoader)translator.FastGetCSObj(L, 1);
            
            
			    int gen_param_count = LuaAPI.lua_gettop(L);
            
                if(gen_param_count == 4&& translator.Assignable<UnityEngine.MeshRenderer>(L, 2)&& (LuaAPI.lua_isnil(L, 3) || LuaAPI.lua_type(L, 3) == LuaTypes.LUA_TSTRING)&& LuaTypes.LUA_TBOOLEAN == LuaAPI.lua_type(L, 4)) 
                {
                    UnityEngine.MeshRenderer _renderer = (UnityEngine.MeshRenderer)translator.GetObject(L, 2, typeof(UnityEngine.MeshRenderer));
                    string _fileName = LuaAPI.lua_tostring(L, 3);
                    bool _isMatInst = LuaAPI.lua_toboolean(L, 4);
                    
                        var gen_ret = gen_to_be_invoked.LoadMainTexture( _renderer, _fileName, _isMatInst );
                        LuaAPI.lua_pushboolean(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                if(gen_param_count == 3&& translator.Assignable<UnityEngine.MeshRenderer>(L, 2)&& (LuaAPI.lua_isnil(L, 3) || LuaAPI.lua_type(L, 3) == LuaTypes.LUA_TSTRING)) 
                {
                    UnityEngine.MeshRenderer _renderer = (UnityEngine.MeshRenderer)translator.GetObject(L, 2, typeof(UnityEngine.MeshRenderer));
                    string _fileName = LuaAPI.lua_tostring(L, 3);
                    
                        var gen_ret = gen_to_be_invoked.LoadMainTexture( _renderer, _fileName );
                        LuaAPI.lua_pushboolean(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
            return LuaAPI.luaL_error(L, "invalid arguments to BaseResLoader.LoadMainTexture!");
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_CreateGameObject_xlua_st_(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
            
                
                {
                    string _fileName = LuaAPI.lua_tostring(L, 1);
                    
                        var gen_ret = BaseResLoader.CreateGameObject( _fileName );
                        translator.Push(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
        }
        
        
        
        
        
        
		
		
		
		
    }
}
