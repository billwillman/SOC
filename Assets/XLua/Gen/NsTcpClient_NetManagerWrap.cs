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
    public class NsTcpClientNetManagerWrap 
    {
        public static void __Register(RealStatePtr L)
        {
			ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
			System.Type type = typeof(NsTcpClient.NetManager);
			Utils.BeginObjectRegister(type, L, translator, 0, 8, 5, 2);
			
			Utils.RegisterFunc(L, Utils.METHOD_IDX, "ConnectLastServer", _m_ConnectLastServer);
			Utils.RegisterFunc(L, Utils.METHOD_IDX, "ConnectServer", _m_ConnectServer);
			Utils.RegisterFunc(L, Utils.METHOD_IDX, "Disconnect", _m_Disconnect);
			Utils.RegisterFunc(L, Utils.METHOD_IDX, "AddPacketListener", _m_AddPacketListener);
			Utils.RegisterFunc(L, Utils.METHOD_IDX, "AddServerMessageClass", _m_AddServerMessageClass);
			Utils.RegisterFunc(L, Utils.METHOD_IDX, "Send", _m_Send);
			Utils.RegisterFunc(L, Utils.METHOD_IDX, "SendStr", _m_SendStr);
			Utils.RegisterFunc(L, Utils.METHOD_IDX, "SendMessage", _m_SendMessage);
			
			
			Utils.RegisterFunc(L, Utils.GETTER_IDX, "Ip", _g_get_Ip);
            Utils.RegisterFunc(L, Utils.GETTER_IDX, "Port", _g_get_Port);
            Utils.RegisterFunc(L, Utils.GETTER_IDX, "ClietnState", _g_get_ClietnState);
            Utils.RegisterFunc(L, Utils.GETTER_IDX, "OnSocketAbort", _g_get_OnSocketAbort);
            Utils.RegisterFunc(L, Utils.GETTER_IDX, "OnConnectResult", _g_get_OnConnectResult);
            
			Utils.RegisterFunc(L, Utils.SETTER_IDX, "OnSocketAbort", _s_set_OnSocketAbort);
            Utils.RegisterFunc(L, Utils.SETTER_IDX, "OnConnectResult", _s_set_OnConnectResult);
            
			
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
					
					var gen_ret = new NsTcpClient.NetManager();
					translator.Push(L, gen_ret);
                    
					return 1;
				}
				
			}
			catch(System.Exception gen_e) {
				return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
			}
            return LuaAPI.luaL_error(L, "invalid arguments to NsTcpClient.NetManager constructor!");
            
        }
        
		
        
		
        
        
        
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_ConnectLastServer(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
                NsTcpClient.NetManager gen_to_be_invoked = (NsTcpClient.NetManager)translator.FastGetCSObj(L, 1);
            
            
                
                {
                    
                        var gen_ret = gen_to_be_invoked.ConnectLastServer(  );
                        LuaAPI.lua_pushboolean(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_ConnectServer(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
                NsTcpClient.NetManager gen_to_be_invoked = (NsTcpClient.NetManager)translator.FastGetCSObj(L, 1);
            
            
                
                {
                    string _ip = LuaAPI.lua_tostring(L, 2);
                    int _port = LuaAPI.xlua_tointeger(L, 3);
                    
                        var gen_ret = gen_to_be_invoked.ConnectServer( _ip, _port );
                        LuaAPI.lua_pushboolean(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_Disconnect(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
                NsTcpClient.NetManager gen_to_be_invoked = (NsTcpClient.NetManager)translator.FastGetCSObj(L, 1);
            
            
                
                {
                    
                    gen_to_be_invoked.Disconnect(  );
                    
                    
                    
                    return 0;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_AddPacketListener(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
                NsTcpClient.NetManager gen_to_be_invoked = (NsTcpClient.NetManager)translator.FastGetCSObj(L, 1);
            
            
                
                {
                    int _header = LuaAPI.xlua_tointeger(L, 2);
                    NsTcpClient.OnPacketRead _callBack = translator.GetDelegate<NsTcpClient.OnPacketRead>(L, 3);
                    
                    gen_to_be_invoked.AddPacketListener( _header, _callBack );
                    
                    
                    
                    return 0;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_AddServerMessageClass(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
                NsTcpClient.NetManager gen_to_be_invoked = (NsTcpClient.NetManager)translator.FastGetCSObj(L, 1);
            
            
                
                {
                    int _header = LuaAPI.xlua_tointeger(L, 2);
                    System.Type _messageClass = (System.Type)translator.GetObject(L, 3, typeof(System.Type));
                    
                    gen_to_be_invoked.AddServerMessageClass( _header, _messageClass );
                    
                    
                    
                    return 0;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_Send(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
                NsTcpClient.NetManager gen_to_be_invoked = (NsTcpClient.NetManager)translator.FastGetCSObj(L, 1);
            
            
			    int gen_param_count = LuaAPI.lua_gettop(L);
            
                if(gen_param_count == 2&& LuaTypes.LUA_TNUMBER == LuaAPI.lua_type(L, 2)) 
                {
                    int _packetHandle = LuaAPI.xlua_tointeger(L, 2);
                    
                    gen_to_be_invoked.Send( _packetHandle );
                    
                    
                    
                    return 0;
                }
                if(gen_param_count == 4&& (LuaAPI.lua_isnil(L, 2) || LuaAPI.lua_type(L, 2) == LuaTypes.LUA_TSTRING)&& LuaTypes.LUA_TNUMBER == LuaAPI.lua_type(L, 3)&& LuaTypes.LUA_TNUMBER == LuaAPI.lua_type(L, 4)) 
                {
                    byte[] _buf = LuaAPI.lua_tobytes(L, 2);
                    int _packetHandle = LuaAPI.xlua_tointeger(L, 3);
                    int _bufSize = LuaAPI.xlua_tointeger(L, 4);
                    
                    gen_to_be_invoked.Send( _buf, _packetHandle, _bufSize );
                    
                    
                    
                    return 0;
                }
                if(gen_param_count == 3&& (LuaAPI.lua_isnil(L, 2) || LuaAPI.lua_type(L, 2) == LuaTypes.LUA_TSTRING)&& LuaTypes.LUA_TNUMBER == LuaAPI.lua_type(L, 3)) 
                {
                    byte[] _buf = LuaAPI.lua_tobytes(L, 2);
                    int _packetHandle = LuaAPI.xlua_tointeger(L, 3);
                    
                    gen_to_be_invoked.Send( _buf, _packetHandle );
                    
                    
                    
                    return 0;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
            return LuaAPI.luaL_error(L, "invalid arguments to NsTcpClient.NetManager.Send!");
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_SendStr(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
                NsTcpClient.NetManager gen_to_be_invoked = (NsTcpClient.NetManager)translator.FastGetCSObj(L, 1);
            
            
                
                {
                    string _data = LuaAPI.lua_tostring(L, 2);
                    int _packetHandle = LuaAPI.xlua_tointeger(L, 3);
                    
                    gen_to_be_invoked.SendStr( _data, _packetHandle );
                    
                    
                    
                    return 0;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_SendMessage(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
                NsTcpClient.NetManager gen_to_be_invoked = (NsTcpClient.NetManager)translator.FastGetCSObj(L, 1);
            
            
                
                {
                    int _packetHandle = LuaAPI.xlua_tointeger(L, 2);
                    NsTcpClient.AbstractClientMessage _message = (NsTcpClient.AbstractClientMessage)translator.GetObject(L, 3, typeof(NsTcpClient.AbstractClientMessage));
                    
                    gen_to_be_invoked.SendMessage( _packetHandle, _message );
                    
                    
                    
                    return 0;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
        }
        
        
        
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _g_get_Ip(RealStatePtr L)
        {
		    try {
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
			
                NsTcpClient.NetManager gen_to_be_invoked = (NsTcpClient.NetManager)translator.FastGetCSObj(L, 1);
                LuaAPI.lua_pushstring(L, gen_to_be_invoked.Ip);
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            return 1;
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _g_get_Port(RealStatePtr L)
        {
		    try {
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
			
                NsTcpClient.NetManager gen_to_be_invoked = (NsTcpClient.NetManager)translator.FastGetCSObj(L, 1);
                LuaAPI.xlua_pushinteger(L, gen_to_be_invoked.Port);
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            return 1;
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _g_get_ClietnState(RealStatePtr L)
        {
		    try {
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
			
                NsTcpClient.NetManager gen_to_be_invoked = (NsTcpClient.NetManager)translator.FastGetCSObj(L, 1);
                translator.Push(L, gen_to_be_invoked.ClietnState);
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            return 1;
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _g_get_OnSocketAbort(RealStatePtr L)
        {
		    try {
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
			
                NsTcpClient.NetManager gen_to_be_invoked = (NsTcpClient.NetManager)translator.FastGetCSObj(L, 1);
                translator.Push(L, gen_to_be_invoked.OnSocketAbort);
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            return 1;
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _g_get_OnConnectResult(RealStatePtr L)
        {
		    try {
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
			
                NsTcpClient.NetManager gen_to_be_invoked = (NsTcpClient.NetManager)translator.FastGetCSObj(L, 1);
                translator.Push(L, gen_to_be_invoked.OnConnectResult);
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            return 1;
        }
        
        
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _s_set_OnSocketAbort(RealStatePtr L)
        {
		    try {
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
			
                NsTcpClient.NetManager gen_to_be_invoked = (NsTcpClient.NetManager)translator.FastGetCSObj(L, 1);
                gen_to_be_invoked.OnSocketAbort = translator.GetDelegate<System.Action>(L, 2);
            
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            return 0;
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _s_set_OnConnectResult(RealStatePtr L)
        {
		    try {
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
			
                NsTcpClient.NetManager gen_to_be_invoked = (NsTcpClient.NetManager)translator.FastGetCSObj(L, 1);
                gen_to_be_invoked.OnConnectResult = translator.GetDelegate<System.Action<bool>>(L, 2);
            
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            return 0;
        }
        
		
		
		
		
    }
}
