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

        private void ProcessSkinnedMesh(SkinnedMeshRenderer body, SkinnedMeshRenderer other) {
            if (body == null || other == null)
                return;
            var otherBone = other.rootBone;
            if (otherBone == null)
                return;
            // 1.处理rootBone
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
            // 合并骨骼，并且需要生成一个Mesh的VertexIndex, 最后要自己生成一个Mesh的资产
            // 处理最大骨骼数量，然后处理bindPoses
            //other.bones = body.bones;
            // 2.处理bones
            if (other.bones != null && body.bones != null && other.bones.Length > 0 && other.bones.Length != body.bones.Length) {
                Dictionary<int, int> oldBoneToNewBoneMap = new Dictionary<int, int>();
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
                                int index = System.Array.FindIndex<Transform>(body.bones, (Transform inBone)=>{
                                    bool ret = inBone == newBone;
                                    return true;
                                });
                                oldBoneToNewBoneMap[i] = index;
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
                                meshFilePath = Path.ChangeExtension(meshFilePath, ".asset");
                                AssetDatabase.DeleteAsset(meshFilePath);
                                AssetDatabase.CreateAsset(targetMesh, meshFilePath);
                                SetAssetMeshReadable(meshFilePath);

                                BoneWeight[] otherBoneWeights = OrignMesh.boneWeights;

                                var iter = oldBoneToNewBoneMap.GetEnumerator();
                                while (iter.MoveNext()) {

                                }
                                iter.Dispose();
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
            }
        }

        static void SetAssetMeshReadable(string meshFilePath) {
            if (!string.IsNullOrEmpty(meshFilePath))
                return;
            if (File.Exists(meshFilePath)) {
                FileStream metaStream = new FileStream(meshFilePath, FileMode.Open, FileAccess.ReadWrite);
                try {
                    byte[] buffer = new byte[meshFilePath.Length];
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
                    metaStr = leftStr + readAblaStr + "1" + rightStr;
                    metaStream.Seek(0, SeekOrigin.Begin);

                    buffer = System.Text.Encoding.UTF8.GetBytes(metaStr);
                    metaStream.Write(buffer, 0, buffer.Length);
                } finally {
                    metaStream.Close();
                    metaStream.Dispose();
                }
                AssetDatabase.Refresh(); // 刷新
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
            controller.m_Animancer = animancerComp;
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

        public override void OnInspectorGUI() {
            base.OnInspectorGUI();
            if (GUILayout.Button("角色标准化")) {
                MoeCharacterController controller = this.target as MoeCharacterController;
                if (controller != null) {
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
