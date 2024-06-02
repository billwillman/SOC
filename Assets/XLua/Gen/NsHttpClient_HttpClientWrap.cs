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
    public class NsHttpClientHttpClientWrap 
    {
        public static void __Register(RealStatePtr L)
        {
			ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
			System.Type type = typeof(NsHttpClient.HttpClient);
			Utils.BeginObjectRegister(type, L, translator, 0, 2, 5, 1);
			
			Utils.RegisterFunc(L, Utils.METHOD_IDX, "Init", _m_Init);
			Utils.RegisterFunc(L, Utils.METHOD_IDX, "Dispose", _m_Dispose);
			
			
			Utils.RegisterFunc(L, Utils.GETTER_IDX, "Url", _g_get_Url);
            Utils.RegisterFunc(L, Utils.GETTER_IDX, "Timeout", _g_get_Timeout);
            Utils.RegisterFunc(L, Utils.GETTER_IDX, "ReadTimeout", _g_get_ReadTimeout);
            Utils.RegisterFunc(L, Utils.GETTER_IDX, "UserData", _g_get_UserData);
            Utils.RegisterFunc(L, Utils.GETTER_IDX, "Listener", _g_get_Listener);
            
			Utils.RegisterFunc(L, Utils.SETTER_IDX, "UserData", _s_set_UserData);
            
			
			Utils.EndObjectRegister(type, L, translator, null, null,
			    null, null, null);

		    Utils.BeginClassRegister(type, L, __CreateInstance, 4, 0, 0);
			Utils.RegisterFunc(L, Utils.CLS_IDX, "ResetServerPointCallBack", _m_ResetServerPointCallBack_xlua_st_);
            Utils.RegisterFunc(L, Utils.CLS_IDX, "GetPostUpFileContentType", _m_GetPostUpFileContentType_xlua_st_);
            Utils.RegisterFunc(L, Utils.CLS_IDX, "GetPostDefaultContentType", _m_GetPostDefaultContentType_xlua_st_);
            
			
            
			
			
			
			Utils.EndClassRegister(type, L, translator);
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int __CreateInstance(RealStatePtr L)
        {
            
			try {
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
				if(LuaAPI.lua_gettop(L) == 1)
				{
					
					var gen_ret = new NsHttpClient.HttpClient();
					translator.Push(L, gen_ret);
                    
					return 1;
				}
				if(LuaAPI.lua_gettop(L) == 9 && (LuaAPI.lua_isnil(L, 2) || LuaAPI.lua_type(L, 2) == LuaTypes.LUA_TSTRING) && translator.Assignable<NsHttpClient.IHttpClientListener>(L, 3) && LuaTypes.LUA_TNUMBER == LuaAPI.lua_type(L, 4) && LuaTypes.LUA_TNUMBER == LuaAPI.lua_type(L, 5) && translator.Assignable<NsHttpClient.HttpClientType>(L, 6) && (LuaAPI.lua_isnil(L, 7) || LuaAPI.lua_type(L, 7) == LuaTypes.LUA_TSTRING) && LuaTypes.LUA_TBOOLEAN == LuaAPI.lua_type(L, 8) && translator.Assignable<System.Collections.Generic.List<System.Security.Cryptography.X509Certificates.X509Certificate>>(L, 9))
				{
					string _url = LuaAPI.lua_tostring(L, 2);
					NsHttpClient.IHttpClientListener _listener = (NsHttpClient.IHttpClientListener)translator.GetObject(L, 3, typeof(NsHttpClient.IHttpClientListener));
					float _connectTimeOut = (float)LuaAPI.lua_tonumber(L, 4);
					float _readTimeOut = (float)LuaAPI.lua_tonumber(L, 5);
					NsHttpClient.HttpClientType _clientType;translator.Get(L, 6, out _clientType);
					string _postStr = LuaAPI.lua_tostring(L, 7);
					bool _isKeepAlive = LuaAPI.lua_toboolean(L, 8);
					System.Collections.Generic.List<System.Security.Cryptography.X509Certificates.X509Certificate> _certs = (System.Collections.Generic.List<System.Security.Cryptography.X509Certificates.X509Certificate>)translator.GetObject(L, 9, typeof(System.Collections.Generic.List<System.Security.Cryptography.X509Certificates.X509Certificate>));
					
					var gen_ret = new NsHttpClient.HttpClient(_url, _listener, _connectTimeOut, _readTimeOut, _clientType, _postStr, _isKeepAlive, _certs);
					translator.Push(L, gen_ret);
                    
					return 1;
				}
				if(LuaAPI.lua_gettop(L) == 8 && (LuaAPI.lua_isnil(L, 2) || LuaAPI.lua_type(L, 2) == LuaTypes.LUA_TSTRING) && translator.Assignable<NsHttpClient.IHttpClientListener>(L, 3) && LuaTypes.LUA_TNUMBER == LuaAPI.lua_type(L, 4) && LuaTypes.LUA_TNUMBER == LuaAPI.lua_type(L, 5) && translator.Assignable<NsHttpClient.HttpClientType>(L, 6) && (LuaAPI.lua_isnil(L, 7) || LuaAPI.lua_type(L, 7) == LuaTypes.LUA_TSTRING) && LuaTypes.LUA_TBOOLEAN == LuaAPI.lua_type(L, 8))
				{
					string _url = LuaAPI.lua_tostring(L, 2);
					NsHttpClient.IHttpClientListener _listener = (NsHttpClient.IHttpClientListener)translator.GetObject(L, 3, typeof(NsHttpClient.IHttpClientListener));
					float _connectTimeOut = (float)LuaAPI.lua_tonumber(L, 4);
					float _readTimeOut = (float)LuaAPI.lua_tonumber(L, 5);
					NsHttpClient.HttpClientType _clientType;translator.Get(L, 6, out _clientType);
					string _postStr = LuaAPI.lua_tostring(L, 7);
					bool _isKeepAlive = LuaAPI.lua_toboolean(L, 8);
					
					var gen_ret = new NsHttpClient.HttpClient(_url, _listener, _connectTimeOut, _readTimeOut, _clientType, _postStr, _isKeepAlive);
					translator.Push(L, gen_ret);
                    
					return 1;
				}
				if(LuaAPI.lua_gettop(L) == 7 && (LuaAPI.lua_isnil(L, 2) || LuaAPI.lua_type(L, 2) == LuaTypes.LUA_TSTRING) && translator.Assignable<NsHttpClient.IHttpClientListener>(L, 3) && LuaTypes.LUA_TNUMBER == LuaAPI.lua_type(L, 4) && LuaTypes.LUA_TNUMBER == LuaAPI.lua_type(L, 5) && translator.Assignable<NsHttpClient.HttpClientType>(L, 6) && (LuaAPI.lua_isnil(L, 7) || LuaAPI.lua_type(L, 7) == LuaTypes.LUA_TSTRING))
				{
					string _url = LuaAPI.lua_tostring(L, 2);
					NsHttpClient.IHttpClientListener _listener = (NsHttpClient.IHttpClientListener)translator.GetObject(L, 3, typeof(NsHttpClient.IHttpClientListener));
					float _connectTimeOut = (float)LuaAPI.lua_tonumber(L, 4);
					float _readTimeOut = (float)LuaAPI.lua_tonumber(L, 5);
					NsHttpClient.HttpClientType _clientType;translator.Get(L, 6, out _clientType);
					string _postStr = LuaAPI.lua_tostring(L, 7);
					
					var gen_ret = new NsHttpClient.HttpClient(_url, _listener, _connectTimeOut, _readTimeOut, _clientType, _postStr);
					translator.Push(L, gen_ret);
                    
					return 1;
				}
				if(LuaAPI.lua_gettop(L) == 6 && (LuaAPI.lua_isnil(L, 2) || LuaAPI.lua_type(L, 2) == LuaTypes.LUA_TSTRING) && translator.Assignable<NsHttpClient.IHttpClientListener>(L, 3) && LuaTypes.LUA_TNUMBER == LuaAPI.lua_type(L, 4) && LuaTypes.LUA_TNUMBER == LuaAPI.lua_type(L, 5) && translator.Assignable<NsHttpClient.HttpClientType>(L, 6))
				{
					string _url = LuaAPI.lua_tostring(L, 2);
					NsHttpClient.IHttpClientListener _listener = (NsHttpClient.IHttpClientListener)translator.GetObject(L, 3, typeof(NsHttpClient.IHttpClientListener));
					float _connectTimeOut = (float)LuaAPI.lua_tonumber(L, 4);
					float _readTimeOut = (float)LuaAPI.lua_tonumber(L, 5);
					NsHttpClient.HttpClientType _clientType;translator.Get(L, 6, out _clientType);
					
					var gen_ret = new NsHttpClient.HttpClient(_url, _listener, _connectTimeOut, _readTimeOut, _clientType);
					translator.Push(L, gen_ret);
                    
					return 1;
				}
				if(LuaAPI.lua_gettop(L) == 5 && (LuaAPI.lua_isnil(L, 2) || LuaAPI.lua_type(L, 2) == LuaTypes.LUA_TSTRING) && translator.Assignable<NsHttpClient.IHttpClientListener>(L, 3) && LuaTypes.LUA_TNUMBER == LuaAPI.lua_type(L, 4) && LuaTypes.LUA_TNUMBER == LuaAPI.lua_type(L, 5))
				{
					string _url = LuaAPI.lua_tostring(L, 2);
					NsHttpClient.IHttpClientListener _listener = (NsHttpClient.IHttpClientListener)translator.GetObject(L, 3, typeof(NsHttpClient.IHttpClientListener));
					float _connectTimeOut = (float)LuaAPI.lua_tonumber(L, 4);
					float _readTimeOut = (float)LuaAPI.lua_tonumber(L, 5);
					
					var gen_ret = new NsHttpClient.HttpClient(_url, _listener, _connectTimeOut, _readTimeOut);
					translator.Push(L, gen_ret);
                    
					return 1;
				}
				if(LuaAPI.lua_gettop(L) == 4 && (LuaAPI.lua_isnil(L, 2) || LuaAPI.lua_type(L, 2) == LuaTypes.LUA_TSTRING) && translator.Assignable<NsHttpClient.IHttpClientListener>(L, 3) && LuaTypes.LUA_TNUMBER == LuaAPI.lua_type(L, 4))
				{
					string _url = LuaAPI.lua_tostring(L, 2);
					NsHttpClient.IHttpClientListener _listener = (NsHttpClient.IHttpClientListener)translator.GetObject(L, 3, typeof(NsHttpClient.IHttpClientListener));
					float _connectTimeOut = (float)LuaAPI.lua_tonumber(L, 4);
					
					var gen_ret = new NsHttpClient.HttpClient(_url, _listener, _connectTimeOut);
					translator.Push(L, gen_ret);
                    
					return 1;
				}
				if(LuaAPI.lua_gettop(L) == 6 && (LuaAPI.lua_isnil(L, 2) || LuaAPI.lua_type(L, 2) == LuaTypes.LUA_TSTRING) && translator.Assignable<NsHttpClient.IHttpClientListener>(L, 3) && (LuaTypes.LUA_TNUMBER == LuaAPI.lua_type(L, 4) || LuaAPI.lua_isint64(L, 4)) && LuaTypes.LUA_TNUMBER == LuaAPI.lua_type(L, 5) && LuaTypes.LUA_TNUMBER == LuaAPI.lua_type(L, 6))
				{
					string _url = LuaAPI.lua_tostring(L, 2);
					NsHttpClient.IHttpClientListener _listener = (NsHttpClient.IHttpClientListener)translator.GetObject(L, 3, typeof(NsHttpClient.IHttpClientListener));
					long _filePos = LuaAPI.lua_toint64(L, 4);
					float _connectTimeOut = (float)LuaAPI.lua_tonumber(L, 5);
					float _readTimeOut = (float)LuaAPI.lua_tonumber(L, 6);
					
					var gen_ret = new NsHttpClient.HttpClient(_url, _listener, _filePos, _connectTimeOut, _readTimeOut);
					translator.Push(L, gen_ret);
                    
					return 1;
				}
				if(LuaAPI.lua_gettop(L) == 5 && (LuaAPI.lua_isnil(L, 2) || LuaAPI.lua_type(L, 2) == LuaTypes.LUA_TSTRING) && translator.Assignable<NsHttpClient.IHttpClientListener>(L, 3) && (LuaTypes.LUA_TNUMBER == LuaAPI.lua_type(L, 4) || LuaAPI.lua_isint64(L, 4)) && LuaTypes.LUA_TNUMBER == LuaAPI.lua_type(L, 5))
				{
					string _url = LuaAPI.lua_tostring(L, 2);
					NsHttpClient.IHttpClientListener _listener = (NsHttpClient.IHttpClientListener)translator.GetObject(L, 3, typeof(NsHttpClient.IHttpClientListener));
					long _filePos = LuaAPI.lua_toint64(L, 4);
					float _connectTimeOut = (float)LuaAPI.lua_tonumber(L, 5);
					
					var gen_ret = new NsHttpClient.HttpClient(_url, _listener, _filePos, _connectTimeOut);
					translator.Push(L, gen_ret);
                    
					return 1;
				}
				
			}
			catch(System.Exception gen_e) {
				return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
			}
            return LuaAPI.luaL_error(L, "invalid arguments to NsHttpClient.HttpClient constructor!");
            
        }
        
		
        
		
        
        
        
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_Init(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
                NsHttpClient.HttpClient gen_to_be_invoked = (NsHttpClient.HttpClient)translator.FastGetCSObj(L, 1);
            
            
			    int gen_param_count = LuaAPI.lua_gettop(L);
            
                if(gen_param_count == 10&& (LuaAPI.lua_isnil(L, 2) || LuaAPI.lua_type(L, 2) == LuaTypes.LUA_TSTRING)&& translator.Assignable<NsHttpClient.IHttpClientListener>(L, 3)&& (LuaTypes.LUA_TNUMBER == LuaAPI.lua_type(L, 4) || LuaAPI.lua_isint64(L, 4))&& LuaTypes.LUA_TNUMBER == LuaAPI.lua_type(L, 5)&& LuaTypes.LUA_TNUMBER == LuaAPI.lua_type(L, 6)&& translator.Assignable<NsHttpClient.HttpClientType>(L, 7)&& (LuaAPI.lua_isnil(L, 8) || LuaAPI.lua_type(L, 8) == LuaTypes.LUA_TSTRING)&& LuaTypes.LUA_TBOOLEAN == LuaAPI.lua_type(L, 9)&& translator.Assignable<System.Collections.Generic.List<System.Security.Cryptography.X509Certificates.X509Certificate>>(L, 10)) 
                {
                    string _url = LuaAPI.lua_tostring(L, 2);
                    NsHttpClient.IHttpClientListener _listener = (NsHttpClient.IHttpClientListener)translator.GetObject(L, 3, typeof(NsHttpClient.IHttpClientListener));
                    long _filePos = LuaAPI.lua_toint64(L, 4);
                    float _connectTimeOut = (float)LuaAPI.lua_tonumber(L, 5);
                    float _readTimeOut = (float)LuaAPI.lua_tonumber(L, 6);
                    NsHttpClient.HttpClientType _clientType;translator.Get(L, 7, out _clientType);
                    byte[] _postBuf = LuaAPI.lua_tobytes(L, 8);
                    bool _isKeepAlive = LuaAPI.lua_toboolean(L, 9);
                    System.Collections.Generic.List<System.Security.Cryptography.X509Certificates.X509Certificate> _certs = (System.Collections.Generic.List<System.Security.Cryptography.X509Certificates.X509Certificate>)translator.GetObject(L, 10, typeof(System.Collections.Generic.List<System.Security.Cryptography.X509Certificates.X509Certificate>));
                    
                    gen_to_be_invoked.Init( _url, _listener, _filePos, _connectTimeOut, _readTimeOut, _clientType, _postBuf, _isKeepAlive, _certs );
                    
                    
                    
                    return 0;
                }
                if(gen_param_count == 9&& (LuaAPI.lua_isnil(L, 2) || LuaAPI.lua_type(L, 2) == LuaTypes.LUA_TSTRING)&& translator.Assignable<NsHttpClient.IHttpClientListener>(L, 3)&& (LuaTypes.LUA_TNUMBER == LuaAPI.lua_type(L, 4) || LuaAPI.lua_isint64(L, 4))&& LuaTypes.LUA_TNUMBER == LuaAPI.lua_type(L, 5)&& LuaTypes.LUA_TNUMBER == LuaAPI.lua_type(L, 6)&& translator.Assignable<NsHttpClient.HttpClientType>(L, 7)&& (LuaAPI.lua_isnil(L, 8) || LuaAPI.lua_type(L, 8) == LuaTypes.LUA_TSTRING)&& LuaTypes.LUA_TBOOLEAN == LuaAPI.lua_type(L, 9)) 
                {
                    string _url = LuaAPI.lua_tostring(L, 2);
                    NsHttpClient.IHttpClientListener _listener = (NsHttpClient.IHttpClientListener)translator.GetObject(L, 3, typeof(NsHttpClient.IHttpClientListener));
                    long _filePos = LuaAPI.lua_toint64(L, 4);
                    float _connectTimeOut = (float)LuaAPI.lua_tonumber(L, 5);
                    float _readTimeOut = (float)LuaAPI.lua_tonumber(L, 6);
                    NsHttpClient.HttpClientType _clientType;translator.Get(L, 7, out _clientType);
                    byte[] _postBuf = LuaAPI.lua_tobytes(L, 8);
                    bool _isKeepAlive = LuaAPI.lua_toboolean(L, 9);
                    
                    gen_to_be_invoked.Init( _url, _listener, _filePos, _connectTimeOut, _readTimeOut, _clientType, _postBuf, _isKeepAlive );
                    
                    
                    
                    return 0;
                }
                if(gen_param_count == 8&& (LuaAPI.lua_isnil(L, 2) || LuaAPI.lua_type(L, 2) == LuaTypes.LUA_TSTRING)&& translator.Assignable<NsHttpClient.IHttpClientListener>(L, 3)&& (LuaTypes.LUA_TNUMBER == LuaAPI.lua_type(L, 4) || LuaAPI.lua_isint64(L, 4))&& LuaTypes.LUA_TNUMBER == LuaAPI.lua_type(L, 5)&& LuaTypes.LUA_TNUMBER == LuaAPI.lua_type(L, 6)&& translator.Assignable<NsHttpClient.HttpClientType>(L, 7)&& (LuaAPI.lua_isnil(L, 8) || LuaAPI.lua_type(L, 8) == LuaTypes.LUA_TSTRING)) 
                {
                    string _url = LuaAPI.lua_tostring(L, 2);
                    NsHttpClient.IHttpClientListener _listener = (NsHttpClient.IHttpClientListener)translator.GetObject(L, 3, typeof(NsHttpClient.IHttpClientListener));
                    long _filePos = LuaAPI.lua_toint64(L, 4);
                    float _connectTimeOut = (float)LuaAPI.lua_tonumber(L, 5);
                    float _readTimeOut = (float)LuaAPI.lua_tonumber(L, 6);
                    NsHttpClient.HttpClientType _clientType;translator.Get(L, 7, out _clientType);
                    byte[] _postBuf = LuaAPI.lua_tobytes(L, 8);
                    
                    gen_to_be_invoked.Init( _url, _listener, _filePos, _connectTimeOut, _readTimeOut, _clientType, _postBuf );
                    
                    
                    
                    return 0;
                }
                if(gen_param_count == 7&& (LuaAPI.lua_isnil(L, 2) || LuaAPI.lua_type(L, 2) == LuaTypes.LUA_TSTRING)&& translator.Assignable<NsHttpClient.IHttpClientListener>(L, 3)&& (LuaTypes.LUA_TNUMBER == LuaAPI.lua_type(L, 4) || LuaAPI.lua_isint64(L, 4))&& LuaTypes.LUA_TNUMBER == LuaAPI.lua_type(L, 5)&& LuaTypes.LUA_TNUMBER == LuaAPI.lua_type(L, 6)&& translator.Assignable<NsHttpClient.HttpClientType>(L, 7)) 
                {
                    string _url = LuaAPI.lua_tostring(L, 2);
                    NsHttpClient.IHttpClientListener _listener = (NsHttpClient.IHttpClientListener)translator.GetObject(L, 3, typeof(NsHttpClient.IHttpClientListener));
                    long _filePos = LuaAPI.lua_toint64(L, 4);
                    float _connectTimeOut = (float)LuaAPI.lua_tonumber(L, 5);
                    float _readTimeOut = (float)LuaAPI.lua_tonumber(L, 6);
                    NsHttpClient.HttpClientType _clientType;translator.Get(L, 7, out _clientType);
                    
                    gen_to_be_invoked.Init( _url, _listener, _filePos, _connectTimeOut, _readTimeOut, _clientType );
                    
                    
                    
                    return 0;
                }
                if(gen_param_count == 6&& (LuaAPI.lua_isnil(L, 2) || LuaAPI.lua_type(L, 2) == LuaTypes.LUA_TSTRING)&& translator.Assignable<NsHttpClient.IHttpClientListener>(L, 3)&& (LuaTypes.LUA_TNUMBER == LuaAPI.lua_type(L, 4) || LuaAPI.lua_isint64(L, 4))&& LuaTypes.LUA_TNUMBER == LuaAPI.lua_type(L, 5)&& LuaTypes.LUA_TNUMBER == LuaAPI.lua_type(L, 6)) 
                {
                    string _url = LuaAPI.lua_tostring(L, 2);
                    NsHttpClient.IHttpClientListener _listener = (NsHttpClient.IHttpClientListener)translator.GetObject(L, 3, typeof(NsHttpClient.IHttpClientListener));
                    long _filePos = LuaAPI.lua_toint64(L, 4);
                    float _connectTimeOut = (float)LuaAPI.lua_tonumber(L, 5);
                    float _readTimeOut = (float)LuaAPI.lua_tonumber(L, 6);
                    
                    gen_to_be_invoked.Init( _url, _listener, _filePos, _connectTimeOut, _readTimeOut );
                    
                    
                    
                    return 0;
                }
                if(gen_param_count == 5&& (LuaAPI.lua_isnil(L, 2) || LuaAPI.lua_type(L, 2) == LuaTypes.LUA_TSTRING)&& translator.Assignable<NsHttpClient.IHttpClientListener>(L, 3)&& (LuaTypes.LUA_TNUMBER == LuaAPI.lua_type(L, 4) || LuaAPI.lua_isint64(L, 4))&& LuaTypes.LUA_TNUMBER == LuaAPI.lua_type(L, 5)) 
                {
                    string _url = LuaAPI.lua_tostring(L, 2);
                    NsHttpClient.IHttpClientListener _listener = (NsHttpClient.IHttpClientListener)translator.GetObject(L, 3, typeof(NsHttpClient.IHttpClientListener));
                    long _filePos = LuaAPI.lua_toint64(L, 4);
                    float _connectTimeOut = (float)LuaAPI.lua_tonumber(L, 5);
                    
                    gen_to_be_invoked.Init( _url, _listener, _filePos, _connectTimeOut );
                    
                    
                    
                    return 0;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
            return LuaAPI.luaL_error(L, "invalid arguments to NsHttpClient.HttpClient.Init!");
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_ResetServerPointCallBack_xlua_st_(RealStatePtr L)
        {
		    try {
            
            
            
                
                {
                    
                    NsHttpClient.HttpClient.ResetServerPointCallBack(  );
                    
                    
                    
                    return 0;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_Dispose(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
                NsHttpClient.HttpClient gen_to_be_invoked = (NsHttpClient.HttpClient)translator.FastGetCSObj(L, 1);
            
            
                
                {
                    
                    gen_to_be_invoked.Dispose(  );
                    
                    
                    
                    return 0;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_GetPostUpFileContentType_xlua_st_(RealStatePtr L)
        {
		    try {
            
            
            
                
                {
                    string _boundary = LuaAPI.lua_tostring(L, 1);
                    
                        var gen_ret = NsHttpClient.HttpClient.GetPostUpFileContentType( ref _boundary );
                        LuaAPI.lua_pushstring(L, gen_ret);
                    LuaAPI.lua_pushstring(L, _boundary);
                        
                    
                    
                    
                    return 2;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_GetPostDefaultContentType_xlua_st_(RealStatePtr L)
        {
		    try {
            
            
            
                
                {
                    
                        var gen_ret = NsHttpClient.HttpClient.GetPostDefaultContentType(  );
                        LuaAPI.lua_pushstring(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
        }
        
        
        
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _g_get_Url(RealStatePtr L)
        {
		    try {
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
			
                NsHttpClient.HttpClient gen_to_be_invoked = (NsHttpClient.HttpClient)translator.FastGetCSObj(L, 1);
                LuaAPI.lua_pushstring(L, gen_to_be_invoked.Url);
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            return 1;
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _g_get_Timeout(RealStatePtr L)
        {
		    try {
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
			
                NsHttpClient.HttpClient gen_to_be_invoked = (NsHttpClient.HttpClient)translator.FastGetCSObj(L, 1);
                LuaAPI.lua_pushnumber(L, gen_to_be_invoked.Timeout);
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            return 1;
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _g_get_ReadTimeout(RealStatePtr L)
        {
		    try {
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
			
                NsHttpClient.HttpClient gen_to_be_invoked = (NsHttpClient.HttpClient)translator.FastGetCSObj(L, 1);
                LuaAPI.lua_pushnumber(L, gen_to_be_invoked.ReadTimeout);
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            return 1;
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _g_get_UserData(RealStatePtr L)
        {
		    try {
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
			
                NsHttpClient.HttpClient gen_to_be_invoked = (NsHttpClient.HttpClient)translator.FastGetCSObj(L, 1);
                translator.PushAny(L, gen_to_be_invoked.UserData);
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            return 1;
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _g_get_Listener(RealStatePtr L)
        {
		    try {
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
			
                NsHttpClient.HttpClient gen_to_be_invoked = (NsHttpClient.HttpClient)translator.FastGetCSObj(L, 1);
                translator.PushAny(L, gen_to_be_invoked.Listener);
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            return 1;
        }
        
        
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _s_set_UserData(RealStatePtr L)
        {
		    try {
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
			
                NsHttpClient.HttpClient gen_to_be_invoked = (NsHttpClient.HttpClient)translator.FastGetCSObj(L, 1);
                gen_to_be_invoked.UserData = translator.GetObject(L, 2, typeof(object));
            
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            return 0;
        }
        
		
		
		
		
    }
}
