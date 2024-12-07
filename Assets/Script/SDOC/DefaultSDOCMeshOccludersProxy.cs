using System.Collections.Generic;
using UnityEngine;

namespace SDOC
{
    public class DefaultSDOCMeshProxy : ISDOCMeshOccludersProxy
    {
        private List<SDOCMeshOccluder> m_MeshOccluders = new List<SDOCMeshOccluder>();
        public SDOCMeshOccluder this[int index] {
            get {
                if (index < 0 || index >= m_MeshOccluders.Count)
                    return null;
                return m_MeshOccluders[index];
            }
        }

        public int Count {
            get {
                return m_MeshOccluders.Count;
            }
        }

        public void RegisterVisible(SDOCMeshOccluder occluder) {
            m_MeshOccluders.Add(occluder);
        }

        public void UnRegisterVisible(SDOCMeshOccluder occluder) {
            m_MeshOccluders.Remove(occluder);
        }
    }
}
