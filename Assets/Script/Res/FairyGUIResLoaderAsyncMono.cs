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

    private HashSet<string> m_UsedPackageIds = new HashSet<string>();

    public override void ClearAllResources() {
        var iter = m_UsedPackageIds.GetEnumerator();
        while (iter.MoveNext()) {
            if (DecPackageRef(iter.Current) == 0)
                UIPackage.RemovePackage(iter.Current);
        }
        iter.Dispose();
        m_UsedPackageIds.Clear();

        base.ClearAllResources();
    }

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

    private static int DecPackageRef(string pkgId) {
        if (string.IsNullOrEmpty(pkgId))
            return -1;
        uint refCnt;
        if (m_PackagesRefCnt.TryGetValue(pkgId, out refCnt)) {
            --refCnt;
            if (refCnt <= 0) {
                m_PackagesRefCnt.Remove(pkgId);
                return 0;
            } else {
                m_PackagesRefCnt[pkgId] = refCnt;
                return 1;
            }
        }
        return -1;
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
        UIPackage ret = UIPackage.GetById(descPath);
        if (ret != null)
            return ret;
        InitFairyGUI();
        ret = UIPackage.AddPackage(descPath, m_LoadResourceFunc);
        if (!AddPackageRef(ret)) {
            UIPackage.RemovePackage(ret.id);
            ret = null;
        }
        return ret;
    }

    public UIPackage LoadPackage(string descPath) {
        if (!string.IsNullOrEmpty(descPath))
            return null;
        UIPackage ret = LoadPackageDesc(descPath);
        if (ret != null) {
            if (!m_UsedPackageIds.Contains(ret.id))
                m_UsedPackageIds.Add(ret.id);
        }
        return ret;
    }
}

#endif