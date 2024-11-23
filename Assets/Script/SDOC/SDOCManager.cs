using UnityEngine;

namespace SDOC
{
    public unsafe class SDOCManager : MonoBehaviour
    {
        private void* m_pSDOCInstance = null;

        protected void DestroySDOCInstance()
        {
            if (SDOCHelper.DestroyInstance(m_pSDOCInstance))
                m_pSDOCInstance = null;
        }
    }
}
