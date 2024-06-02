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
    
    public class ResourceCacheTypeWrap
    {
		public static void __Register(RealStatePtr L)
        {
		    ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
		    Utils.BeginObjectRegister(typeof(ResourceCacheType), L, translator, 0, 0, 0, 0);
			Utils.EndObjectRegister(typeof(ResourceCacheType), L, translator, null, null, null, null, null);
			
			Utils.BeginClassRegister(typeof(ResourceCacheType), L, null, 4, 0, 0);

            
            Utils.RegisterObject(L, translator, Utils.CLS_IDX, "rctNone", ResourceCacheType.rctNone);
            
            Utils.RegisterObject(L, translator, Utils.CLS_IDX, "rctTemp", ResourceCacheType.rctTemp);
            
            Utils.RegisterObject(L, translator, Utils.CLS_IDX, "rctRefAdd", ResourceCacheType.rctRefAdd);
            

			Utils.RegisterFunc(L, Utils.CLS_IDX, "__CastFrom", __CastFrom);
            
            Utils.EndClassRegister(typeof(ResourceCacheType), L, translator);
        }
		
		[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int __CastFrom(RealStatePtr L)
		{
			ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
			LuaTypes lua_type = LuaAPI.lua_type(L, 1);
            if (lua_type == LuaTypes.LUA_TNUMBER)
            {
                translator.PushResourceCacheType(L, (ResourceCacheType)LuaAPI.xlua_tointeger(L, 1));
            }
			
            else if(lua_type == LuaTypes.LUA_TSTRING)
            {

			    if (LuaAPI.xlua_is_eq_str(L, 1, "rctNone"))
                {
                    translator.PushResourceCacheType(L, ResourceCacheType.rctNone);
                }
				else if (LuaAPI.xlua_is_eq_str(L, 1, "rctTemp"))
                {
                    translator.PushResourceCacheType(L, ResourceCacheType.rctTemp);
                }
				else if (LuaAPI.xlua_is_eq_str(L, 1, "rctRefAdd"))
                {
                    translator.PushResourceCacheType(L, ResourceCacheType.rctRefAdd);
                }
				else
                {
                    return LuaAPI.luaL_error(L, "invalid string for ResourceCacheType!");
                }

            }
			
            else
            {
                return LuaAPI.luaL_error(L, "invalid lua type for ResourceCacheType! Expect number or string, got + " + lua_type);
            }

            return 1;
		}
	}
    
    public class TutorialTestEnumWrap
    {
		public static void __Register(RealStatePtr L)
        {
		    ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
		    Utils.BeginObjectRegister(typeof(Tutorial.TestEnum), L, translator, 0, 0, 0, 0);
			Utils.EndObjectRegister(typeof(Tutorial.TestEnum), L, translator, null, null, null, null, null);
			
			Utils.BeginClassRegister(typeof(Tutorial.TestEnum), L, null, 3, 0, 0);

            
            Utils.RegisterObject(L, translator, Utils.CLS_IDX, "E1", Tutorial.TestEnum.E1);
            
            Utils.RegisterObject(L, translator, Utils.CLS_IDX, "E2", Tutorial.TestEnum.E2);
            

			Utils.RegisterFunc(L, Utils.CLS_IDX, "__CastFrom", __CastFrom);
            
            Utils.EndClassRegister(typeof(Tutorial.TestEnum), L, translator);
        }
		
		[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int __CastFrom(RealStatePtr L)
		{
			ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
			LuaTypes lua_type = LuaAPI.lua_type(L, 1);
            if (lua_type == LuaTypes.LUA_TNUMBER)
            {
                translator.PushTutorialTestEnum(L, (Tutorial.TestEnum)LuaAPI.xlua_tointeger(L, 1));
            }
			
            else if(lua_type == LuaTypes.LUA_TSTRING)
            {

			    if (LuaAPI.xlua_is_eq_str(L, 1, "E1"))
                {
                    translator.PushTutorialTestEnum(L, Tutorial.TestEnum.E1);
                }
				else if (LuaAPI.xlua_is_eq_str(L, 1, "E2"))
                {
                    translator.PushTutorialTestEnum(L, Tutorial.TestEnum.E2);
                }
				else
                {
                    return LuaAPI.luaL_error(L, "invalid string for Tutorial.TestEnum!");
                }

            }
			
            else
            {
                return LuaAPI.luaL_error(L, "invalid lua type for Tutorial.TestEnum! Expect number or string, got + " + lua_type);
            }

            return 1;
		}
	}
    
    public class TutorialDerivedClassTestEnumInnerWrap
    {
		public static void __Register(RealStatePtr L)
        {
		    ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
		    Utils.BeginObjectRegister(typeof(Tutorial.DerivedClass.TestEnumInner), L, translator, 0, 0, 0, 0);
			Utils.EndObjectRegister(typeof(Tutorial.DerivedClass.TestEnumInner), L, translator, null, null, null, null, null);
			
			Utils.BeginClassRegister(typeof(Tutorial.DerivedClass.TestEnumInner), L, null, 3, 0, 0);

            
            Utils.RegisterObject(L, translator, Utils.CLS_IDX, "E3", Tutorial.DerivedClass.TestEnumInner.E3);
            
            Utils.RegisterObject(L, translator, Utils.CLS_IDX, "E4", Tutorial.DerivedClass.TestEnumInner.E4);
            

			Utils.RegisterFunc(L, Utils.CLS_IDX, "__CastFrom", __CastFrom);
            
            Utils.EndClassRegister(typeof(Tutorial.DerivedClass.TestEnumInner), L, translator);
        }
		
		[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int __CastFrom(RealStatePtr L)
		{
			ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
			LuaTypes lua_type = LuaAPI.lua_type(L, 1);
            if (lua_type == LuaTypes.LUA_TNUMBER)
            {
                translator.PushTutorialDerivedClassTestEnumInner(L, (Tutorial.DerivedClass.TestEnumInner)LuaAPI.xlua_tointeger(L, 1));
            }
			
            else if(lua_type == LuaTypes.LUA_TSTRING)
            {

			    if (LuaAPI.xlua_is_eq_str(L, 1, "E3"))
                {
                    translator.PushTutorialDerivedClassTestEnumInner(L, Tutorial.DerivedClass.TestEnumInner.E3);
                }
				else if (LuaAPI.xlua_is_eq_str(L, 1, "E4"))
                {
                    translator.PushTutorialDerivedClassTestEnumInner(L, Tutorial.DerivedClass.TestEnumInner.E4);
                }
				else
                {
                    return LuaAPI.luaL_error(L, "invalid string for Tutorial.DerivedClass.TestEnumInner!");
                }

            }
			
            else
            {
                return LuaAPI.luaL_error(L, "invalid lua type for Tutorial.DerivedClass.TestEnumInner! Expect number or string, got + " + lua_type);
            }

            return 1;
		}
	}
    
    public class XLuaTestMyEnumWrap
    {
		public static void __Register(RealStatePtr L)
        {
		    ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
		    Utils.BeginObjectRegister(typeof(XLuaTest.MyEnum), L, translator, 0, 0, 0, 0);
			Utils.EndObjectRegister(typeof(XLuaTest.MyEnum), L, translator, null, null, null, null, null);
			
			Utils.BeginClassRegister(typeof(XLuaTest.MyEnum), L, null, 3, 0, 0);

            
            Utils.RegisterObject(L, translator, Utils.CLS_IDX, "E1", XLuaTest.MyEnum.E1);
            
            Utils.RegisterObject(L, translator, Utils.CLS_IDX, "E2", XLuaTest.MyEnum.E2);
            

			Utils.RegisterFunc(L, Utils.CLS_IDX, "__CastFrom", __CastFrom);
            
            Utils.EndClassRegister(typeof(XLuaTest.MyEnum), L, translator);
        }
		
		[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int __CastFrom(RealStatePtr L)
		{
			ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
			LuaTypes lua_type = LuaAPI.lua_type(L, 1);
            if (lua_type == LuaTypes.LUA_TNUMBER)
            {
                translator.PushXLuaTestMyEnum(L, (XLuaTest.MyEnum)LuaAPI.xlua_tointeger(L, 1));
            }
			
            else if(lua_type == LuaTypes.LUA_TSTRING)
            {

			    if (LuaAPI.xlua_is_eq_str(L, 1, "E1"))
                {
                    translator.PushXLuaTestMyEnum(L, XLuaTest.MyEnum.E1);
                }
				else if (LuaAPI.xlua_is_eq_str(L, 1, "E2"))
                {
                    translator.PushXLuaTestMyEnum(L, XLuaTest.MyEnum.E2);
                }
				else
                {
                    return LuaAPI.luaL_error(L, "invalid string for XLuaTest.MyEnum!");
                }

            }
			
            else
            {
                return LuaAPI.luaL_error(L, "invalid lua type for XLuaTest.MyEnum! Expect number or string, got + " + lua_type);
            }

            return 1;
		}
	}
    
    public class NsLibResMgrBaseResLoaderAsyncTypeWrap
    {
		public static void __Register(RealStatePtr L)
        {
		    ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
		    Utils.BeginObjectRegister(typeof(NsLib.ResMgr.BaseResLoaderAsyncType), L, translator, 0, 0, 0, 0);
			Utils.EndObjectRegister(typeof(NsLib.ResMgr.BaseResLoaderAsyncType), L, translator, null, null, null, null, null);
			
			Utils.BeginClassRegister(typeof(NsLib.ResMgr.BaseResLoaderAsyncType), L, null, 14, 0, 0);

            
            Utils.RegisterObject(L, translator, Utils.CLS_IDX, "SpriteRenderMainTexture", NsLib.ResMgr.BaseResLoaderAsyncType.SpriteRenderMainTexture);
            
            Utils.RegisterObject(L, translator, Utils.CLS_IDX, "SpriteRenderMaterial", NsLib.ResMgr.BaseResLoaderAsyncType.SpriteRenderMaterial);
            
            Utils.RegisterObject(L, translator, Utils.CLS_IDX, "MeshRenderMainTexture", NsLib.ResMgr.BaseResLoaderAsyncType.MeshRenderMainTexture);
            
            Utils.RegisterObject(L, translator, Utils.CLS_IDX, "MeshRenderMaterial", NsLib.ResMgr.BaseResLoaderAsyncType.MeshRenderMaterial);
            
            Utils.RegisterObject(L, translator, Utils.CLS_IDX, "UITextureMainTexture", NsLib.ResMgr.BaseResLoaderAsyncType.UITextureMainTexture);
            
            Utils.RegisterObject(L, translator, Utils.CLS_IDX, "UITextureShader", NsLib.ResMgr.BaseResLoaderAsyncType.UITextureShader);
            
            Utils.RegisterObject(L, translator, Utils.CLS_IDX, "UISpriteMainTexture", NsLib.ResMgr.BaseResLoaderAsyncType.UISpriteMainTexture);
            
            Utils.RegisterObject(L, translator, Utils.CLS_IDX, "UI2DSpriteMainTexture", NsLib.ResMgr.BaseResLoaderAsyncType.UI2DSpriteMainTexture);
            
            Utils.RegisterObject(L, translator, Utils.CLS_IDX, "UI2DSpriteShader", NsLib.ResMgr.BaseResLoaderAsyncType.UI2DSpriteShader);
            
            Utils.RegisterObject(L, translator, Utils.CLS_IDX, "AnimatorController", NsLib.ResMgr.BaseResLoaderAsyncType.AnimatorController);
            
            Utils.RegisterObject(L, translator, Utils.CLS_IDX, "TextMeshFont", NsLib.ResMgr.BaseResLoaderAsyncType.TextMeshFont);
            
            Utils.RegisterObject(L, translator, Utils.CLS_IDX, "NGUIUIFontFont", NsLib.ResMgr.BaseResLoaderAsyncType.NGUIUIFontFont);
            
            Utils.RegisterObject(L, translator, Utils.CLS_IDX, "NGUIUISpriteAtlas", NsLib.ResMgr.BaseResLoaderAsyncType.NGUIUISpriteAtlas);
            

			Utils.RegisterFunc(L, Utils.CLS_IDX, "__CastFrom", __CastFrom);
            
            Utils.EndClassRegister(typeof(NsLib.ResMgr.BaseResLoaderAsyncType), L, translator);
        }
		
		[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int __CastFrom(RealStatePtr L)
		{
			ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
			LuaTypes lua_type = LuaAPI.lua_type(L, 1);
            if (lua_type == LuaTypes.LUA_TNUMBER)
            {
                translator.PushNsLibResMgrBaseResLoaderAsyncType(L, (NsLib.ResMgr.BaseResLoaderAsyncType)LuaAPI.xlua_tointeger(L, 1));
            }
			
            else if(lua_type == LuaTypes.LUA_TSTRING)
            {

			    if (LuaAPI.xlua_is_eq_str(L, 1, "SpriteRenderMainTexture"))
                {
                    translator.PushNsLibResMgrBaseResLoaderAsyncType(L, NsLib.ResMgr.BaseResLoaderAsyncType.SpriteRenderMainTexture);
                }
				else if (LuaAPI.xlua_is_eq_str(L, 1, "SpriteRenderMaterial"))
                {
                    translator.PushNsLibResMgrBaseResLoaderAsyncType(L, NsLib.ResMgr.BaseResLoaderAsyncType.SpriteRenderMaterial);
                }
				else if (LuaAPI.xlua_is_eq_str(L, 1, "MeshRenderMainTexture"))
                {
                    translator.PushNsLibResMgrBaseResLoaderAsyncType(L, NsLib.ResMgr.BaseResLoaderAsyncType.MeshRenderMainTexture);
                }
				else if (LuaAPI.xlua_is_eq_str(L, 1, "MeshRenderMaterial"))
                {
                    translator.PushNsLibResMgrBaseResLoaderAsyncType(L, NsLib.ResMgr.BaseResLoaderAsyncType.MeshRenderMaterial);
                }
				else if (LuaAPI.xlua_is_eq_str(L, 1, "UITextureMainTexture"))
                {
                    translator.PushNsLibResMgrBaseResLoaderAsyncType(L, NsLib.ResMgr.BaseResLoaderAsyncType.UITextureMainTexture);
                }
				else if (LuaAPI.xlua_is_eq_str(L, 1, "UITextureShader"))
                {
                    translator.PushNsLibResMgrBaseResLoaderAsyncType(L, NsLib.ResMgr.BaseResLoaderAsyncType.UITextureShader);
                }
				else if (LuaAPI.xlua_is_eq_str(L, 1, "UISpriteMainTexture"))
                {
                    translator.PushNsLibResMgrBaseResLoaderAsyncType(L, NsLib.ResMgr.BaseResLoaderAsyncType.UISpriteMainTexture);
                }
				else if (LuaAPI.xlua_is_eq_str(L, 1, "UI2DSpriteMainTexture"))
                {
                    translator.PushNsLibResMgrBaseResLoaderAsyncType(L, NsLib.ResMgr.BaseResLoaderAsyncType.UI2DSpriteMainTexture);
                }
				else if (LuaAPI.xlua_is_eq_str(L, 1, "UI2DSpriteShader"))
                {
                    translator.PushNsLibResMgrBaseResLoaderAsyncType(L, NsLib.ResMgr.BaseResLoaderAsyncType.UI2DSpriteShader);
                }
				else if (LuaAPI.xlua_is_eq_str(L, 1, "AnimatorController"))
                {
                    translator.PushNsLibResMgrBaseResLoaderAsyncType(L, NsLib.ResMgr.BaseResLoaderAsyncType.AnimatorController);
                }
				else if (LuaAPI.xlua_is_eq_str(L, 1, "TextMeshFont"))
                {
                    translator.PushNsLibResMgrBaseResLoaderAsyncType(L, NsLib.ResMgr.BaseResLoaderAsyncType.TextMeshFont);
                }
				else if (LuaAPI.xlua_is_eq_str(L, 1, "NGUIUIFontFont"))
                {
                    translator.PushNsLibResMgrBaseResLoaderAsyncType(L, NsLib.ResMgr.BaseResLoaderAsyncType.NGUIUIFontFont);
                }
				else if (LuaAPI.xlua_is_eq_str(L, 1, "NGUIUISpriteAtlas"))
                {
                    translator.PushNsLibResMgrBaseResLoaderAsyncType(L, NsLib.ResMgr.BaseResLoaderAsyncType.NGUIUISpriteAtlas);
                }
				else
                {
                    return LuaAPI.luaL_error(L, "invalid string for NsLib.ResMgr.BaseResLoaderAsyncType!");
                }

            }
			
            else
            {
                return LuaAPI.luaL_error(L, "invalid lua type for NsLib.ResMgr.BaseResLoaderAsyncType! Expect number or string, got + " + lua_type);
            }

            return 1;
		}
	}
    
}