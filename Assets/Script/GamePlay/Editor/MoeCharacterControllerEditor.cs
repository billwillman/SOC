using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEditor;

namespace SOC.GamePlay
{
    [CustomEditor(typeof(MoeCharacterController))]
    public class MoeCharacterControllerEditor : Editor
    {
        public override void OnInspectorGUI() {
            base.OnInspectorGUI();
            if (GUILayout.Button("½ÇÉ«¹Ç÷ÀºÏ²¢")) {

            }
        }
    }
}
