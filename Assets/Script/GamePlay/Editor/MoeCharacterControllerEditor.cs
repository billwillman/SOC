using System.Collections;
using System.Collections.Generic;
using System.Text;
using UnityEngine;
using UnityEditor;

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
            GetBonePath(bone, ref builder);
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
                            if (otherRootTrans != null) {
                                Animator otherAnim = otherRootTrans.GetComponent<Animator>();
                                if (otherAnim != null) {
                                    GameObject.DestroyImmediate(otherAnim);
                                }
                            }
                        }
                    }
                }
            }
        }

        void ProcessBodySkinnedMesh(SkinnedMeshRenderer body) {
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
                    ProcessBodySkinnedMesh(controller.m_Body);
                    this.SetDirty();
                    this.SaveChanges();
                }
            }
        }
    }
}
