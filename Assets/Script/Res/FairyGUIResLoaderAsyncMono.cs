#define _USE_FAIRY_GUI

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UnityEngine;
#if _USE_FAIRY_GUI
using FairyGUI;
#endif

#if _USE_FAIRY_GUI

[XLua.LuaCallCSharp]
public class FairyGUIResLoaderAsyncMono: BaseResLoaderAsyncMono {
    private static bool m_IsInitFairyGUI = false;
    private static UIPackage.LoadResource m_LoadResourceFunc = null;
    private static System.Type m_TextAssetType = null;

    private static void InitFairyGUI() {
        if (m_IsInitFairyGUI)
            return;
        m_IsInitFairyGUI = true;
        m_LoadResourceFunc = new UIPackage.LoadResource(OnLoadResource);
        m_TextAssetType = typeof(TextAsset);
    }

    private static UnityEngine.Object OnLoadResource(string name, string extension, System.Type type, out DestroyMethod destroyMethod) {
        destroyMethod = DestroyMethod.Custom;
        if (type == m_TextAssetType)
            return ResourceMgr.Instance.LoadTextAsset(name + extension);
        return null;
    }

    public static UIPackage LoadPackageDesc(string descPath) {
        if (string.IsNullOrEmpty(descPath))
            return null;
        InitFairyGUI();
        return UIPackage.AddPackage(descPath, m_LoadResourceFunc);
    }
}

#endif