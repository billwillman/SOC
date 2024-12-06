using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SDOC
{
    public unsafe interface ISDOCMeshOccludersProxy
    {
        // 注册可见
        public void RegisterVisible(SDOCMeshOccluder occluder);
        // 注册不可见
        public void UnRegisterVisible(SDOCMeshOccluder occluder);

        public SDOCMeshOccluder this[int index] {
            get;
        }

        public int Count {
            get;
        }
    }
}
