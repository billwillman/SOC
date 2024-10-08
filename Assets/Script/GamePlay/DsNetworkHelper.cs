using System;
using UnityEngine;
using Unity.Netcode;

namespace SOC.GamePlay
{

    [XLua.LuaCallCSharp]
    public static class DsNetworkHelper
    {
        private static Action<bool> m_OnClientStopped = null;
        private static Action m_OnClientStarted = null;
        
        public static bool NetworkManager_SetOnClientStopped(Action<bool> onClientStopped) {
            if (NetworkManager.Singleton != null) {
                if (m_OnClientStopped != null)
                    NetworkManager.Singleton.OnClientStopped -= m_OnClientStopped;
                if (onClientStopped != null)
                    NetworkManager.Singleton.OnClientStopped += onClientStopped;
                m_OnClientStopped = onClientStopped;
                return true;
            }
            return false;
        }

        public static bool NetworkManager_SetOnClientStarted(Action onClientStarted) {
            if (NetworkManager.Singleton != null) {
                if (m_OnClientStarted != null)
                    NetworkManager.Singleton.OnClientStarted -= m_OnClientStarted;
                if (onClientStarted != null)
                    NetworkManager.Singleton.OnClientStarted += onClientStarted;
                m_OnClientStarted = onClientStarted;
                return true;
            }
            return false;
        }

        public static void NetworkManager_ClearOnClientStopped() {
            if (m_OnClientStopped  != null && NetworkManager.Singleton != null) {
                NetworkManager.Singleton.OnClientStopped -= m_OnClientStopped;
            }
            m_OnClientStopped = null;
        }

        public static void NetworkManager_ClearOnClientStarted() {
            if (m_OnClientStarted != null && NetworkManager.Singleton != null) {
                NetworkManager.Singleton.OnClientStarted -= m_OnClientStarted;
            }
            m_OnClientStarted = null;
        }

        public static void NetworkManager_ClearAllEvents() {
            NetworkManager_ClearOnClientStopped();
            NetworkManager_ClearOnClientStarted();
        }
    }
}
