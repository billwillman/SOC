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
    public class NsHttpClientHttpHelperWrap 
    {
        public static void __Register(RealStatePtr L)
        {
			ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
			System.Type type = typeof(NsHttpClient.HttpHelper);
			Utils.BeginObjectRegister(type, L, translator, 0, 0, 0, 0);
			
			
			
			
			
			
			Utils.EndObjectRegister(type, L, translator, null, null,
			    null, null, null);

		    Utils.BeginClassRegister(type, L, __CreateInstance, 6, 2, 0);
			Utils.RegisterFunc(L, Utils.CLS_IDX, "OpenUrl", _m_OpenUrl_xlua_st_);
            Utils.RegisterFunc(L, Utils.CLS_IDX, "OnAppExit", _m_OnAppExit_xlua_st_);
            Utils.RegisterFunc(L, Utils.CLS_IDX, "GetTimeStampStr", _m_GetTimeStampStr_xlua_st_);
            Utils.RegisterFunc(L, Utils.CLS_IDX, "AddTimeStamp", _m_AddTimeStamp_xlua_st_);
            Utils.RegisterFunc(L, Utils.CLS_IDX, "GeneratorPostString", _m_GeneratorPostString_xlua_st_);
            
			
            
			Utils.RegisterFunc(L, Utils.CLS_GETTER_IDX, "PoolCount", _g_get_PoolCount);
            Utils.RegisterFunc(L, Utils.CLS_GETTER_IDX, "RunCount", _g_get_RunCount);
            
			
			
			Utils.EndClassRegister(type, L, translator);
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int __CreateInstance(RealStatePtr L)
        {
            return LuaAPI.luaL_error(L, "NsHttpClient.HttpHelper does not have a constructor!");
        }
        
		
        
		
        
        
        
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_OpenUrl_xlua_st_(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
            
			    int gen_param_count = LuaAPI.lua_gettop(L);
            
                if(gen_param_count == 9&& (LuaAPI.lua_isnil(L, 1) || LuaAPI.lua_type(L, 1) == LuaTypes.LUA_TSTRING)&& translator.Assignable<NsHttpClient.HttpClientResponse>(L, 2)&& translator.Assignable<System.Action<NsHttpClient.HttpClient, NsHttpClient.HttpListenerStatus>>(L, 3)&& translator.Assignable<System.Action<NsHttpClient.HttpClient>>(L, 4)&& LuaTypes.LUA_TNUMBER == LuaAPI.lua_type(L, 5)&& LuaTypes.LUA_TNUMBER == LuaAPI.lua_type(L, 6)&& (LuaAPI.lua_isnil(L, 7) || LuaAPI.lua_type(L, 7) == LuaTypes.LUA_TSTRING)&& LuaTypes.LUA_TBOOLEAN == LuaAPI.lua_type(L, 8)&& translator.Assignable<System.Collections.Generic.List<System.Security.Cryptography.X509Certificates.X509Certificate>>(L, 9)) 
                {
                    string _url = LuaAPI.lua_tostring(L, 1);
                    NsHttpClient.HttpClientResponse _listener = (NsHttpClient.HttpClientResponse)translator.GetObject(L, 2, typeof(NsHttpClient.HttpClientResponse));
                    System.Action<NsHttpClient.HttpClient, NsHttpClient.HttpListenerStatus> _OnEnd = translator.GetDelegate<System.Action<NsHttpClient.HttpClient, NsHttpClient.HttpListenerStatus>>(L, 3);
                    System.Action<NsHttpClient.HttpClient> _OnProcess = translator.GetDelegate<System.Action<NsHttpClient.HttpClient>>(L, 4);
                    float _connectTimeOut = (float)LuaAPI.lua_tonumber(L, 5);
                    float _readTimeOut = (float)LuaAPI.lua_tonumber(L, 6);
                    string _postStr = LuaAPI.lua_tostring(L, 7);
                    bool _isKeepAlive = LuaAPI.lua_toboolean(L, 8);
                    System.Collections.Generic.List<System.Security.Cryptography.X509Certificates.X509Certificate> _certs = (System.Collections.Generic.List<System.Security.Cryptography.X509Certificates.X509Certificate>)translator.GetObject(L, 9, typeof(System.Collections.Generic.List<System.Security.Cryptography.X509Certificates.X509Certificate>));
                    
                        var gen_ret = NsHttpClient.HttpHelper.OpenUrl( _url, _listener, _OnEnd, _OnProcess, _connectTimeOut, _readTimeOut, _postStr, _isKeepAlive, _certs );
                        translator.Push(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                if(gen_param_count == 8&& (LuaAPI.lua_isnil(L, 1) || LuaAPI.lua_type(L, 1) == LuaTypes.LUA_TSTRING)&& translator.Assignable<NsHttpClient.HttpClientResponse>(L, 2)&& translator.Assignable<System.Action<NsHttpClient.HttpClient, NsHttpClient.HttpListenerStatus>>(L, 3)&& translator.Assignable<System.Action<NsHttpClient.HttpClient>>(L, 4)&& LuaTypes.LUA_TNUMBER == LuaAPI.lua_type(L, 5)&& LuaTypes.LUA_TNUMBER == LuaAPI.lua_type(L, 6)&& (LuaAPI.lua_isnil(L, 7) || LuaAPI.lua_type(L, 7) == LuaTypes.LUA_TSTRING)&& LuaTypes.LUA_TBOOLEAN == LuaAPI.lua_type(L, 8)) 
                {
                    string _url = LuaAPI.lua_tostring(L, 1);
                    NsHttpClient.HttpClientResponse _listener = (NsHttpClient.HttpClientResponse)translator.GetObject(L, 2, typeof(NsHttpClient.HttpClientResponse));
                    System.Action<NsHttpClient.HttpClient, NsHttpClient.HttpListenerStatus> _OnEnd = translator.GetDelegate<System.Action<NsHttpClient.HttpClient, NsHttpClient.HttpListenerStatus>>(L, 3);
                    System.Action<NsHttpClient.HttpClient> _OnProcess = translator.GetDelegate<System.Action<NsHttpClient.HttpClient>>(L, 4);
                    float _connectTimeOut = (float)LuaAPI.lua_tonumber(L, 5);
                    float _readTimeOut = (float)LuaAPI.lua_tonumber(L, 6);
                    string _postStr = LuaAPI.lua_tostring(L, 7);
                    bool _isKeepAlive = LuaAPI.lua_toboolean(L, 8);
                    
                        var gen_ret = NsHttpClient.HttpHelper.OpenUrl( _url, _listener, _OnEnd, _OnProcess, _connectTimeOut, _readTimeOut, _postStr, _isKeepAlive );
                        translator.Push(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                if(gen_param_count == 7&& (LuaAPI.lua_isnil(L, 1) || LuaAPI.lua_type(L, 1) == LuaTypes.LUA_TSTRING)&& translator.Assignable<NsHttpClient.HttpClientResponse>(L, 2)&& translator.Assignable<System.Action<NsHttpClient.HttpClient, NsHttpClient.HttpListenerStatus>>(L, 3)&& translator.Assignable<System.Action<NsHttpClient.HttpClient>>(L, 4)&& LuaTypes.LUA_TNUMBER == LuaAPI.lua_type(L, 5)&& LuaTypes.LUA_TNUMBER == LuaAPI.lua_type(L, 6)&& (LuaAPI.lua_isnil(L, 7) || LuaAPI.lua_type(L, 7) == LuaTypes.LUA_TSTRING)) 
                {
                    string _url = LuaAPI.lua_tostring(L, 1);
                    NsHttpClient.HttpClientResponse _listener = (NsHttpClient.HttpClientResponse)translator.GetObject(L, 2, typeof(NsHttpClient.HttpClientResponse));
                    System.Action<NsHttpClient.HttpClient, NsHttpClient.HttpListenerStatus> _OnEnd = translator.GetDelegate<System.Action<NsHttpClient.HttpClient, NsHttpClient.HttpListenerStatus>>(L, 3);
                    System.Action<NsHttpClient.HttpClient> _OnProcess = translator.GetDelegate<System.Action<NsHttpClient.HttpClient>>(L, 4);
                    float _connectTimeOut = (float)LuaAPI.lua_tonumber(L, 5);
                    float _readTimeOut = (float)LuaAPI.lua_tonumber(L, 6);
                    string _postStr = LuaAPI.lua_tostring(L, 7);
                    
                        var gen_ret = NsHttpClient.HttpHelper.OpenUrl( _url, _listener, _OnEnd, _OnProcess, _connectTimeOut, _readTimeOut, _postStr );
                        translator.Push(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                if(gen_param_count == 6&& (LuaAPI.lua_isnil(L, 1) || LuaAPI.lua_type(L, 1) == LuaTypes.LUA_TSTRING)&& translator.Assignable<NsHttpClient.HttpClientResponse>(L, 2)&& translator.Assignable<System.Action<NsHttpClient.HttpClient, NsHttpClient.HttpListenerStatus>>(L, 3)&& translator.Assignable<System.Action<NsHttpClient.HttpClient>>(L, 4)&& LuaTypes.LUA_TNUMBER == LuaAPI.lua_type(L, 5)&& LuaTypes.LUA_TNUMBER == LuaAPI.lua_type(L, 6)) 
                {
                    string _url = LuaAPI.lua_tostring(L, 1);
                    NsHttpClient.HttpClientResponse _listener = (NsHttpClient.HttpClientResponse)translator.GetObject(L, 2, typeof(NsHttpClient.HttpClientResponse));
                    System.Action<NsHttpClient.HttpClient, NsHttpClient.HttpListenerStatus> _OnEnd = translator.GetDelegate<System.Action<NsHttpClient.HttpClient, NsHttpClient.HttpListenerStatus>>(L, 3);
                    System.Action<NsHttpClient.HttpClient> _OnProcess = translator.GetDelegate<System.Action<NsHttpClient.HttpClient>>(L, 4);
                    float _connectTimeOut = (float)LuaAPI.lua_tonumber(L, 5);
                    float _readTimeOut = (float)LuaAPI.lua_tonumber(L, 6);
                    
                        var gen_ret = NsHttpClient.HttpHelper.OpenUrl( _url, _listener, _OnEnd, _OnProcess, _connectTimeOut, _readTimeOut );
                        translator.Push(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                if(gen_param_count == 5&& (LuaAPI.lua_isnil(L, 1) || LuaAPI.lua_type(L, 1) == LuaTypes.LUA_TSTRING)&& translator.Assignable<NsHttpClient.HttpClientResponse>(L, 2)&& translator.Assignable<System.Action<NsHttpClient.HttpClient, NsHttpClient.HttpListenerStatus>>(L, 3)&& translator.Assignable<System.Action<NsHttpClient.HttpClient>>(L, 4)&& LuaTypes.LUA_TNUMBER == LuaAPI.lua_type(L, 5)) 
                {
                    string _url = LuaAPI.lua_tostring(L, 1);
                    NsHttpClient.HttpClientResponse _listener = (NsHttpClient.HttpClientResponse)translator.GetObject(L, 2, typeof(NsHttpClient.HttpClientResponse));
                    System.Action<NsHttpClient.HttpClient, NsHttpClient.HttpListenerStatus> _OnEnd = translator.GetDelegate<System.Action<NsHttpClient.HttpClient, NsHttpClient.HttpListenerStatus>>(L, 3);
                    System.Action<NsHttpClient.HttpClient> _OnProcess = translator.GetDelegate<System.Action<NsHttpClient.HttpClient>>(L, 4);
                    float _connectTimeOut = (float)LuaAPI.lua_tonumber(L, 5);
                    
                        var gen_ret = NsHttpClient.HttpHelper.OpenUrl( _url, _listener, _OnEnd, _OnProcess, _connectTimeOut );
                        translator.Push(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                if(gen_param_count == 4&& (LuaAPI.lua_isnil(L, 1) || LuaAPI.lua_type(L, 1) == LuaTypes.LUA_TSTRING)&& translator.Assignable<NsHttpClient.HttpClientResponse>(L, 2)&& translator.Assignable<System.Action<NsHttpClient.HttpClient, NsHttpClient.HttpListenerStatus>>(L, 3)&& translator.Assignable<System.Action<NsHttpClient.HttpClient>>(L, 4)) 
                {
                    string _url = LuaAPI.lua_tostring(L, 1);
                    NsHttpClient.HttpClientResponse _listener = (NsHttpClient.HttpClientResponse)translator.GetObject(L, 2, typeof(NsHttpClient.HttpClientResponse));
                    System.Action<NsHttpClient.HttpClient, NsHttpClient.HttpListenerStatus> _OnEnd = translator.GetDelegate<System.Action<NsHttpClient.HttpClient, NsHttpClient.HttpListenerStatus>>(L, 3);
                    System.Action<NsHttpClient.HttpClient> _OnProcess = translator.GetDelegate<System.Action<NsHttpClient.HttpClient>>(L, 4);
                    
                        var gen_ret = NsHttpClient.HttpHelper.OpenUrl( _url, _listener, _OnEnd, _OnProcess );
                        translator.Push(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                if(gen_param_count == 3&& (LuaAPI.lua_isnil(L, 1) || LuaAPI.lua_type(L, 1) == LuaTypes.LUA_TSTRING)&& translator.Assignable<NsHttpClient.HttpClientResponse>(L, 2)&& translator.Assignable<System.Action<NsHttpClient.HttpClient, NsHttpClient.HttpListenerStatus>>(L, 3)) 
                {
                    string _url = LuaAPI.lua_tostring(L, 1);
                    NsHttpClient.HttpClientResponse _listener = (NsHttpClient.HttpClientResponse)translator.GetObject(L, 2, typeof(NsHttpClient.HttpClientResponse));
                    System.Action<NsHttpClient.HttpClient, NsHttpClient.HttpListenerStatus> _OnEnd = translator.GetDelegate<System.Action<NsHttpClient.HttpClient, NsHttpClient.HttpListenerStatus>>(L, 3);
                    
                        var gen_ret = NsHttpClient.HttpHelper.OpenUrl( _url, _listener, _OnEnd );
                        translator.Push(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                if(gen_param_count == 2&& (LuaAPI.lua_isnil(L, 1) || LuaAPI.lua_type(L, 1) == LuaTypes.LUA_TSTRING)&& translator.Assignable<NsHttpClient.HttpClientResponse>(L, 2)) 
                {
                    string _url = LuaAPI.lua_tostring(L, 1);
                    NsHttpClient.HttpClientResponse _listener = (NsHttpClient.HttpClientResponse)translator.GetObject(L, 2, typeof(NsHttpClient.HttpClientResponse));
                    
                        var gen_ret = NsHttpClient.HttpHelper.OpenUrl( _url, _listener );
                        translator.Push(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                if(gen_param_count == 10&& (LuaAPI.lua_isnil(L, 1) || LuaAPI.lua_type(L, 1) == LuaTypes.LUA_TSTRING)&& translator.Assignable<NsHttpClient.HttpClientResponse>(L, 2)&& (LuaTypes.LUA_TNUMBER == LuaAPI.lua_type(L, 3) || LuaAPI.lua_isint64(L, 3))&& translator.Assignable<System.Action<NsHttpClient.HttpClient, NsHttpClient.HttpListenerStatus>>(L, 4)&& translator.Assignable<System.Action<NsHttpClient.HttpClient>>(L, 5)&& LuaTypes.LUA_TNUMBER == LuaAPI.lua_type(L, 6)&& LuaTypes.LUA_TNUMBER == LuaAPI.lua_type(L, 7)&& (LuaAPI.lua_isnil(L, 8) || LuaAPI.lua_type(L, 8) == LuaTypes.LUA_TSTRING)&& LuaTypes.LUA_TBOOLEAN == LuaAPI.lua_type(L, 9)&& translator.Assignable<System.Collections.Generic.List<System.Security.Cryptography.X509Certificates.X509Certificate>>(L, 10)) 
                {
                    string _url = LuaAPI.lua_tostring(L, 1);
                    NsHttpClient.HttpClientResponse _listener = (NsHttpClient.HttpClientResponse)translator.GetObject(L, 2, typeof(NsHttpClient.HttpClientResponse));
                    long _filePos = LuaAPI.lua_toint64(L, 3);
                    System.Action<NsHttpClient.HttpClient, NsHttpClient.HttpListenerStatus> _OnEnd = translator.GetDelegate<System.Action<NsHttpClient.HttpClient, NsHttpClient.HttpListenerStatus>>(L, 4);
                    System.Action<NsHttpClient.HttpClient> _OnProcess = translator.GetDelegate<System.Action<NsHttpClient.HttpClient>>(L, 5);
                    float _connectTimeOut = (float)LuaAPI.lua_tonumber(L, 6);
                    float _readTimeOut = (float)LuaAPI.lua_tonumber(L, 7);
                    string _postStr = LuaAPI.lua_tostring(L, 8);
                    bool _isKeepAlive = LuaAPI.lua_toboolean(L, 9);
                    System.Collections.Generic.List<System.Security.Cryptography.X509Certificates.X509Certificate> _certs = (System.Collections.Generic.List<System.Security.Cryptography.X509Certificates.X509Certificate>)translator.GetObject(L, 10, typeof(System.Collections.Generic.List<System.Security.Cryptography.X509Certificates.X509Certificate>));
                    
                        var gen_ret = NsHttpClient.HttpHelper.OpenUrl( _url, _listener, _filePos, _OnEnd, _OnProcess, _connectTimeOut, _readTimeOut, _postStr, _isKeepAlive, _certs );
                        translator.Push(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                if(gen_param_count == 9&& (LuaAPI.lua_isnil(L, 1) || LuaAPI.lua_type(L, 1) == LuaTypes.LUA_TSTRING)&& translator.Assignable<NsHttpClient.HttpClientResponse>(L, 2)&& (LuaTypes.LUA_TNUMBER == LuaAPI.lua_type(L, 3) || LuaAPI.lua_isint64(L, 3))&& translator.Assignable<System.Action<NsHttpClient.HttpClient, NsHttpClient.HttpListenerStatus>>(L, 4)&& translator.Assignable<System.Action<NsHttpClient.HttpClient>>(L, 5)&& LuaTypes.LUA_TNUMBER == LuaAPI.lua_type(L, 6)&& LuaTypes.LUA_TNUMBER == LuaAPI.lua_type(L, 7)&& (LuaAPI.lua_isnil(L, 8) || LuaAPI.lua_type(L, 8) == LuaTypes.LUA_TSTRING)&& LuaTypes.LUA_TBOOLEAN == LuaAPI.lua_type(L, 9)) 
                {
                    string _url = LuaAPI.lua_tostring(L, 1);
                    NsHttpClient.HttpClientResponse _listener = (NsHttpClient.HttpClientResponse)translator.GetObject(L, 2, typeof(NsHttpClient.HttpClientResponse));
                    long _filePos = LuaAPI.lua_toint64(L, 3);
                    System.Action<NsHttpClient.HttpClient, NsHttpClient.HttpListenerStatus> _OnEnd = translator.GetDelegate<System.Action<NsHttpClient.HttpClient, NsHttpClient.HttpListenerStatus>>(L, 4);
                    System.Action<NsHttpClient.HttpClient> _OnProcess = translator.GetDelegate<System.Action<NsHttpClient.HttpClient>>(L, 5);
                    float _connectTimeOut = (float)LuaAPI.lua_tonumber(L, 6);
                    float _readTimeOut = (float)LuaAPI.lua_tonumber(L, 7);
                    string _postStr = LuaAPI.lua_tostring(L, 8);
                    bool _isKeepAlive = LuaAPI.lua_toboolean(L, 9);
                    
                        var gen_ret = NsHttpClient.HttpHelper.OpenUrl( _url, _listener, _filePos, _OnEnd, _OnProcess, _connectTimeOut, _readTimeOut, _postStr, _isKeepAlive );
                        translator.Push(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                if(gen_param_count == 8&& (LuaAPI.lua_isnil(L, 1) || LuaAPI.lua_type(L, 1) == LuaTypes.LUA_TSTRING)&& translator.Assignable<NsHttpClient.HttpClientResponse>(L, 2)&& (LuaTypes.LUA_TNUMBER == LuaAPI.lua_type(L, 3) || LuaAPI.lua_isint64(L, 3))&& translator.Assignable<System.Action<NsHttpClient.HttpClient, NsHttpClient.HttpListenerStatus>>(L, 4)&& translator.Assignable<System.Action<NsHttpClient.HttpClient>>(L, 5)&& LuaTypes.LUA_TNUMBER == LuaAPI.lua_type(L, 6)&& LuaTypes.LUA_TNUMBER == LuaAPI.lua_type(L, 7)&& (LuaAPI.lua_isnil(L, 8) || LuaAPI.lua_type(L, 8) == LuaTypes.LUA_TSTRING)) 
                {
                    string _url = LuaAPI.lua_tostring(L, 1);
                    NsHttpClient.HttpClientResponse _listener = (NsHttpClient.HttpClientResponse)translator.GetObject(L, 2, typeof(NsHttpClient.HttpClientResponse));
                    long _filePos = LuaAPI.lua_toint64(L, 3);
                    System.Action<NsHttpClient.HttpClient, NsHttpClient.HttpListenerStatus> _OnEnd = translator.GetDelegate<System.Action<NsHttpClient.HttpClient, NsHttpClient.HttpListenerStatus>>(L, 4);
                    System.Action<NsHttpClient.HttpClient> _OnProcess = translator.GetDelegate<System.Action<NsHttpClient.HttpClient>>(L, 5);
                    float _connectTimeOut = (float)LuaAPI.lua_tonumber(L, 6);
                    float _readTimeOut = (float)LuaAPI.lua_tonumber(L, 7);
                    string _postStr = LuaAPI.lua_tostring(L, 8);
                    
                        var gen_ret = NsHttpClient.HttpHelper.OpenUrl( _url, _listener, _filePos, _OnEnd, _OnProcess, _connectTimeOut, _readTimeOut, _postStr );
                        translator.Push(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                if(gen_param_count == 7&& (LuaAPI.lua_isnil(L, 1) || LuaAPI.lua_type(L, 1) == LuaTypes.LUA_TSTRING)&& translator.Assignable<NsHttpClient.HttpClientResponse>(L, 2)&& (LuaTypes.LUA_TNUMBER == LuaAPI.lua_type(L, 3) || LuaAPI.lua_isint64(L, 3))&& translator.Assignable<System.Action<NsHttpClient.HttpClient, NsHttpClient.HttpListenerStatus>>(L, 4)&& translator.Assignable<System.Action<NsHttpClient.HttpClient>>(L, 5)&& LuaTypes.LUA_TNUMBER == LuaAPI.lua_type(L, 6)&& LuaTypes.LUA_TNUMBER == LuaAPI.lua_type(L, 7)) 
                {
                    string _url = LuaAPI.lua_tostring(L, 1);
                    NsHttpClient.HttpClientResponse _listener = (NsHttpClient.HttpClientResponse)translator.GetObject(L, 2, typeof(NsHttpClient.HttpClientResponse));
                    long _filePos = LuaAPI.lua_toint64(L, 3);
                    System.Action<NsHttpClient.HttpClient, NsHttpClient.HttpListenerStatus> _OnEnd = translator.GetDelegate<System.Action<NsHttpClient.HttpClient, NsHttpClient.HttpListenerStatus>>(L, 4);
                    System.Action<NsHttpClient.HttpClient> _OnProcess = translator.GetDelegate<System.Action<NsHttpClient.HttpClient>>(L, 5);
                    float _connectTimeOut = (float)LuaAPI.lua_tonumber(L, 6);
                    float _readTimeOut = (float)LuaAPI.lua_tonumber(L, 7);
                    
                        var gen_ret = NsHttpClient.HttpHelper.OpenUrl( _url, _listener, _filePos, _OnEnd, _OnProcess, _connectTimeOut, _readTimeOut );
                        translator.Push(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                if(gen_param_count == 6&& (LuaAPI.lua_isnil(L, 1) || LuaAPI.lua_type(L, 1) == LuaTypes.LUA_TSTRING)&& translator.Assignable<NsHttpClient.HttpClientResponse>(L, 2)&& (LuaTypes.LUA_TNUMBER == LuaAPI.lua_type(L, 3) || LuaAPI.lua_isint64(L, 3))&& translator.Assignable<System.Action<NsHttpClient.HttpClient, NsHttpClient.HttpListenerStatus>>(L, 4)&& translator.Assignable<System.Action<NsHttpClient.HttpClient>>(L, 5)&& LuaTypes.LUA_TNUMBER == LuaAPI.lua_type(L, 6)) 
                {
                    string _url = LuaAPI.lua_tostring(L, 1);
                    NsHttpClient.HttpClientResponse _listener = (NsHttpClient.HttpClientResponse)translator.GetObject(L, 2, typeof(NsHttpClient.HttpClientResponse));
                    long _filePos = LuaAPI.lua_toint64(L, 3);
                    System.Action<NsHttpClient.HttpClient, NsHttpClient.HttpListenerStatus> _OnEnd = translator.GetDelegate<System.Action<NsHttpClient.HttpClient, NsHttpClient.HttpListenerStatus>>(L, 4);
                    System.Action<NsHttpClient.HttpClient> _OnProcess = translator.GetDelegate<System.Action<NsHttpClient.HttpClient>>(L, 5);
                    float _connectTimeOut = (float)LuaAPI.lua_tonumber(L, 6);
                    
                        var gen_ret = NsHttpClient.HttpHelper.OpenUrl( _url, _listener, _filePos, _OnEnd, _OnProcess, _connectTimeOut );
                        translator.Push(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                if(gen_param_count == 5&& (LuaAPI.lua_isnil(L, 1) || LuaAPI.lua_type(L, 1) == LuaTypes.LUA_TSTRING)&& translator.Assignable<NsHttpClient.HttpClientResponse>(L, 2)&& (LuaTypes.LUA_TNUMBER == LuaAPI.lua_type(L, 3) || LuaAPI.lua_isint64(L, 3))&& translator.Assignable<System.Action<NsHttpClient.HttpClient, NsHttpClient.HttpListenerStatus>>(L, 4)&& translator.Assignable<System.Action<NsHttpClient.HttpClient>>(L, 5)) 
                {
                    string _url = LuaAPI.lua_tostring(L, 1);
                    NsHttpClient.HttpClientResponse _listener = (NsHttpClient.HttpClientResponse)translator.GetObject(L, 2, typeof(NsHttpClient.HttpClientResponse));
                    long _filePos = LuaAPI.lua_toint64(L, 3);
                    System.Action<NsHttpClient.HttpClient, NsHttpClient.HttpListenerStatus> _OnEnd = translator.GetDelegate<System.Action<NsHttpClient.HttpClient, NsHttpClient.HttpListenerStatus>>(L, 4);
                    System.Action<NsHttpClient.HttpClient> _OnProcess = translator.GetDelegate<System.Action<NsHttpClient.HttpClient>>(L, 5);
                    
                        var gen_ret = NsHttpClient.HttpHelper.OpenUrl( _url, _listener, _filePos, _OnEnd, _OnProcess );
                        translator.Push(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                if(gen_param_count == 4&& (LuaAPI.lua_isnil(L, 1) || LuaAPI.lua_type(L, 1) == LuaTypes.LUA_TSTRING)&& translator.Assignable<NsHttpClient.HttpClientResponse>(L, 2)&& (LuaTypes.LUA_TNUMBER == LuaAPI.lua_type(L, 3) || LuaAPI.lua_isint64(L, 3))&& translator.Assignable<System.Action<NsHttpClient.HttpClient, NsHttpClient.HttpListenerStatus>>(L, 4)) 
                {
                    string _url = LuaAPI.lua_tostring(L, 1);
                    NsHttpClient.HttpClientResponse _listener = (NsHttpClient.HttpClientResponse)translator.GetObject(L, 2, typeof(NsHttpClient.HttpClientResponse));
                    long _filePos = LuaAPI.lua_toint64(L, 3);
                    System.Action<NsHttpClient.HttpClient, NsHttpClient.HttpListenerStatus> _OnEnd = translator.GetDelegate<System.Action<NsHttpClient.HttpClient, NsHttpClient.HttpListenerStatus>>(L, 4);
                    
                        var gen_ret = NsHttpClient.HttpHelper.OpenUrl( _url, _listener, _filePos, _OnEnd );
                        translator.Push(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                if(gen_param_count == 3&& (LuaAPI.lua_isnil(L, 1) || LuaAPI.lua_type(L, 1) == LuaTypes.LUA_TSTRING)&& translator.Assignable<NsHttpClient.HttpClientResponse>(L, 2)&& (LuaTypes.LUA_TNUMBER == LuaAPI.lua_type(L, 3) || LuaAPI.lua_isint64(L, 3))) 
                {
                    string _url = LuaAPI.lua_tostring(L, 1);
                    NsHttpClient.HttpClientResponse _listener = (NsHttpClient.HttpClientResponse)translator.GetObject(L, 2, typeof(NsHttpClient.HttpClientResponse));
                    long _filePos = LuaAPI.lua_toint64(L, 3);
                    
                        var gen_ret = NsHttpClient.HttpHelper.OpenUrl( _url, _listener, _filePos );
                        translator.Push(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
            return LuaAPI.luaL_error(L, "invalid arguments to NsHttpClient.HttpHelper.OpenUrl!");
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_OnAppExit_xlua_st_(RealStatePtr L)
        {
		    try {
            
            
            
                
                {
                    
                    NsHttpClient.HttpHelper.OnAppExit(  );
                    
                    
                    
                    return 0;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_GetTimeStampStr_xlua_st_(RealStatePtr L)
        {
		    try {
            
            
            
                
                {
                    
                        var gen_ret = NsHttpClient.HttpHelper.GetTimeStampStr(  );
                        LuaAPI.lua_pushstring(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_AddTimeStamp_xlua_st_(RealStatePtr L)
        {
		    try {
            
            
            
                
                {
                    string _url = LuaAPI.lua_tostring(L, 1);
                    
                        var gen_ret = NsHttpClient.HttpHelper.AddTimeStamp( _url );
                        LuaAPI.lua_pushstring(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_GeneratorPostString_xlua_st_(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
            
                
                {
                    string[] _keyValues = translator.GetParams<string>(L, 1);
                    
                        var gen_ret = NsHttpClient.HttpHelper.GeneratorPostString( _keyValues );
                        LuaAPI.lua_pushstring(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
        }
        
        
        
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _g_get_PoolCount(RealStatePtr L)
        {
		    try {
            
			    LuaAPI.xlua_pushinteger(L, NsHttpClient.HttpHelper.PoolCount);
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            return 1;
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _g_get_RunCount(RealStatePtr L)
        {
		    try {
            
			    LuaAPI.xlua_pushinteger(L, NsHttpClient.HttpHelper.RunCount);
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            return 1;
        }
        
        
        
		
		
		
		
    }
}
