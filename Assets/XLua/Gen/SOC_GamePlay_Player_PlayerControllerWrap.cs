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
    public class SOCGamePlayPlayerPlayerControllerWrap 
    {
        public static void __Register(RealStatePtr L)
        {
			ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
			System.Type type = typeof(SOC.GamePlay.Player.PlayerController);
			Utils.BeginObjectRegister(type, L, translator, 0, 0, 2, 2);
			
			
			
			Utils.RegisterFunc(L, Utils.GETTER_IDX, "Input", _g_get_Input);
            Utils.RegisterFunc(L, Utils.GETTER_IDX, "Character", _g_get_Character);
            
			Utils.RegisterFunc(L, Utils.SETTER_IDX, "Input", _s_set_Input);
            Utils.RegisterFunc(L, Utils.SETTER_IDX, "Character", _s_set_Character);
            
			
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
					
					var gen_ret = new SOC.GamePlay.Player.PlayerController();
					translator.Push(L, gen_ret);
                    
					return 1;
				}
				
			}
			catch(System.Exception gen_e) {
				return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
			}
            return LuaAPI.luaL_error(L, "invalid arguments to SOC.GamePlay.Player.PlayerController constructor!");
            
        }
        
		
        
		
        
        
        
        
        
        
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _g_get_Input(RealStatePtr L)
        {
		    try {
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
			
                SOC.GamePlay.Player.PlayerController gen_to_be_invoked = (SOC.GamePlay.Player.PlayerController)translator.FastGetCSObj(L, 1);
                translator.Push(L, gen_to_be_invoked.Input);
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            return 1;
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _g_get_Character(RealStatePtr L)
        {
		    try {
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
			
                SOC.GamePlay.Player.PlayerController gen_to_be_invoked = (SOC.GamePlay.Player.PlayerController)translator.FastGetCSObj(L, 1);
                translator.Push(L, gen_to_be_invoked.Character);
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            return 1;
        }
        
        
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _s_set_Input(RealStatePtr L)
        {
		    try {
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
			
                SOC.GamePlay.Player.PlayerController gen_to_be_invoked = (SOC.GamePlay.Player.PlayerController)translator.FastGetCSObj(L, 1);
                gen_to_be_invoked.Input = (SOC.GamePlay.Player.PlayerInput)translator.GetObject(L, 2, typeof(SOC.GamePlay.Player.PlayerInput));
            
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            return 0;
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _s_set_Character(RealStatePtr L)
        {
		    try {
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
			
                SOC.GamePlay.Player.PlayerController gen_to_be_invoked = (SOC.GamePlay.Player.PlayerController)translator.FastGetCSObj(L, 1);
                gen_to_be_invoked.Character = (SOC.GamePlay.CharacterController)translator.GetObject(L, 2, typeof(SOC.GamePlay.CharacterController));
            
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            return 0;
        }
        
		
		
		
		
    }
}
