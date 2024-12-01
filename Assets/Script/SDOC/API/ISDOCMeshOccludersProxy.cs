using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SDOC
{
    public unsafe interface ISDOCMeshOccludersProxy
    {
        public SDOCMeshOccluder this[int index] {
            get;
        }

        public int Count {
            get;
        }
    }
}
