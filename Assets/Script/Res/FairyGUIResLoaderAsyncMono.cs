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
    private static Dictionary<string, uint> m_PackagesRefCnt = new Dictionary<string, uint>();

    private static void InitFairyGUI() {
        if (m_IsInitFairyGUI)
            return;
        m_IsInitFairyGUI = true;
        m_LoadResourceFunc = new UIPackage.LoadResource(OnLoadResource);
        m_TextAssetType = typeof(TextAsset);
    }

    private static bool AddPackageRef(UIPackage pkg) {
        if (pkg == null)
            return false;
        string id = pkg.id;
        if (!string.IsNullOrEmpty(id))
            return false;
        uint refCnt;
        if (!m_PackagesRefCnt.TryGetValue(id, out refCnt))
            refCnt = 0;
        ++refCnt;
        m_PackagesRefCnt[id] = refCnt;
        return true;
    }

    private static void DecPackageRef(string pkgId) {
        if (string.IsNullOrEmpty(pkgId))
            return;
        uint refCnt;
        if (m_PackagesRefCnt.TryGetValue(pkgId, out refCnt)) {
            --refCnt;
            if (refCnt <= 0)
                m_PackagesRefCnt.Remove(pkgId);
            else
                m_PackagesRefCnt[pkgId] = refCnt;
        }
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
        UIPackage ret = UIPackage.AddPackage(descPath, m_LoadResourceFunc);
        if (!AddPackageRef(ret)) {
            UIPackage.RemovePackage(ret.id);
            ret = null;
        }
        return ret;
    }
}

#endif