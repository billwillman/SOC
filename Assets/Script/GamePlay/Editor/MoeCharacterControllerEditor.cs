using System.Collections;
using System.Collections.Generic;
using System.Text;
using System.IO;
using UnityEngine;
using UnityEditor;
using Unity.Netcode;

namespace SOC.GamePlay
{
    [CustomEditor(typeof(MoeCharacterController))]
    public class MoeCharacterControllerEditor : Editor
    {

        private static void GetBonePath(Transform bone, ref StringBuilder builder, Transform root = null) {
            if (bone == null)
                return;
            if (root != null && bone == root)
                return;
            if (builder == null)
                builder = new StringBuilder();
            if (builder.Length <= 0)
                builder.Append(bone.name);
            else {
                builder.Insert(0, bone.name + "/");
            }
            bone = bone.parent;
            GetBonePath(bone, ref builder, root);
        }

        void BuildNewBodyMesh(SkinnedMeshRenderer body, List<Transform> boneList, List<Matrix4x4> bindPoseList) {
            if (body == null || boneList == null || bindPoseList == null)
                return;
            Mesh OrignMesh = body.sharedMesh;
            if (OrignMesh != null) {
                string meshFilePath = AssetDatabase.GetAssetPath(OrignMesh);
                if (!string.IsNullOrEmpty(meshFilePath)) {
                    string ext = Path.GetExtension(meshFilePath);
                    if (string.Compare(ext, ".fbx", true) == 0) {
                        Mesh targetMesh = Instantiate<Mesh>(OrignMesh);
                        meshFilePath = Path.GetDirectoryName(meshFilePath) + "/" + OrignMesh.name + ".asset";
                        meshFilePath = meshFilePath.Replace("\\", "/");
                        AssetDatabase.DeleteAsset(meshFilePath);
                        AssetDatabase.CreateAsset(targetMesh, meshFilePath);
                        SetAssetMeshReadable(meshFilePath, true);
                        // �洢�����
                        OrignMesh = AssetDatabase.LoadAssetAtPath<Mesh>(meshFilePath);
                        body.bones = boneList.ToArray();
                        OrignMesh.bindposes = bindPoseList.ToArray();
                        AssetDatabase.SaveAssets();
                        SetAssetMeshReadable(OrignMesh, false);
                        this.SetDirty();
                        this.SaveChanges();
                        AssetDatabase.Refresh();
                        // ���õ�body��skinned��
                        body.sharedMesh = AssetDatabase.LoadAssetAtPath<Mesh>(meshFilePath);
                        this.SetDirty();
                        this.SaveChanges();
                        AssetDatabase.Refresh();
                    }
                }
            }
        }

        private void ProcessSkinnedMesh(SkinnedMeshRenderer body, SkinnedMeshRenderer other) {
            if (body == null || other == null)
                return;
            var otherBone = other.rootBone;
            if (otherBone == null)
                return;
            // 1.����rootBone
            StringBuilder builder = new StringBuilder();
            Transform otherRootTrans = other.transform.parent;
            GetBonePath(otherBone, ref builder, otherRootTrans);
            if (builder != null) {
                string path = builder.ToString();
                if (!string.IsNullOrEmpty(path)) {
                    Transform bodyRootTrans = body.transform.parent;
                    if (bodyRootTrans != null) {
                        Transform newRootBone = bodyRootTrans.Find(path);
                        if (newRootBone != null) {
                            other.rootBone = newRootBone;
                        }
                    }
                }
            }
            // �ϲ�������������Ҫ����һ��Mesh��VertexIndex, ���Ҫ�Լ�����һ��Mesh���ʲ�
            // ����������������Ȼ����bindPoses
            //other.bones = body.bones;
            // 2.����bones
            if (other.bones != null && body.bones != null && other.bones.Length > 0 && other.bones.Length != body.bones.Length) {
                Dictionary<int, int> oldBoneToNewBoneMap = new Dictionary<int, int>();
                var bodyBones = body.bones;
                for (int i = 0; i < other.bones.Length; ++i) {
                    var bone = other.bones[i];
                    builder.Clear();
                    GetBonePath(bone, ref builder, otherRootTrans);
                    string path = builder.ToString();
                    if (!string.IsNullOrEmpty(path)) {
                        Transform bodyRootTrans = body.transform.parent;
                        if (bodyRootTrans != null) {
                            Transform newBone = bodyRootTrans.Find(path);
                            if (newBone != null) {
                                int index = -1;
                                for (int j = 0; j < bodyBones.Length; ++j) {
                                    if (bodyBones[j] == newBone) {
                                        index = j;
                                        break;
                                    }
                                }
                                if (index >= 0)
                                    oldBoneToNewBoneMap[i] = index;
                                else {
                                    Debug.LogError("[OtherBone] not found:" + path + "\n=== " + other.name);
                                }
                            }
                        }
                    }
                }
                if (oldBoneToNewBoneMap.Count > 0) {
                    // Clone Mesh
                    Mesh OrignMesh = other.sharedMesh;
                    if (OrignMesh != null) {
                        string meshFilePath = AssetDatabase.GetAssetPath(OrignMesh);
                        if (!string.IsNullOrEmpty(meshFilePath)) {
                            string ext = Path.GetExtension(meshFilePath);
                            if (string.Compare(ext, ".fbx", true) == 0) {
                                Mesh targetMesh = Instantiate<Mesh>(OrignMesh);
                                meshFilePath = Path.GetDirectoryName(meshFilePath) + "/" + OrignMesh.name + ".asset";
                                meshFilePath = meshFilePath.Replace("\\", "/");
                                AssetDatabase.DeleteAsset(meshFilePath);
                                AssetDatabase.CreateAsset(targetMesh, meshFilePath);
                                SetAssetMeshReadable(meshFilePath, true);
                                // �洢�����
                                OrignMesh = AssetDatabase.LoadAssetAtPath<Mesh>(meshFilePath);
                                BoneWeight[] otherBoneWeights = OrignMesh.boneWeights;
                                if (otherBoneWeights != null) {
                                    bool isDirty = false;
                                    for (int i = 0; i < otherBoneWeights.Length; ++i) {
                                        BoneWeight boneWeight = otherBoneWeights[i];
                                        if (TransOldBoneIndexToNewBoneIndex(oldBoneToNewBoneMap, ref boneWeight)) {
                                            otherBoneWeights[i] = boneWeight;
                                            isDirty = true;
                                        }
                                    }
                                    if (isDirty) {
                                        OrignMesh.boneWeights = otherBoneWeights;
                                    }
                                }
                                // дbindPose
                                var otherBindPoses = OrignMesh.bindposes;
                                var bodyBindPoses = body.sharedMesh.bindposes;
                                if (otherBindPoses != null) {
                                    for (int i = 0; i < OrignMesh.bindposes.Length; ++i) {
                                        int newIdx;
                                        if (oldBoneToNewBoneMap.TryGetValue(i, out newIdx)) {
                                            Debug.Log("[Origin] " + otherBindPoses[i].ToString() + "\n[New] " + bodyBindPoses[newIdx].ToString());
                                        } else {
                                            Debug.LogError("not found bindPose: " + i.ToString() + "\n=== " + other.name);
                                        }
                                    }
                                    OrignMesh.bindposes = bodyBindPoses;
                                    other.bones = body.bones;
                                }
                                AssetDatabase.SaveAssets();
                                SetAssetMeshReadable(OrignMesh, false);
                            }
                        }
                    }
                }
                //--
            }
            // other.sharedMesh.bindposes
            if (otherRootTrans != null) {
                Animator otherAnim = otherRootTrans.GetComponent<Animator>();
                if (otherAnim != null) {
                    otherAnim.enabled = false;
                    GameObject.DestroyImmediate(otherAnim);
                }
                Animancer.AnimancerComponent a1 = otherRootTrans.GetComponent<Animancer.AnimancerComponent>();
                if (a1 != null) {
                    GameObject.DestroyImmediate(a1);
                }
                Animancer.NamedAnimancerComponent a2 = otherRootTrans.GetComponent<Animancer.NamedAnimancerComponent>();
                if (a2 != null) {
                    GameObject.DestroyImmediate(a2);
                }
            }
        }

        static bool TransOldBoneIndexToNewBoneIndex(Dictionary<int, int> map, ref BoneWeight weight) {
            if (map == null)
                return false;
            bool ret = false;
            if (weight.weight0 > 0) {
                int idx;
                if (map.TryGetValue(weight.boneIndex0, out idx)) {
                    weight.boneIndex0 = idx;
                    ret = true;
                }
            }
            if (weight.weight1 > 0) {
                int idx;
                if (map.TryGetValue(weight.boneIndex1, out idx)) {
                    weight.boneIndex1 = idx;
                    ret = true;
                }
            }
            if (weight.weight2 > 0) {
                int idx;
                if (map.TryGetValue(weight.boneIndex2, out idx)) {
                    weight.boneIndex2 = idx;
                    ret = true;
                }
            }
            if (weight.weight3 > 0) {
                int idx;
                if (map.TryGetValue(weight.boneIndex3, out idx)) {
                    weight.boneIndex3 = idx;
                    ret = true;
                }
            }
            return ret;
        }

        static void SetAssetMeshReadable(UnityEngine.Object assetObj, bool isReadWrite) {
            if (assetObj == null)
                return;
            string path = AssetDatabase.GetAssetPath(assetObj);
            SetAssetMeshReadable(path, isReadWrite);
        }

        static void SetAssetMeshReadable(string meshFilePath, bool isReadWrite) {
            if (string.IsNullOrEmpty(meshFilePath))
                return;
            if (File.Exists(meshFilePath)) {
                FileStream metaStream = new FileStream(meshFilePath, FileMode.Open, FileAccess.ReadWrite);
                try {
                    byte[] buffer = new byte[metaStream.Length];
                    metaStream.Read(buffer, 0, buffer.Length);
                    string metaStr = System.Text.Encoding.UTF8.GetString(buffer);
                    const string readAblaStr = "m_IsReadable: ";
                    int startIndex = metaStr.IndexOf(readAblaStr);
                    if (startIndex < 0)
                        return;
                    int endIndex = metaStr.IndexOf("\n", startIndex);
                    if (endIndex < 0)
                        endIndex = metaStr.Length - 1;
                    string leftStr = metaStr.Substring(0, startIndex);
                    string rightStr = metaStr.Substring(endIndex);
                    metaStr = leftStr + readAblaStr + (isReadWrite ? "1" : "0") + rightStr;
                    metaStream.Seek(0, SeekOrigin.Begin);

                    buffer = System.Text.Encoding.UTF8.GetBytes(metaStr);
                    metaStream.Write(buffer, 0, buffer.Length);
                } finally {
                    metaStream.Close();
                    metaStream.Dispose();
                }
                AssetDatabase.Refresh(); // ˢ��
            }
        }


        static void ProcessBodySkinnedMesh(MoeCharacterController controller, SkinnedMeshRenderer body) {
            if (body == null)
                return;
            Transform parent = body.transform.parent;
            if (parent == null)
                return;
            Animator animator = parent.GetComponent<Animator>();
            if (animator == null)
                return;
            animator.enabled = true;
            Animancer.AnimancerComponent animancerComp = parent.GetComponent<Animancer.AnimancerComponent>();
            if (animancerComp == null) {
                animancerComp = parent.gameObject.AddComponent<Animancer.AnimancerComponent>();
            }
            animancerComp.enabled = true;
            if (controller.m_Animancer == null)
                controller.m_Animancer = new Animancer.AnimancerComponent[1];
            controller.m_Animancer[0] = animancerComp;
        }

        static void ProcessControllerRoot(MoeCharacterController controller) {
            if (controller == null)
                return;
            NetworkObject netObject = controller.GetComponent<NetworkObject>();
            if (netObject != null) {
                netObject.enabled = true;
                netObject.AlwaysReplicateAsRoot = true;
                netObject.SynchronizeTransform = true;
            }
        }

        static void _AddBodyToListFunc(SkinnedMeshRenderer body, ref List<Transform> bodyBoneList,
                ref List<Matrix4x4> bodyBoneBindPoseList,
                Transform[] otherBones, Matrix4x4[] otherBindPoses, Transform cloneChildRoot, Transform childRoot) {
            int oldIdx = -1;
            for (int i = 0; i < otherBones.Length; ++i) {
                if (otherBones[i] == childRoot) {
                    oldIdx = i;
                    break;
                }
            }
            if (oldIdx >= 0) {
                if (bodyBoneList == null)
                    bodyBoneList = new List<Transform>(body.bones);
                bodyBoneList.Add(cloneChildRoot);
                if (bodyBoneBindPoseList == null)
                    bodyBoneBindPoseList = new List<Matrix4x4>(body.sharedMesh.bindposes);
                bodyBoneBindPoseList.Add(otherBindPoses[oldIdx]);
            }
            for (int i = 0; i < childRoot.childCount; ++i) {
                _AddBodyToListFunc(body, ref bodyBoneList, ref bodyBoneBindPoseList, otherBones, otherBindPoses, cloneChildRoot.GetChild(i), childRoot.GetChild(i));
            }
        }

        static void CheckAddChildNode(Transform targetRoot, Transform sourceRoot) {
            if (targetRoot != null && sourceRoot != null) {
                for (int i = 0; i < sourceRoot.childCount; ++i) {
                    var sourceChild = sourceRoot.GetChild(i);
                    string name = sourceChild.name;
                    var targetChild = targetRoot.Find(name);
                    if (targetChild != null) {
                        CheckAddChildNode(targetChild, sourceChild);
                    } else {
                        var newGameObj = GameObject.Instantiate<GameObject>(sourceChild.gameObject, targetRoot, false);
                        newGameObj.name = sourceChild.gameObject.name;
                        //CheckAddChildNode(newGameObj.transform, sourceChild);
                    }
                }
            }
        }

        // ������������⣬bindposes��bones�������������ڵ������ǲ�һ���ģ���Ҫȫ�ϲ����ٸ���bindposes��bones����
        static void ProcessOhterBonesAddToBodySkinnedMesh(SkinnedMeshRenderer body, SkinnedMeshRenderer other, ref List<Transform> bodyBoneList,
                ref List<Matrix4x4> bodyBoneBindPoseList) {
            if (body == null || other == null || body.sharedMesh == null || other.sharedMesh == null)
                return;
            Transform bodyRootTrans = body.transform.parent;
            Transform otherRootTrans = other.transform.parent;
            Transform[] otherBones = other.bones;
            Matrix4x4[] otherBindPoses = other.sharedMesh.bindposes;
            if (otherBones != null) {
                List<string> newBoneIndexs = new List<string>();
                StringBuilder builder = new StringBuilder();
                // 1.����û�е�bone,�ŵ��б���
                string boneRootName = null;
                for (int i = 0; i < otherBones.Length; ++i) {
                    builder.Clear();
                    Transform bone = otherBones[i];
                    GetBonePath(bone, ref builder, otherRootTrans);
                    string path = builder.ToString();
                    if (bodyRootTrans.Find(path) != null)
                        continue;
                    if (string.IsNullOrEmpty(boneRootName))
                        boneRootName = path.Split("/")[0];
                    newBoneIndexs.Add(path);
                }
                if (!string.IsNullOrEmpty(boneRootName) && newBoneIndexs.Count > 0) {
                    Transform bodyBoneRoot = bodyRootTrans.Find(boneRootName);
                    Transform otherBoneRoot = otherRootTrans.Find(boneRootName);
                    CheckAddChildNode(bodyBoneRoot, otherBoneRoot);
                    for (int i = 0; i < newBoneIndexs.Count; ++i) {
                        string path = newBoneIndexs[i];
                        Transform cloneChildRoot = bodyRootTrans.Find(path);
                        Transform childRoot = otherRootTrans.Find(path);
                        _AddBodyToListFunc(body, ref bodyBoneList, ref bodyBoneBindPoseList, otherBones, otherBindPoses, cloneChildRoot, childRoot);
                    }
                }
            }
        }

        public override void OnInspectorGUI() {
            base.OnInspectorGUI();
            if (GUILayout.Button("��ɫ��׼��")) {
                MoeCharacterController controller = this.target as MoeCharacterController;
                if (controller != null) {
                    // �������ӵ�Body��
                    List<Transform> boneList = null;
                    List<Matrix4x4> bindPoseList = null;
                    ProcessOhterBonesAddToBodySkinnedMesh(controller.m_Body, controller.m_Head, ref boneList, ref bindPoseList);
                    ProcessOhterBonesAddToBodySkinnedMesh(controller.m_Body, controller.m_Hair, ref boneList, ref bindPoseList);
                    ProcessOhterBonesAddToBodySkinnedMesh(controller.m_Body, controller.m_Weapon, ref boneList, ref bindPoseList);
                    if (controller.m_OtherSkinedMeshList != null) {
                        for (int i = 0; i < controller.m_OtherSkinedMeshList.Count; ++i) {
                            ProcessOhterBonesAddToBodySkinnedMesh(controller.m_Body, controller.m_OtherSkinedMeshList[i], ref boneList, ref bindPoseList);
                        }
                    }
                    // �����µ�body����
                    BuildNewBodyMesh(controller.m_Body, boneList, bindPoseList);
                    // �洢���ݵ�prefab
                    PrefabUtility.SavePrefabAsset(controller.gameObject);
                    AssetDatabase.Refresh();
                    //--
                    ProcessSkinnedMesh(controller.m_Body, controller.m_Head);
                    ProcessSkinnedMesh(controller.m_Body, controller.m_Hair);
                    ProcessSkinnedMesh(controller.m_Body, controller.m_Weapon);
                    if (controller.m_OtherSkinedMeshList != null) {
                        for (int i = 0; i < controller.m_OtherSkinedMeshList.Count; ++i) {
                            ProcessSkinnedMesh(controller.m_Body, controller.m_OtherSkinedMeshList[i]);
                        }
                    }
                    ProcessBodySkinnedMesh(controller, controller.m_Body);
                    ProcessControllerRoot(controller);
                    this.SetDirty();
                    this.SaveChanges();
                }
            }
        }
    }
}
