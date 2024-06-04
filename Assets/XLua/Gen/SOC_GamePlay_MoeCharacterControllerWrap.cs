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
    public class SOCGamePlayMoeCharacterControllerWrap 
    {
        public static void __Register(RealStatePtr L)
        {
			ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
			System.Type type = typeof(SOC.GamePlay.MoeCharacterController);
			Utils.BeginObjectRegister(type, L, translator, 0, 10, 0, 0);
			
			Utils.RegisterFunc(L, Utils.METHOD_IDX, "UpdateRotation", _m_UpdateRotation);
			Utils.RegisterFunc(L, Utils.METHOD_IDX, "UpdateVelocity", _m_UpdateVelocity);
			Utils.RegisterFunc(L, Utils.METHOD_IDX, "BeforeCharacterUpdate", _m_BeforeCharacterUpdate);
			Utils.RegisterFunc(L, Utils.METHOD_IDX, "PostGroundingUpdate", _m_PostGroundingUpdate);
			Utils.RegisterFunc(L, Utils.METHOD_IDX, "AfterCharacterUpdate", _m_AfterCharacterUpdate);
			Utils.RegisterFunc(L, Utils.METHOD_IDX, "IsColliderValidForCollisions", _m_IsColliderValidForCollisions);
			Utils.RegisterFunc(L, Utils.METHOD_IDX, "OnGroundHit", _m_OnGroundHit);
			Utils.RegisterFunc(L, Utils.METHOD_IDX, "OnMovementHit", _m_OnMovementHit);
			Utils.RegisterFunc(L, Utils.METHOD_IDX, "ProcessHitStabilityReport", _m_ProcessHitStabilityReport);
			Utils.RegisterFunc(L, Utils.METHOD_IDX, "OnDiscreteCollisionDetected", _m_OnDiscreteCollisionDetected);
			
			
			
			
			
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
					
					var gen_ret = new SOC.GamePlay.MoeCharacterController();
					translator.Push(L, gen_ret);
                    
					return 1;
				}
				
			}
			catch(System.Exception gen_e) {
				return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
			}
            return LuaAPI.luaL_error(L, "invalid arguments to SOC.GamePlay.MoeCharacterController constructor!");
            
        }
        
		
        
		
        
        
        
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_UpdateRotation(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
                SOC.GamePlay.MoeCharacterController gen_to_be_invoked = (SOC.GamePlay.MoeCharacterController)translator.FastGetCSObj(L, 1);
            
            
                
                {
                    UnityEngine.Quaternion _currentRotation;translator.Get(L, 2, out _currentRotation);
                    float _deltaTime = (float)LuaAPI.lua_tonumber(L, 3);
                    
                    gen_to_be_invoked.UpdateRotation( ref _currentRotation, _deltaTime );
                    translator.PushUnityEngineQuaternion(L, _currentRotation);
                        translator.UpdateUnityEngineQuaternion(L, 2, _currentRotation);
                        
                    
                    
                    
                    return 1;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_UpdateVelocity(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
                SOC.GamePlay.MoeCharacterController gen_to_be_invoked = (SOC.GamePlay.MoeCharacterController)translator.FastGetCSObj(L, 1);
            
            
                
                {
                    UnityEngine.Vector3 _currentVelocity;translator.Get(L, 2, out _currentVelocity);
                    float _deltaTime = (float)LuaAPI.lua_tonumber(L, 3);
                    
                    gen_to_be_invoked.UpdateVelocity( ref _currentVelocity, _deltaTime );
                    translator.PushUnityEngineVector3(L, _currentVelocity);
                        translator.UpdateUnityEngineVector3(L, 2, _currentVelocity);
                        
                    
                    
                    
                    return 1;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_BeforeCharacterUpdate(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
                SOC.GamePlay.MoeCharacterController gen_to_be_invoked = (SOC.GamePlay.MoeCharacterController)translator.FastGetCSObj(L, 1);
            
            
                
                {
                    float _deltaTime = (float)LuaAPI.lua_tonumber(L, 2);
                    
                    gen_to_be_invoked.BeforeCharacterUpdate( _deltaTime );
                    
                    
                    
                    return 0;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_PostGroundingUpdate(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
                SOC.GamePlay.MoeCharacterController gen_to_be_invoked = (SOC.GamePlay.MoeCharacterController)translator.FastGetCSObj(L, 1);
            
            
                
                {
                    float _deltaTime = (float)LuaAPI.lua_tonumber(L, 2);
                    
                    gen_to_be_invoked.PostGroundingUpdate( _deltaTime );
                    
                    
                    
                    return 0;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_AfterCharacterUpdate(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
                SOC.GamePlay.MoeCharacterController gen_to_be_invoked = (SOC.GamePlay.MoeCharacterController)translator.FastGetCSObj(L, 1);
            
            
                
                {
                    float _deltaTime = (float)LuaAPI.lua_tonumber(L, 2);
                    
                    gen_to_be_invoked.AfterCharacterUpdate( _deltaTime );
                    
                    
                    
                    return 0;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_IsColliderValidForCollisions(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
                SOC.GamePlay.MoeCharacterController gen_to_be_invoked = (SOC.GamePlay.MoeCharacterController)translator.FastGetCSObj(L, 1);
            
            
                
                {
                    UnityEngine.Collider _coll = (UnityEngine.Collider)translator.GetObject(L, 2, typeof(UnityEngine.Collider));
                    
                        var gen_ret = gen_to_be_invoked.IsColliderValidForCollisions( _coll );
                        LuaAPI.lua_pushboolean(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_OnGroundHit(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
                SOC.GamePlay.MoeCharacterController gen_to_be_invoked = (SOC.GamePlay.MoeCharacterController)translator.FastGetCSObj(L, 1);
            
            
                
                {
                    UnityEngine.Collider _hitCollider = (UnityEngine.Collider)translator.GetObject(L, 2, typeof(UnityEngine.Collider));
                    UnityEngine.Vector3 _hitNormal;translator.Get(L, 3, out _hitNormal);
                    UnityEngine.Vector3 _hitPoint;translator.Get(L, 4, out _hitPoint);
                    KinematicCharacterController.HitStabilityReport _hitStabilityReport;translator.Get(L, 5, out _hitStabilityReport);
                    
                    gen_to_be_invoked.OnGroundHit( _hitCollider, _hitNormal, _hitPoint, ref _hitStabilityReport );
                    translator.Push(L, _hitStabilityReport);
                        translator.Update(L, 5, _hitStabilityReport);
                        
                    
                    
                    
                    return 1;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_OnMovementHit(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
                SOC.GamePlay.MoeCharacterController gen_to_be_invoked = (SOC.GamePlay.MoeCharacterController)translator.FastGetCSObj(L, 1);
            
            
                
                {
                    UnityEngine.Collider _hitCollider = (UnityEngine.Collider)translator.GetObject(L, 2, typeof(UnityEngine.Collider));
                    UnityEngine.Vector3 _hitNormal;translator.Get(L, 3, out _hitNormal);
                    UnityEngine.Vector3 _hitPoint;translator.Get(L, 4, out _hitPoint);
                    KinematicCharacterController.HitStabilityReport _hitStabilityReport;translator.Get(L, 5, out _hitStabilityReport);
                    
                    gen_to_be_invoked.OnMovementHit( _hitCollider, _hitNormal, _hitPoint, ref _hitStabilityReport );
                    translator.Push(L, _hitStabilityReport);
                        translator.Update(L, 5, _hitStabilityReport);
                        
                    
                    
                    
                    return 1;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_ProcessHitStabilityReport(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
                SOC.GamePlay.MoeCharacterController gen_to_be_invoked = (SOC.GamePlay.MoeCharacterController)translator.FastGetCSObj(L, 1);
            
            
                
                {
                    UnityEngine.Collider _hitCollider = (UnityEngine.Collider)translator.GetObject(L, 2, typeof(UnityEngine.Collider));
                    UnityEngine.Vector3 _hitNormal;translator.Get(L, 3, out _hitNormal);
                    UnityEngine.Vector3 _hitPoint;translator.Get(L, 4, out _hitPoint);
                    UnityEngine.Vector3 _atCharacterPosition;translator.Get(L, 5, out _atCharacterPosition);
                    UnityEngine.Quaternion _atCharacterRotation;translator.Get(L, 6, out _atCharacterRotation);
                    KinematicCharacterController.HitStabilityReport _hitStabilityReport;translator.Get(L, 7, out _hitStabilityReport);
                    
                    gen_to_be_invoked.ProcessHitStabilityReport( _hitCollider, _hitNormal, _hitPoint, _atCharacterPosition, _atCharacterRotation, ref _hitStabilityReport );
                    translator.Push(L, _hitStabilityReport);
                        translator.Update(L, 7, _hitStabilityReport);
                        
                    
                    
                    
                    return 1;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_OnDiscreteCollisionDetected(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
                SOC.GamePlay.MoeCharacterController gen_to_be_invoked = (SOC.GamePlay.MoeCharacterController)translator.FastGetCSObj(L, 1);
            
            
                
                {
                    UnityEngine.Collider _hitCollider = (UnityEngine.Collider)translator.GetObject(L, 2, typeof(UnityEngine.Collider));
                    
                    gen_to_be_invoked.OnDiscreteCollisionDetected( _hitCollider );
                    
                    
                    
                    return 0;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
        }
        
        
        
        
        
        
		
		
		
		
    }
}
