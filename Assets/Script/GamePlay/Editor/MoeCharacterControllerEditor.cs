using System.Collections;
using System.Collections.Generic;
using System.Text;
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

        private static void ProcessSkinnedMesh(SkinnedMeshRenderer body, SkinnedMeshRenderer other) {
            if (body == null || other == null)
                return;
            var otherBone = other.rootBone;
            if (otherBone == null)
                return;
            StringBuilder builder = null;
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
            // other.sharedMesh.bindposes
            if (otherRootTrans != null) {
                Animator otherAnim = otherRootTrans.GetComponent<Animator>();
                if (otherAnim != null) {
                    otherAnim.enabled = false;
                    GameObject.DestroyImmediate(otherAnim);
                }
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
