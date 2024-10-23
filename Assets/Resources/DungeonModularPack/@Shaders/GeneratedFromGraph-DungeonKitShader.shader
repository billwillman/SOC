Shader "LB Shader/DungeonKitShader_1"
{
    Properties
    {
        [NoScaleOffset]_Color_Texture("Color Texture", 2D) = "white" {}
        [NoScaleOffset]_Normal_Texture("Normal Texture", 2D) = "white" {}
        [NoScaleOffset]_ORM_Texture("ORM Texture", 2D) = "white" {}
        [ToggleUI]_Emission("Emission", Float) = 0
        [NoScaleOffset]_Emissive_Texture("Emissive Texture", 2D) = "white" {}
        _Param_AO("Param : AO", Range(0, 1)) = 0
        _Param_Roughness("Param : Roughness", Range(0, 1)) = 0
        _Param_Metalic("Param : Metalic", Range(0, 1)) = 0
        [HideInInspector]_WorkflowMode("_WorkflowMode", Float) = 1
        [HideInInspector]_CastShadows("_CastShadows", Float) = 1
        [HideInInspector]_ReceiveShadows("_ReceiveShadows", Float) = 1
        [HideInInspector]_Surface("_Surface", Float) = 0
        [HideInInspector]_Blend("_Blend", Float) = 0
        [HideInInspector]_AlphaClip("_AlphaClip", Float) = 0
        [HideInInspector]_BlendModePreserveSpecular("_BlendModePreserveSpecular", Float) = 1
        [HideInInspector]_SrcBlend("_SrcBlend", Float) = 1
        [HideInInspector]_DstBlend("_DstBlend", Float) = 0
        [HideInInspector][ToggleUI]_ZWrite("_ZWrite", Float) = 1
        [HideInInspector]_ZWriteControl("_ZWriteControl", Float) = 0
        [HideInInspector]_ZTest("_ZTest", Float) = 4
        [HideInInspector]_Cull("_Cull", Float) = 2
        [HideInInspector]_AlphaToMask("_AlphaToMask", Float) = 0
        [HideInInspector]_QueueOffset("_QueueOffset", Float) = 0
        [HideInInspector]_QueueControl("_QueueControl", Float) = -1
        [HideInInspector][NoScaleOffset]unity_Lightmaps("unity_Lightmaps", 2DArray) = "" {}
        [HideInInspector][NoScaleOffset]unity_LightmapsInd("unity_LightmapsInd", 2DArray) = "" {}
        [HideInInspector][NoScaleOffset]unity_ShadowMasks("unity_ShadowMasks", 2DArray) = "" {}
        [HideInInspector]_BUILTIN_Surface("Float", Float) = 0
        [HideInInspector]_BUILTIN_Blend("Float", Float) = 0
        [HideInInspector]_BUILTIN_AlphaClip("Float", Float) = 0
        [HideInInspector]_BUILTIN_SrcBlend("Float", Float) = 1
        [HideInInspector]_BUILTIN_DstBlend("Float", Float) = 0
        [HideInInspector]_BUILTIN_ZWrite("Float", Float) = 1
        [HideInInspector]_BUILTIN_ZWriteControl("Float", Float) = 0
        [HideInInspector]_BUILTIN_ZTest("Float", Float) = 4
        [HideInInspector]_BUILTIN_CullMode("Float", Float) = 2
        [HideInInspector]_BUILTIN_QueueOffset("Float", Float) = 0
        [HideInInspector]_BUILTIN_QueueControl("Float", Float) = -1
    }
    SubShader
    {
        Tags
        {
            "RenderPipeline"="UniversalPipeline"
            "RenderType"="Opaque"
            "UniversalMaterialType" = "Lit"
            "Queue"="Geometry"
            "DisableBatching"="False"
            "ShaderGraphShader"="true"
            "ShaderGraphTargetId"="UniversalLitSubTarget"
        }
        Pass
        {
            Name "Universal Forward"
            Tags
            {
                "LightMode" = "UniversalForward"
            }
        
        // Render State
        Cull [_Cull]
        Blend [_SrcBlend] [_DstBlend]
        ZTest [_ZTest]
        ZWrite [_ZWrite]
        AlphaToMask [_AlphaToMask]
        
        // Debug
        // <None>
        
        // --------------------------------------------------
        // Pass
        
        HLSLPROGRAM
        
        // Pragmas
        #pragma target 2.0
        #pragma multi_compile_instancing
        #pragma multi_compile_fog
        #pragma instancing_options renderinglayer
        #pragma vertex vert
        #pragma fragment frag
        
        // Keywords
        #pragma multi_compile_fragment _ _SCREEN_SPACE_OCCLUSION
        #pragma multi_compile _ LIGHTMAP_ON
        #pragma multi_compile _ DYNAMICLIGHTMAP_ON
        #pragma multi_compile _ DIRLIGHTMAP_COMBINED
        #pragma multi_compile _ USE_LEGACY_LIGHTMAPS
        #pragma multi_compile _ _MAIN_LIGHT_SHADOWS _MAIN_LIGHT_SHADOWS_CASCADE _MAIN_LIGHT_SHADOWS_SCREEN
        #pragma multi_compile _ _ADDITIONAL_LIGHTS_VERTEX _ADDITIONAL_LIGHTS
        #pragma multi_compile_fragment _ _ADDITIONAL_LIGHT_SHADOWS
        #pragma multi_compile_fragment _ _REFLECTION_PROBE_BLENDING
        #pragma multi_compile_fragment _ _REFLECTION_PROBE_BOX_PROJECTION
        #pragma multi_compile_fragment _ _SHADOWS_SOFT _SHADOWS_SOFT_LOW _SHADOWS_SOFT_MEDIUM _SHADOWS_SOFT_HIGH
        #pragma multi_compile _ LIGHTMAP_SHADOW_MIXING
        #pragma multi_compile _ SHADOWS_SHADOWMASK
        #pragma multi_compile_fragment _ _DBUFFER_MRT1 _DBUFFER_MRT2 _DBUFFER_MRT3
        #pragma multi_compile_fragment _ _LIGHT_LAYERS
        #pragma multi_compile_fragment _ DEBUG_DISPLAY
        #pragma multi_compile_fragment _ _LIGHT_COOKIES
        #pragma multi_compile _ _FORWARD_PLUS
        #pragma multi_compile _ EVALUATE_SH_MIXED EVALUATE_SH_VERTEX
        #pragma shader_feature_fragment _ _SURFACE_TYPE_TRANSPARENT
        #pragma shader_feature_local_fragment _ _ALPHAPREMULTIPLY_ON
        #pragma shader_feature_local_fragment _ _ALPHAMODULATE_ON
        #pragma shader_feature_local_fragment _ _ALPHATEST_ON
        #pragma shader_feature_local_fragment _ _SPECULAR_SETUP
        #pragma shader_feature_local _ _RECEIVE_SHADOWS_OFF
        // GraphKeywords: <None>
        
        // Defines
        
        #define _NORMALMAP 1
        #define _NORMAL_DROPOFF_TS 1
        #define ATTRIBUTES_NEED_NORMAL
        #define ATTRIBUTES_NEED_TANGENT
        #define ATTRIBUTES_NEED_TEXCOORD0
        #define ATTRIBUTES_NEED_TEXCOORD1
        #define ATTRIBUTES_NEED_TEXCOORD2
        #define FEATURES_GRAPH_VERTEX_NORMAL_OUTPUT
        #define FEATURES_GRAPH_VERTEX_TANGENT_OUTPUT
        #define VARYINGS_NEED_POSITION_WS
        #define VARYINGS_NEED_NORMAL_WS
        #define VARYINGS_NEED_TANGENT_WS
        #define VARYINGS_NEED_TEXCOORD0
        #define VARYINGS_NEED_FOG_AND_VERTEX_LIGHT
        #define VARYINGS_NEED_SHADOW_COORD
        #define FEATURES_GRAPH_VERTEX
        /* WARNING: $splice Could not find named fragment 'PassInstancing' */
        #define SHADERPASS SHADERPASS_FORWARD
        #define _FOG_FRAGMENT 1
        
        
        // custom interpolator pre-include
        /* WARNING: $splice Could not find named fragment 'sgci_CustomInterpolatorPreInclude' */
        
        // Includes
        #include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DOTS.hlsl"
        #include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/RenderingLayers.hlsl"
        #include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ProbeVolumeVariants.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Input.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
        #include_with_pragmas "Packages/com.unity.render-pipelines.core/ShaderLibrary/FoveatedRenderingKeywords.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/FoveatedRendering.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/DebugMipmapStreamingMacros.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Shadows.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DBuffer.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
        
        // --------------------------------------------------
        // Structs and Packing
        
        // custom interpolators pre packing
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPrePacking' */
        
        struct Attributes
        {
             float3 positionOS : POSITION;
             float3 normalOS : NORMAL;
             float4 tangentOS : TANGENT;
             float4 uv0 : TEXCOORD0;
             float4 uv1 : TEXCOORD1;
             float4 uv2 : TEXCOORD2;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(ATTRIBUTES_NEED_INSTANCEID)
             uint instanceID : INSTANCEID_SEMANTIC;
            #endif
        };
        struct Varyings
        {
             float4 positionCS : SV_POSITION;
             float3 positionWS;
             float3 normalWS;
             float4 tangentWS;
             float4 texCoord0;
            #if defined(LIGHTMAP_ON)
             float2 staticLightmapUV;
            #endif
            #if defined(DYNAMICLIGHTMAP_ON)
             float2 dynamicLightmapUV;
            #endif
            #if !defined(LIGHTMAP_ON)
             float3 sh;
            #endif
             float4 fogFactorAndVertexLight;
            #if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
             float4 shadowCoord;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        struct SurfaceDescriptionInputs
        {
             float3 TangentSpaceNormal;
             float4 uv0;
        };
        struct VertexDescriptionInputs
        {
             float3 ObjectSpaceNormal;
             float3 ObjectSpaceTangent;
             float3 ObjectSpacePosition;
        };
        struct PackedVaryings
        {
             float4 positionCS : SV_POSITION;
            #if defined(LIGHTMAP_ON)
             float2 staticLightmapUV : INTERP0;
            #endif
            #if defined(DYNAMICLIGHTMAP_ON)
             float2 dynamicLightmapUV : INTERP1;
            #endif
            #if !defined(LIGHTMAP_ON)
             float3 sh : INTERP2;
            #endif
            #if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
             float4 shadowCoord : INTERP3;
            #endif
             float4 tangentWS : INTERP4;
             float4 texCoord0 : INTERP5;
             float4 fogFactorAndVertexLight : INTERP6;
             float3 positionWS : INTERP7;
             float3 normalWS : INTERP8;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        
        PackedVaryings PackVaryings (Varyings input)
        {
            PackedVaryings output;
            ZERO_INITIALIZE(PackedVaryings, output);
            output.positionCS = input.positionCS;
            #if defined(LIGHTMAP_ON)
            output.staticLightmapUV = input.staticLightmapUV;
            #endif
            #if defined(DYNAMICLIGHTMAP_ON)
            output.dynamicLightmapUV = input.dynamicLightmapUV;
            #endif
            #if !defined(LIGHTMAP_ON)
            output.sh = input.sh;
            #endif
            #if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
            output.shadowCoord = input.shadowCoord;
            #endif
            output.tangentWS.xyzw = input.tangentWS;
            output.texCoord0.xyzw = input.texCoord0;
            output.fogFactorAndVertexLight.xyzw = input.fogFactorAndVertexLight;
            output.positionWS.xyz = input.positionWS;
            output.normalWS.xyz = input.normalWS;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        
        Varyings UnpackVaryings (PackedVaryings input)
        {
            Varyings output;
            output.positionCS = input.positionCS;
            #if defined(LIGHTMAP_ON)
            output.staticLightmapUV = input.staticLightmapUV;
            #endif
            #if defined(DYNAMICLIGHTMAP_ON)
            output.dynamicLightmapUV = input.dynamicLightmapUV;
            #endif
            #if !defined(LIGHTMAP_ON)
            output.sh = input.sh;
            #endif
            #if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
            output.shadowCoord = input.shadowCoord;
            #endif
            output.tangentWS = input.tangentWS.xyzw;
            output.texCoord0 = input.texCoord0.xyzw;
            output.fogFactorAndVertexLight = input.fogFactorAndVertexLight.xyzw;
            output.positionWS = input.positionWS.xyz;
            output.normalWS = input.normalWS.xyz;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        
        
        // --------------------------------------------------
        // Graph
        
        // Graph Properties
        CBUFFER_START(UnityPerMaterial)
        float4 _Color_Texture_TexelSize;
        float4 _Normal_Texture_TexelSize;
        float4 _ORM_Texture_TexelSize;
        float4 _Emissive_Texture_TexelSize;
        float _Emission;
        float _Param_Roughness;
        float _Param_Metalic;
        float _Param_AO;
        UNITY_TEXTURE_STREAMING_DEBUG_VARS;
        CBUFFER_END
        
        
        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        TEXTURE2D(_Color_Texture);
        SAMPLER(sampler_Color_Texture);
        TEXTURE2D(_Normal_Texture);
        SAMPLER(sampler_Normal_Texture);
        TEXTURE2D(_ORM_Texture);
        SAMPLER(sampler_ORM_Texture);
        TEXTURE2D(_Emissive_Texture);
        SAMPLER(sampler_Emissive_Texture);
        
        // Graph Includes
        // GraphIncludes: <None>
        
        // -- Property used by ScenePickingPass
        #ifdef SCENEPICKINGPASS
        float4 _SelectionID;
        #endif
        
        // -- Properties used by SceneSelectionPass
        #ifdef SCENESELECTIONPASS
        int _ObjectId;
        int _PassValue;
        #endif
        
        // Graph Functions
        
        void Unity_Branch_float4(float Predicate, float4 True, float4 False, out float4 Out)
        {
            Out = Predicate ? True : False;
        }
        
        void Unity_Multiply_float_float(float A, float B, out float Out)
        {
            Out = A * B;
        }
        
        void Unity_OneMinus_float(float In, out float Out)
        {
            Out = 1 - In;
        }
        
        // Custom interpolators pre vertex
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPreVertex' */
        
        // Graph Vertex
        struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
        };
        
        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            description.Position = IN.ObjectSpacePosition;
            description.Normal = IN.ObjectSpaceNormal;
            description.Tangent = IN.ObjectSpaceTangent;
            return description;
        }
        
        // Custom interpolators, pre surface
        #ifdef FEATURES_GRAPH_VERTEX
        Varyings CustomInterpolatorPassThroughFunc(inout Varyings output, VertexDescription input)
        {
        return output;
        }
        #define CUSTOMINTERPOLATOR_VARYPASSTHROUGH_FUNC
        #endif
        
        // Graph Pixel
        struct SurfaceDescription
        {
            float3 BaseColor;
            float3 NormalTS;
            float3 Emission;
            float Metallic;
            float3 Specular;
            float Smoothness;
            float Occlusion;
            float Alpha;
            float AlphaClipThreshold;
        };
        
        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            UnityTexture2D _Property_29d95cca61c84013ba8453d2eba10e9a_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_Color_Texture);
            float4 _SampleTexture2D_1d46dbc4d51248578b3c5b19a9c762b6_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_29d95cca61c84013ba8453d2eba10e9a_Out_0_Texture2D.tex, _Property_29d95cca61c84013ba8453d2eba10e9a_Out_0_Texture2D.samplerstate, _Property_29d95cca61c84013ba8453d2eba10e9a_Out_0_Texture2D.GetTransformedUV(IN.uv0.xy) );
            float _SampleTexture2D_1d46dbc4d51248578b3c5b19a9c762b6_R_4_Float = _SampleTexture2D_1d46dbc4d51248578b3c5b19a9c762b6_RGBA_0_Vector4.r;
            float _SampleTexture2D_1d46dbc4d51248578b3c5b19a9c762b6_G_5_Float = _SampleTexture2D_1d46dbc4d51248578b3c5b19a9c762b6_RGBA_0_Vector4.g;
            float _SampleTexture2D_1d46dbc4d51248578b3c5b19a9c762b6_B_6_Float = _SampleTexture2D_1d46dbc4d51248578b3c5b19a9c762b6_RGBA_0_Vector4.b;
            float _SampleTexture2D_1d46dbc4d51248578b3c5b19a9c762b6_A_7_Float = _SampleTexture2D_1d46dbc4d51248578b3c5b19a9c762b6_RGBA_0_Vector4.a;
            UnityTexture2D _Property_43d6b361960241fa85238beaa18eaee7_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_Normal_Texture);
            float4 _SampleTexture2D_850c7807224247dcb806755ff839cbee_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_43d6b361960241fa85238beaa18eaee7_Out_0_Texture2D.tex, _Property_43d6b361960241fa85238beaa18eaee7_Out_0_Texture2D.samplerstate, _Property_43d6b361960241fa85238beaa18eaee7_Out_0_Texture2D.GetTransformedUV(IN.uv0.xy) );
            _SampleTexture2D_850c7807224247dcb806755ff839cbee_RGBA_0_Vector4.rgb = UnpackNormal(_SampleTexture2D_850c7807224247dcb806755ff839cbee_RGBA_0_Vector4);
            float _SampleTexture2D_850c7807224247dcb806755ff839cbee_R_4_Float = _SampleTexture2D_850c7807224247dcb806755ff839cbee_RGBA_0_Vector4.r;
            float _SampleTexture2D_850c7807224247dcb806755ff839cbee_G_5_Float = _SampleTexture2D_850c7807224247dcb806755ff839cbee_RGBA_0_Vector4.g;
            float _SampleTexture2D_850c7807224247dcb806755ff839cbee_B_6_Float = _SampleTexture2D_850c7807224247dcb806755ff839cbee_RGBA_0_Vector4.b;
            float _SampleTexture2D_850c7807224247dcb806755ff839cbee_A_7_Float = _SampleTexture2D_850c7807224247dcb806755ff839cbee_RGBA_0_Vector4.a;
            float _Property_17ea8ffc961b4ffd871836de5084ef86_Out_0_Boolean = _Emission;
            UnityTexture2D _Property_411dbbb2322442ebba4716107ea863fe_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_Emissive_Texture);
            float4 _SampleTexture2D_a57be8c4d236480f8104751aa7f681ab_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_411dbbb2322442ebba4716107ea863fe_Out_0_Texture2D.tex, _Property_411dbbb2322442ebba4716107ea863fe_Out_0_Texture2D.samplerstate, _Property_411dbbb2322442ebba4716107ea863fe_Out_0_Texture2D.GetTransformedUV(IN.uv0.xy) );
            float _SampleTexture2D_a57be8c4d236480f8104751aa7f681ab_R_4_Float = _SampleTexture2D_a57be8c4d236480f8104751aa7f681ab_RGBA_0_Vector4.r;
            float _SampleTexture2D_a57be8c4d236480f8104751aa7f681ab_G_5_Float = _SampleTexture2D_a57be8c4d236480f8104751aa7f681ab_RGBA_0_Vector4.g;
            float _SampleTexture2D_a57be8c4d236480f8104751aa7f681ab_B_6_Float = _SampleTexture2D_a57be8c4d236480f8104751aa7f681ab_RGBA_0_Vector4.b;
            float _SampleTexture2D_a57be8c4d236480f8104751aa7f681ab_A_7_Float = _SampleTexture2D_a57be8c4d236480f8104751aa7f681ab_RGBA_0_Vector4.a;
            float4 _Branch_45ebf603e9cf4ff3a4a6dbcc35b2c9e5_Out_3_Vector4;
            Unity_Branch_float4(_Property_17ea8ffc961b4ffd871836de5084ef86_Out_0_Boolean, _SampleTexture2D_a57be8c4d236480f8104751aa7f681ab_RGBA_0_Vector4, float4(0, 0, 0, 0), _Branch_45ebf603e9cf4ff3a4a6dbcc35b2c9e5_Out_3_Vector4);
            float _Property_e541f47f17b54763be002613df4e2428_Out_0_Float = _Param_Metalic;
            UnityTexture2D _Property_c819d15f02ab4493881e69c5685e980c_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_ORM_Texture);
            float4 _SampleTexture2D_f5e041739c8a4db594a428363896e97b_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_c819d15f02ab4493881e69c5685e980c_Out_0_Texture2D.tex, _Property_c819d15f02ab4493881e69c5685e980c_Out_0_Texture2D.samplerstate, _Property_c819d15f02ab4493881e69c5685e980c_Out_0_Texture2D.GetTransformedUV(IN.uv0.xy) );
            float _SampleTexture2D_f5e041739c8a4db594a428363896e97b_R_4_Float = _SampleTexture2D_f5e041739c8a4db594a428363896e97b_RGBA_0_Vector4.r;
            float _SampleTexture2D_f5e041739c8a4db594a428363896e97b_G_5_Float = _SampleTexture2D_f5e041739c8a4db594a428363896e97b_RGBA_0_Vector4.g;
            float _SampleTexture2D_f5e041739c8a4db594a428363896e97b_B_6_Float = _SampleTexture2D_f5e041739c8a4db594a428363896e97b_RGBA_0_Vector4.b;
            float _SampleTexture2D_f5e041739c8a4db594a428363896e97b_A_7_Float = _SampleTexture2D_f5e041739c8a4db594a428363896e97b_RGBA_0_Vector4.a;
            float _Multiply_329695002f9a4b7b953f2aa60124e02e_Out_2_Float;
            Unity_Multiply_float_float(_Property_e541f47f17b54763be002613df4e2428_Out_0_Float, _SampleTexture2D_f5e041739c8a4db594a428363896e97b_B_6_Float, _Multiply_329695002f9a4b7b953f2aa60124e02e_Out_2_Float);
            float _Property_6c57147c2e7c495ea1738f9c8e64529c_Out_0_Float = _Param_Roughness;
            UnityTexture2D _Property_1356c63c0d7e43a687e350a9f46377b7_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_ORM_Texture);
            float4 _SampleTexture2D_e90300966fdc464b97b573e644b4d54e_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_1356c63c0d7e43a687e350a9f46377b7_Out_0_Texture2D.tex, _Property_1356c63c0d7e43a687e350a9f46377b7_Out_0_Texture2D.samplerstate, _Property_1356c63c0d7e43a687e350a9f46377b7_Out_0_Texture2D.GetTransformedUV(IN.uv0.xy) );
            float _SampleTexture2D_e90300966fdc464b97b573e644b4d54e_R_4_Float = _SampleTexture2D_e90300966fdc464b97b573e644b4d54e_RGBA_0_Vector4.r;
            float _SampleTexture2D_e90300966fdc464b97b573e644b4d54e_G_5_Float = _SampleTexture2D_e90300966fdc464b97b573e644b4d54e_RGBA_0_Vector4.g;
            float _SampleTexture2D_e90300966fdc464b97b573e644b4d54e_B_6_Float = _SampleTexture2D_e90300966fdc464b97b573e644b4d54e_RGBA_0_Vector4.b;
            float _SampleTexture2D_e90300966fdc464b97b573e644b4d54e_A_7_Float = _SampleTexture2D_e90300966fdc464b97b573e644b4d54e_RGBA_0_Vector4.a;
            float _OneMinus_d33f5143a8f9425dbab28c41060c3228_Out_1_Float;
            Unity_OneMinus_float(_SampleTexture2D_e90300966fdc464b97b573e644b4d54e_G_5_Float, _OneMinus_d33f5143a8f9425dbab28c41060c3228_Out_1_Float);
            float _Multiply_7f595a9eb4fd414a91e0ff1327f32f3e_Out_2_Float;
            Unity_Multiply_float_float(_Property_6c57147c2e7c495ea1738f9c8e64529c_Out_0_Float, _OneMinus_d33f5143a8f9425dbab28c41060c3228_Out_1_Float, _Multiply_7f595a9eb4fd414a91e0ff1327f32f3e_Out_2_Float);
            float _Property_2d439fd022cd4b8da84a9a675029227b_Out_0_Float = _Param_AO;
            UnityTexture2D _Property_96ae0bdba5a642d19e3ff9e8ed5f8028_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_ORM_Texture);
            float4 _SampleTexture2D_18c326b7c2674546a72d722f47fa6532_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_96ae0bdba5a642d19e3ff9e8ed5f8028_Out_0_Texture2D.tex, _Property_96ae0bdba5a642d19e3ff9e8ed5f8028_Out_0_Texture2D.samplerstate, _Property_96ae0bdba5a642d19e3ff9e8ed5f8028_Out_0_Texture2D.GetTransformedUV(IN.uv0.xy) );
            float _SampleTexture2D_18c326b7c2674546a72d722f47fa6532_R_4_Float = _SampleTexture2D_18c326b7c2674546a72d722f47fa6532_RGBA_0_Vector4.r;
            float _SampleTexture2D_18c326b7c2674546a72d722f47fa6532_G_5_Float = _SampleTexture2D_18c326b7c2674546a72d722f47fa6532_RGBA_0_Vector4.g;
            float _SampleTexture2D_18c326b7c2674546a72d722f47fa6532_B_6_Float = _SampleTexture2D_18c326b7c2674546a72d722f47fa6532_RGBA_0_Vector4.b;
            float _SampleTexture2D_18c326b7c2674546a72d722f47fa6532_A_7_Float = _SampleTexture2D_18c326b7c2674546a72d722f47fa6532_RGBA_0_Vector4.a;
            float _Multiply_2bb5981ec276444eacb16af51e6f9a4b_Out_2_Float;
            Unity_Multiply_float_float(_Property_2d439fd022cd4b8da84a9a675029227b_Out_0_Float, _SampleTexture2D_18c326b7c2674546a72d722f47fa6532_R_4_Float, _Multiply_2bb5981ec276444eacb16af51e6f9a4b_Out_2_Float);
            UnityTexture2D _Property_8c9189612f044695b5e413fa751834bc_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_Color_Texture);
            float4 _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_8c9189612f044695b5e413fa751834bc_Out_0_Texture2D.tex, _Property_8c9189612f044695b5e413fa751834bc_Out_0_Texture2D.samplerstate, _Property_8c9189612f044695b5e413fa751834bc_Out_0_Texture2D.GetTransformedUV(IN.uv0.xy) );
            float _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_R_4_Float = _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_RGBA_0_Vector4.r;
            float _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_G_5_Float = _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_RGBA_0_Vector4.g;
            float _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_B_6_Float = _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_RGBA_0_Vector4.b;
            float _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_A_7_Float = _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_RGBA_0_Vector4.a;
            surface.BaseColor = (_SampleTexture2D_1d46dbc4d51248578b3c5b19a9c762b6_RGBA_0_Vector4.xyz);
            surface.NormalTS = (_SampleTexture2D_850c7807224247dcb806755ff839cbee_RGBA_0_Vector4.xyz);
            surface.Emission = (_Branch_45ebf603e9cf4ff3a4a6dbcc35b2c9e5_Out_3_Vector4.xyz);
            surface.Metallic = _Multiply_329695002f9a4b7b953f2aa60124e02e_Out_2_Float;
            surface.Specular = IsGammaSpace() ? float3(0.5, 0.5, 0.5) : SRGBToLinear(float3(0.5, 0.5, 0.5));
            surface.Smoothness = _Multiply_7f595a9eb4fd414a91e0ff1327f32f3e_Out_2_Float;
            surface.Occlusion = _Multiply_2bb5981ec276444eacb16af51e6f9a4b_Out_2_Float;
            surface.Alpha = _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_A_7_Float;
            surface.AlphaClipThreshold = 0.5;
            return surface;
        }
        
        // --------------------------------------------------
        // Build Graph Inputs
        #ifdef HAVE_VFX_MODIFICATION
        #define VFX_SRP_ATTRIBUTES Attributes
        #define VFX_SRP_VARYINGS Varyings
        #define VFX_SRP_SURFACE_INPUTS SurfaceDescriptionInputs
        #endif
        VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);
        
            output.ObjectSpaceNormal =                          input.normalOS;
            output.ObjectSpaceTangent =                         input.tangentOS.xyz;
            output.ObjectSpacePosition =                        input.positionOS;
        #if UNITY_ANY_INSTANCING_ENABLED
        #else // TODO: XR support for procedural instancing because in this case UNITY_ANY_INSTANCING_ENABLED is not defined and instanceID is incorrect.
        #endif
        
            return output;
        }
        SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
        
        #ifdef HAVE_VFX_MODIFICATION
        #if VFX_USE_GRAPH_VALUES
            uint instanceActiveIndex = asuint(UNITY_ACCESS_INSTANCED_PROP(PerInstance, _InstanceActiveIndex));
            /* WARNING: $splice Could not find named fragment 'VFXLoadGraphValues' */
        #endif
            /* WARNING: $splice Could not find named fragment 'VFXSetFragInputs' */
        
        #endif
        
            
        
        
        
            output.TangentSpaceNormal = float3(0.0f, 0.0f, 1.0f);
        
        
        
            #if UNITY_UV_STARTS_AT_TOP
            #else
            #endif
        
        
            output.uv0 = input.texCoord0;
        #if UNITY_ANY_INSTANCING_ENABLED
        #else // TODO: XR support for procedural instancing because in this case UNITY_ANY_INSTANCING_ENABLED is not defined and instanceID is incorrect.
        #endif
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
        #else
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        #endif
        #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        
                return output;
        }
        
        // --------------------------------------------------
        // Main
        
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/PBRForwardPass.hlsl"
        
        // --------------------------------------------------
        // Visual Effect Vertex Invocations
        #ifdef HAVE_VFX_MODIFICATION
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/VisualEffectVertex.hlsl"
        #endif
        
        ENDHLSL
        }
        Pass
        {
            Name "GBuffer"
            Tags
            {
                "LightMode" = "UniversalGBuffer"
            }
        
        // Render State
        Cull [_Cull]
        Blend [_SrcBlend] [_DstBlend]
        ZTest [_ZTest]
        ZWrite [_ZWrite]
        
        // Debug
        // <None>
        
        // --------------------------------------------------
        // Pass
        
        HLSLPROGRAM
        
        // Pragmas
        #pragma target 4.5
        #pragma exclude_renderers gles3 glcore
        #pragma multi_compile_instancing
        #pragma multi_compile_fog
        #pragma instancing_options renderinglayer
        #pragma vertex vert
        #pragma fragment frag
        
        // Keywords
        #pragma multi_compile _ LIGHTMAP_ON
        #pragma multi_compile _ DYNAMICLIGHTMAP_ON
        #pragma multi_compile _ DIRLIGHTMAP_COMBINED
        #pragma multi_compile _ USE_LEGACY_LIGHTMAPS
        #pragma multi_compile _ _MAIN_LIGHT_SHADOWS _MAIN_LIGHT_SHADOWS_CASCADE _MAIN_LIGHT_SHADOWS_SCREEN
        #pragma multi_compile_fragment _ _REFLECTION_PROBE_BLENDING
        #pragma multi_compile_fragment _ _REFLECTION_PROBE_BOX_PROJECTION
        #pragma multi_compile_fragment _ _SHADOWS_SOFT _SHADOWS_SOFT_LOW _SHADOWS_SOFT_MEDIUM _SHADOWS_SOFT_HIGH
        #pragma multi_compile _ LIGHTMAP_SHADOW_MIXING
        #pragma multi_compile _ SHADOWS_SHADOWMASK
        #pragma multi_compile _ _MIXED_LIGHTING_SUBTRACTIVE
        #pragma multi_compile_fragment _ _DBUFFER_MRT1 _DBUFFER_MRT2 _DBUFFER_MRT3
        #pragma multi_compile_fragment _ _GBUFFER_NORMALS_OCT
        #pragma multi_compile_fragment _ _RENDER_PASS_ENABLED
        #pragma multi_compile_fragment _ DEBUG_DISPLAY
        #pragma shader_feature_fragment _ _SURFACE_TYPE_TRANSPARENT
        #pragma shader_feature_local_fragment _ _ALPHAPREMULTIPLY_ON
        #pragma shader_feature_local_fragment _ _ALPHAMODULATE_ON
        #pragma shader_feature_local_fragment _ _ALPHATEST_ON
        #pragma shader_feature_local_fragment _ _SPECULAR_SETUP
        #pragma shader_feature_local _ _RECEIVE_SHADOWS_OFF
        // GraphKeywords: <None>
        
        // Defines
        
        #define _NORMALMAP 1
        #define _NORMAL_DROPOFF_TS 1
        #define ATTRIBUTES_NEED_NORMAL
        #define ATTRIBUTES_NEED_TANGENT
        #define ATTRIBUTES_NEED_TEXCOORD0
        #define ATTRIBUTES_NEED_TEXCOORD1
        #define ATTRIBUTES_NEED_TEXCOORD2
        #define FEATURES_GRAPH_VERTEX_NORMAL_OUTPUT
        #define FEATURES_GRAPH_VERTEX_TANGENT_OUTPUT
        #define VARYINGS_NEED_POSITION_WS
        #define VARYINGS_NEED_NORMAL_WS
        #define VARYINGS_NEED_TANGENT_WS
        #define VARYINGS_NEED_TEXCOORD0
        #define VARYINGS_NEED_FOG_AND_VERTEX_LIGHT
        #define VARYINGS_NEED_SHADOW_COORD
        #define FEATURES_GRAPH_VERTEX
        /* WARNING: $splice Could not find named fragment 'PassInstancing' */
        #define SHADERPASS SHADERPASS_GBUFFER
        #define _FOG_FRAGMENT 1
        
        
        // custom interpolator pre-include
        /* WARNING: $splice Could not find named fragment 'sgci_CustomInterpolatorPreInclude' */
        
        // Includes
        #include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DOTS.hlsl"
        #include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/RenderingLayers.hlsl"
        #include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ProbeVolumeVariants.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Input.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
        #include_with_pragmas "Packages/com.unity.render-pipelines.core/ShaderLibrary/FoveatedRenderingKeywords.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/FoveatedRendering.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/DebugMipmapStreamingMacros.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Shadows.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DBuffer.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
        
        // --------------------------------------------------
        // Structs and Packing
        
        // custom interpolators pre packing
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPrePacking' */
        
        struct Attributes
        {
             float3 positionOS : POSITION;
             float3 normalOS : NORMAL;
             float4 tangentOS : TANGENT;
             float4 uv0 : TEXCOORD0;
             float4 uv1 : TEXCOORD1;
             float4 uv2 : TEXCOORD2;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(ATTRIBUTES_NEED_INSTANCEID)
             uint instanceID : INSTANCEID_SEMANTIC;
            #endif
        };
        struct Varyings
        {
             float4 positionCS : SV_POSITION;
             float3 positionWS;
             float3 normalWS;
             float4 tangentWS;
             float4 texCoord0;
            #if defined(LIGHTMAP_ON)
             float2 staticLightmapUV;
            #endif
            #if defined(DYNAMICLIGHTMAP_ON)
             float2 dynamicLightmapUV;
            #endif
            #if !defined(LIGHTMAP_ON)
             float3 sh;
            #endif
             float4 fogFactorAndVertexLight;
            #if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
             float4 shadowCoord;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        struct SurfaceDescriptionInputs
        {
             float3 TangentSpaceNormal;
             float4 uv0;
        };
        struct VertexDescriptionInputs
        {
             float3 ObjectSpaceNormal;
             float3 ObjectSpaceTangent;
             float3 ObjectSpacePosition;
        };
        struct PackedVaryings
        {
             float4 positionCS : SV_POSITION;
            #if defined(LIGHTMAP_ON)
             float2 staticLightmapUV : INTERP0;
            #endif
            #if defined(DYNAMICLIGHTMAP_ON)
             float2 dynamicLightmapUV : INTERP1;
            #endif
            #if !defined(LIGHTMAP_ON)
             float3 sh : INTERP2;
            #endif
            #if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
             float4 shadowCoord : INTERP3;
            #endif
             float4 tangentWS : INTERP4;
             float4 texCoord0 : INTERP5;
             float4 fogFactorAndVertexLight : INTERP6;
             float3 positionWS : INTERP7;
             float3 normalWS : INTERP8;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        
        PackedVaryings PackVaryings (Varyings input)
        {
            PackedVaryings output;
            ZERO_INITIALIZE(PackedVaryings, output);
            output.positionCS = input.positionCS;
            #if defined(LIGHTMAP_ON)
            output.staticLightmapUV = input.staticLightmapUV;
            #endif
            #if defined(DYNAMICLIGHTMAP_ON)
            output.dynamicLightmapUV = input.dynamicLightmapUV;
            #endif
            #if !defined(LIGHTMAP_ON)
            output.sh = input.sh;
            #endif
            #if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
            output.shadowCoord = input.shadowCoord;
            #endif
            output.tangentWS.xyzw = input.tangentWS;
            output.texCoord0.xyzw = input.texCoord0;
            output.fogFactorAndVertexLight.xyzw = input.fogFactorAndVertexLight;
            output.positionWS.xyz = input.positionWS;
            output.normalWS.xyz = input.normalWS;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        
        Varyings UnpackVaryings (PackedVaryings input)
        {
            Varyings output;
            output.positionCS = input.positionCS;
            #if defined(LIGHTMAP_ON)
            output.staticLightmapUV = input.staticLightmapUV;
            #endif
            #if defined(DYNAMICLIGHTMAP_ON)
            output.dynamicLightmapUV = input.dynamicLightmapUV;
            #endif
            #if !defined(LIGHTMAP_ON)
            output.sh = input.sh;
            #endif
            #if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
            output.shadowCoord = input.shadowCoord;
            #endif
            output.tangentWS = input.tangentWS.xyzw;
            output.texCoord0 = input.texCoord0.xyzw;
            output.fogFactorAndVertexLight = input.fogFactorAndVertexLight.xyzw;
            output.positionWS = input.positionWS.xyz;
            output.normalWS = input.normalWS.xyz;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        
        
        // --------------------------------------------------
        // Graph
        
        // Graph Properties
        CBUFFER_START(UnityPerMaterial)
        float4 _Color_Texture_TexelSize;
        float4 _Normal_Texture_TexelSize;
        float4 _ORM_Texture_TexelSize;
        float4 _Emissive_Texture_TexelSize;
        float _Emission;
        float _Param_Roughness;
        float _Param_Metalic;
        float _Param_AO;
        UNITY_TEXTURE_STREAMING_DEBUG_VARS;
        CBUFFER_END
        
        
        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        TEXTURE2D(_Color_Texture);
        SAMPLER(sampler_Color_Texture);
        TEXTURE2D(_Normal_Texture);
        SAMPLER(sampler_Normal_Texture);
        TEXTURE2D(_ORM_Texture);
        SAMPLER(sampler_ORM_Texture);
        TEXTURE2D(_Emissive_Texture);
        SAMPLER(sampler_Emissive_Texture);
        
        // Graph Includes
        // GraphIncludes: <None>
        
        // -- Property used by ScenePickingPass
        #ifdef SCENEPICKINGPASS
        float4 _SelectionID;
        #endif
        
        // -- Properties used by SceneSelectionPass
        #ifdef SCENESELECTIONPASS
        int _ObjectId;
        int _PassValue;
        #endif
        
        // Graph Functions
        
        void Unity_Branch_float4(float Predicate, float4 True, float4 False, out float4 Out)
        {
            Out = Predicate ? True : False;
        }
        
        void Unity_Multiply_float_float(float A, float B, out float Out)
        {
            Out = A * B;
        }
        
        void Unity_OneMinus_float(float In, out float Out)
        {
            Out = 1 - In;
        }
        
        // Custom interpolators pre vertex
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPreVertex' */
        
        // Graph Vertex
        struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
        };
        
        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            description.Position = IN.ObjectSpacePosition;
            description.Normal = IN.ObjectSpaceNormal;
            description.Tangent = IN.ObjectSpaceTangent;
            return description;
        }
        
        // Custom interpolators, pre surface
        #ifdef FEATURES_GRAPH_VERTEX
        Varyings CustomInterpolatorPassThroughFunc(inout Varyings output, VertexDescription input)
        {
        return output;
        }
        #define CUSTOMINTERPOLATOR_VARYPASSTHROUGH_FUNC
        #endif
        
        // Graph Pixel
        struct SurfaceDescription
        {
            float3 BaseColor;
            float3 NormalTS;
            float3 Emission;
            float Metallic;
            float3 Specular;
            float Smoothness;
            float Occlusion;
            float Alpha;
            float AlphaClipThreshold;
        };
        
        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            UnityTexture2D _Property_29d95cca61c84013ba8453d2eba10e9a_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_Color_Texture);
            float4 _SampleTexture2D_1d46dbc4d51248578b3c5b19a9c762b6_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_29d95cca61c84013ba8453d2eba10e9a_Out_0_Texture2D.tex, _Property_29d95cca61c84013ba8453d2eba10e9a_Out_0_Texture2D.samplerstate, _Property_29d95cca61c84013ba8453d2eba10e9a_Out_0_Texture2D.GetTransformedUV(IN.uv0.xy) );
            float _SampleTexture2D_1d46dbc4d51248578b3c5b19a9c762b6_R_4_Float = _SampleTexture2D_1d46dbc4d51248578b3c5b19a9c762b6_RGBA_0_Vector4.r;
            float _SampleTexture2D_1d46dbc4d51248578b3c5b19a9c762b6_G_5_Float = _SampleTexture2D_1d46dbc4d51248578b3c5b19a9c762b6_RGBA_0_Vector4.g;
            float _SampleTexture2D_1d46dbc4d51248578b3c5b19a9c762b6_B_6_Float = _SampleTexture2D_1d46dbc4d51248578b3c5b19a9c762b6_RGBA_0_Vector4.b;
            float _SampleTexture2D_1d46dbc4d51248578b3c5b19a9c762b6_A_7_Float = _SampleTexture2D_1d46dbc4d51248578b3c5b19a9c762b6_RGBA_0_Vector4.a;
            UnityTexture2D _Property_43d6b361960241fa85238beaa18eaee7_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_Normal_Texture);
            float4 _SampleTexture2D_850c7807224247dcb806755ff839cbee_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_43d6b361960241fa85238beaa18eaee7_Out_0_Texture2D.tex, _Property_43d6b361960241fa85238beaa18eaee7_Out_0_Texture2D.samplerstate, _Property_43d6b361960241fa85238beaa18eaee7_Out_0_Texture2D.GetTransformedUV(IN.uv0.xy) );
            _SampleTexture2D_850c7807224247dcb806755ff839cbee_RGBA_0_Vector4.rgb = UnpackNormal(_SampleTexture2D_850c7807224247dcb806755ff839cbee_RGBA_0_Vector4);
            float _SampleTexture2D_850c7807224247dcb806755ff839cbee_R_4_Float = _SampleTexture2D_850c7807224247dcb806755ff839cbee_RGBA_0_Vector4.r;
            float _SampleTexture2D_850c7807224247dcb806755ff839cbee_G_5_Float = _SampleTexture2D_850c7807224247dcb806755ff839cbee_RGBA_0_Vector4.g;
            float _SampleTexture2D_850c7807224247dcb806755ff839cbee_B_6_Float = _SampleTexture2D_850c7807224247dcb806755ff839cbee_RGBA_0_Vector4.b;
            float _SampleTexture2D_850c7807224247dcb806755ff839cbee_A_7_Float = _SampleTexture2D_850c7807224247dcb806755ff839cbee_RGBA_0_Vector4.a;
            float _Property_17ea8ffc961b4ffd871836de5084ef86_Out_0_Boolean = _Emission;
            UnityTexture2D _Property_411dbbb2322442ebba4716107ea863fe_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_Emissive_Texture);
            float4 _SampleTexture2D_a57be8c4d236480f8104751aa7f681ab_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_411dbbb2322442ebba4716107ea863fe_Out_0_Texture2D.tex, _Property_411dbbb2322442ebba4716107ea863fe_Out_0_Texture2D.samplerstate, _Property_411dbbb2322442ebba4716107ea863fe_Out_0_Texture2D.GetTransformedUV(IN.uv0.xy) );
            float _SampleTexture2D_a57be8c4d236480f8104751aa7f681ab_R_4_Float = _SampleTexture2D_a57be8c4d236480f8104751aa7f681ab_RGBA_0_Vector4.r;
            float _SampleTexture2D_a57be8c4d236480f8104751aa7f681ab_G_5_Float = _SampleTexture2D_a57be8c4d236480f8104751aa7f681ab_RGBA_0_Vector4.g;
            float _SampleTexture2D_a57be8c4d236480f8104751aa7f681ab_B_6_Float = _SampleTexture2D_a57be8c4d236480f8104751aa7f681ab_RGBA_0_Vector4.b;
            float _SampleTexture2D_a57be8c4d236480f8104751aa7f681ab_A_7_Float = _SampleTexture2D_a57be8c4d236480f8104751aa7f681ab_RGBA_0_Vector4.a;
            float4 _Branch_45ebf603e9cf4ff3a4a6dbcc35b2c9e5_Out_3_Vector4;
            Unity_Branch_float4(_Property_17ea8ffc961b4ffd871836de5084ef86_Out_0_Boolean, _SampleTexture2D_a57be8c4d236480f8104751aa7f681ab_RGBA_0_Vector4, float4(0, 0, 0, 0), _Branch_45ebf603e9cf4ff3a4a6dbcc35b2c9e5_Out_3_Vector4);
            float _Property_e541f47f17b54763be002613df4e2428_Out_0_Float = _Param_Metalic;
            UnityTexture2D _Property_c819d15f02ab4493881e69c5685e980c_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_ORM_Texture);
            float4 _SampleTexture2D_f5e041739c8a4db594a428363896e97b_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_c819d15f02ab4493881e69c5685e980c_Out_0_Texture2D.tex, _Property_c819d15f02ab4493881e69c5685e980c_Out_0_Texture2D.samplerstate, _Property_c819d15f02ab4493881e69c5685e980c_Out_0_Texture2D.GetTransformedUV(IN.uv0.xy) );
            float _SampleTexture2D_f5e041739c8a4db594a428363896e97b_R_4_Float = _SampleTexture2D_f5e041739c8a4db594a428363896e97b_RGBA_0_Vector4.r;
            float _SampleTexture2D_f5e041739c8a4db594a428363896e97b_G_5_Float = _SampleTexture2D_f5e041739c8a4db594a428363896e97b_RGBA_0_Vector4.g;
            float _SampleTexture2D_f5e041739c8a4db594a428363896e97b_B_6_Float = _SampleTexture2D_f5e041739c8a4db594a428363896e97b_RGBA_0_Vector4.b;
            float _SampleTexture2D_f5e041739c8a4db594a428363896e97b_A_7_Float = _SampleTexture2D_f5e041739c8a4db594a428363896e97b_RGBA_0_Vector4.a;
            float _Multiply_329695002f9a4b7b953f2aa60124e02e_Out_2_Float;
            Unity_Multiply_float_float(_Property_e541f47f17b54763be002613df4e2428_Out_0_Float, _SampleTexture2D_f5e041739c8a4db594a428363896e97b_B_6_Float, _Multiply_329695002f9a4b7b953f2aa60124e02e_Out_2_Float);
            float _Property_6c57147c2e7c495ea1738f9c8e64529c_Out_0_Float = _Param_Roughness;
            UnityTexture2D _Property_1356c63c0d7e43a687e350a9f46377b7_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_ORM_Texture);
            float4 _SampleTexture2D_e90300966fdc464b97b573e644b4d54e_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_1356c63c0d7e43a687e350a9f46377b7_Out_0_Texture2D.tex, _Property_1356c63c0d7e43a687e350a9f46377b7_Out_0_Texture2D.samplerstate, _Property_1356c63c0d7e43a687e350a9f46377b7_Out_0_Texture2D.GetTransformedUV(IN.uv0.xy) );
            float _SampleTexture2D_e90300966fdc464b97b573e644b4d54e_R_4_Float = _SampleTexture2D_e90300966fdc464b97b573e644b4d54e_RGBA_0_Vector4.r;
            float _SampleTexture2D_e90300966fdc464b97b573e644b4d54e_G_5_Float = _SampleTexture2D_e90300966fdc464b97b573e644b4d54e_RGBA_0_Vector4.g;
            float _SampleTexture2D_e90300966fdc464b97b573e644b4d54e_B_6_Float = _SampleTexture2D_e90300966fdc464b97b573e644b4d54e_RGBA_0_Vector4.b;
            float _SampleTexture2D_e90300966fdc464b97b573e644b4d54e_A_7_Float = _SampleTexture2D_e90300966fdc464b97b573e644b4d54e_RGBA_0_Vector4.a;
            float _OneMinus_d33f5143a8f9425dbab28c41060c3228_Out_1_Float;
            Unity_OneMinus_float(_SampleTexture2D_e90300966fdc464b97b573e644b4d54e_G_5_Float, _OneMinus_d33f5143a8f9425dbab28c41060c3228_Out_1_Float);
            float _Multiply_7f595a9eb4fd414a91e0ff1327f32f3e_Out_2_Float;
            Unity_Multiply_float_float(_Property_6c57147c2e7c495ea1738f9c8e64529c_Out_0_Float, _OneMinus_d33f5143a8f9425dbab28c41060c3228_Out_1_Float, _Multiply_7f595a9eb4fd414a91e0ff1327f32f3e_Out_2_Float);
            float _Property_2d439fd022cd4b8da84a9a675029227b_Out_0_Float = _Param_AO;
            UnityTexture2D _Property_96ae0bdba5a642d19e3ff9e8ed5f8028_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_ORM_Texture);
            float4 _SampleTexture2D_18c326b7c2674546a72d722f47fa6532_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_96ae0bdba5a642d19e3ff9e8ed5f8028_Out_0_Texture2D.tex, _Property_96ae0bdba5a642d19e3ff9e8ed5f8028_Out_0_Texture2D.samplerstate, _Property_96ae0bdba5a642d19e3ff9e8ed5f8028_Out_0_Texture2D.GetTransformedUV(IN.uv0.xy) );
            float _SampleTexture2D_18c326b7c2674546a72d722f47fa6532_R_4_Float = _SampleTexture2D_18c326b7c2674546a72d722f47fa6532_RGBA_0_Vector4.r;
            float _SampleTexture2D_18c326b7c2674546a72d722f47fa6532_G_5_Float = _SampleTexture2D_18c326b7c2674546a72d722f47fa6532_RGBA_0_Vector4.g;
            float _SampleTexture2D_18c326b7c2674546a72d722f47fa6532_B_6_Float = _SampleTexture2D_18c326b7c2674546a72d722f47fa6532_RGBA_0_Vector4.b;
            float _SampleTexture2D_18c326b7c2674546a72d722f47fa6532_A_7_Float = _SampleTexture2D_18c326b7c2674546a72d722f47fa6532_RGBA_0_Vector4.a;
            float _Multiply_2bb5981ec276444eacb16af51e6f9a4b_Out_2_Float;
            Unity_Multiply_float_float(_Property_2d439fd022cd4b8da84a9a675029227b_Out_0_Float, _SampleTexture2D_18c326b7c2674546a72d722f47fa6532_R_4_Float, _Multiply_2bb5981ec276444eacb16af51e6f9a4b_Out_2_Float);
            UnityTexture2D _Property_8c9189612f044695b5e413fa751834bc_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_Color_Texture);
            float4 _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_8c9189612f044695b5e413fa751834bc_Out_0_Texture2D.tex, _Property_8c9189612f044695b5e413fa751834bc_Out_0_Texture2D.samplerstate, _Property_8c9189612f044695b5e413fa751834bc_Out_0_Texture2D.GetTransformedUV(IN.uv0.xy) );
            float _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_R_4_Float = _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_RGBA_0_Vector4.r;
            float _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_G_5_Float = _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_RGBA_0_Vector4.g;
            float _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_B_6_Float = _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_RGBA_0_Vector4.b;
            float _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_A_7_Float = _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_RGBA_0_Vector4.a;
            surface.BaseColor = (_SampleTexture2D_1d46dbc4d51248578b3c5b19a9c762b6_RGBA_0_Vector4.xyz);
            surface.NormalTS = (_SampleTexture2D_850c7807224247dcb806755ff839cbee_RGBA_0_Vector4.xyz);
            surface.Emission = (_Branch_45ebf603e9cf4ff3a4a6dbcc35b2c9e5_Out_3_Vector4.xyz);
            surface.Metallic = _Multiply_329695002f9a4b7b953f2aa60124e02e_Out_2_Float;
            surface.Specular = IsGammaSpace() ? float3(0.5, 0.5, 0.5) : SRGBToLinear(float3(0.5, 0.5, 0.5));
            surface.Smoothness = _Multiply_7f595a9eb4fd414a91e0ff1327f32f3e_Out_2_Float;
            surface.Occlusion = _Multiply_2bb5981ec276444eacb16af51e6f9a4b_Out_2_Float;
            surface.Alpha = _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_A_7_Float;
            surface.AlphaClipThreshold = 0.5;
            return surface;
        }
        
        // --------------------------------------------------
        // Build Graph Inputs
        #ifdef HAVE_VFX_MODIFICATION
        #define VFX_SRP_ATTRIBUTES Attributes
        #define VFX_SRP_VARYINGS Varyings
        #define VFX_SRP_SURFACE_INPUTS SurfaceDescriptionInputs
        #endif
        VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);
        
            output.ObjectSpaceNormal =                          input.normalOS;
            output.ObjectSpaceTangent =                         input.tangentOS.xyz;
            output.ObjectSpacePosition =                        input.positionOS;
        #if UNITY_ANY_INSTANCING_ENABLED
        #else // TODO: XR support for procedural instancing because in this case UNITY_ANY_INSTANCING_ENABLED is not defined and instanceID is incorrect.
        #endif
        
            return output;
        }
        SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
        
        #ifdef HAVE_VFX_MODIFICATION
        #if VFX_USE_GRAPH_VALUES
            uint instanceActiveIndex = asuint(UNITY_ACCESS_INSTANCED_PROP(PerInstance, _InstanceActiveIndex));
            /* WARNING: $splice Could not find named fragment 'VFXLoadGraphValues' */
        #endif
            /* WARNING: $splice Could not find named fragment 'VFXSetFragInputs' */
        
        #endif
        
            
        
        
        
            output.TangentSpaceNormal = float3(0.0f, 0.0f, 1.0f);
        
        
        
            #if UNITY_UV_STARTS_AT_TOP
            #else
            #endif
        
        
            output.uv0 = input.texCoord0;
        #if UNITY_ANY_INSTANCING_ENABLED
        #else // TODO: XR support for procedural instancing because in this case UNITY_ANY_INSTANCING_ENABLED is not defined and instanceID is incorrect.
        #endif
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
        #else
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        #endif
        #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        
                return output;
        }
        
        // --------------------------------------------------
        // Main
        
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/UnityGBuffer.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/PBRGBufferPass.hlsl"
        
        // --------------------------------------------------
        // Visual Effect Vertex Invocations
        #ifdef HAVE_VFX_MODIFICATION
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/VisualEffectVertex.hlsl"
        #endif
        
        ENDHLSL
        }
        Pass
        {
            Name "ShadowCaster"
            Tags
            {
                "LightMode" = "ShadowCaster"
            }
        
        // Render State
        Cull [_Cull]
        ZTest LEqual
        ZWrite On
        ColorMask 0
        
        // Debug
        // <None>
        
        // --------------------------------------------------
        // Pass
        
        HLSLPROGRAM
        
        // Pragmas
        #pragma target 2.0
        #pragma multi_compile_instancing
        #pragma vertex vert
        #pragma fragment frag
        
        // Keywords
        #pragma multi_compile_vertex _ _CASTING_PUNCTUAL_LIGHT_SHADOW
        #pragma shader_feature_local_fragment _ _ALPHATEST_ON
        // GraphKeywords: <None>
        
        // Defines
        
        #define _NORMALMAP 1
        #define _NORMAL_DROPOFF_TS 1
        #define ATTRIBUTES_NEED_NORMAL
        #define ATTRIBUTES_NEED_TANGENT
        #define ATTRIBUTES_NEED_TEXCOORD0
        #define FEATURES_GRAPH_VERTEX_NORMAL_OUTPUT
        #define FEATURES_GRAPH_VERTEX_TANGENT_OUTPUT
        #define VARYINGS_NEED_NORMAL_WS
        #define VARYINGS_NEED_TEXCOORD0
        #define FEATURES_GRAPH_VERTEX
        /* WARNING: $splice Could not find named fragment 'PassInstancing' */
        #define SHADERPASS SHADERPASS_SHADOWCASTER
        
        
        // custom interpolator pre-include
        /* WARNING: $splice Could not find named fragment 'sgci_CustomInterpolatorPreInclude' */
        
        // Includes
        #include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DOTS.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Input.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
        #include_with_pragmas "Packages/com.unity.render-pipelines.core/ShaderLibrary/FoveatedRenderingKeywords.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/FoveatedRendering.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/DebugMipmapStreamingMacros.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
        
        // --------------------------------------------------
        // Structs and Packing
        
        // custom interpolators pre packing
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPrePacking' */
        
        struct Attributes
        {
             float3 positionOS : POSITION;
             float3 normalOS : NORMAL;
             float4 tangentOS : TANGENT;
             float4 uv0 : TEXCOORD0;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(ATTRIBUTES_NEED_INSTANCEID)
             uint instanceID : INSTANCEID_SEMANTIC;
            #endif
        };
        struct Varyings
        {
             float4 positionCS : SV_POSITION;
             float3 normalWS;
             float4 texCoord0;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        struct SurfaceDescriptionInputs
        {
             float4 uv0;
        };
        struct VertexDescriptionInputs
        {
             float3 ObjectSpaceNormal;
             float3 ObjectSpaceTangent;
             float3 ObjectSpacePosition;
        };
        struct PackedVaryings
        {
             float4 positionCS : SV_POSITION;
             float4 texCoord0 : INTERP0;
             float3 normalWS : INTERP1;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        
        PackedVaryings PackVaryings (Varyings input)
        {
            PackedVaryings output;
            ZERO_INITIALIZE(PackedVaryings, output);
            output.positionCS = input.positionCS;
            output.texCoord0.xyzw = input.texCoord0;
            output.normalWS.xyz = input.normalWS;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        
        Varyings UnpackVaryings (PackedVaryings input)
        {
            Varyings output;
            output.positionCS = input.positionCS;
            output.texCoord0 = input.texCoord0.xyzw;
            output.normalWS = input.normalWS.xyz;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        
        
        // --------------------------------------------------
        // Graph
        
        // Graph Properties
        CBUFFER_START(UnityPerMaterial)
        float4 _Color_Texture_TexelSize;
        float4 _Normal_Texture_TexelSize;
        float4 _ORM_Texture_TexelSize;
        float4 _Emissive_Texture_TexelSize;
        float _Emission;
        float _Param_Roughness;
        float _Param_Metalic;
        float _Param_AO;
        UNITY_TEXTURE_STREAMING_DEBUG_VARS;
        CBUFFER_END
        
        
        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        TEXTURE2D(_Color_Texture);
        SAMPLER(sampler_Color_Texture);
        TEXTURE2D(_Normal_Texture);
        SAMPLER(sampler_Normal_Texture);
        TEXTURE2D(_ORM_Texture);
        SAMPLER(sampler_ORM_Texture);
        TEXTURE2D(_Emissive_Texture);
        SAMPLER(sampler_Emissive_Texture);
        
        // Graph Includes
        // GraphIncludes: <None>
        
        // -- Property used by ScenePickingPass
        #ifdef SCENEPICKINGPASS
        float4 _SelectionID;
        #endif
        
        // -- Properties used by SceneSelectionPass
        #ifdef SCENESELECTIONPASS
        int _ObjectId;
        int _PassValue;
        #endif
        
        // Graph Functions
        // GraphFunctions: <None>
        
        // Custom interpolators pre vertex
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPreVertex' */
        
        // Graph Vertex
        struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
        };
        
        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            description.Position = IN.ObjectSpacePosition;
            description.Normal = IN.ObjectSpaceNormal;
            description.Tangent = IN.ObjectSpaceTangent;
            return description;
        }
        
        // Custom interpolators, pre surface
        #ifdef FEATURES_GRAPH_VERTEX
        Varyings CustomInterpolatorPassThroughFunc(inout Varyings output, VertexDescription input)
        {
        return output;
        }
        #define CUSTOMINTERPOLATOR_VARYPASSTHROUGH_FUNC
        #endif
        
        // Graph Pixel
        struct SurfaceDescription
        {
            float Alpha;
            float AlphaClipThreshold;
        };
        
        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            UnityTexture2D _Property_8c9189612f044695b5e413fa751834bc_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_Color_Texture);
            float4 _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_8c9189612f044695b5e413fa751834bc_Out_0_Texture2D.tex, _Property_8c9189612f044695b5e413fa751834bc_Out_0_Texture2D.samplerstate, _Property_8c9189612f044695b5e413fa751834bc_Out_0_Texture2D.GetTransformedUV(IN.uv0.xy) );
            float _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_R_4_Float = _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_RGBA_0_Vector4.r;
            float _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_G_5_Float = _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_RGBA_0_Vector4.g;
            float _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_B_6_Float = _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_RGBA_0_Vector4.b;
            float _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_A_7_Float = _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_RGBA_0_Vector4.a;
            surface.Alpha = _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_A_7_Float;
            surface.AlphaClipThreshold = 0.5;
            return surface;
        }
        
        // --------------------------------------------------
        // Build Graph Inputs
        #ifdef HAVE_VFX_MODIFICATION
        #define VFX_SRP_ATTRIBUTES Attributes
        #define VFX_SRP_VARYINGS Varyings
        #define VFX_SRP_SURFACE_INPUTS SurfaceDescriptionInputs
        #endif
        VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);
        
            output.ObjectSpaceNormal =                          input.normalOS;
            output.ObjectSpaceTangent =                         input.tangentOS.xyz;
            output.ObjectSpacePosition =                        input.positionOS;
        #if UNITY_ANY_INSTANCING_ENABLED
        #else // TODO: XR support for procedural instancing because in this case UNITY_ANY_INSTANCING_ENABLED is not defined and instanceID is incorrect.
        #endif
        
            return output;
        }
        SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
        
        #ifdef HAVE_VFX_MODIFICATION
        #if VFX_USE_GRAPH_VALUES
            uint instanceActiveIndex = asuint(UNITY_ACCESS_INSTANCED_PROP(PerInstance, _InstanceActiveIndex));
            /* WARNING: $splice Could not find named fragment 'VFXLoadGraphValues' */
        #endif
            /* WARNING: $splice Could not find named fragment 'VFXSetFragInputs' */
        
        #endif
        
            
        
        
        
        
        
        
            #if UNITY_UV_STARTS_AT_TOP
            #else
            #endif
        
        
            output.uv0 = input.texCoord0;
        #if UNITY_ANY_INSTANCING_ENABLED
        #else // TODO: XR support for procedural instancing because in this case UNITY_ANY_INSTANCING_ENABLED is not defined and instanceID is incorrect.
        #endif
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
        #else
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        #endif
        #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        
                return output;
        }
        
        // --------------------------------------------------
        // Main
        
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShadowCasterPass.hlsl"
        
        // --------------------------------------------------
        // Visual Effect Vertex Invocations
        #ifdef HAVE_VFX_MODIFICATION
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/VisualEffectVertex.hlsl"
        #endif
        
        ENDHLSL
        }
        Pass
        {
            Name "MotionVectors"
            Tags
            {
                "LightMode" = "MotionVectors"
            }
        
        // Render State
        Cull [_Cull]
        ZTest LEqual
        ZWrite On
        ColorMask RG
        
        // Debug
        // <None>
        
        // --------------------------------------------------
        // Pass
        
        HLSLPROGRAM
        
        // Pragmas
        #pragma target 3.5
        #pragma multi_compile_instancing
        #pragma vertex vert
        #pragma fragment frag
        
        // Keywords
        #pragma shader_feature_local_fragment _ _ALPHATEST_ON
        // GraphKeywords: <None>
        
        // Defines
        
        #define _NORMALMAP 1
        #define _NORMAL_DROPOFF_TS 1
        #define ATTRIBUTES_NEED_TEXCOORD0
        #define VARYINGS_NEED_TEXCOORD0
        #define FEATURES_GRAPH_VERTEX
        /* WARNING: $splice Could not find named fragment 'PassInstancing' */
        #define SHADERPASS SHADERPASS_MOTION_VECTORS
        
        
        // custom interpolator pre-include
        /* WARNING: $splice Could not find named fragment 'sgci_CustomInterpolatorPreInclude' */
        
        // Includes
        #include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DOTS.hlsl"
        #include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/RenderingLayers.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Input.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
        #include_with_pragmas "Packages/com.unity.render-pipelines.core/ShaderLibrary/FoveatedRenderingKeywords.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/FoveatedRendering.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/DebugMipmapStreamingMacros.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
        
        // --------------------------------------------------
        // Structs and Packing
        
        // custom interpolators pre packing
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPrePacking' */
        
        struct Attributes
        {
             float3 positionOS : POSITION;
             float4 uv0 : TEXCOORD0;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(ATTRIBUTES_NEED_INSTANCEID)
             uint instanceID : INSTANCEID_SEMANTIC;
            #endif
        };
        struct Varyings
        {
             float4 positionCS : SV_POSITION;
             float4 texCoord0;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        struct SurfaceDescriptionInputs
        {
             float4 uv0;
        };
        struct VertexDescriptionInputs
        {
             float3 ObjectSpacePosition;
        };
        struct PackedVaryings
        {
             float4 positionCS : SV_POSITION;
             float4 texCoord0 : INTERP0;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        
        PackedVaryings PackVaryings (Varyings input)
        {
            PackedVaryings output;
            ZERO_INITIALIZE(PackedVaryings, output);
            output.positionCS = input.positionCS;
            output.texCoord0.xyzw = input.texCoord0;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        
        Varyings UnpackVaryings (PackedVaryings input)
        {
            Varyings output;
            output.positionCS = input.positionCS;
            output.texCoord0 = input.texCoord0.xyzw;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        
        
        // --------------------------------------------------
        // Graph
        
        // Graph Properties
        CBUFFER_START(UnityPerMaterial)
        float4 _Color_Texture_TexelSize;
        float4 _Normal_Texture_TexelSize;
        float4 _ORM_Texture_TexelSize;
        float4 _Emissive_Texture_TexelSize;
        float _Emission;
        float _Param_Roughness;
        float _Param_Metalic;
        float _Param_AO;
        UNITY_TEXTURE_STREAMING_DEBUG_VARS;
        CBUFFER_END
        
        
        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        TEXTURE2D(_Color_Texture);
        SAMPLER(sampler_Color_Texture);
        TEXTURE2D(_Normal_Texture);
        SAMPLER(sampler_Normal_Texture);
        TEXTURE2D(_ORM_Texture);
        SAMPLER(sampler_ORM_Texture);
        TEXTURE2D(_Emissive_Texture);
        SAMPLER(sampler_Emissive_Texture);
        
        // Graph Includes
        // GraphIncludes: <None>
        
        // -- Property used by ScenePickingPass
        #ifdef SCENEPICKINGPASS
        float4 _SelectionID;
        #endif
        
        // -- Properties used by SceneSelectionPass
        #ifdef SCENESELECTIONPASS
        int _ObjectId;
        int _PassValue;
        #endif
        
        // Graph Functions
        // GraphFunctions: <None>
        
        // Custom interpolators pre vertex
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPreVertex' */
        
        // Graph Vertex
        struct VertexDescription
        {
            float3 Position;
        };
        
        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            description.Position = IN.ObjectSpacePosition;
            return description;
        }
        
        // Custom interpolators, pre surface
        #ifdef FEATURES_GRAPH_VERTEX
        Varyings CustomInterpolatorPassThroughFunc(inout Varyings output, VertexDescription input)
        {
        return output;
        }
        #define CUSTOMINTERPOLATOR_VARYPASSTHROUGH_FUNC
        #endif
        
        // Graph Pixel
        struct SurfaceDescription
        {
            float Alpha;
            float AlphaClipThreshold;
        };
        
        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            UnityTexture2D _Property_8c9189612f044695b5e413fa751834bc_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_Color_Texture);
            float4 _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_8c9189612f044695b5e413fa751834bc_Out_0_Texture2D.tex, _Property_8c9189612f044695b5e413fa751834bc_Out_0_Texture2D.samplerstate, _Property_8c9189612f044695b5e413fa751834bc_Out_0_Texture2D.GetTransformedUV(IN.uv0.xy) );
            float _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_R_4_Float = _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_RGBA_0_Vector4.r;
            float _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_G_5_Float = _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_RGBA_0_Vector4.g;
            float _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_B_6_Float = _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_RGBA_0_Vector4.b;
            float _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_A_7_Float = _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_RGBA_0_Vector4.a;
            surface.Alpha = _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_A_7_Float;
            surface.AlphaClipThreshold = 0.5;
            return surface;
        }
        
        // --------------------------------------------------
        // Build Graph Inputs
        #ifdef HAVE_VFX_MODIFICATION
        #define VFX_SRP_ATTRIBUTES Attributes
        #define VFX_SRP_VARYINGS Varyings
        #define VFX_SRP_SURFACE_INPUTS SurfaceDescriptionInputs
        #endif
        VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);
        
            output.ObjectSpacePosition =                        input.positionOS;
        #if UNITY_ANY_INSTANCING_ENABLED
        #else // TODO: XR support for procedural instancing because in this case UNITY_ANY_INSTANCING_ENABLED is not defined and instanceID is incorrect.
        #endif
        
            return output;
        }
        SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
        
        #ifdef HAVE_VFX_MODIFICATION
        #if VFX_USE_GRAPH_VALUES
            uint instanceActiveIndex = asuint(UNITY_ACCESS_INSTANCED_PROP(PerInstance, _InstanceActiveIndex));
            /* WARNING: $splice Could not find named fragment 'VFXLoadGraphValues' */
        #endif
            /* WARNING: $splice Could not find named fragment 'VFXSetFragInputs' */
        
        #endif
        
            
        
        
        
        
        
        
            #if UNITY_UV_STARTS_AT_TOP
            #else
            #endif
        
        
            output.uv0 = input.texCoord0;
        #if UNITY_ANY_INSTANCING_ENABLED
        #else // TODO: XR support for procedural instancing because in this case UNITY_ANY_INSTANCING_ENABLED is not defined and instanceID is incorrect.
        #endif
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
        #else
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        #endif
        #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        
                return output;
        }
        
        // --------------------------------------------------
        // Main
        
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/MotionVectorPass.hlsl"
        
        // --------------------------------------------------
        // Visual Effect Vertex Invocations
        #ifdef HAVE_VFX_MODIFICATION
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/VisualEffectVertex.hlsl"
        #endif
        
        ENDHLSL
        }
        Pass
        {
            Name "DepthOnly"
            Tags
            {
                "LightMode" = "DepthOnly"
            }
        
        // Render State
        Cull [_Cull]
        ZTest LEqual
        ZWrite On
        ColorMask R
        
        // Debug
        // <None>
        
        // --------------------------------------------------
        // Pass
        
        HLSLPROGRAM
        
        // Pragmas
        #pragma target 2.0
        #pragma multi_compile_instancing
        #pragma vertex vert
        #pragma fragment frag
        
        // Keywords
        #pragma shader_feature_local_fragment _ _ALPHATEST_ON
        // GraphKeywords: <None>
        
        // Defines
        
        #define _NORMALMAP 1
        #define _NORMAL_DROPOFF_TS 1
        #define ATTRIBUTES_NEED_NORMAL
        #define ATTRIBUTES_NEED_TANGENT
        #define ATTRIBUTES_NEED_TEXCOORD0
        #define FEATURES_GRAPH_VERTEX_NORMAL_OUTPUT
        #define FEATURES_GRAPH_VERTEX_TANGENT_OUTPUT
        #define VARYINGS_NEED_TEXCOORD0
        #define FEATURES_GRAPH_VERTEX
        /* WARNING: $splice Could not find named fragment 'PassInstancing' */
        #define SHADERPASS SHADERPASS_DEPTHONLY
        
        
        // custom interpolator pre-include
        /* WARNING: $splice Could not find named fragment 'sgci_CustomInterpolatorPreInclude' */
        
        // Includes
        #include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DOTS.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Input.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
        #include_with_pragmas "Packages/com.unity.render-pipelines.core/ShaderLibrary/FoveatedRenderingKeywords.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/FoveatedRendering.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/DebugMipmapStreamingMacros.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
        
        // --------------------------------------------------
        // Structs and Packing
        
        // custom interpolators pre packing
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPrePacking' */
        
        struct Attributes
        {
             float3 positionOS : POSITION;
             float3 normalOS : NORMAL;
             float4 tangentOS : TANGENT;
             float4 uv0 : TEXCOORD0;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(ATTRIBUTES_NEED_INSTANCEID)
             uint instanceID : INSTANCEID_SEMANTIC;
            #endif
        };
        struct Varyings
        {
             float4 positionCS : SV_POSITION;
             float4 texCoord0;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        struct SurfaceDescriptionInputs
        {
             float4 uv0;
        };
        struct VertexDescriptionInputs
        {
             float3 ObjectSpaceNormal;
             float3 ObjectSpaceTangent;
             float3 ObjectSpacePosition;
        };
        struct PackedVaryings
        {
             float4 positionCS : SV_POSITION;
             float4 texCoord0 : INTERP0;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        
        PackedVaryings PackVaryings (Varyings input)
        {
            PackedVaryings output;
            ZERO_INITIALIZE(PackedVaryings, output);
            output.positionCS = input.positionCS;
            output.texCoord0.xyzw = input.texCoord0;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        
        Varyings UnpackVaryings (PackedVaryings input)
        {
            Varyings output;
            output.positionCS = input.positionCS;
            output.texCoord0 = input.texCoord0.xyzw;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        
        
        // --------------------------------------------------
        // Graph
        
        // Graph Properties
        CBUFFER_START(UnityPerMaterial)
        float4 _Color_Texture_TexelSize;
        float4 _Normal_Texture_TexelSize;
        float4 _ORM_Texture_TexelSize;
        float4 _Emissive_Texture_TexelSize;
        float _Emission;
        float _Param_Roughness;
        float _Param_Metalic;
        float _Param_AO;
        UNITY_TEXTURE_STREAMING_DEBUG_VARS;
        CBUFFER_END
        
        
        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        TEXTURE2D(_Color_Texture);
        SAMPLER(sampler_Color_Texture);
        TEXTURE2D(_Normal_Texture);
        SAMPLER(sampler_Normal_Texture);
        TEXTURE2D(_ORM_Texture);
        SAMPLER(sampler_ORM_Texture);
        TEXTURE2D(_Emissive_Texture);
        SAMPLER(sampler_Emissive_Texture);
        
        // Graph Includes
        // GraphIncludes: <None>
        
        // -- Property used by ScenePickingPass
        #ifdef SCENEPICKINGPASS
        float4 _SelectionID;
        #endif
        
        // -- Properties used by SceneSelectionPass
        #ifdef SCENESELECTIONPASS
        int _ObjectId;
        int _PassValue;
        #endif
        
        // Graph Functions
        // GraphFunctions: <None>
        
        // Custom interpolators pre vertex
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPreVertex' */
        
        // Graph Vertex
        struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
        };
        
        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            description.Position = IN.ObjectSpacePosition;
            description.Normal = IN.ObjectSpaceNormal;
            description.Tangent = IN.ObjectSpaceTangent;
            return description;
        }
        
        // Custom interpolators, pre surface
        #ifdef FEATURES_GRAPH_VERTEX
        Varyings CustomInterpolatorPassThroughFunc(inout Varyings output, VertexDescription input)
        {
        return output;
        }
        #define CUSTOMINTERPOLATOR_VARYPASSTHROUGH_FUNC
        #endif
        
        // Graph Pixel
        struct SurfaceDescription
        {
            float Alpha;
            float AlphaClipThreshold;
        };
        
        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            UnityTexture2D _Property_8c9189612f044695b5e413fa751834bc_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_Color_Texture);
            float4 _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_8c9189612f044695b5e413fa751834bc_Out_0_Texture2D.tex, _Property_8c9189612f044695b5e413fa751834bc_Out_0_Texture2D.samplerstate, _Property_8c9189612f044695b5e413fa751834bc_Out_0_Texture2D.GetTransformedUV(IN.uv0.xy) );
            float _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_R_4_Float = _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_RGBA_0_Vector4.r;
            float _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_G_5_Float = _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_RGBA_0_Vector4.g;
            float _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_B_6_Float = _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_RGBA_0_Vector4.b;
            float _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_A_7_Float = _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_RGBA_0_Vector4.a;
            surface.Alpha = _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_A_7_Float;
            surface.AlphaClipThreshold = 0.5;
            return surface;
        }
        
        // --------------------------------------------------
        // Build Graph Inputs
        #ifdef HAVE_VFX_MODIFICATION
        #define VFX_SRP_ATTRIBUTES Attributes
        #define VFX_SRP_VARYINGS Varyings
        #define VFX_SRP_SURFACE_INPUTS SurfaceDescriptionInputs
        #endif
        VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);
        
            output.ObjectSpaceNormal =                          input.normalOS;
            output.ObjectSpaceTangent =                         input.tangentOS.xyz;
            output.ObjectSpacePosition =                        input.positionOS;
        #if UNITY_ANY_INSTANCING_ENABLED
        #else // TODO: XR support for procedural instancing because in this case UNITY_ANY_INSTANCING_ENABLED is not defined and instanceID is incorrect.
        #endif
        
            return output;
        }
        SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
        
        #ifdef HAVE_VFX_MODIFICATION
        #if VFX_USE_GRAPH_VALUES
            uint instanceActiveIndex = asuint(UNITY_ACCESS_INSTANCED_PROP(PerInstance, _InstanceActiveIndex));
            /* WARNING: $splice Could not find named fragment 'VFXLoadGraphValues' */
        #endif
            /* WARNING: $splice Could not find named fragment 'VFXSetFragInputs' */
        
        #endif
        
            
        
        
        
        
        
        
            #if UNITY_UV_STARTS_AT_TOP
            #else
            #endif
        
        
            output.uv0 = input.texCoord0;
        #if UNITY_ANY_INSTANCING_ENABLED
        #else // TODO: XR support for procedural instancing because in this case UNITY_ANY_INSTANCING_ENABLED is not defined and instanceID is incorrect.
        #endif
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
        #else
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        #endif
        #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        
                return output;
        }
        
        // --------------------------------------------------
        // Main
        
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/DepthOnlyPass.hlsl"
        
        // --------------------------------------------------
        // Visual Effect Vertex Invocations
        #ifdef HAVE_VFX_MODIFICATION
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/VisualEffectVertex.hlsl"
        #endif
        
        ENDHLSL
        }
        Pass
        {
            Name "DepthNormals"
            Tags
            {
                "LightMode" = "DepthNormals"
            }
        
        // Render State
        Cull [_Cull]
        ZTest LEqual
        ZWrite On
        
        // Debug
        // <None>
        
        // --------------------------------------------------
        // Pass
        
        HLSLPROGRAM
        
        // Pragmas
        #pragma target 2.0
        #pragma multi_compile_instancing
        #pragma vertex vert
        #pragma fragment frag
        
        // Keywords
        #pragma shader_feature_local_fragment _ _ALPHATEST_ON
        // GraphKeywords: <None>
        
        // Defines
        
        #define _NORMALMAP 1
        #define _NORMAL_DROPOFF_TS 1
        #define ATTRIBUTES_NEED_NORMAL
        #define ATTRIBUTES_NEED_TANGENT
        #define ATTRIBUTES_NEED_TEXCOORD0
        #define ATTRIBUTES_NEED_TEXCOORD1
        #define FEATURES_GRAPH_VERTEX_NORMAL_OUTPUT
        #define FEATURES_GRAPH_VERTEX_TANGENT_OUTPUT
        #define VARYINGS_NEED_NORMAL_WS
        #define VARYINGS_NEED_TANGENT_WS
        #define VARYINGS_NEED_TEXCOORD0
        #define FEATURES_GRAPH_VERTEX
        /* WARNING: $splice Could not find named fragment 'PassInstancing' */
        #define SHADERPASS SHADERPASS_DEPTHNORMALS
        
        
        // custom interpolator pre-include
        /* WARNING: $splice Could not find named fragment 'sgci_CustomInterpolatorPreInclude' */
        
        // Includes
        #include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DOTS.hlsl"
        #include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/RenderingLayers.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Input.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
        #include_with_pragmas "Packages/com.unity.render-pipelines.core/ShaderLibrary/FoveatedRenderingKeywords.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/FoveatedRendering.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/DebugMipmapStreamingMacros.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
        
        // --------------------------------------------------
        // Structs and Packing
        
        // custom interpolators pre packing
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPrePacking' */
        
        struct Attributes
        {
             float3 positionOS : POSITION;
             float3 normalOS : NORMAL;
             float4 tangentOS : TANGENT;
             float4 uv0 : TEXCOORD0;
             float4 uv1 : TEXCOORD1;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(ATTRIBUTES_NEED_INSTANCEID)
             uint instanceID : INSTANCEID_SEMANTIC;
            #endif
        };
        struct Varyings
        {
             float4 positionCS : SV_POSITION;
             float3 normalWS;
             float4 tangentWS;
             float4 texCoord0;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        struct SurfaceDescriptionInputs
        {
             float3 TangentSpaceNormal;
             float4 uv0;
        };
        struct VertexDescriptionInputs
        {
             float3 ObjectSpaceNormal;
             float3 ObjectSpaceTangent;
             float3 ObjectSpacePosition;
        };
        struct PackedVaryings
        {
             float4 positionCS : SV_POSITION;
             float4 tangentWS : INTERP0;
             float4 texCoord0 : INTERP1;
             float3 normalWS : INTERP2;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        
        PackedVaryings PackVaryings (Varyings input)
        {
            PackedVaryings output;
            ZERO_INITIALIZE(PackedVaryings, output);
            output.positionCS = input.positionCS;
            output.tangentWS.xyzw = input.tangentWS;
            output.texCoord0.xyzw = input.texCoord0;
            output.normalWS.xyz = input.normalWS;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        
        Varyings UnpackVaryings (PackedVaryings input)
        {
            Varyings output;
            output.positionCS = input.positionCS;
            output.tangentWS = input.tangentWS.xyzw;
            output.texCoord0 = input.texCoord0.xyzw;
            output.normalWS = input.normalWS.xyz;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        
        
        // --------------------------------------------------
        // Graph
        
        // Graph Properties
        CBUFFER_START(UnityPerMaterial)
        float4 _Color_Texture_TexelSize;
        float4 _Normal_Texture_TexelSize;
        float4 _ORM_Texture_TexelSize;
        float4 _Emissive_Texture_TexelSize;
        float _Emission;
        float _Param_Roughness;
        float _Param_Metalic;
        float _Param_AO;
        UNITY_TEXTURE_STREAMING_DEBUG_VARS;
        CBUFFER_END
        
        
        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        TEXTURE2D(_Color_Texture);
        SAMPLER(sampler_Color_Texture);
        TEXTURE2D(_Normal_Texture);
        SAMPLER(sampler_Normal_Texture);
        TEXTURE2D(_ORM_Texture);
        SAMPLER(sampler_ORM_Texture);
        TEXTURE2D(_Emissive_Texture);
        SAMPLER(sampler_Emissive_Texture);
        
        // Graph Includes
        // GraphIncludes: <None>
        
        // -- Property used by ScenePickingPass
        #ifdef SCENEPICKINGPASS
        float4 _SelectionID;
        #endif
        
        // -- Properties used by SceneSelectionPass
        #ifdef SCENESELECTIONPASS
        int _ObjectId;
        int _PassValue;
        #endif
        
        // Graph Functions
        // GraphFunctions: <None>
        
        // Custom interpolators pre vertex
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPreVertex' */
        
        // Graph Vertex
        struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
        };
        
        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            description.Position = IN.ObjectSpacePosition;
            description.Normal = IN.ObjectSpaceNormal;
            description.Tangent = IN.ObjectSpaceTangent;
            return description;
        }
        
        // Custom interpolators, pre surface
        #ifdef FEATURES_GRAPH_VERTEX
        Varyings CustomInterpolatorPassThroughFunc(inout Varyings output, VertexDescription input)
        {
        return output;
        }
        #define CUSTOMINTERPOLATOR_VARYPASSTHROUGH_FUNC
        #endif
        
        // Graph Pixel
        struct SurfaceDescription
        {
            float3 NormalTS;
            float Alpha;
            float AlphaClipThreshold;
        };
        
        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            UnityTexture2D _Property_43d6b361960241fa85238beaa18eaee7_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_Normal_Texture);
            float4 _SampleTexture2D_850c7807224247dcb806755ff839cbee_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_43d6b361960241fa85238beaa18eaee7_Out_0_Texture2D.tex, _Property_43d6b361960241fa85238beaa18eaee7_Out_0_Texture2D.samplerstate, _Property_43d6b361960241fa85238beaa18eaee7_Out_0_Texture2D.GetTransformedUV(IN.uv0.xy) );
            _SampleTexture2D_850c7807224247dcb806755ff839cbee_RGBA_0_Vector4.rgb = UnpackNormal(_SampleTexture2D_850c7807224247dcb806755ff839cbee_RGBA_0_Vector4);
            float _SampleTexture2D_850c7807224247dcb806755ff839cbee_R_4_Float = _SampleTexture2D_850c7807224247dcb806755ff839cbee_RGBA_0_Vector4.r;
            float _SampleTexture2D_850c7807224247dcb806755ff839cbee_G_5_Float = _SampleTexture2D_850c7807224247dcb806755ff839cbee_RGBA_0_Vector4.g;
            float _SampleTexture2D_850c7807224247dcb806755ff839cbee_B_6_Float = _SampleTexture2D_850c7807224247dcb806755ff839cbee_RGBA_0_Vector4.b;
            float _SampleTexture2D_850c7807224247dcb806755ff839cbee_A_7_Float = _SampleTexture2D_850c7807224247dcb806755ff839cbee_RGBA_0_Vector4.a;
            UnityTexture2D _Property_8c9189612f044695b5e413fa751834bc_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_Color_Texture);
            float4 _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_8c9189612f044695b5e413fa751834bc_Out_0_Texture2D.tex, _Property_8c9189612f044695b5e413fa751834bc_Out_0_Texture2D.samplerstate, _Property_8c9189612f044695b5e413fa751834bc_Out_0_Texture2D.GetTransformedUV(IN.uv0.xy) );
            float _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_R_4_Float = _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_RGBA_0_Vector4.r;
            float _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_G_5_Float = _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_RGBA_0_Vector4.g;
            float _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_B_6_Float = _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_RGBA_0_Vector4.b;
            float _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_A_7_Float = _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_RGBA_0_Vector4.a;
            surface.NormalTS = (_SampleTexture2D_850c7807224247dcb806755ff839cbee_RGBA_0_Vector4.xyz);
            surface.Alpha = _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_A_7_Float;
            surface.AlphaClipThreshold = 0.5;
            return surface;
        }
        
        // --------------------------------------------------
        // Build Graph Inputs
        #ifdef HAVE_VFX_MODIFICATION
        #define VFX_SRP_ATTRIBUTES Attributes
        #define VFX_SRP_VARYINGS Varyings
        #define VFX_SRP_SURFACE_INPUTS SurfaceDescriptionInputs
        #endif
        VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);
        
            output.ObjectSpaceNormal =                          input.normalOS;
            output.ObjectSpaceTangent =                         input.tangentOS.xyz;
            output.ObjectSpacePosition =                        input.positionOS;
        #if UNITY_ANY_INSTANCING_ENABLED
        #else // TODO: XR support for procedural instancing because in this case UNITY_ANY_INSTANCING_ENABLED is not defined and instanceID is incorrect.
        #endif
        
            return output;
        }
        SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
        
        #ifdef HAVE_VFX_MODIFICATION
        #if VFX_USE_GRAPH_VALUES
            uint instanceActiveIndex = asuint(UNITY_ACCESS_INSTANCED_PROP(PerInstance, _InstanceActiveIndex));
            /* WARNING: $splice Could not find named fragment 'VFXLoadGraphValues' */
        #endif
            /* WARNING: $splice Could not find named fragment 'VFXSetFragInputs' */
        
        #endif
        
            
        
        
        
            output.TangentSpaceNormal = float3(0.0f, 0.0f, 1.0f);
        
        
        
            #if UNITY_UV_STARTS_AT_TOP
            #else
            #endif
        
        
            output.uv0 = input.texCoord0;
        #if UNITY_ANY_INSTANCING_ENABLED
        #else // TODO: XR support for procedural instancing because in this case UNITY_ANY_INSTANCING_ENABLED is not defined and instanceID is incorrect.
        #endif
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
        #else
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        #endif
        #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        
                return output;
        }
        
        // --------------------------------------------------
        // Main
        
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/DepthNormalsOnlyPass.hlsl"
        
        // --------------------------------------------------
        // Visual Effect Vertex Invocations
        #ifdef HAVE_VFX_MODIFICATION
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/VisualEffectVertex.hlsl"
        #endif
        
        ENDHLSL
        }
        Pass
        {
            Name "Meta"
            Tags
            {
                "LightMode" = "Meta"
            }
        
        // Render State
        Cull Off
        
        // Debug
        // <None>
        
        // --------------------------------------------------
        // Pass
        
        HLSLPROGRAM
        
        // Pragmas
        #pragma target 2.0
        #pragma vertex vert
        #pragma fragment frag
        
        // Keywords
        #pragma shader_feature _ EDITOR_VISUALIZATION
        #pragma shader_feature_local_fragment _ _ALPHATEST_ON
        // GraphKeywords: <None>
        
        // Defines
        
        #define _NORMALMAP 1
        #define _NORMAL_DROPOFF_TS 1
        #define ATTRIBUTES_NEED_NORMAL
        #define ATTRIBUTES_NEED_TANGENT
        #define ATTRIBUTES_NEED_TEXCOORD0
        #define ATTRIBUTES_NEED_TEXCOORD1
        #define ATTRIBUTES_NEED_TEXCOORD2
        #define ATTRIBUTES_NEED_INSTANCEID
        #define FEATURES_GRAPH_VERTEX_NORMAL_OUTPUT
        #define FEATURES_GRAPH_VERTEX_TANGENT_OUTPUT
        #define VARYINGS_NEED_TEXCOORD0
        #define VARYINGS_NEED_TEXCOORD1
        #define VARYINGS_NEED_TEXCOORD2
        #define FEATURES_GRAPH_VERTEX
        /* WARNING: $splice Could not find named fragment 'PassInstancing' */
        #define SHADERPASS SHADERPASS_META
        #define _FOG_FRAGMENT 1
        
        
        // custom interpolator pre-include
        /* WARNING: $splice Could not find named fragment 'sgci_CustomInterpolatorPreInclude' */
        
        // Includes
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Input.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
        #include_with_pragmas "Packages/com.unity.render-pipelines.core/ShaderLibrary/FoveatedRenderingKeywords.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/FoveatedRendering.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/DebugMipmapStreamingMacros.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/MetaInput.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
        
        // --------------------------------------------------
        // Structs and Packing
        
        // custom interpolators pre packing
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPrePacking' */
        
        struct Attributes
        {
             float3 positionOS : POSITION;
             float3 normalOS : NORMAL;
             float4 tangentOS : TANGENT;
             float4 uv0 : TEXCOORD0;
             float4 uv1 : TEXCOORD1;
             float4 uv2 : TEXCOORD2;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(ATTRIBUTES_NEED_INSTANCEID)
             uint instanceID : INSTANCEID_SEMANTIC;
            #endif
        };
        struct Varyings
        {
             float4 positionCS : SV_POSITION;
             float4 texCoord0;
             float4 texCoord1;
             float4 texCoord2;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        struct SurfaceDescriptionInputs
        {
             float4 uv0;
        };
        struct VertexDescriptionInputs
        {
             float3 ObjectSpaceNormal;
             float3 ObjectSpaceTangent;
             float3 ObjectSpacePosition;
        };
        struct PackedVaryings
        {
             float4 positionCS : SV_POSITION;
             float4 texCoord0 : INTERP0;
             float4 texCoord1 : INTERP1;
             float4 texCoord2 : INTERP2;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        
        PackedVaryings PackVaryings (Varyings input)
        {
            PackedVaryings output;
            ZERO_INITIALIZE(PackedVaryings, output);
            output.positionCS = input.positionCS;
            output.texCoord0.xyzw = input.texCoord0;
            output.texCoord1.xyzw = input.texCoord1;
            output.texCoord2.xyzw = input.texCoord2;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        
        Varyings UnpackVaryings (PackedVaryings input)
        {
            Varyings output;
            output.positionCS = input.positionCS;
            output.texCoord0 = input.texCoord0.xyzw;
            output.texCoord1 = input.texCoord1.xyzw;
            output.texCoord2 = input.texCoord2.xyzw;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        
        
        // --------------------------------------------------
        // Graph
        
        // Graph Properties
        CBUFFER_START(UnityPerMaterial)
        float4 _Color_Texture_TexelSize;
        float4 _Normal_Texture_TexelSize;
        float4 _ORM_Texture_TexelSize;
        float4 _Emissive_Texture_TexelSize;
        float _Emission;
        float _Param_Roughness;
        float _Param_Metalic;
        float _Param_AO;
        UNITY_TEXTURE_STREAMING_DEBUG_VARS;
        CBUFFER_END
        
        
        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        TEXTURE2D(_Color_Texture);
        SAMPLER(sampler_Color_Texture);
        TEXTURE2D(_Normal_Texture);
        SAMPLER(sampler_Normal_Texture);
        TEXTURE2D(_ORM_Texture);
        SAMPLER(sampler_ORM_Texture);
        TEXTURE2D(_Emissive_Texture);
        SAMPLER(sampler_Emissive_Texture);
        
        // Graph Includes
        // GraphIncludes: <None>
        
        // -- Property used by ScenePickingPass
        #ifdef SCENEPICKINGPASS
        float4 _SelectionID;
        #endif
        
        // -- Properties used by SceneSelectionPass
        #ifdef SCENESELECTIONPASS
        int _ObjectId;
        int _PassValue;
        #endif
        
        // Graph Functions
        
        void Unity_Branch_float4(float Predicate, float4 True, float4 False, out float4 Out)
        {
            Out = Predicate ? True : False;
        }
        
        // Custom interpolators pre vertex
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPreVertex' */
        
        // Graph Vertex
        struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
        };
        
        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            description.Position = IN.ObjectSpacePosition;
            description.Normal = IN.ObjectSpaceNormal;
            description.Tangent = IN.ObjectSpaceTangent;
            return description;
        }
        
        // Custom interpolators, pre surface
        #ifdef FEATURES_GRAPH_VERTEX
        Varyings CustomInterpolatorPassThroughFunc(inout Varyings output, VertexDescription input)
        {
        return output;
        }
        #define CUSTOMINTERPOLATOR_VARYPASSTHROUGH_FUNC
        #endif
        
        // Graph Pixel
        struct SurfaceDescription
        {
            float3 BaseColor;
            float3 Emission;
            float Alpha;
            float AlphaClipThreshold;
        };
        
        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            UnityTexture2D _Property_29d95cca61c84013ba8453d2eba10e9a_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_Color_Texture);
            float4 _SampleTexture2D_1d46dbc4d51248578b3c5b19a9c762b6_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_29d95cca61c84013ba8453d2eba10e9a_Out_0_Texture2D.tex, _Property_29d95cca61c84013ba8453d2eba10e9a_Out_0_Texture2D.samplerstate, _Property_29d95cca61c84013ba8453d2eba10e9a_Out_0_Texture2D.GetTransformedUV(IN.uv0.xy) );
            float _SampleTexture2D_1d46dbc4d51248578b3c5b19a9c762b6_R_4_Float = _SampleTexture2D_1d46dbc4d51248578b3c5b19a9c762b6_RGBA_0_Vector4.r;
            float _SampleTexture2D_1d46dbc4d51248578b3c5b19a9c762b6_G_5_Float = _SampleTexture2D_1d46dbc4d51248578b3c5b19a9c762b6_RGBA_0_Vector4.g;
            float _SampleTexture2D_1d46dbc4d51248578b3c5b19a9c762b6_B_6_Float = _SampleTexture2D_1d46dbc4d51248578b3c5b19a9c762b6_RGBA_0_Vector4.b;
            float _SampleTexture2D_1d46dbc4d51248578b3c5b19a9c762b6_A_7_Float = _SampleTexture2D_1d46dbc4d51248578b3c5b19a9c762b6_RGBA_0_Vector4.a;
            float _Property_17ea8ffc961b4ffd871836de5084ef86_Out_0_Boolean = _Emission;
            UnityTexture2D _Property_411dbbb2322442ebba4716107ea863fe_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_Emissive_Texture);
            float4 _SampleTexture2D_a57be8c4d236480f8104751aa7f681ab_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_411dbbb2322442ebba4716107ea863fe_Out_0_Texture2D.tex, _Property_411dbbb2322442ebba4716107ea863fe_Out_0_Texture2D.samplerstate, _Property_411dbbb2322442ebba4716107ea863fe_Out_0_Texture2D.GetTransformedUV(IN.uv0.xy) );
            float _SampleTexture2D_a57be8c4d236480f8104751aa7f681ab_R_4_Float = _SampleTexture2D_a57be8c4d236480f8104751aa7f681ab_RGBA_0_Vector4.r;
            float _SampleTexture2D_a57be8c4d236480f8104751aa7f681ab_G_5_Float = _SampleTexture2D_a57be8c4d236480f8104751aa7f681ab_RGBA_0_Vector4.g;
            float _SampleTexture2D_a57be8c4d236480f8104751aa7f681ab_B_6_Float = _SampleTexture2D_a57be8c4d236480f8104751aa7f681ab_RGBA_0_Vector4.b;
            float _SampleTexture2D_a57be8c4d236480f8104751aa7f681ab_A_7_Float = _SampleTexture2D_a57be8c4d236480f8104751aa7f681ab_RGBA_0_Vector4.a;
            float4 _Branch_45ebf603e9cf4ff3a4a6dbcc35b2c9e5_Out_3_Vector4;
            Unity_Branch_float4(_Property_17ea8ffc961b4ffd871836de5084ef86_Out_0_Boolean, _SampleTexture2D_a57be8c4d236480f8104751aa7f681ab_RGBA_0_Vector4, float4(0, 0, 0, 0), _Branch_45ebf603e9cf4ff3a4a6dbcc35b2c9e5_Out_3_Vector4);
            UnityTexture2D _Property_8c9189612f044695b5e413fa751834bc_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_Color_Texture);
            float4 _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_8c9189612f044695b5e413fa751834bc_Out_0_Texture2D.tex, _Property_8c9189612f044695b5e413fa751834bc_Out_0_Texture2D.samplerstate, _Property_8c9189612f044695b5e413fa751834bc_Out_0_Texture2D.GetTransformedUV(IN.uv0.xy) );
            float _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_R_4_Float = _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_RGBA_0_Vector4.r;
            float _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_G_5_Float = _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_RGBA_0_Vector4.g;
            float _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_B_6_Float = _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_RGBA_0_Vector4.b;
            float _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_A_7_Float = _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_RGBA_0_Vector4.a;
            surface.BaseColor = (_SampleTexture2D_1d46dbc4d51248578b3c5b19a9c762b6_RGBA_0_Vector4.xyz);
            surface.Emission = (_Branch_45ebf603e9cf4ff3a4a6dbcc35b2c9e5_Out_3_Vector4.xyz);
            surface.Alpha = _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_A_7_Float;
            surface.AlphaClipThreshold = 0.5;
            return surface;
        }
        
        // --------------------------------------------------
        // Build Graph Inputs
        #ifdef HAVE_VFX_MODIFICATION
        #define VFX_SRP_ATTRIBUTES Attributes
        #define VFX_SRP_VARYINGS Varyings
        #define VFX_SRP_SURFACE_INPUTS SurfaceDescriptionInputs
        #endif
        VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);
        
            output.ObjectSpaceNormal =                          input.normalOS;
            output.ObjectSpaceTangent =                         input.tangentOS.xyz;
            output.ObjectSpacePosition =                        input.positionOS;
        #if UNITY_ANY_INSTANCING_ENABLED
        #else // TODO: XR support for procedural instancing because in this case UNITY_ANY_INSTANCING_ENABLED is not defined and instanceID is incorrect.
        #endif
        
            return output;
        }
        SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
        
        #ifdef HAVE_VFX_MODIFICATION
        #if VFX_USE_GRAPH_VALUES
            uint instanceActiveIndex = asuint(UNITY_ACCESS_INSTANCED_PROP(PerInstance, _InstanceActiveIndex));
            /* WARNING: $splice Could not find named fragment 'VFXLoadGraphValues' */
        #endif
            /* WARNING: $splice Could not find named fragment 'VFXSetFragInputs' */
        
        #endif
        
            
        
        
        
        
        
        
            #if UNITY_UV_STARTS_AT_TOP
            #else
            #endif
        
        
            output.uv0 = input.texCoord0;
        #if UNITY_ANY_INSTANCING_ENABLED
        #else // TODO: XR support for procedural instancing because in this case UNITY_ANY_INSTANCING_ENABLED is not defined and instanceID is incorrect.
        #endif
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
        #else
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        #endif
        #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        
                return output;
        }
        
        // --------------------------------------------------
        // Main
        
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/LightingMetaPass.hlsl"
        
        // --------------------------------------------------
        // Visual Effect Vertex Invocations
        #ifdef HAVE_VFX_MODIFICATION
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/VisualEffectVertex.hlsl"
        #endif
        
        ENDHLSL
        }
        Pass
        {
            Name "SceneSelectionPass"
            Tags
            {
                "LightMode" = "SceneSelectionPass"
            }
        
        // Render State
        Cull Off
        
        // Debug
        // <None>
        
        // --------------------------------------------------
        // Pass
        
        HLSLPROGRAM
        
        // Pragmas
        #pragma target 2.0
        #pragma vertex vert
        #pragma fragment frag
        
        // Keywords
        #pragma shader_feature_local_fragment _ _ALPHATEST_ON
        // GraphKeywords: <None>
        
        // Defines
        
        #define _NORMALMAP 1
        #define _NORMAL_DROPOFF_TS 1
        #define ATTRIBUTES_NEED_NORMAL
        #define ATTRIBUTES_NEED_TANGENT
        #define ATTRIBUTES_NEED_TEXCOORD0
        #define FEATURES_GRAPH_VERTEX_NORMAL_OUTPUT
        #define FEATURES_GRAPH_VERTEX_TANGENT_OUTPUT
        #define VARYINGS_NEED_TEXCOORD0
        #define FEATURES_GRAPH_VERTEX
        /* WARNING: $splice Could not find named fragment 'PassInstancing' */
        #define SHADERPASS SHADERPASS_DEPTHONLY
        #define SCENESELECTIONPASS 1
        #define ALPHA_CLIP_THRESHOLD 1
        
        
        // custom interpolator pre-include
        /* WARNING: $splice Could not find named fragment 'sgci_CustomInterpolatorPreInclude' */
        
        // Includes
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Input.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
        #include_with_pragmas "Packages/com.unity.render-pipelines.core/ShaderLibrary/FoveatedRenderingKeywords.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/FoveatedRendering.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/DebugMipmapStreamingMacros.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
        #include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DOTS.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
        
        // --------------------------------------------------
        // Structs and Packing
        
        // custom interpolators pre packing
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPrePacking' */
        
        struct Attributes
        {
             float3 positionOS : POSITION;
             float3 normalOS : NORMAL;
             float4 tangentOS : TANGENT;
             float4 uv0 : TEXCOORD0;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(ATTRIBUTES_NEED_INSTANCEID)
             uint instanceID : INSTANCEID_SEMANTIC;
            #endif
        };
        struct Varyings
        {
             float4 positionCS : SV_POSITION;
             float4 texCoord0;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        struct SurfaceDescriptionInputs
        {
             float4 uv0;
        };
        struct VertexDescriptionInputs
        {
             float3 ObjectSpaceNormal;
             float3 ObjectSpaceTangent;
             float3 ObjectSpacePosition;
        };
        struct PackedVaryings
        {
             float4 positionCS : SV_POSITION;
             float4 texCoord0 : INTERP0;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        
        PackedVaryings PackVaryings (Varyings input)
        {
            PackedVaryings output;
            ZERO_INITIALIZE(PackedVaryings, output);
            output.positionCS = input.positionCS;
            output.texCoord0.xyzw = input.texCoord0;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        
        Varyings UnpackVaryings (PackedVaryings input)
        {
            Varyings output;
            output.positionCS = input.positionCS;
            output.texCoord0 = input.texCoord0.xyzw;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        
        
        // --------------------------------------------------
        // Graph
        
        // Graph Properties
        CBUFFER_START(UnityPerMaterial)
        float4 _Color_Texture_TexelSize;
        float4 _Normal_Texture_TexelSize;
        float4 _ORM_Texture_TexelSize;
        float4 _Emissive_Texture_TexelSize;
        float _Emission;
        float _Param_Roughness;
        float _Param_Metalic;
        float _Param_AO;
        UNITY_TEXTURE_STREAMING_DEBUG_VARS;
        CBUFFER_END
        
        
        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        TEXTURE2D(_Color_Texture);
        SAMPLER(sampler_Color_Texture);
        TEXTURE2D(_Normal_Texture);
        SAMPLER(sampler_Normal_Texture);
        TEXTURE2D(_ORM_Texture);
        SAMPLER(sampler_ORM_Texture);
        TEXTURE2D(_Emissive_Texture);
        SAMPLER(sampler_Emissive_Texture);
        
        // Graph Includes
        // GraphIncludes: <None>
        
        // -- Property used by ScenePickingPass
        #ifdef SCENEPICKINGPASS
        float4 _SelectionID;
        #endif
        
        // -- Properties used by SceneSelectionPass
        #ifdef SCENESELECTIONPASS
        int _ObjectId;
        int _PassValue;
        #endif
        
        // Graph Functions
        // GraphFunctions: <None>
        
        // Custom interpolators pre vertex
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPreVertex' */
        
        // Graph Vertex
        struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
        };
        
        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            description.Position = IN.ObjectSpacePosition;
            description.Normal = IN.ObjectSpaceNormal;
            description.Tangent = IN.ObjectSpaceTangent;
            return description;
        }
        
        // Custom interpolators, pre surface
        #ifdef FEATURES_GRAPH_VERTEX
        Varyings CustomInterpolatorPassThroughFunc(inout Varyings output, VertexDescription input)
        {
        return output;
        }
        #define CUSTOMINTERPOLATOR_VARYPASSTHROUGH_FUNC
        #endif
        
        // Graph Pixel
        struct SurfaceDescription
        {
            float Alpha;
            float AlphaClipThreshold;
        };
        
        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            UnityTexture2D _Property_8c9189612f044695b5e413fa751834bc_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_Color_Texture);
            float4 _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_8c9189612f044695b5e413fa751834bc_Out_0_Texture2D.tex, _Property_8c9189612f044695b5e413fa751834bc_Out_0_Texture2D.samplerstate, _Property_8c9189612f044695b5e413fa751834bc_Out_0_Texture2D.GetTransformedUV(IN.uv0.xy) );
            float _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_R_4_Float = _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_RGBA_0_Vector4.r;
            float _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_G_5_Float = _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_RGBA_0_Vector4.g;
            float _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_B_6_Float = _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_RGBA_0_Vector4.b;
            float _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_A_7_Float = _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_RGBA_0_Vector4.a;
            surface.Alpha = _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_A_7_Float;
            surface.AlphaClipThreshold = 0.5;
            return surface;
        }
        
        // --------------------------------------------------
        // Build Graph Inputs
        #ifdef HAVE_VFX_MODIFICATION
        #define VFX_SRP_ATTRIBUTES Attributes
        #define VFX_SRP_VARYINGS Varyings
        #define VFX_SRP_SURFACE_INPUTS SurfaceDescriptionInputs
        #endif
        VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);
        
            output.ObjectSpaceNormal =                          input.normalOS;
            output.ObjectSpaceTangent =                         input.tangentOS.xyz;
            output.ObjectSpacePosition =                        input.positionOS;
        #if UNITY_ANY_INSTANCING_ENABLED
        #else // TODO: XR support for procedural instancing because in this case UNITY_ANY_INSTANCING_ENABLED is not defined and instanceID is incorrect.
        #endif
        
            return output;
        }
        SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
        
        #ifdef HAVE_VFX_MODIFICATION
        #if VFX_USE_GRAPH_VALUES
            uint instanceActiveIndex = asuint(UNITY_ACCESS_INSTANCED_PROP(PerInstance, _InstanceActiveIndex));
            /* WARNING: $splice Could not find named fragment 'VFXLoadGraphValues' */
        #endif
            /* WARNING: $splice Could not find named fragment 'VFXSetFragInputs' */
        
        #endif
        
            
        
        
        
        
        
        
            #if UNITY_UV_STARTS_AT_TOP
            #else
            #endif
        
        
            output.uv0 = input.texCoord0;
        #if UNITY_ANY_INSTANCING_ENABLED
        #else // TODO: XR support for procedural instancing because in this case UNITY_ANY_INSTANCING_ENABLED is not defined and instanceID is incorrect.
        #endif
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
        #else
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        #endif
        #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        
                return output;
        }
        
        // --------------------------------------------------
        // Main
        
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/SelectionPickingPass.hlsl"
        
        // --------------------------------------------------
        // Visual Effect Vertex Invocations
        #ifdef HAVE_VFX_MODIFICATION
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/VisualEffectVertex.hlsl"
        #endif
        
        ENDHLSL
        }
        Pass
        {
            Name "ScenePickingPass"
            Tags
            {
                "LightMode" = "Picking"
            }
        
        // Render State
        Cull [_Cull]
        
        // Debug
        // <None>
        
        // --------------------------------------------------
        // Pass
        
        HLSLPROGRAM
        
        // Pragmas
        #pragma target 2.0
        #pragma vertex vert
        #pragma fragment frag
        
        // Keywords
        #pragma shader_feature_local_fragment _ _ALPHATEST_ON
        // GraphKeywords: <None>
        
        // Defines
        
        #define _NORMALMAP 1
        #define _NORMAL_DROPOFF_TS 1
        #define ATTRIBUTES_NEED_NORMAL
        #define ATTRIBUTES_NEED_TANGENT
        #define ATTRIBUTES_NEED_TEXCOORD0
        #define FEATURES_GRAPH_VERTEX_NORMAL_OUTPUT
        #define FEATURES_GRAPH_VERTEX_TANGENT_OUTPUT
        #define VARYINGS_NEED_TEXCOORD0
        #define FEATURES_GRAPH_VERTEX
        /* WARNING: $splice Could not find named fragment 'PassInstancing' */
        #define SHADERPASS SHADERPASS_DEPTHONLY
        #define SCENEPICKINGPASS 1
        #define ALPHA_CLIP_THRESHOLD 1
        
        
        // custom interpolator pre-include
        /* WARNING: $splice Could not find named fragment 'sgci_CustomInterpolatorPreInclude' */
        
        // Includes
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Input.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
        #include_with_pragmas "Packages/com.unity.render-pipelines.core/ShaderLibrary/FoveatedRenderingKeywords.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/FoveatedRendering.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/DebugMipmapStreamingMacros.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
        #include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DOTS.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
        
        // --------------------------------------------------
        // Structs and Packing
        
        // custom interpolators pre packing
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPrePacking' */
        
        struct Attributes
        {
             float3 positionOS : POSITION;
             float3 normalOS : NORMAL;
             float4 tangentOS : TANGENT;
             float4 uv0 : TEXCOORD0;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(ATTRIBUTES_NEED_INSTANCEID)
             uint instanceID : INSTANCEID_SEMANTIC;
            #endif
        };
        struct Varyings
        {
             float4 positionCS : SV_POSITION;
             float4 texCoord0;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        struct SurfaceDescriptionInputs
        {
             float4 uv0;
        };
        struct VertexDescriptionInputs
        {
             float3 ObjectSpaceNormal;
             float3 ObjectSpaceTangent;
             float3 ObjectSpacePosition;
        };
        struct PackedVaryings
        {
             float4 positionCS : SV_POSITION;
             float4 texCoord0 : INTERP0;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        
        PackedVaryings PackVaryings (Varyings input)
        {
            PackedVaryings output;
            ZERO_INITIALIZE(PackedVaryings, output);
            output.positionCS = input.positionCS;
            output.texCoord0.xyzw = input.texCoord0;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        
        Varyings UnpackVaryings (PackedVaryings input)
        {
            Varyings output;
            output.positionCS = input.positionCS;
            output.texCoord0 = input.texCoord0.xyzw;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        
        
        // --------------------------------------------------
        // Graph
        
        // Graph Properties
        CBUFFER_START(UnityPerMaterial)
        float4 _Color_Texture_TexelSize;
        float4 _Normal_Texture_TexelSize;
        float4 _ORM_Texture_TexelSize;
        float4 _Emissive_Texture_TexelSize;
        float _Emission;
        float _Param_Roughness;
        float _Param_Metalic;
        float _Param_AO;
        UNITY_TEXTURE_STREAMING_DEBUG_VARS;
        CBUFFER_END
        
        
        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        TEXTURE2D(_Color_Texture);
        SAMPLER(sampler_Color_Texture);
        TEXTURE2D(_Normal_Texture);
        SAMPLER(sampler_Normal_Texture);
        TEXTURE2D(_ORM_Texture);
        SAMPLER(sampler_ORM_Texture);
        TEXTURE2D(_Emissive_Texture);
        SAMPLER(sampler_Emissive_Texture);
        
        // Graph Includes
        // GraphIncludes: <None>
        
        // -- Property used by ScenePickingPass
        #ifdef SCENEPICKINGPASS
        float4 _SelectionID;
        #endif
        
        // -- Properties used by SceneSelectionPass
        #ifdef SCENESELECTIONPASS
        int _ObjectId;
        int _PassValue;
        #endif
        
        // Graph Functions
        // GraphFunctions: <None>
        
        // Custom interpolators pre vertex
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPreVertex' */
        
        // Graph Vertex
        struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
        };
        
        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            description.Position = IN.ObjectSpacePosition;
            description.Normal = IN.ObjectSpaceNormal;
            description.Tangent = IN.ObjectSpaceTangent;
            return description;
        }
        
        // Custom interpolators, pre surface
        #ifdef FEATURES_GRAPH_VERTEX
        Varyings CustomInterpolatorPassThroughFunc(inout Varyings output, VertexDescription input)
        {
        return output;
        }
        #define CUSTOMINTERPOLATOR_VARYPASSTHROUGH_FUNC
        #endif
        
        // Graph Pixel
        struct SurfaceDescription
        {
            float3 BaseColor;
            float Alpha;
            float AlphaClipThreshold;
        };
        
        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            UnityTexture2D _Property_29d95cca61c84013ba8453d2eba10e9a_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_Color_Texture);
            float4 _SampleTexture2D_1d46dbc4d51248578b3c5b19a9c762b6_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_29d95cca61c84013ba8453d2eba10e9a_Out_0_Texture2D.tex, _Property_29d95cca61c84013ba8453d2eba10e9a_Out_0_Texture2D.samplerstate, _Property_29d95cca61c84013ba8453d2eba10e9a_Out_0_Texture2D.GetTransformedUV(IN.uv0.xy) );
            float _SampleTexture2D_1d46dbc4d51248578b3c5b19a9c762b6_R_4_Float = _SampleTexture2D_1d46dbc4d51248578b3c5b19a9c762b6_RGBA_0_Vector4.r;
            float _SampleTexture2D_1d46dbc4d51248578b3c5b19a9c762b6_G_5_Float = _SampleTexture2D_1d46dbc4d51248578b3c5b19a9c762b6_RGBA_0_Vector4.g;
            float _SampleTexture2D_1d46dbc4d51248578b3c5b19a9c762b6_B_6_Float = _SampleTexture2D_1d46dbc4d51248578b3c5b19a9c762b6_RGBA_0_Vector4.b;
            float _SampleTexture2D_1d46dbc4d51248578b3c5b19a9c762b6_A_7_Float = _SampleTexture2D_1d46dbc4d51248578b3c5b19a9c762b6_RGBA_0_Vector4.a;
            UnityTexture2D _Property_8c9189612f044695b5e413fa751834bc_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_Color_Texture);
            float4 _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_8c9189612f044695b5e413fa751834bc_Out_0_Texture2D.tex, _Property_8c9189612f044695b5e413fa751834bc_Out_0_Texture2D.samplerstate, _Property_8c9189612f044695b5e413fa751834bc_Out_0_Texture2D.GetTransformedUV(IN.uv0.xy) );
            float _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_R_4_Float = _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_RGBA_0_Vector4.r;
            float _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_G_5_Float = _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_RGBA_0_Vector4.g;
            float _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_B_6_Float = _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_RGBA_0_Vector4.b;
            float _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_A_7_Float = _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_RGBA_0_Vector4.a;
            surface.BaseColor = (_SampleTexture2D_1d46dbc4d51248578b3c5b19a9c762b6_RGBA_0_Vector4.xyz);
            surface.Alpha = _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_A_7_Float;
            surface.AlphaClipThreshold = 0.5;
            return surface;
        }
        
        // --------------------------------------------------
        // Build Graph Inputs
        #ifdef HAVE_VFX_MODIFICATION
        #define VFX_SRP_ATTRIBUTES Attributes
        #define VFX_SRP_VARYINGS Varyings
        #define VFX_SRP_SURFACE_INPUTS SurfaceDescriptionInputs
        #endif
        VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);
        
            output.ObjectSpaceNormal =                          input.normalOS;
            output.ObjectSpaceTangent =                         input.tangentOS.xyz;
            output.ObjectSpacePosition =                        input.positionOS;
        #if UNITY_ANY_INSTANCING_ENABLED
        #else // TODO: XR support for procedural instancing because in this case UNITY_ANY_INSTANCING_ENABLED is not defined and instanceID is incorrect.
        #endif
        
            return output;
        }
        SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
        
        #ifdef HAVE_VFX_MODIFICATION
        #if VFX_USE_GRAPH_VALUES
            uint instanceActiveIndex = asuint(UNITY_ACCESS_INSTANCED_PROP(PerInstance, _InstanceActiveIndex));
            /* WARNING: $splice Could not find named fragment 'VFXLoadGraphValues' */
        #endif
            /* WARNING: $splice Could not find named fragment 'VFXSetFragInputs' */
        
        #endif
        
            
        
        
        
        
        
        
            #if UNITY_UV_STARTS_AT_TOP
            #else
            #endif
        
        
            output.uv0 = input.texCoord0;
        #if UNITY_ANY_INSTANCING_ENABLED
        #else // TODO: XR support for procedural instancing because in this case UNITY_ANY_INSTANCING_ENABLED is not defined and instanceID is incorrect.
        #endif
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
        #else
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        #endif
        #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        
                return output;
        }
        
        // --------------------------------------------------
        // Main
        
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/SelectionPickingPass.hlsl"
        
        // --------------------------------------------------
        // Visual Effect Vertex Invocations
        #ifdef HAVE_VFX_MODIFICATION
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/VisualEffectVertex.hlsl"
        #endif
        
        ENDHLSL
        }
        Pass
        {
            // Name: <None>
            Tags
            {
                "LightMode" = "Universal2D"
            }
        
        // Render State
        Cull [_Cull]
        Blend [_SrcBlend] [_DstBlend]
        ZTest [_ZTest]
        ZWrite [_ZWrite]
        
        // Debug
        // <None>
        
        // --------------------------------------------------
        // Pass
        
        HLSLPROGRAM
        
        // Pragmas
        #pragma target 2.0
        #pragma vertex vert
        #pragma fragment frag
        
        // Keywords
        #pragma shader_feature_local_fragment _ _ALPHATEST_ON
        // GraphKeywords: <None>
        
        // Defines
        
        #define _NORMALMAP 1
        #define _NORMAL_DROPOFF_TS 1
        #define ATTRIBUTES_NEED_NORMAL
        #define ATTRIBUTES_NEED_TANGENT
        #define ATTRIBUTES_NEED_TEXCOORD0
        #define FEATURES_GRAPH_VERTEX_NORMAL_OUTPUT
        #define FEATURES_GRAPH_VERTEX_TANGENT_OUTPUT
        #define VARYINGS_NEED_TEXCOORD0
        #define FEATURES_GRAPH_VERTEX
        /* WARNING: $splice Could not find named fragment 'PassInstancing' */
        #define SHADERPASS SHADERPASS_2D
        
        
        // custom interpolator pre-include
        /* WARNING: $splice Could not find named fragment 'sgci_CustomInterpolatorPreInclude' */
        
        // Includes
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Input.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
        #include_with_pragmas "Packages/com.unity.render-pipelines.core/ShaderLibrary/FoveatedRenderingKeywords.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/FoveatedRendering.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/DebugMipmapStreamingMacros.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
        
        // --------------------------------------------------
        // Structs and Packing
        
        // custom interpolators pre packing
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPrePacking' */
        
        struct Attributes
        {
             float3 positionOS : POSITION;
             float3 normalOS : NORMAL;
             float4 tangentOS : TANGENT;
             float4 uv0 : TEXCOORD0;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(ATTRIBUTES_NEED_INSTANCEID)
             uint instanceID : INSTANCEID_SEMANTIC;
            #endif
        };
        struct Varyings
        {
             float4 positionCS : SV_POSITION;
             float4 texCoord0;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        struct SurfaceDescriptionInputs
        {
             float4 uv0;
        };
        struct VertexDescriptionInputs
        {
             float3 ObjectSpaceNormal;
             float3 ObjectSpaceTangent;
             float3 ObjectSpacePosition;
        };
        struct PackedVaryings
        {
             float4 positionCS : SV_POSITION;
             float4 texCoord0 : INTERP0;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        
        PackedVaryings PackVaryings (Varyings input)
        {
            PackedVaryings output;
            ZERO_INITIALIZE(PackedVaryings, output);
            output.positionCS = input.positionCS;
            output.texCoord0.xyzw = input.texCoord0;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        
        Varyings UnpackVaryings (PackedVaryings input)
        {
            Varyings output;
            output.positionCS = input.positionCS;
            output.texCoord0 = input.texCoord0.xyzw;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        
        
        // --------------------------------------------------
        // Graph
        
        // Graph Properties
        CBUFFER_START(UnityPerMaterial)
        float4 _Color_Texture_TexelSize;
        float4 _Normal_Texture_TexelSize;
        float4 _ORM_Texture_TexelSize;
        float4 _Emissive_Texture_TexelSize;
        float _Emission;
        float _Param_Roughness;
        float _Param_Metalic;
        float _Param_AO;
        UNITY_TEXTURE_STREAMING_DEBUG_VARS;
        CBUFFER_END
        
        
        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        TEXTURE2D(_Color_Texture);
        SAMPLER(sampler_Color_Texture);
        TEXTURE2D(_Normal_Texture);
        SAMPLER(sampler_Normal_Texture);
        TEXTURE2D(_ORM_Texture);
        SAMPLER(sampler_ORM_Texture);
        TEXTURE2D(_Emissive_Texture);
        SAMPLER(sampler_Emissive_Texture);
        
        // Graph Includes
        // GraphIncludes: <None>
        
        // -- Property used by ScenePickingPass
        #ifdef SCENEPICKINGPASS
        float4 _SelectionID;
        #endif
        
        // -- Properties used by SceneSelectionPass
        #ifdef SCENESELECTIONPASS
        int _ObjectId;
        int _PassValue;
        #endif
        
        // Graph Functions
        // GraphFunctions: <None>
        
        // Custom interpolators pre vertex
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPreVertex' */
        
        // Graph Vertex
        struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
        };
        
        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            description.Position = IN.ObjectSpacePosition;
            description.Normal = IN.ObjectSpaceNormal;
            description.Tangent = IN.ObjectSpaceTangent;
            return description;
        }
        
        // Custom interpolators, pre surface
        #ifdef FEATURES_GRAPH_VERTEX
        Varyings CustomInterpolatorPassThroughFunc(inout Varyings output, VertexDescription input)
        {
        return output;
        }
        #define CUSTOMINTERPOLATOR_VARYPASSTHROUGH_FUNC
        #endif
        
        // Graph Pixel
        struct SurfaceDescription
        {
            float3 BaseColor;
            float Alpha;
            float AlphaClipThreshold;
        };
        
        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            UnityTexture2D _Property_29d95cca61c84013ba8453d2eba10e9a_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_Color_Texture);
            float4 _SampleTexture2D_1d46dbc4d51248578b3c5b19a9c762b6_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_29d95cca61c84013ba8453d2eba10e9a_Out_0_Texture2D.tex, _Property_29d95cca61c84013ba8453d2eba10e9a_Out_0_Texture2D.samplerstate, _Property_29d95cca61c84013ba8453d2eba10e9a_Out_0_Texture2D.GetTransformedUV(IN.uv0.xy) );
            float _SampleTexture2D_1d46dbc4d51248578b3c5b19a9c762b6_R_4_Float = _SampleTexture2D_1d46dbc4d51248578b3c5b19a9c762b6_RGBA_0_Vector4.r;
            float _SampleTexture2D_1d46dbc4d51248578b3c5b19a9c762b6_G_5_Float = _SampleTexture2D_1d46dbc4d51248578b3c5b19a9c762b6_RGBA_0_Vector4.g;
            float _SampleTexture2D_1d46dbc4d51248578b3c5b19a9c762b6_B_6_Float = _SampleTexture2D_1d46dbc4d51248578b3c5b19a9c762b6_RGBA_0_Vector4.b;
            float _SampleTexture2D_1d46dbc4d51248578b3c5b19a9c762b6_A_7_Float = _SampleTexture2D_1d46dbc4d51248578b3c5b19a9c762b6_RGBA_0_Vector4.a;
            UnityTexture2D _Property_8c9189612f044695b5e413fa751834bc_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_Color_Texture);
            float4 _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_8c9189612f044695b5e413fa751834bc_Out_0_Texture2D.tex, _Property_8c9189612f044695b5e413fa751834bc_Out_0_Texture2D.samplerstate, _Property_8c9189612f044695b5e413fa751834bc_Out_0_Texture2D.GetTransformedUV(IN.uv0.xy) );
            float _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_R_4_Float = _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_RGBA_0_Vector4.r;
            float _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_G_5_Float = _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_RGBA_0_Vector4.g;
            float _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_B_6_Float = _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_RGBA_0_Vector4.b;
            float _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_A_7_Float = _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_RGBA_0_Vector4.a;
            surface.BaseColor = (_SampleTexture2D_1d46dbc4d51248578b3c5b19a9c762b6_RGBA_0_Vector4.xyz);
            surface.Alpha = _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_A_7_Float;
            surface.AlphaClipThreshold = 0.5;
            return surface;
        }
        
        // --------------------------------------------------
        // Build Graph Inputs
        #ifdef HAVE_VFX_MODIFICATION
        #define VFX_SRP_ATTRIBUTES Attributes
        #define VFX_SRP_VARYINGS Varyings
        #define VFX_SRP_SURFACE_INPUTS SurfaceDescriptionInputs
        #endif
        VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);
        
            output.ObjectSpaceNormal =                          input.normalOS;
            output.ObjectSpaceTangent =                         input.tangentOS.xyz;
            output.ObjectSpacePosition =                        input.positionOS;
        #if UNITY_ANY_INSTANCING_ENABLED
        #else // TODO: XR support for procedural instancing because in this case UNITY_ANY_INSTANCING_ENABLED is not defined and instanceID is incorrect.
        #endif
        
            return output;
        }
        SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
        
        #ifdef HAVE_VFX_MODIFICATION
        #if VFX_USE_GRAPH_VALUES
            uint instanceActiveIndex = asuint(UNITY_ACCESS_INSTANCED_PROP(PerInstance, _InstanceActiveIndex));
            /* WARNING: $splice Could not find named fragment 'VFXLoadGraphValues' */
        #endif
            /* WARNING: $splice Could not find named fragment 'VFXSetFragInputs' */
        
        #endif
        
            
        
        
        
        
        
        
            #if UNITY_UV_STARTS_AT_TOP
            #else
            #endif
        
        
            output.uv0 = input.texCoord0;
        #if UNITY_ANY_INSTANCING_ENABLED
        #else // TODO: XR support for procedural instancing because in this case UNITY_ANY_INSTANCING_ENABLED is not defined and instanceID is incorrect.
        #endif
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
        #else
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        #endif
        #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        
                return output;
        }
        
        // --------------------------------------------------
        // Main
        
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/PBR2DPass.hlsl"
        
        // --------------------------------------------------
        // Visual Effect Vertex Invocations
        #ifdef HAVE_VFX_MODIFICATION
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/VisualEffectVertex.hlsl"
        #endif
        
        ENDHLSL
        }
    }
    SubShader
    {
        Tags
        {
            // RenderPipeline: <None>
            "RenderType"="Opaque"
            "BuiltInMaterialType" = "Lit"
            "Queue"="Geometry"
            // DisableBatching: <None>
            "ShaderGraphShader"="true"
            "ShaderGraphTargetId"="BuiltInLitSubTarget"
        }
        Pass
        {
            Name "BuiltIn Forward"
            Tags
            {
                "LightMode" = "ForwardBase"
            }
        
        // Render State
        Cull [_BUILTIN_CullMode]
        Blend [_BUILTIN_SrcBlend] [_BUILTIN_DstBlend]
        ZTest [_BUILTIN_ZTest]
        ZWrite [_BUILTIN_ZWrite]
        
        // Debug
        // <None>
        
        // --------------------------------------------------
        // Pass
        
        HLSLPROGRAM
        
        // Pragmas
        #pragma target 3.0
        #pragma multi_compile_instancing
        #pragma multi_compile_fog
        #pragma multi_compile_fwdbase
        #pragma vertex vert
        #pragma fragment frag
        
        // Keywords
        #pragma multi_compile _ _SCREEN_SPACE_OCCLUSION
        #pragma multi_compile _ LIGHTMAP_ON
        #pragma multi_compile _ DIRLIGHTMAP_COMBINED
        #pragma multi_compile _ _MAIN_LIGHT_SHADOWS _MAIN_LIGHT_SHADOWS_CASCADE _MAIN_LIGHT_SHADOWS_SCREEN
        #pragma multi_compile _ADDITIONAL_LIGHTS_VERTEX _ADDITIONAL_LIGHTS _ADDITIONAL_OFF
        #pragma multi_compile _ _ADDITIONAL_LIGHT_SHADOWS
        #pragma multi_compile _ _SHADOWS_SOFT
        #pragma multi_compile _ LIGHTMAP_SHADOW_MIXING
        #pragma multi_compile _ SHADOWS_SHADOWMASK
        #pragma shader_feature_local_fragment _ _BUILTIN_SURFACE_TYPE_TRANSPARENT
        #pragma shader_feature_local_fragment _ _BUILTIN_ALPHAPREMULTIPLY_ON
        #pragma shader_feature_local_fragment _ _BUILTIN_AlphaClip
        #pragma shader_feature_local_fragment _ _BUILTIN_ALPHATEST_ON
        // GraphKeywords: <None>
        
        // Defines
        #define _NORMALMAP 1
        #define _NORMAL_DROPOFF_TS 1
        #define ATTRIBUTES_NEED_NORMAL
        #define ATTRIBUTES_NEED_TANGENT
        #define ATTRIBUTES_NEED_TEXCOORD0
        #define ATTRIBUTES_NEED_TEXCOORD1
        #define VARYINGS_NEED_POSITION_WS
        #define VARYINGS_NEED_NORMAL_WS
        #define VARYINGS_NEED_TANGENT_WS
        #define VARYINGS_NEED_TEXCOORD0
        #define VARYINGS_NEED_FOG_AND_VERTEX_LIGHT
        #define FEATURES_GRAPH_VERTEX
        /* WARNING: $splice Could not find named fragment 'PassInstancing' */
        #define SHADERPASS SHADERPASS_FORWARD
        #define BUILTIN_TARGET_API 1
        #ifdef _BUILTIN_SURFACE_TYPE_TRANSPARENT
        #define _SURFACE_TYPE_TRANSPARENT _BUILTIN_SURFACE_TYPE_TRANSPARENT
        #endif
        #ifdef _BUILTIN_ALPHATEST_ON
        #define _ALPHATEST_ON _BUILTIN_ALPHATEST_ON
        #endif
        #ifdef _BUILTIN_AlphaClip
        #define _AlphaClip _BUILTIN_AlphaClip
        #endif
        #ifdef _BUILTIN_ALPHAPREMULTIPLY_ON
        #define _ALPHAPREMULTIPLY_ON _BUILTIN_ALPHAPREMULTIPLY_ON
        #endif
        
        
        // custom interpolator pre-include
        /* WARNING: $splice Could not find named fragment 'sgci_CustomInterpolatorPreInclude' */
        
        // Includes
        #include "Packages/com.unity.shadergraph/Editor/Generation/Targets/BuiltIn/ShaderLibrary/Shim/Shims.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
        #include "Packages/com.unity.shadergraph/Editor/Generation/Targets/BuiltIn/ShaderLibrary/Core.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
        #include "Packages/com.unity.shadergraph/Editor/Generation/Targets/BuiltIn/ShaderLibrary/Lighting.hlsl"
        #include "Packages/com.unity.shadergraph/Editor/Generation/Targets/BuiltIn/Editor/ShaderGraph/Includes/LegacySurfaceVertex.hlsl"
        #include "Packages/com.unity.shadergraph/Editor/Generation/Targets/BuiltIn/ShaderLibrary/ShaderGraphFunctions.hlsl"
        
        // --------------------------------------------------
        // Structs and Packing
        
        // custom interpolators pre packing
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPrePacking' */
        
        struct Attributes
        {
             float3 positionOS : POSITION;
             float3 normalOS : NORMAL;
             float4 tangentOS : TANGENT;
             float4 uv0 : TEXCOORD0;
             float4 uv1 : TEXCOORD1;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(ATTRIBUTES_NEED_INSTANCEID)
             uint instanceID : INSTANCEID_SEMANTIC;
            #endif
        };
        struct Varyings
        {
             float4 positionCS : SV_POSITION;
             float3 positionWS;
             float3 normalWS;
             float4 tangentWS;
             float4 texCoord0;
            #if defined(LIGHTMAP_ON)
             float2 lightmapUV;
            #endif
            #if !defined(LIGHTMAP_ON)
             float3 sh;
            #endif
             float4 fogFactorAndVertexLight;
             float4 shadowCoord;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        struct SurfaceDescriptionInputs
        {
             float3 TangentSpaceNormal;
             float4 uv0;
        };
        struct VertexDescriptionInputs
        {
             float3 ObjectSpaceNormal;
             float3 ObjectSpaceTangent;
             float3 ObjectSpacePosition;
        };
        struct PackedVaryings
        {
             float4 positionCS : SV_POSITION;
            #if defined(LIGHTMAP_ON)
             float2 lightmapUV : INTERP0;
            #endif
            #if !defined(LIGHTMAP_ON)
             float3 sh : INTERP1;
            #endif
             float4 tangentWS : INTERP2;
             float4 texCoord0 : INTERP3;
             float4 fogFactorAndVertexLight : INTERP4;
             float4 shadowCoord : INTERP5;
             float3 positionWS : INTERP6;
             float3 normalWS : INTERP7;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        
        PackedVaryings PackVaryings (Varyings input)
        {
            PackedVaryings output;
            ZERO_INITIALIZE(PackedVaryings, output);
            output.positionCS = input.positionCS;
            #if defined(LIGHTMAP_ON)
            output.lightmapUV = input.lightmapUV;
            #endif
            #if !defined(LIGHTMAP_ON)
            output.sh = input.sh;
            #endif
            output.tangentWS.xyzw = input.tangentWS;
            output.texCoord0.xyzw = input.texCoord0;
            output.fogFactorAndVertexLight.xyzw = input.fogFactorAndVertexLight;
            output.shadowCoord.xyzw = input.shadowCoord;
            output.positionWS.xyz = input.positionWS;
            output.normalWS.xyz = input.normalWS;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        
        Varyings UnpackVaryings (PackedVaryings input)
        {
            Varyings output;
            output.positionCS = input.positionCS;
            #if defined(LIGHTMAP_ON)
            output.lightmapUV = input.lightmapUV;
            #endif
            #if !defined(LIGHTMAP_ON)
            output.sh = input.sh;
            #endif
            output.tangentWS = input.tangentWS.xyzw;
            output.texCoord0 = input.texCoord0.xyzw;
            output.fogFactorAndVertexLight = input.fogFactorAndVertexLight.xyzw;
            output.shadowCoord = input.shadowCoord.xyzw;
            output.positionWS = input.positionWS.xyz;
            output.normalWS = input.normalWS.xyz;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        
        
        // --------------------------------------------------
        // Graph
        
        // Graph Properties
        CBUFFER_START(UnityPerMaterial)
        float4 _Color_Texture_TexelSize;
        float4 _Normal_Texture_TexelSize;
        float4 _ORM_Texture_TexelSize;
        float4 _Emissive_Texture_TexelSize;
        float _Emission;
        float _Param_Roughness;
        float _Param_Metalic;
        float _Param_AO;
        CBUFFER_END
        
        
        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        TEXTURE2D(_Color_Texture);
        SAMPLER(sampler_Color_Texture);
        TEXTURE2D(_Normal_Texture);
        SAMPLER(sampler_Normal_Texture);
        TEXTURE2D(_ORM_Texture);
        SAMPLER(sampler_ORM_Texture);
        TEXTURE2D(_Emissive_Texture);
        SAMPLER(sampler_Emissive_Texture);
        
        // -- Property used by ScenePickingPass
        #ifdef SCENEPICKINGPASS
        float4 _SelectionID;
        #endif
        
        // -- Properties used by SceneSelectionPass
        #ifdef SCENESELECTIONPASS
        int _ObjectId;
        int _PassValue;
        #endif
        
        // Graph Includes
        // GraphIncludes: <None>
        
        // Graph Functions
        
        void Unity_Branch_float4(float Predicate, float4 True, float4 False, out float4 Out)
        {
            Out = Predicate ? True : False;
        }
        
        void Unity_Multiply_float_float(float A, float B, out float Out)
        {
            Out = A * B;
        }
        
        void Unity_OneMinus_float(float In, out float Out)
        {
            Out = 1 - In;
        }
        
        // Custom interpolators pre vertex
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPreVertex' */
        
        // Graph Vertex
        struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
        };
        
        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            description.Position = IN.ObjectSpacePosition;
            description.Normal = IN.ObjectSpaceNormal;
            description.Tangent = IN.ObjectSpaceTangent;
            return description;
        }
        
        // Custom interpolators, pre surface
        #ifdef FEATURES_GRAPH_VERTEX
        Varyings CustomInterpolatorPassThroughFunc(inout Varyings output, VertexDescription input)
        {
        return output;
        }
        #define CUSTOMINTERPOLATOR_VARYPASSTHROUGH_FUNC
        #endif
        
        // Graph Pixel
        struct SurfaceDescription
        {
            float3 BaseColor;
            float3 NormalTS;
            float3 Emission;
            float Metallic;
            float Smoothness;
            float Occlusion;
            float Alpha;
            float AlphaClipThreshold;
        };
        
        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            UnityTexture2D _Property_29d95cca61c84013ba8453d2eba10e9a_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_Color_Texture);
            float4 _SampleTexture2D_1d46dbc4d51248578b3c5b19a9c762b6_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_29d95cca61c84013ba8453d2eba10e9a_Out_0_Texture2D.tex, _Property_29d95cca61c84013ba8453d2eba10e9a_Out_0_Texture2D.samplerstate, _Property_29d95cca61c84013ba8453d2eba10e9a_Out_0_Texture2D.GetTransformedUV(IN.uv0.xy) );
            float _SampleTexture2D_1d46dbc4d51248578b3c5b19a9c762b6_R_4_Float = _SampleTexture2D_1d46dbc4d51248578b3c5b19a9c762b6_RGBA_0_Vector4.r;
            float _SampleTexture2D_1d46dbc4d51248578b3c5b19a9c762b6_G_5_Float = _SampleTexture2D_1d46dbc4d51248578b3c5b19a9c762b6_RGBA_0_Vector4.g;
            float _SampleTexture2D_1d46dbc4d51248578b3c5b19a9c762b6_B_6_Float = _SampleTexture2D_1d46dbc4d51248578b3c5b19a9c762b6_RGBA_0_Vector4.b;
            float _SampleTexture2D_1d46dbc4d51248578b3c5b19a9c762b6_A_7_Float = _SampleTexture2D_1d46dbc4d51248578b3c5b19a9c762b6_RGBA_0_Vector4.a;
            UnityTexture2D _Property_43d6b361960241fa85238beaa18eaee7_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_Normal_Texture);
            float4 _SampleTexture2D_850c7807224247dcb806755ff839cbee_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_43d6b361960241fa85238beaa18eaee7_Out_0_Texture2D.tex, _Property_43d6b361960241fa85238beaa18eaee7_Out_0_Texture2D.samplerstate, _Property_43d6b361960241fa85238beaa18eaee7_Out_0_Texture2D.GetTransformedUV(IN.uv0.xy) );
            _SampleTexture2D_850c7807224247dcb806755ff839cbee_RGBA_0_Vector4.rgb = UnpackNormal(_SampleTexture2D_850c7807224247dcb806755ff839cbee_RGBA_0_Vector4);
            float _SampleTexture2D_850c7807224247dcb806755ff839cbee_R_4_Float = _SampleTexture2D_850c7807224247dcb806755ff839cbee_RGBA_0_Vector4.r;
            float _SampleTexture2D_850c7807224247dcb806755ff839cbee_G_5_Float = _SampleTexture2D_850c7807224247dcb806755ff839cbee_RGBA_0_Vector4.g;
            float _SampleTexture2D_850c7807224247dcb806755ff839cbee_B_6_Float = _SampleTexture2D_850c7807224247dcb806755ff839cbee_RGBA_0_Vector4.b;
            float _SampleTexture2D_850c7807224247dcb806755ff839cbee_A_7_Float = _SampleTexture2D_850c7807224247dcb806755ff839cbee_RGBA_0_Vector4.a;
            float _Property_17ea8ffc961b4ffd871836de5084ef86_Out_0_Boolean = _Emission;
            UnityTexture2D _Property_411dbbb2322442ebba4716107ea863fe_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_Emissive_Texture);
            float4 _SampleTexture2D_a57be8c4d236480f8104751aa7f681ab_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_411dbbb2322442ebba4716107ea863fe_Out_0_Texture2D.tex, _Property_411dbbb2322442ebba4716107ea863fe_Out_0_Texture2D.samplerstate, _Property_411dbbb2322442ebba4716107ea863fe_Out_0_Texture2D.GetTransformedUV(IN.uv0.xy) );
            float _SampleTexture2D_a57be8c4d236480f8104751aa7f681ab_R_4_Float = _SampleTexture2D_a57be8c4d236480f8104751aa7f681ab_RGBA_0_Vector4.r;
            float _SampleTexture2D_a57be8c4d236480f8104751aa7f681ab_G_5_Float = _SampleTexture2D_a57be8c4d236480f8104751aa7f681ab_RGBA_0_Vector4.g;
            float _SampleTexture2D_a57be8c4d236480f8104751aa7f681ab_B_6_Float = _SampleTexture2D_a57be8c4d236480f8104751aa7f681ab_RGBA_0_Vector4.b;
            float _SampleTexture2D_a57be8c4d236480f8104751aa7f681ab_A_7_Float = _SampleTexture2D_a57be8c4d236480f8104751aa7f681ab_RGBA_0_Vector4.a;
            float4 _Branch_45ebf603e9cf4ff3a4a6dbcc35b2c9e5_Out_3_Vector4;
            Unity_Branch_float4(_Property_17ea8ffc961b4ffd871836de5084ef86_Out_0_Boolean, _SampleTexture2D_a57be8c4d236480f8104751aa7f681ab_RGBA_0_Vector4, float4(0, 0, 0, 0), _Branch_45ebf603e9cf4ff3a4a6dbcc35b2c9e5_Out_3_Vector4);
            float _Property_e541f47f17b54763be002613df4e2428_Out_0_Float = _Param_Metalic;
            UnityTexture2D _Property_c819d15f02ab4493881e69c5685e980c_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_ORM_Texture);
            float4 _SampleTexture2D_f5e041739c8a4db594a428363896e97b_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_c819d15f02ab4493881e69c5685e980c_Out_0_Texture2D.tex, _Property_c819d15f02ab4493881e69c5685e980c_Out_0_Texture2D.samplerstate, _Property_c819d15f02ab4493881e69c5685e980c_Out_0_Texture2D.GetTransformedUV(IN.uv0.xy) );
            float _SampleTexture2D_f5e041739c8a4db594a428363896e97b_R_4_Float = _SampleTexture2D_f5e041739c8a4db594a428363896e97b_RGBA_0_Vector4.r;
            float _SampleTexture2D_f5e041739c8a4db594a428363896e97b_G_5_Float = _SampleTexture2D_f5e041739c8a4db594a428363896e97b_RGBA_0_Vector4.g;
            float _SampleTexture2D_f5e041739c8a4db594a428363896e97b_B_6_Float = _SampleTexture2D_f5e041739c8a4db594a428363896e97b_RGBA_0_Vector4.b;
            float _SampleTexture2D_f5e041739c8a4db594a428363896e97b_A_7_Float = _SampleTexture2D_f5e041739c8a4db594a428363896e97b_RGBA_0_Vector4.a;
            float _Multiply_329695002f9a4b7b953f2aa60124e02e_Out_2_Float;
            Unity_Multiply_float_float(_Property_e541f47f17b54763be002613df4e2428_Out_0_Float, _SampleTexture2D_f5e041739c8a4db594a428363896e97b_B_6_Float, _Multiply_329695002f9a4b7b953f2aa60124e02e_Out_2_Float);
            float _Property_6c57147c2e7c495ea1738f9c8e64529c_Out_0_Float = _Param_Roughness;
            UnityTexture2D _Property_1356c63c0d7e43a687e350a9f46377b7_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_ORM_Texture);
            float4 _SampleTexture2D_e90300966fdc464b97b573e644b4d54e_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_1356c63c0d7e43a687e350a9f46377b7_Out_0_Texture2D.tex, _Property_1356c63c0d7e43a687e350a9f46377b7_Out_0_Texture2D.samplerstate, _Property_1356c63c0d7e43a687e350a9f46377b7_Out_0_Texture2D.GetTransformedUV(IN.uv0.xy) );
            float _SampleTexture2D_e90300966fdc464b97b573e644b4d54e_R_4_Float = _SampleTexture2D_e90300966fdc464b97b573e644b4d54e_RGBA_0_Vector4.r;
            float _SampleTexture2D_e90300966fdc464b97b573e644b4d54e_G_5_Float = _SampleTexture2D_e90300966fdc464b97b573e644b4d54e_RGBA_0_Vector4.g;
            float _SampleTexture2D_e90300966fdc464b97b573e644b4d54e_B_6_Float = _SampleTexture2D_e90300966fdc464b97b573e644b4d54e_RGBA_0_Vector4.b;
            float _SampleTexture2D_e90300966fdc464b97b573e644b4d54e_A_7_Float = _SampleTexture2D_e90300966fdc464b97b573e644b4d54e_RGBA_0_Vector4.a;
            float _OneMinus_d33f5143a8f9425dbab28c41060c3228_Out_1_Float;
            Unity_OneMinus_float(_SampleTexture2D_e90300966fdc464b97b573e644b4d54e_G_5_Float, _OneMinus_d33f5143a8f9425dbab28c41060c3228_Out_1_Float);
            float _Multiply_7f595a9eb4fd414a91e0ff1327f32f3e_Out_2_Float;
            Unity_Multiply_float_float(_Property_6c57147c2e7c495ea1738f9c8e64529c_Out_0_Float, _OneMinus_d33f5143a8f9425dbab28c41060c3228_Out_1_Float, _Multiply_7f595a9eb4fd414a91e0ff1327f32f3e_Out_2_Float);
            float _Property_2d439fd022cd4b8da84a9a675029227b_Out_0_Float = _Param_AO;
            UnityTexture2D _Property_96ae0bdba5a642d19e3ff9e8ed5f8028_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_ORM_Texture);
            float4 _SampleTexture2D_18c326b7c2674546a72d722f47fa6532_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_96ae0bdba5a642d19e3ff9e8ed5f8028_Out_0_Texture2D.tex, _Property_96ae0bdba5a642d19e3ff9e8ed5f8028_Out_0_Texture2D.samplerstate, _Property_96ae0bdba5a642d19e3ff9e8ed5f8028_Out_0_Texture2D.GetTransformedUV(IN.uv0.xy) );
            float _SampleTexture2D_18c326b7c2674546a72d722f47fa6532_R_4_Float = _SampleTexture2D_18c326b7c2674546a72d722f47fa6532_RGBA_0_Vector4.r;
            float _SampleTexture2D_18c326b7c2674546a72d722f47fa6532_G_5_Float = _SampleTexture2D_18c326b7c2674546a72d722f47fa6532_RGBA_0_Vector4.g;
            float _SampleTexture2D_18c326b7c2674546a72d722f47fa6532_B_6_Float = _SampleTexture2D_18c326b7c2674546a72d722f47fa6532_RGBA_0_Vector4.b;
            float _SampleTexture2D_18c326b7c2674546a72d722f47fa6532_A_7_Float = _SampleTexture2D_18c326b7c2674546a72d722f47fa6532_RGBA_0_Vector4.a;
            float _Multiply_2bb5981ec276444eacb16af51e6f9a4b_Out_2_Float;
            Unity_Multiply_float_float(_Property_2d439fd022cd4b8da84a9a675029227b_Out_0_Float, _SampleTexture2D_18c326b7c2674546a72d722f47fa6532_R_4_Float, _Multiply_2bb5981ec276444eacb16af51e6f9a4b_Out_2_Float);
            UnityTexture2D _Property_8c9189612f044695b5e413fa751834bc_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_Color_Texture);
            float4 _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_8c9189612f044695b5e413fa751834bc_Out_0_Texture2D.tex, _Property_8c9189612f044695b5e413fa751834bc_Out_0_Texture2D.samplerstate, _Property_8c9189612f044695b5e413fa751834bc_Out_0_Texture2D.GetTransformedUV(IN.uv0.xy) );
            float _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_R_4_Float = _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_RGBA_0_Vector4.r;
            float _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_G_5_Float = _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_RGBA_0_Vector4.g;
            float _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_B_6_Float = _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_RGBA_0_Vector4.b;
            float _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_A_7_Float = _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_RGBA_0_Vector4.a;
            surface.BaseColor = (_SampleTexture2D_1d46dbc4d51248578b3c5b19a9c762b6_RGBA_0_Vector4.xyz);
            surface.NormalTS = (_SampleTexture2D_850c7807224247dcb806755ff839cbee_RGBA_0_Vector4.xyz);
            surface.Emission = (_Branch_45ebf603e9cf4ff3a4a6dbcc35b2c9e5_Out_3_Vector4.xyz);
            surface.Metallic = _Multiply_329695002f9a4b7b953f2aa60124e02e_Out_2_Float;
            surface.Smoothness = _Multiply_7f595a9eb4fd414a91e0ff1327f32f3e_Out_2_Float;
            surface.Occlusion = _Multiply_2bb5981ec276444eacb16af51e6f9a4b_Out_2_Float;
            surface.Alpha = _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_A_7_Float;
            surface.AlphaClipThreshold = 0.5;
            return surface;
        }
        
        // --------------------------------------------------
        // Build Graph Inputs
        
        VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);
        
            output.ObjectSpaceNormal =                          input.normalOS;
            output.ObjectSpaceTangent =                         input.tangentOS.xyz;
            output.ObjectSpacePosition =                        input.positionOS;
        #if UNITY_ANY_INSTANCING_ENABLED
        #else // TODO: XR support for procedural instancing because in this case UNITY_ANY_INSTANCING_ENABLED is not defined and instanceID is incorrect.
        #endif
        
            return output;
        }
        SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
        
            
        
        
        
            output.TangentSpaceNormal = float3(0.0f, 0.0f, 1.0f);
        
        
        
            #if UNITY_UV_STARTS_AT_TOP
            #else
            #endif
        
        
            output.uv0 = input.texCoord0;
        #if UNITY_ANY_INSTANCING_ENABLED
        #else // TODO: XR support for procedural instancing because in this case UNITY_ANY_INSTANCING_ENABLED is not defined and instanceID is incorrect.
        #endif
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
        #else
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        #endif
        #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        
                return output;
        }
        
        void BuildAppDataFull(Attributes attributes, VertexDescription vertexDescription, inout appdata_full result)
        {
            result.vertex     = float4(attributes.positionOS, 1);
            result.tangent    = attributes.tangentOS;
            result.normal     = attributes.normalOS;
            result.texcoord   = attributes.uv0;
            result.texcoord1  = attributes.uv1;
            result.vertex     = float4(vertexDescription.Position, 1);
            result.normal     = vertexDescription.Normal;
            result.tangent    = float4(vertexDescription.Tangent, 0);
            #if UNITY_ANY_INSTANCING_ENABLED
            #endif
        }
        
        void VaryingsToSurfaceVertex(Varyings varyings, inout v2f_surf result)
        {
            result.pos = varyings.positionCS;
            result.worldPos = varyings.positionWS;
            result.worldNormal = varyings.normalWS;
            // World Tangent isn't an available input on v2f_surf
        
            result._ShadowCoord = varyings.shadowCoord;
        
            #if UNITY_ANY_INSTANCING_ENABLED
            #endif
            #if UNITY_SHOULD_SAMPLE_SH
            #if !defined(LIGHTMAP_ON)
            result.sh = varyings.sh;
            #endif
            #endif
            #if defined(LIGHTMAP_ON)
            result.lmap.xy = varyings.lightmapUV;
            #endif
            #ifdef VARYINGS_NEED_FOG_AND_VERTEX_LIGHT
                result.fogCoord = varyings.fogFactorAndVertexLight.x;
                COPY_TO_LIGHT_COORDS(result, varyings.fogFactorAndVertexLight.yzw);
            #endif
        
            DEFAULT_UNITY_TRANSFER_VERTEX_OUTPUT_STEREO(varyings, result);
        }
        
        void SurfaceVertexToVaryings(v2f_surf surfVertex, inout Varyings result)
        {
            result.positionCS = surfVertex.pos;
            result.positionWS = surfVertex.worldPos;
            result.normalWS = surfVertex.worldNormal;
            // viewDirectionWS is never filled out in the legacy pass' function. Always use the value computed by SRP
            // World Tangent isn't an available input on v2f_surf
            result.shadowCoord = surfVertex._ShadowCoord;
        
            #if UNITY_ANY_INSTANCING_ENABLED
            #endif
            #if UNITY_SHOULD_SAMPLE_SH
            #if !defined(LIGHTMAP_ON)
            result.sh = surfVertex.sh;
            #endif
            #endif
            #if defined(LIGHTMAP_ON)
            result.lightmapUV = surfVertex.lmap.xy;
            #endif
            #ifdef VARYINGS_NEED_FOG_AND_VERTEX_LIGHT
                result.fogFactorAndVertexLight.x = surfVertex.fogCoord;
                COPY_FROM_LIGHT_COORDS(result.fogFactorAndVertexLight.yzw, surfVertex);
            #endif
        
            DEFAULT_UNITY_TRANSFER_VERTEX_OUTPUT_STEREO(surfVertex, result);
        }
        
        // --------------------------------------------------
        // Main
        
        #include "Packages/com.unity.shadergraph/Editor/Generation/Targets/BuiltIn/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
        #include "Packages/com.unity.shadergraph/Editor/Generation/Targets/BuiltIn/Editor/ShaderGraph/Includes/Varyings.hlsl"
        #include "Packages/com.unity.shadergraph/Editor/Generation/Targets/BuiltIn/Editor/ShaderGraph/Includes/PBRForwardPass.hlsl"
        
        ENDHLSL
        }
        Pass
        {
            Name "BuiltIn ForwardAdd"
            Tags
            {
                "LightMode" = "ForwardAdd"
            }
        
        // Render State
        Blend SrcAlpha One, One One
        ZWrite Off
        
        // Debug
        // <None>
        
        // --------------------------------------------------
        // Pass
        
        HLSLPROGRAM
        
        // Pragmas
        #pragma target 3.0
        #pragma multi_compile_instancing
        #pragma multi_compile_fog
        #pragma multi_compile_fwdadd_fullshadows
        #pragma vertex vert
        #pragma fragment frag
        
        // Keywords
        #pragma multi_compile _ _SCREEN_SPACE_OCCLUSION
        #pragma multi_compile _ LIGHTMAP_ON
        #pragma multi_compile _ DIRLIGHTMAP_COMBINED
        #pragma multi_compile _ _MAIN_LIGHT_SHADOWS _MAIN_LIGHT_SHADOWS_CASCADE _MAIN_LIGHT_SHADOWS_SCREEN
        #pragma multi_compile _ADDITIONAL_LIGHTS_VERTEX _ADDITIONAL_LIGHTS _ADDITIONAL_OFF
        #pragma multi_compile _ _ADDITIONAL_LIGHT_SHADOWS
        #pragma multi_compile _ _SHADOWS_SOFT
        #pragma multi_compile _ LIGHTMAP_SHADOW_MIXING
        #pragma multi_compile _ SHADOWS_SHADOWMASK
        #pragma shader_feature_local_fragment _ _BUILTIN_SURFACE_TYPE_TRANSPARENT
        #pragma shader_feature_local_fragment _ _BUILTIN_AlphaClip
        #pragma shader_feature_local_fragment _ _BUILTIN_ALPHATEST_ON
        // GraphKeywords: <None>
        
        // Defines
        #define _NORMALMAP 1
        #define _NORMAL_DROPOFF_TS 1
        #define ATTRIBUTES_NEED_NORMAL
        #define ATTRIBUTES_NEED_TANGENT
        #define ATTRIBUTES_NEED_TEXCOORD0
        #define ATTRIBUTES_NEED_TEXCOORD1
        #define VARYINGS_NEED_POSITION_WS
        #define VARYINGS_NEED_NORMAL_WS
        #define VARYINGS_NEED_TANGENT_WS
        #define VARYINGS_NEED_TEXCOORD0
        #define VARYINGS_NEED_FOG_AND_VERTEX_LIGHT
        #define FEATURES_GRAPH_VERTEX
        /* WARNING: $splice Could not find named fragment 'PassInstancing' */
        #define SHADERPASS SHADERPASS_FORWARD_ADD
        #define BUILTIN_TARGET_API 1
        #ifdef _BUILTIN_SURFACE_TYPE_TRANSPARENT
        #define _SURFACE_TYPE_TRANSPARENT _BUILTIN_SURFACE_TYPE_TRANSPARENT
        #endif
        #ifdef _BUILTIN_ALPHATEST_ON
        #define _ALPHATEST_ON _BUILTIN_ALPHATEST_ON
        #endif
        #ifdef _BUILTIN_AlphaClip
        #define _AlphaClip _BUILTIN_AlphaClip
        #endif
        #ifdef _BUILTIN_ALPHAPREMULTIPLY_ON
        #define _ALPHAPREMULTIPLY_ON _BUILTIN_ALPHAPREMULTIPLY_ON
        #endif
        
        
        // custom interpolator pre-include
        /* WARNING: $splice Could not find named fragment 'sgci_CustomInterpolatorPreInclude' */
        
        // Includes
        #include "Packages/com.unity.shadergraph/Editor/Generation/Targets/BuiltIn/ShaderLibrary/Shim/Shims.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
        #include "Packages/com.unity.shadergraph/Editor/Generation/Targets/BuiltIn/ShaderLibrary/Core.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
        #include "Packages/com.unity.shadergraph/Editor/Generation/Targets/BuiltIn/ShaderLibrary/Lighting.hlsl"
        #include "Packages/com.unity.shadergraph/Editor/Generation/Targets/BuiltIn/Editor/ShaderGraph/Includes/LegacySurfaceVertex.hlsl"
        #include "Packages/com.unity.shadergraph/Editor/Generation/Targets/BuiltIn/ShaderLibrary/ShaderGraphFunctions.hlsl"
        
        // --------------------------------------------------
        // Structs and Packing
        
        // custom interpolators pre packing
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPrePacking' */
        
        struct Attributes
        {
             float3 positionOS : POSITION;
             float3 normalOS : NORMAL;
             float4 tangentOS : TANGENT;
             float4 uv0 : TEXCOORD0;
             float4 uv1 : TEXCOORD1;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(ATTRIBUTES_NEED_INSTANCEID)
             uint instanceID : INSTANCEID_SEMANTIC;
            #endif
        };
        struct Varyings
        {
             float4 positionCS : SV_POSITION;
             float3 positionWS;
             float3 normalWS;
             float4 tangentWS;
             float4 texCoord0;
            #if defined(LIGHTMAP_ON)
             float2 lightmapUV;
            #endif
            #if !defined(LIGHTMAP_ON)
             float3 sh;
            #endif
             float4 fogFactorAndVertexLight;
             float4 shadowCoord;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        struct SurfaceDescriptionInputs
        {
             float3 TangentSpaceNormal;
             float4 uv0;
        };
        struct VertexDescriptionInputs
        {
             float3 ObjectSpaceNormal;
             float3 ObjectSpaceTangent;
             float3 ObjectSpacePosition;
        };
        struct PackedVaryings
        {
             float4 positionCS : SV_POSITION;
            #if defined(LIGHTMAP_ON)
             float2 lightmapUV : INTERP0;
            #endif
            #if !defined(LIGHTMAP_ON)
             float3 sh : INTERP1;
            #endif
             float4 tangentWS : INTERP2;
             float4 texCoord0 : INTERP3;
             float4 fogFactorAndVertexLight : INTERP4;
             float4 shadowCoord : INTERP5;
             float3 positionWS : INTERP6;
             float3 normalWS : INTERP7;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        
        PackedVaryings PackVaryings (Varyings input)
        {
            PackedVaryings output;
            ZERO_INITIALIZE(PackedVaryings, output);
            output.positionCS = input.positionCS;
            #if defined(LIGHTMAP_ON)
            output.lightmapUV = input.lightmapUV;
            #endif
            #if !defined(LIGHTMAP_ON)
            output.sh = input.sh;
            #endif
            output.tangentWS.xyzw = input.tangentWS;
            output.texCoord0.xyzw = input.texCoord0;
            output.fogFactorAndVertexLight.xyzw = input.fogFactorAndVertexLight;
            output.shadowCoord.xyzw = input.shadowCoord;
            output.positionWS.xyz = input.positionWS;
            output.normalWS.xyz = input.normalWS;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        
        Varyings UnpackVaryings (PackedVaryings input)
        {
            Varyings output;
            output.positionCS = input.positionCS;
            #if defined(LIGHTMAP_ON)
            output.lightmapUV = input.lightmapUV;
            #endif
            #if !defined(LIGHTMAP_ON)
            output.sh = input.sh;
            #endif
            output.tangentWS = input.tangentWS.xyzw;
            output.texCoord0 = input.texCoord0.xyzw;
            output.fogFactorAndVertexLight = input.fogFactorAndVertexLight.xyzw;
            output.shadowCoord = input.shadowCoord.xyzw;
            output.positionWS = input.positionWS.xyz;
            output.normalWS = input.normalWS.xyz;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        
        
        // --------------------------------------------------
        // Graph
        
        // Graph Properties
        CBUFFER_START(UnityPerMaterial)
        float4 _Color_Texture_TexelSize;
        float4 _Normal_Texture_TexelSize;
        float4 _ORM_Texture_TexelSize;
        float4 _Emissive_Texture_TexelSize;
        float _Emission;
        float _Param_Roughness;
        float _Param_Metalic;
        float _Param_AO;
        CBUFFER_END
        
        
        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        TEXTURE2D(_Color_Texture);
        SAMPLER(sampler_Color_Texture);
        TEXTURE2D(_Normal_Texture);
        SAMPLER(sampler_Normal_Texture);
        TEXTURE2D(_ORM_Texture);
        SAMPLER(sampler_ORM_Texture);
        TEXTURE2D(_Emissive_Texture);
        SAMPLER(sampler_Emissive_Texture);
        
        // -- Property used by ScenePickingPass
        #ifdef SCENEPICKINGPASS
        float4 _SelectionID;
        #endif
        
        // -- Properties used by SceneSelectionPass
        #ifdef SCENESELECTIONPASS
        int _ObjectId;
        int _PassValue;
        #endif
        
        // Graph Includes
        // GraphIncludes: <None>
        
        // Graph Functions
        
        void Unity_Branch_float4(float Predicate, float4 True, float4 False, out float4 Out)
        {
            Out = Predicate ? True : False;
        }
        
        void Unity_Multiply_float_float(float A, float B, out float Out)
        {
            Out = A * B;
        }
        
        void Unity_OneMinus_float(float In, out float Out)
        {
            Out = 1 - In;
        }
        
        // Custom interpolators pre vertex
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPreVertex' */
        
        // Graph Vertex
        struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
        };
        
        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            description.Position = IN.ObjectSpacePosition;
            description.Normal = IN.ObjectSpaceNormal;
            description.Tangent = IN.ObjectSpaceTangent;
            return description;
        }
        
        // Custom interpolators, pre surface
        #ifdef FEATURES_GRAPH_VERTEX
        Varyings CustomInterpolatorPassThroughFunc(inout Varyings output, VertexDescription input)
        {
        return output;
        }
        #define CUSTOMINTERPOLATOR_VARYPASSTHROUGH_FUNC
        #endif
        
        // Graph Pixel
        struct SurfaceDescription
        {
            float3 BaseColor;
            float3 NormalTS;
            float3 Emission;
            float Metallic;
            float Smoothness;
            float Occlusion;
            float Alpha;
            float AlphaClipThreshold;
        };
        
        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            UnityTexture2D _Property_29d95cca61c84013ba8453d2eba10e9a_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_Color_Texture);
            float4 _SampleTexture2D_1d46dbc4d51248578b3c5b19a9c762b6_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_29d95cca61c84013ba8453d2eba10e9a_Out_0_Texture2D.tex, _Property_29d95cca61c84013ba8453d2eba10e9a_Out_0_Texture2D.samplerstate, _Property_29d95cca61c84013ba8453d2eba10e9a_Out_0_Texture2D.GetTransformedUV(IN.uv0.xy) );
            float _SampleTexture2D_1d46dbc4d51248578b3c5b19a9c762b6_R_4_Float = _SampleTexture2D_1d46dbc4d51248578b3c5b19a9c762b6_RGBA_0_Vector4.r;
            float _SampleTexture2D_1d46dbc4d51248578b3c5b19a9c762b6_G_5_Float = _SampleTexture2D_1d46dbc4d51248578b3c5b19a9c762b6_RGBA_0_Vector4.g;
            float _SampleTexture2D_1d46dbc4d51248578b3c5b19a9c762b6_B_6_Float = _SampleTexture2D_1d46dbc4d51248578b3c5b19a9c762b6_RGBA_0_Vector4.b;
            float _SampleTexture2D_1d46dbc4d51248578b3c5b19a9c762b6_A_7_Float = _SampleTexture2D_1d46dbc4d51248578b3c5b19a9c762b6_RGBA_0_Vector4.a;
            UnityTexture2D _Property_43d6b361960241fa85238beaa18eaee7_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_Normal_Texture);
            float4 _SampleTexture2D_850c7807224247dcb806755ff839cbee_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_43d6b361960241fa85238beaa18eaee7_Out_0_Texture2D.tex, _Property_43d6b361960241fa85238beaa18eaee7_Out_0_Texture2D.samplerstate, _Property_43d6b361960241fa85238beaa18eaee7_Out_0_Texture2D.GetTransformedUV(IN.uv0.xy) );
            _SampleTexture2D_850c7807224247dcb806755ff839cbee_RGBA_0_Vector4.rgb = UnpackNormal(_SampleTexture2D_850c7807224247dcb806755ff839cbee_RGBA_0_Vector4);
            float _SampleTexture2D_850c7807224247dcb806755ff839cbee_R_4_Float = _SampleTexture2D_850c7807224247dcb806755ff839cbee_RGBA_0_Vector4.r;
            float _SampleTexture2D_850c7807224247dcb806755ff839cbee_G_5_Float = _SampleTexture2D_850c7807224247dcb806755ff839cbee_RGBA_0_Vector4.g;
            float _SampleTexture2D_850c7807224247dcb806755ff839cbee_B_6_Float = _SampleTexture2D_850c7807224247dcb806755ff839cbee_RGBA_0_Vector4.b;
            float _SampleTexture2D_850c7807224247dcb806755ff839cbee_A_7_Float = _SampleTexture2D_850c7807224247dcb806755ff839cbee_RGBA_0_Vector4.a;
            float _Property_17ea8ffc961b4ffd871836de5084ef86_Out_0_Boolean = _Emission;
            UnityTexture2D _Property_411dbbb2322442ebba4716107ea863fe_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_Emissive_Texture);
            float4 _SampleTexture2D_a57be8c4d236480f8104751aa7f681ab_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_411dbbb2322442ebba4716107ea863fe_Out_0_Texture2D.tex, _Property_411dbbb2322442ebba4716107ea863fe_Out_0_Texture2D.samplerstate, _Property_411dbbb2322442ebba4716107ea863fe_Out_0_Texture2D.GetTransformedUV(IN.uv0.xy) );
            float _SampleTexture2D_a57be8c4d236480f8104751aa7f681ab_R_4_Float = _SampleTexture2D_a57be8c4d236480f8104751aa7f681ab_RGBA_0_Vector4.r;
            float _SampleTexture2D_a57be8c4d236480f8104751aa7f681ab_G_5_Float = _SampleTexture2D_a57be8c4d236480f8104751aa7f681ab_RGBA_0_Vector4.g;
            float _SampleTexture2D_a57be8c4d236480f8104751aa7f681ab_B_6_Float = _SampleTexture2D_a57be8c4d236480f8104751aa7f681ab_RGBA_0_Vector4.b;
            float _SampleTexture2D_a57be8c4d236480f8104751aa7f681ab_A_7_Float = _SampleTexture2D_a57be8c4d236480f8104751aa7f681ab_RGBA_0_Vector4.a;
            float4 _Branch_45ebf603e9cf4ff3a4a6dbcc35b2c9e5_Out_3_Vector4;
            Unity_Branch_float4(_Property_17ea8ffc961b4ffd871836de5084ef86_Out_0_Boolean, _SampleTexture2D_a57be8c4d236480f8104751aa7f681ab_RGBA_0_Vector4, float4(0, 0, 0, 0), _Branch_45ebf603e9cf4ff3a4a6dbcc35b2c9e5_Out_3_Vector4);
            float _Property_e541f47f17b54763be002613df4e2428_Out_0_Float = _Param_Metalic;
            UnityTexture2D _Property_c819d15f02ab4493881e69c5685e980c_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_ORM_Texture);
            float4 _SampleTexture2D_f5e041739c8a4db594a428363896e97b_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_c819d15f02ab4493881e69c5685e980c_Out_0_Texture2D.tex, _Property_c819d15f02ab4493881e69c5685e980c_Out_0_Texture2D.samplerstate, _Property_c819d15f02ab4493881e69c5685e980c_Out_0_Texture2D.GetTransformedUV(IN.uv0.xy) );
            float _SampleTexture2D_f5e041739c8a4db594a428363896e97b_R_4_Float = _SampleTexture2D_f5e041739c8a4db594a428363896e97b_RGBA_0_Vector4.r;
            float _SampleTexture2D_f5e041739c8a4db594a428363896e97b_G_5_Float = _SampleTexture2D_f5e041739c8a4db594a428363896e97b_RGBA_0_Vector4.g;
            float _SampleTexture2D_f5e041739c8a4db594a428363896e97b_B_6_Float = _SampleTexture2D_f5e041739c8a4db594a428363896e97b_RGBA_0_Vector4.b;
            float _SampleTexture2D_f5e041739c8a4db594a428363896e97b_A_7_Float = _SampleTexture2D_f5e041739c8a4db594a428363896e97b_RGBA_0_Vector4.a;
            float _Multiply_329695002f9a4b7b953f2aa60124e02e_Out_2_Float;
            Unity_Multiply_float_float(_Property_e541f47f17b54763be002613df4e2428_Out_0_Float, _SampleTexture2D_f5e041739c8a4db594a428363896e97b_B_6_Float, _Multiply_329695002f9a4b7b953f2aa60124e02e_Out_2_Float);
            float _Property_6c57147c2e7c495ea1738f9c8e64529c_Out_0_Float = _Param_Roughness;
            UnityTexture2D _Property_1356c63c0d7e43a687e350a9f46377b7_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_ORM_Texture);
            float4 _SampleTexture2D_e90300966fdc464b97b573e644b4d54e_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_1356c63c0d7e43a687e350a9f46377b7_Out_0_Texture2D.tex, _Property_1356c63c0d7e43a687e350a9f46377b7_Out_0_Texture2D.samplerstate, _Property_1356c63c0d7e43a687e350a9f46377b7_Out_0_Texture2D.GetTransformedUV(IN.uv0.xy) );
            float _SampleTexture2D_e90300966fdc464b97b573e644b4d54e_R_4_Float = _SampleTexture2D_e90300966fdc464b97b573e644b4d54e_RGBA_0_Vector4.r;
            float _SampleTexture2D_e90300966fdc464b97b573e644b4d54e_G_5_Float = _SampleTexture2D_e90300966fdc464b97b573e644b4d54e_RGBA_0_Vector4.g;
            float _SampleTexture2D_e90300966fdc464b97b573e644b4d54e_B_6_Float = _SampleTexture2D_e90300966fdc464b97b573e644b4d54e_RGBA_0_Vector4.b;
            float _SampleTexture2D_e90300966fdc464b97b573e644b4d54e_A_7_Float = _SampleTexture2D_e90300966fdc464b97b573e644b4d54e_RGBA_0_Vector4.a;
            float _OneMinus_d33f5143a8f9425dbab28c41060c3228_Out_1_Float;
            Unity_OneMinus_float(_SampleTexture2D_e90300966fdc464b97b573e644b4d54e_G_5_Float, _OneMinus_d33f5143a8f9425dbab28c41060c3228_Out_1_Float);
            float _Multiply_7f595a9eb4fd414a91e0ff1327f32f3e_Out_2_Float;
            Unity_Multiply_float_float(_Property_6c57147c2e7c495ea1738f9c8e64529c_Out_0_Float, _OneMinus_d33f5143a8f9425dbab28c41060c3228_Out_1_Float, _Multiply_7f595a9eb4fd414a91e0ff1327f32f3e_Out_2_Float);
            float _Property_2d439fd022cd4b8da84a9a675029227b_Out_0_Float = _Param_AO;
            UnityTexture2D _Property_96ae0bdba5a642d19e3ff9e8ed5f8028_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_ORM_Texture);
            float4 _SampleTexture2D_18c326b7c2674546a72d722f47fa6532_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_96ae0bdba5a642d19e3ff9e8ed5f8028_Out_0_Texture2D.tex, _Property_96ae0bdba5a642d19e3ff9e8ed5f8028_Out_0_Texture2D.samplerstate, _Property_96ae0bdba5a642d19e3ff9e8ed5f8028_Out_0_Texture2D.GetTransformedUV(IN.uv0.xy) );
            float _SampleTexture2D_18c326b7c2674546a72d722f47fa6532_R_4_Float = _SampleTexture2D_18c326b7c2674546a72d722f47fa6532_RGBA_0_Vector4.r;
            float _SampleTexture2D_18c326b7c2674546a72d722f47fa6532_G_5_Float = _SampleTexture2D_18c326b7c2674546a72d722f47fa6532_RGBA_0_Vector4.g;
            float _SampleTexture2D_18c326b7c2674546a72d722f47fa6532_B_6_Float = _SampleTexture2D_18c326b7c2674546a72d722f47fa6532_RGBA_0_Vector4.b;
            float _SampleTexture2D_18c326b7c2674546a72d722f47fa6532_A_7_Float = _SampleTexture2D_18c326b7c2674546a72d722f47fa6532_RGBA_0_Vector4.a;
            float _Multiply_2bb5981ec276444eacb16af51e6f9a4b_Out_2_Float;
            Unity_Multiply_float_float(_Property_2d439fd022cd4b8da84a9a675029227b_Out_0_Float, _SampleTexture2D_18c326b7c2674546a72d722f47fa6532_R_4_Float, _Multiply_2bb5981ec276444eacb16af51e6f9a4b_Out_2_Float);
            UnityTexture2D _Property_8c9189612f044695b5e413fa751834bc_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_Color_Texture);
            float4 _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_8c9189612f044695b5e413fa751834bc_Out_0_Texture2D.tex, _Property_8c9189612f044695b5e413fa751834bc_Out_0_Texture2D.samplerstate, _Property_8c9189612f044695b5e413fa751834bc_Out_0_Texture2D.GetTransformedUV(IN.uv0.xy) );
            float _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_R_4_Float = _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_RGBA_0_Vector4.r;
            float _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_G_5_Float = _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_RGBA_0_Vector4.g;
            float _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_B_6_Float = _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_RGBA_0_Vector4.b;
            float _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_A_7_Float = _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_RGBA_0_Vector4.a;
            surface.BaseColor = (_SampleTexture2D_1d46dbc4d51248578b3c5b19a9c762b6_RGBA_0_Vector4.xyz);
            surface.NormalTS = (_SampleTexture2D_850c7807224247dcb806755ff839cbee_RGBA_0_Vector4.xyz);
            surface.Emission = (_Branch_45ebf603e9cf4ff3a4a6dbcc35b2c9e5_Out_3_Vector4.xyz);
            surface.Metallic = _Multiply_329695002f9a4b7b953f2aa60124e02e_Out_2_Float;
            surface.Smoothness = _Multiply_7f595a9eb4fd414a91e0ff1327f32f3e_Out_2_Float;
            surface.Occlusion = _Multiply_2bb5981ec276444eacb16af51e6f9a4b_Out_2_Float;
            surface.Alpha = _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_A_7_Float;
            surface.AlphaClipThreshold = 0.5;
            return surface;
        }
        
        // --------------------------------------------------
        // Build Graph Inputs
        
        VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);
        
            output.ObjectSpaceNormal =                          input.normalOS;
            output.ObjectSpaceTangent =                         input.tangentOS.xyz;
            output.ObjectSpacePosition =                        input.positionOS;
        #if UNITY_ANY_INSTANCING_ENABLED
        #else // TODO: XR support for procedural instancing because in this case UNITY_ANY_INSTANCING_ENABLED is not defined and instanceID is incorrect.
        #endif
        
            return output;
        }
        SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
        
            
        
        
        
            output.TangentSpaceNormal = float3(0.0f, 0.0f, 1.0f);
        
        
        
            #if UNITY_UV_STARTS_AT_TOP
            #else
            #endif
        
        
            output.uv0 = input.texCoord0;
        #if UNITY_ANY_INSTANCING_ENABLED
        #else // TODO: XR support for procedural instancing because in this case UNITY_ANY_INSTANCING_ENABLED is not defined and instanceID is incorrect.
        #endif
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
        #else
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        #endif
        #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        
                return output;
        }
        
        void BuildAppDataFull(Attributes attributes, VertexDescription vertexDescription, inout appdata_full result)
        {
            result.vertex     = float4(attributes.positionOS, 1);
            result.tangent    = attributes.tangentOS;
            result.normal     = attributes.normalOS;
            result.texcoord   = attributes.uv0;
            result.texcoord1  = attributes.uv1;
            result.vertex     = float4(vertexDescription.Position, 1);
            result.normal     = vertexDescription.Normal;
            result.tangent    = float4(vertexDescription.Tangent, 0);
            #if UNITY_ANY_INSTANCING_ENABLED
            #endif
        }
        
        void VaryingsToSurfaceVertex(Varyings varyings, inout v2f_surf result)
        {
            result.pos = varyings.positionCS;
            result.worldPos = varyings.positionWS;
            result.worldNormal = varyings.normalWS;
            // World Tangent isn't an available input on v2f_surf
        
            result._ShadowCoord = varyings.shadowCoord;
        
            #if UNITY_ANY_INSTANCING_ENABLED
            #endif
            #if UNITY_SHOULD_SAMPLE_SH
            #if !defined(LIGHTMAP_ON)
            result.sh = varyings.sh;
            #endif
            #endif
            #if defined(LIGHTMAP_ON)
            result.lmap.xy = varyings.lightmapUV;
            #endif
            #ifdef VARYINGS_NEED_FOG_AND_VERTEX_LIGHT
                result.fogCoord = varyings.fogFactorAndVertexLight.x;
                COPY_TO_LIGHT_COORDS(result, varyings.fogFactorAndVertexLight.yzw);
            #endif
        
            DEFAULT_UNITY_TRANSFER_VERTEX_OUTPUT_STEREO(varyings, result);
        }
        
        void SurfaceVertexToVaryings(v2f_surf surfVertex, inout Varyings result)
        {
            result.positionCS = surfVertex.pos;
            result.positionWS = surfVertex.worldPos;
            result.normalWS = surfVertex.worldNormal;
            // viewDirectionWS is never filled out in the legacy pass' function. Always use the value computed by SRP
            // World Tangent isn't an available input on v2f_surf
            result.shadowCoord = surfVertex._ShadowCoord;
        
            #if UNITY_ANY_INSTANCING_ENABLED
            #endif
            #if UNITY_SHOULD_SAMPLE_SH
            #if !defined(LIGHTMAP_ON)
            result.sh = surfVertex.sh;
            #endif
            #endif
            #if defined(LIGHTMAP_ON)
            result.lightmapUV = surfVertex.lmap.xy;
            #endif
            #ifdef VARYINGS_NEED_FOG_AND_VERTEX_LIGHT
                result.fogFactorAndVertexLight.x = surfVertex.fogCoord;
                COPY_FROM_LIGHT_COORDS(result.fogFactorAndVertexLight.yzw, surfVertex);
            #endif
        
            DEFAULT_UNITY_TRANSFER_VERTEX_OUTPUT_STEREO(surfVertex, result);
        }
        
        // --------------------------------------------------
        // Main
        
        #include "Packages/com.unity.shadergraph/Editor/Generation/Targets/BuiltIn/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
        #include "Packages/com.unity.shadergraph/Editor/Generation/Targets/BuiltIn/Editor/ShaderGraph/Includes/Varyings.hlsl"
        #include "Packages/com.unity.shadergraph/Editor/Generation/Targets/BuiltIn/Editor/ShaderGraph/Includes/PBRForwardAddPass.hlsl"
        
        ENDHLSL
        }
        Pass
        {
            Name "BuiltIn Deferred"
            Tags
            {
                "LightMode" = "Deferred"
            }
        
        // Render State
        Cull [_BUILTIN_CullMode]
        Blend [_BUILTIN_SrcBlend] [_BUILTIN_DstBlend]
        ZTest [_BUILTIN_ZTest]
        ZWrite [_BUILTIN_ZWrite]
        
        // Debug
        // <None>
        
        // --------------------------------------------------
        // Pass
        
        HLSLPROGRAM
        
        // Pragmas
        #pragma target 4.5
        #pragma multi_compile_instancing
        #pragma exclude_renderers nomrt
        #pragma multi_compile_prepassfinal
        #pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
        #pragma vertex vert
        #pragma fragment frag
        
        // Keywords
        #pragma multi_compile _ LIGHTMAP_ON
        #pragma multi_compile _ DIRLIGHTMAP_COMBINED
        #pragma multi_compile _ _MAIN_LIGHT_SHADOWS _MAIN_LIGHT_SHADOWS_CASCADE _MAIN_LIGHT_SHADOWS_SCREEN
        #pragma multi_compile _ _SHADOWS_SOFT
        #pragma multi_compile _ LIGHTMAP_SHADOW_MIXING
        #pragma multi_compile _ _MIXED_LIGHTING_SUBTRACTIVE
        #pragma multi_compile _ _GBUFFER_NORMALS_OCT
        #pragma shader_feature_local_fragment _ _BUILTIN_SURFACE_TYPE_TRANSPARENT
        #pragma shader_feature_local_fragment _ _BUILTIN_ALPHAPREMULTIPLY_ON
        #pragma shader_feature_local_fragment _ _BUILTIN_AlphaClip
        #pragma shader_feature_local_fragment _ _BUILTIN_ALPHATEST_ON
        // GraphKeywords: <None>
        
        // Defines
        #define _NORMALMAP 1
        #define _NORMAL_DROPOFF_TS 1
        #define ATTRIBUTES_NEED_NORMAL
        #define ATTRIBUTES_NEED_TANGENT
        #define ATTRIBUTES_NEED_TEXCOORD0
        #define ATTRIBUTES_NEED_TEXCOORD1
        #define VARYINGS_NEED_POSITION_WS
        #define VARYINGS_NEED_NORMAL_WS
        #define VARYINGS_NEED_TANGENT_WS
        #define VARYINGS_NEED_TEXCOORD0
        #define VARYINGS_NEED_FOG_AND_VERTEX_LIGHT
        #define FEATURES_GRAPH_VERTEX
        /* WARNING: $splice Could not find named fragment 'PassInstancing' */
        #define SHADERPASS SHADERPASS_DEFERRED
        #define BUILTIN_TARGET_API 1
        #ifdef _BUILTIN_SURFACE_TYPE_TRANSPARENT
        #define _SURFACE_TYPE_TRANSPARENT _BUILTIN_SURFACE_TYPE_TRANSPARENT
        #endif
        #ifdef _BUILTIN_ALPHATEST_ON
        #define _ALPHATEST_ON _BUILTIN_ALPHATEST_ON
        #endif
        #ifdef _BUILTIN_AlphaClip
        #define _AlphaClip _BUILTIN_AlphaClip
        #endif
        #ifdef _BUILTIN_ALPHAPREMULTIPLY_ON
        #define _ALPHAPREMULTIPLY_ON _BUILTIN_ALPHAPREMULTIPLY_ON
        #endif
        
        
        // custom interpolator pre-include
        /* WARNING: $splice Could not find named fragment 'sgci_CustomInterpolatorPreInclude' */
        
        // Includes
        #include "Packages/com.unity.shadergraph/Editor/Generation/Targets/BuiltIn/ShaderLibrary/Shim/Shims.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
        #include "Packages/com.unity.shadergraph/Editor/Generation/Targets/BuiltIn/ShaderLibrary/Core.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
        #include "Packages/com.unity.shadergraph/Editor/Generation/Targets/BuiltIn/ShaderLibrary/Lighting.hlsl"
        #include "Packages/com.unity.shadergraph/Editor/Generation/Targets/BuiltIn/Editor/ShaderGraph/Includes/LegacySurfaceVertex.hlsl"
        #include "Packages/com.unity.shadergraph/Editor/Generation/Targets/BuiltIn/ShaderLibrary/ShaderGraphFunctions.hlsl"
        
        // --------------------------------------------------
        // Structs and Packing
        
        // custom interpolators pre packing
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPrePacking' */
        
        struct Attributes
        {
             float3 positionOS : POSITION;
             float3 normalOS : NORMAL;
             float4 tangentOS : TANGENT;
             float4 uv0 : TEXCOORD0;
             float4 uv1 : TEXCOORD1;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(ATTRIBUTES_NEED_INSTANCEID)
             uint instanceID : INSTANCEID_SEMANTIC;
            #endif
        };
        struct Varyings
        {
             float4 positionCS : SV_POSITION;
             float3 positionWS;
             float3 normalWS;
             float4 tangentWS;
             float4 texCoord0;
            #if defined(LIGHTMAP_ON)
             float2 lightmapUV;
            #endif
            #if !defined(LIGHTMAP_ON)
             float3 sh;
            #endif
             float4 fogFactorAndVertexLight;
             float4 shadowCoord;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        struct SurfaceDescriptionInputs
        {
             float3 TangentSpaceNormal;
             float4 uv0;
        };
        struct VertexDescriptionInputs
        {
             float3 ObjectSpaceNormal;
             float3 ObjectSpaceTangent;
             float3 ObjectSpacePosition;
        };
        struct PackedVaryings
        {
             float4 positionCS : SV_POSITION;
            #if defined(LIGHTMAP_ON)
             float2 lightmapUV : INTERP0;
            #endif
            #if !defined(LIGHTMAP_ON)
             float3 sh : INTERP1;
            #endif
             float4 tangentWS : INTERP2;
             float4 texCoord0 : INTERP3;
             float4 fogFactorAndVertexLight : INTERP4;
             float4 shadowCoord : INTERP5;
             float3 positionWS : INTERP6;
             float3 normalWS : INTERP7;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        
        PackedVaryings PackVaryings (Varyings input)
        {
            PackedVaryings output;
            ZERO_INITIALIZE(PackedVaryings, output);
            output.positionCS = input.positionCS;
            #if defined(LIGHTMAP_ON)
            output.lightmapUV = input.lightmapUV;
            #endif
            #if !defined(LIGHTMAP_ON)
            output.sh = input.sh;
            #endif
            output.tangentWS.xyzw = input.tangentWS;
            output.texCoord0.xyzw = input.texCoord0;
            output.fogFactorAndVertexLight.xyzw = input.fogFactorAndVertexLight;
            output.shadowCoord.xyzw = input.shadowCoord;
            output.positionWS.xyz = input.positionWS;
            output.normalWS.xyz = input.normalWS;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        
        Varyings UnpackVaryings (PackedVaryings input)
        {
            Varyings output;
            output.positionCS = input.positionCS;
            #if defined(LIGHTMAP_ON)
            output.lightmapUV = input.lightmapUV;
            #endif
            #if !defined(LIGHTMAP_ON)
            output.sh = input.sh;
            #endif
            output.tangentWS = input.tangentWS.xyzw;
            output.texCoord0 = input.texCoord0.xyzw;
            output.fogFactorAndVertexLight = input.fogFactorAndVertexLight.xyzw;
            output.shadowCoord = input.shadowCoord.xyzw;
            output.positionWS = input.positionWS.xyz;
            output.normalWS = input.normalWS.xyz;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        
        
        // --------------------------------------------------
        // Graph
        
        // Graph Properties
        CBUFFER_START(UnityPerMaterial)
        float4 _Color_Texture_TexelSize;
        float4 _Normal_Texture_TexelSize;
        float4 _ORM_Texture_TexelSize;
        float4 _Emissive_Texture_TexelSize;
        float _Emission;
        float _Param_Roughness;
        float _Param_Metalic;
        float _Param_AO;
        CBUFFER_END
        
        
        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        TEXTURE2D(_Color_Texture);
        SAMPLER(sampler_Color_Texture);
        TEXTURE2D(_Normal_Texture);
        SAMPLER(sampler_Normal_Texture);
        TEXTURE2D(_ORM_Texture);
        SAMPLER(sampler_ORM_Texture);
        TEXTURE2D(_Emissive_Texture);
        SAMPLER(sampler_Emissive_Texture);
        
        // -- Property used by ScenePickingPass
        #ifdef SCENEPICKINGPASS
        float4 _SelectionID;
        #endif
        
        // -- Properties used by SceneSelectionPass
        #ifdef SCENESELECTIONPASS
        int _ObjectId;
        int _PassValue;
        #endif
        
        // Graph Includes
        // GraphIncludes: <None>
        
        // Graph Functions
        
        void Unity_Branch_float4(float Predicate, float4 True, float4 False, out float4 Out)
        {
            Out = Predicate ? True : False;
        }
        
        void Unity_Multiply_float_float(float A, float B, out float Out)
        {
            Out = A * B;
        }
        
        void Unity_OneMinus_float(float In, out float Out)
        {
            Out = 1 - In;
        }
        
        // Custom interpolators pre vertex
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPreVertex' */
        
        // Graph Vertex
        struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
        };
        
        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            description.Position = IN.ObjectSpacePosition;
            description.Normal = IN.ObjectSpaceNormal;
            description.Tangent = IN.ObjectSpaceTangent;
            return description;
        }
        
        // Custom interpolators, pre surface
        #ifdef FEATURES_GRAPH_VERTEX
        Varyings CustomInterpolatorPassThroughFunc(inout Varyings output, VertexDescription input)
        {
        return output;
        }
        #define CUSTOMINTERPOLATOR_VARYPASSTHROUGH_FUNC
        #endif
        
        // Graph Pixel
        struct SurfaceDescription
        {
            float3 BaseColor;
            float3 NormalTS;
            float3 Emission;
            float Metallic;
            float Smoothness;
            float Occlusion;
            float Alpha;
            float AlphaClipThreshold;
        };
        
        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            UnityTexture2D _Property_29d95cca61c84013ba8453d2eba10e9a_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_Color_Texture);
            float4 _SampleTexture2D_1d46dbc4d51248578b3c5b19a9c762b6_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_29d95cca61c84013ba8453d2eba10e9a_Out_0_Texture2D.tex, _Property_29d95cca61c84013ba8453d2eba10e9a_Out_0_Texture2D.samplerstate, _Property_29d95cca61c84013ba8453d2eba10e9a_Out_0_Texture2D.GetTransformedUV(IN.uv0.xy) );
            float _SampleTexture2D_1d46dbc4d51248578b3c5b19a9c762b6_R_4_Float = _SampleTexture2D_1d46dbc4d51248578b3c5b19a9c762b6_RGBA_0_Vector4.r;
            float _SampleTexture2D_1d46dbc4d51248578b3c5b19a9c762b6_G_5_Float = _SampleTexture2D_1d46dbc4d51248578b3c5b19a9c762b6_RGBA_0_Vector4.g;
            float _SampleTexture2D_1d46dbc4d51248578b3c5b19a9c762b6_B_6_Float = _SampleTexture2D_1d46dbc4d51248578b3c5b19a9c762b6_RGBA_0_Vector4.b;
            float _SampleTexture2D_1d46dbc4d51248578b3c5b19a9c762b6_A_7_Float = _SampleTexture2D_1d46dbc4d51248578b3c5b19a9c762b6_RGBA_0_Vector4.a;
            UnityTexture2D _Property_43d6b361960241fa85238beaa18eaee7_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_Normal_Texture);
            float4 _SampleTexture2D_850c7807224247dcb806755ff839cbee_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_43d6b361960241fa85238beaa18eaee7_Out_0_Texture2D.tex, _Property_43d6b361960241fa85238beaa18eaee7_Out_0_Texture2D.samplerstate, _Property_43d6b361960241fa85238beaa18eaee7_Out_0_Texture2D.GetTransformedUV(IN.uv0.xy) );
            _SampleTexture2D_850c7807224247dcb806755ff839cbee_RGBA_0_Vector4.rgb = UnpackNormal(_SampleTexture2D_850c7807224247dcb806755ff839cbee_RGBA_0_Vector4);
            float _SampleTexture2D_850c7807224247dcb806755ff839cbee_R_4_Float = _SampleTexture2D_850c7807224247dcb806755ff839cbee_RGBA_0_Vector4.r;
            float _SampleTexture2D_850c7807224247dcb806755ff839cbee_G_5_Float = _SampleTexture2D_850c7807224247dcb806755ff839cbee_RGBA_0_Vector4.g;
            float _SampleTexture2D_850c7807224247dcb806755ff839cbee_B_6_Float = _SampleTexture2D_850c7807224247dcb806755ff839cbee_RGBA_0_Vector4.b;
            float _SampleTexture2D_850c7807224247dcb806755ff839cbee_A_7_Float = _SampleTexture2D_850c7807224247dcb806755ff839cbee_RGBA_0_Vector4.a;
            float _Property_17ea8ffc961b4ffd871836de5084ef86_Out_0_Boolean = _Emission;
            UnityTexture2D _Property_411dbbb2322442ebba4716107ea863fe_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_Emissive_Texture);
            float4 _SampleTexture2D_a57be8c4d236480f8104751aa7f681ab_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_411dbbb2322442ebba4716107ea863fe_Out_0_Texture2D.tex, _Property_411dbbb2322442ebba4716107ea863fe_Out_0_Texture2D.samplerstate, _Property_411dbbb2322442ebba4716107ea863fe_Out_0_Texture2D.GetTransformedUV(IN.uv0.xy) );
            float _SampleTexture2D_a57be8c4d236480f8104751aa7f681ab_R_4_Float = _SampleTexture2D_a57be8c4d236480f8104751aa7f681ab_RGBA_0_Vector4.r;
            float _SampleTexture2D_a57be8c4d236480f8104751aa7f681ab_G_5_Float = _SampleTexture2D_a57be8c4d236480f8104751aa7f681ab_RGBA_0_Vector4.g;
            float _SampleTexture2D_a57be8c4d236480f8104751aa7f681ab_B_6_Float = _SampleTexture2D_a57be8c4d236480f8104751aa7f681ab_RGBA_0_Vector4.b;
            float _SampleTexture2D_a57be8c4d236480f8104751aa7f681ab_A_7_Float = _SampleTexture2D_a57be8c4d236480f8104751aa7f681ab_RGBA_0_Vector4.a;
            float4 _Branch_45ebf603e9cf4ff3a4a6dbcc35b2c9e5_Out_3_Vector4;
            Unity_Branch_float4(_Property_17ea8ffc961b4ffd871836de5084ef86_Out_0_Boolean, _SampleTexture2D_a57be8c4d236480f8104751aa7f681ab_RGBA_0_Vector4, float4(0, 0, 0, 0), _Branch_45ebf603e9cf4ff3a4a6dbcc35b2c9e5_Out_3_Vector4);
            float _Property_e541f47f17b54763be002613df4e2428_Out_0_Float = _Param_Metalic;
            UnityTexture2D _Property_c819d15f02ab4493881e69c5685e980c_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_ORM_Texture);
            float4 _SampleTexture2D_f5e041739c8a4db594a428363896e97b_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_c819d15f02ab4493881e69c5685e980c_Out_0_Texture2D.tex, _Property_c819d15f02ab4493881e69c5685e980c_Out_0_Texture2D.samplerstate, _Property_c819d15f02ab4493881e69c5685e980c_Out_0_Texture2D.GetTransformedUV(IN.uv0.xy) );
            float _SampleTexture2D_f5e041739c8a4db594a428363896e97b_R_4_Float = _SampleTexture2D_f5e041739c8a4db594a428363896e97b_RGBA_0_Vector4.r;
            float _SampleTexture2D_f5e041739c8a4db594a428363896e97b_G_5_Float = _SampleTexture2D_f5e041739c8a4db594a428363896e97b_RGBA_0_Vector4.g;
            float _SampleTexture2D_f5e041739c8a4db594a428363896e97b_B_6_Float = _SampleTexture2D_f5e041739c8a4db594a428363896e97b_RGBA_0_Vector4.b;
            float _SampleTexture2D_f5e041739c8a4db594a428363896e97b_A_7_Float = _SampleTexture2D_f5e041739c8a4db594a428363896e97b_RGBA_0_Vector4.a;
            float _Multiply_329695002f9a4b7b953f2aa60124e02e_Out_2_Float;
            Unity_Multiply_float_float(_Property_e541f47f17b54763be002613df4e2428_Out_0_Float, _SampleTexture2D_f5e041739c8a4db594a428363896e97b_B_6_Float, _Multiply_329695002f9a4b7b953f2aa60124e02e_Out_2_Float);
            float _Property_6c57147c2e7c495ea1738f9c8e64529c_Out_0_Float = _Param_Roughness;
            UnityTexture2D _Property_1356c63c0d7e43a687e350a9f46377b7_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_ORM_Texture);
            float4 _SampleTexture2D_e90300966fdc464b97b573e644b4d54e_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_1356c63c0d7e43a687e350a9f46377b7_Out_0_Texture2D.tex, _Property_1356c63c0d7e43a687e350a9f46377b7_Out_0_Texture2D.samplerstate, _Property_1356c63c0d7e43a687e350a9f46377b7_Out_0_Texture2D.GetTransformedUV(IN.uv0.xy) );
            float _SampleTexture2D_e90300966fdc464b97b573e644b4d54e_R_4_Float = _SampleTexture2D_e90300966fdc464b97b573e644b4d54e_RGBA_0_Vector4.r;
            float _SampleTexture2D_e90300966fdc464b97b573e644b4d54e_G_5_Float = _SampleTexture2D_e90300966fdc464b97b573e644b4d54e_RGBA_0_Vector4.g;
            float _SampleTexture2D_e90300966fdc464b97b573e644b4d54e_B_6_Float = _SampleTexture2D_e90300966fdc464b97b573e644b4d54e_RGBA_0_Vector4.b;
            float _SampleTexture2D_e90300966fdc464b97b573e644b4d54e_A_7_Float = _SampleTexture2D_e90300966fdc464b97b573e644b4d54e_RGBA_0_Vector4.a;
            float _OneMinus_d33f5143a8f9425dbab28c41060c3228_Out_1_Float;
            Unity_OneMinus_float(_SampleTexture2D_e90300966fdc464b97b573e644b4d54e_G_5_Float, _OneMinus_d33f5143a8f9425dbab28c41060c3228_Out_1_Float);
            float _Multiply_7f595a9eb4fd414a91e0ff1327f32f3e_Out_2_Float;
            Unity_Multiply_float_float(_Property_6c57147c2e7c495ea1738f9c8e64529c_Out_0_Float, _OneMinus_d33f5143a8f9425dbab28c41060c3228_Out_1_Float, _Multiply_7f595a9eb4fd414a91e0ff1327f32f3e_Out_2_Float);
            float _Property_2d439fd022cd4b8da84a9a675029227b_Out_0_Float = _Param_AO;
            UnityTexture2D _Property_96ae0bdba5a642d19e3ff9e8ed5f8028_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_ORM_Texture);
            float4 _SampleTexture2D_18c326b7c2674546a72d722f47fa6532_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_96ae0bdba5a642d19e3ff9e8ed5f8028_Out_0_Texture2D.tex, _Property_96ae0bdba5a642d19e3ff9e8ed5f8028_Out_0_Texture2D.samplerstate, _Property_96ae0bdba5a642d19e3ff9e8ed5f8028_Out_0_Texture2D.GetTransformedUV(IN.uv0.xy) );
            float _SampleTexture2D_18c326b7c2674546a72d722f47fa6532_R_4_Float = _SampleTexture2D_18c326b7c2674546a72d722f47fa6532_RGBA_0_Vector4.r;
            float _SampleTexture2D_18c326b7c2674546a72d722f47fa6532_G_5_Float = _SampleTexture2D_18c326b7c2674546a72d722f47fa6532_RGBA_0_Vector4.g;
            float _SampleTexture2D_18c326b7c2674546a72d722f47fa6532_B_6_Float = _SampleTexture2D_18c326b7c2674546a72d722f47fa6532_RGBA_0_Vector4.b;
            float _SampleTexture2D_18c326b7c2674546a72d722f47fa6532_A_7_Float = _SampleTexture2D_18c326b7c2674546a72d722f47fa6532_RGBA_0_Vector4.a;
            float _Multiply_2bb5981ec276444eacb16af51e6f9a4b_Out_2_Float;
            Unity_Multiply_float_float(_Property_2d439fd022cd4b8da84a9a675029227b_Out_0_Float, _SampleTexture2D_18c326b7c2674546a72d722f47fa6532_R_4_Float, _Multiply_2bb5981ec276444eacb16af51e6f9a4b_Out_2_Float);
            UnityTexture2D _Property_8c9189612f044695b5e413fa751834bc_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_Color_Texture);
            float4 _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_8c9189612f044695b5e413fa751834bc_Out_0_Texture2D.tex, _Property_8c9189612f044695b5e413fa751834bc_Out_0_Texture2D.samplerstate, _Property_8c9189612f044695b5e413fa751834bc_Out_0_Texture2D.GetTransformedUV(IN.uv0.xy) );
            float _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_R_4_Float = _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_RGBA_0_Vector4.r;
            float _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_G_5_Float = _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_RGBA_0_Vector4.g;
            float _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_B_6_Float = _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_RGBA_0_Vector4.b;
            float _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_A_7_Float = _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_RGBA_0_Vector4.a;
            surface.BaseColor = (_SampleTexture2D_1d46dbc4d51248578b3c5b19a9c762b6_RGBA_0_Vector4.xyz);
            surface.NormalTS = (_SampleTexture2D_850c7807224247dcb806755ff839cbee_RGBA_0_Vector4.xyz);
            surface.Emission = (_Branch_45ebf603e9cf4ff3a4a6dbcc35b2c9e5_Out_3_Vector4.xyz);
            surface.Metallic = _Multiply_329695002f9a4b7b953f2aa60124e02e_Out_2_Float;
            surface.Smoothness = _Multiply_7f595a9eb4fd414a91e0ff1327f32f3e_Out_2_Float;
            surface.Occlusion = _Multiply_2bb5981ec276444eacb16af51e6f9a4b_Out_2_Float;
            surface.Alpha = _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_A_7_Float;
            surface.AlphaClipThreshold = 0.5;
            return surface;
        }
        
        // --------------------------------------------------
        // Build Graph Inputs
        
        VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);
        
            output.ObjectSpaceNormal =                          input.normalOS;
            output.ObjectSpaceTangent =                         input.tangentOS.xyz;
            output.ObjectSpacePosition =                        input.positionOS;
        #if UNITY_ANY_INSTANCING_ENABLED
        #else // TODO: XR support for procedural instancing because in this case UNITY_ANY_INSTANCING_ENABLED is not defined and instanceID is incorrect.
        #endif
        
            return output;
        }
        SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
        
            
        
        
        
            output.TangentSpaceNormal = float3(0.0f, 0.0f, 1.0f);
        
        
        
            #if UNITY_UV_STARTS_AT_TOP
            #else
            #endif
        
        
            output.uv0 = input.texCoord0;
        #if UNITY_ANY_INSTANCING_ENABLED
        #else // TODO: XR support for procedural instancing because in this case UNITY_ANY_INSTANCING_ENABLED is not defined and instanceID is incorrect.
        #endif
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
        #else
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        #endif
        #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        
                return output;
        }
        
        void BuildAppDataFull(Attributes attributes, VertexDescription vertexDescription, inout appdata_full result)
        {
            result.vertex     = float4(attributes.positionOS, 1);
            result.tangent    = attributes.tangentOS;
            result.normal     = attributes.normalOS;
            result.texcoord   = attributes.uv0;
            result.texcoord1  = attributes.uv1;
            result.vertex     = float4(vertexDescription.Position, 1);
            result.normal     = vertexDescription.Normal;
            result.tangent    = float4(vertexDescription.Tangent, 0);
            #if UNITY_ANY_INSTANCING_ENABLED
            #endif
        }
        
        void VaryingsToSurfaceVertex(Varyings varyings, inout v2f_surf result)
        {
            result.pos = varyings.positionCS;
            result.worldPos = varyings.positionWS;
            result.worldNormal = varyings.normalWS;
            // World Tangent isn't an available input on v2f_surf
        
            result._ShadowCoord = varyings.shadowCoord;
        
            #if UNITY_ANY_INSTANCING_ENABLED
            #endif
            #if UNITY_SHOULD_SAMPLE_SH
            #if !defined(LIGHTMAP_ON)
            result.sh = varyings.sh;
            #endif
            #endif
            #if defined(LIGHTMAP_ON)
            result.lmap.xy = varyings.lightmapUV;
            #endif
            #ifdef VARYINGS_NEED_FOG_AND_VERTEX_LIGHT
                result.fogCoord = varyings.fogFactorAndVertexLight.x;
                COPY_TO_LIGHT_COORDS(result, varyings.fogFactorAndVertexLight.yzw);
            #endif
        
            DEFAULT_UNITY_TRANSFER_VERTEX_OUTPUT_STEREO(varyings, result);
        }
        
        void SurfaceVertexToVaryings(v2f_surf surfVertex, inout Varyings result)
        {
            result.positionCS = surfVertex.pos;
            result.positionWS = surfVertex.worldPos;
            result.normalWS = surfVertex.worldNormal;
            // viewDirectionWS is never filled out in the legacy pass' function. Always use the value computed by SRP
            // World Tangent isn't an available input on v2f_surf
            result.shadowCoord = surfVertex._ShadowCoord;
        
            #if UNITY_ANY_INSTANCING_ENABLED
            #endif
            #if UNITY_SHOULD_SAMPLE_SH
            #if !defined(LIGHTMAP_ON)
            result.sh = surfVertex.sh;
            #endif
            #endif
            #if defined(LIGHTMAP_ON)
            result.lightmapUV = surfVertex.lmap.xy;
            #endif
            #ifdef VARYINGS_NEED_FOG_AND_VERTEX_LIGHT
                result.fogFactorAndVertexLight.x = surfVertex.fogCoord;
                COPY_FROM_LIGHT_COORDS(result.fogFactorAndVertexLight.yzw, surfVertex);
            #endif
        
            DEFAULT_UNITY_TRANSFER_VERTEX_OUTPUT_STEREO(surfVertex, result);
        }
        
        // --------------------------------------------------
        // Main
        
        #include "Packages/com.unity.shadergraph/Editor/Generation/Targets/BuiltIn/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
        #include "Packages/com.unity.shadergraph/Editor/Generation/Targets/BuiltIn/Editor/ShaderGraph/Includes/Varyings.hlsl"
        #include "Packages/com.unity.shadergraph/Editor/Generation/Targets/BuiltIn/Editor/ShaderGraph/Includes/PBRDeferredPass.hlsl"
        
        ENDHLSL
        }
        Pass
        {
            Name "ShadowCaster"
            Tags
            {
                "LightMode" = "ShadowCaster"
            }
        
        // Render State
        Cull [_BUILTIN_CullMode]
        Blend [_BUILTIN_SrcBlend] [_BUILTIN_DstBlend]
        ZTest LEqual
        ZWrite On
        ColorMask 0
        
        // Debug
        // <None>
        
        // --------------------------------------------------
        // Pass
        
        HLSLPROGRAM
        
        // Pragmas
        #pragma target 3.0
        #pragma multi_compile_shadowcaster
        #pragma vertex vert
        #pragma fragment frag
        
        // Keywords
        #pragma multi_compile _ _CASTING_PUNCTUAL_LIGHT_SHADOW
        #pragma shader_feature_local_fragment _ _BUILTIN_SURFACE_TYPE_TRANSPARENT
        #pragma shader_feature_local_fragment _ _BUILTIN_AlphaClip
        #pragma shader_feature_local_fragment _ _BUILTIN_ALPHATEST_ON
        // GraphKeywords: <None>
        
        // Defines
        #define _NORMALMAP 1
        #define _NORMAL_DROPOFF_TS 1
        #define ATTRIBUTES_NEED_NORMAL
        #define ATTRIBUTES_NEED_TANGENT
        #define ATTRIBUTES_NEED_TEXCOORD0
        #define VARYINGS_NEED_TEXCOORD0
        #define FEATURES_GRAPH_VERTEX
        /* WARNING: $splice Could not find named fragment 'PassInstancing' */
        #define SHADERPASS SHADERPASS_SHADOWCASTER
        #define BUILTIN_TARGET_API 1
        #ifdef _BUILTIN_SURFACE_TYPE_TRANSPARENT
        #define _SURFACE_TYPE_TRANSPARENT _BUILTIN_SURFACE_TYPE_TRANSPARENT
        #endif
        #ifdef _BUILTIN_ALPHATEST_ON
        #define _ALPHATEST_ON _BUILTIN_ALPHATEST_ON
        #endif
        #ifdef _BUILTIN_AlphaClip
        #define _AlphaClip _BUILTIN_AlphaClip
        #endif
        #ifdef _BUILTIN_ALPHAPREMULTIPLY_ON
        #define _ALPHAPREMULTIPLY_ON _BUILTIN_ALPHAPREMULTIPLY_ON
        #endif
        
        
        // custom interpolator pre-include
        /* WARNING: $splice Could not find named fragment 'sgci_CustomInterpolatorPreInclude' */
        
        // Includes
        #include "Packages/com.unity.shadergraph/Editor/Generation/Targets/BuiltIn/ShaderLibrary/Shim/Shims.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
        #include "Packages/com.unity.shadergraph/Editor/Generation/Targets/BuiltIn/ShaderLibrary/Core.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
        #include "Packages/com.unity.shadergraph/Editor/Generation/Targets/BuiltIn/ShaderLibrary/Lighting.hlsl"
        #include "Packages/com.unity.shadergraph/Editor/Generation/Targets/BuiltIn/Editor/ShaderGraph/Includes/LegacySurfaceVertex.hlsl"
        #include "Packages/com.unity.shadergraph/Editor/Generation/Targets/BuiltIn/ShaderLibrary/ShaderGraphFunctions.hlsl"
        
        // --------------------------------------------------
        // Structs and Packing
        
        // custom interpolators pre packing
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPrePacking' */
        
        struct Attributes
        {
             float3 positionOS : POSITION;
             float3 normalOS : NORMAL;
             float4 tangentOS : TANGENT;
             float4 uv0 : TEXCOORD0;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(ATTRIBUTES_NEED_INSTANCEID)
             uint instanceID : INSTANCEID_SEMANTIC;
            #endif
        };
        struct Varyings
        {
             float4 positionCS : SV_POSITION;
             float4 texCoord0;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        struct SurfaceDescriptionInputs
        {
             float4 uv0;
        };
        struct VertexDescriptionInputs
        {
             float3 ObjectSpaceNormal;
             float3 ObjectSpaceTangent;
             float3 ObjectSpacePosition;
        };
        struct PackedVaryings
        {
             float4 positionCS : SV_POSITION;
             float4 texCoord0 : INTERP0;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        
        PackedVaryings PackVaryings (Varyings input)
        {
            PackedVaryings output;
            ZERO_INITIALIZE(PackedVaryings, output);
            output.positionCS = input.positionCS;
            output.texCoord0.xyzw = input.texCoord0;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        
        Varyings UnpackVaryings (PackedVaryings input)
        {
            Varyings output;
            output.positionCS = input.positionCS;
            output.texCoord0 = input.texCoord0.xyzw;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        
        
        // --------------------------------------------------
        // Graph
        
        // Graph Properties
        CBUFFER_START(UnityPerMaterial)
        float4 _Color_Texture_TexelSize;
        float4 _Normal_Texture_TexelSize;
        float4 _ORM_Texture_TexelSize;
        float4 _Emissive_Texture_TexelSize;
        float _Emission;
        float _Param_Roughness;
        float _Param_Metalic;
        float _Param_AO;
        CBUFFER_END
        
        
        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        TEXTURE2D(_Color_Texture);
        SAMPLER(sampler_Color_Texture);
        TEXTURE2D(_Normal_Texture);
        SAMPLER(sampler_Normal_Texture);
        TEXTURE2D(_ORM_Texture);
        SAMPLER(sampler_ORM_Texture);
        TEXTURE2D(_Emissive_Texture);
        SAMPLER(sampler_Emissive_Texture);
        
        // -- Property used by ScenePickingPass
        #ifdef SCENEPICKINGPASS
        float4 _SelectionID;
        #endif
        
        // -- Properties used by SceneSelectionPass
        #ifdef SCENESELECTIONPASS
        int _ObjectId;
        int _PassValue;
        #endif
        
        // Graph Includes
        // GraphIncludes: <None>
        
        // Graph Functions
        // GraphFunctions: <None>
        
        // Custom interpolators pre vertex
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPreVertex' */
        
        // Graph Vertex
        struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
        };
        
        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            description.Position = IN.ObjectSpacePosition;
            description.Normal = IN.ObjectSpaceNormal;
            description.Tangent = IN.ObjectSpaceTangent;
            return description;
        }
        
        // Custom interpolators, pre surface
        #ifdef FEATURES_GRAPH_VERTEX
        Varyings CustomInterpolatorPassThroughFunc(inout Varyings output, VertexDescription input)
        {
        return output;
        }
        #define CUSTOMINTERPOLATOR_VARYPASSTHROUGH_FUNC
        #endif
        
        // Graph Pixel
        struct SurfaceDescription
        {
            float Alpha;
            float AlphaClipThreshold;
        };
        
        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            UnityTexture2D _Property_8c9189612f044695b5e413fa751834bc_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_Color_Texture);
            float4 _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_8c9189612f044695b5e413fa751834bc_Out_0_Texture2D.tex, _Property_8c9189612f044695b5e413fa751834bc_Out_0_Texture2D.samplerstate, _Property_8c9189612f044695b5e413fa751834bc_Out_0_Texture2D.GetTransformedUV(IN.uv0.xy) );
            float _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_R_4_Float = _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_RGBA_0_Vector4.r;
            float _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_G_5_Float = _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_RGBA_0_Vector4.g;
            float _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_B_6_Float = _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_RGBA_0_Vector4.b;
            float _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_A_7_Float = _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_RGBA_0_Vector4.a;
            surface.Alpha = _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_A_7_Float;
            surface.AlphaClipThreshold = 0.5;
            return surface;
        }
        
        // --------------------------------------------------
        // Build Graph Inputs
        
        VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);
        
            output.ObjectSpaceNormal =                          input.normalOS;
            output.ObjectSpaceTangent =                         input.tangentOS.xyz;
            output.ObjectSpacePosition =                        input.positionOS;
        #if UNITY_ANY_INSTANCING_ENABLED
        #else // TODO: XR support for procedural instancing because in this case UNITY_ANY_INSTANCING_ENABLED is not defined and instanceID is incorrect.
        #endif
        
            return output;
        }
        SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
        
            
        
        
        
        
        
        
            #if UNITY_UV_STARTS_AT_TOP
            #else
            #endif
        
        
            output.uv0 = input.texCoord0;
        #if UNITY_ANY_INSTANCING_ENABLED
        #else // TODO: XR support for procedural instancing because in this case UNITY_ANY_INSTANCING_ENABLED is not defined and instanceID is incorrect.
        #endif
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
        #else
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        #endif
        #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        
                return output;
        }
        
        void BuildAppDataFull(Attributes attributes, VertexDescription vertexDescription, inout appdata_full result)
        {
            result.vertex     = float4(attributes.positionOS, 1);
            result.tangent    = attributes.tangentOS;
            result.normal     = attributes.normalOS;
            result.texcoord   = attributes.uv0;
            result.vertex     = float4(vertexDescription.Position, 1);
            result.normal     = vertexDescription.Normal;
            result.tangent    = float4(vertexDescription.Tangent, 0);
            #if UNITY_ANY_INSTANCING_ENABLED
            #endif
        }
        
        void VaryingsToSurfaceVertex(Varyings varyings, inout v2f_surf result)
        {
            result.pos = varyings.positionCS;
            // World Tangent isn't an available input on v2f_surf
        
        
            #if UNITY_ANY_INSTANCING_ENABLED
            #endif
            #if UNITY_SHOULD_SAMPLE_SH
            #if !defined(LIGHTMAP_ON)
            #endif
            #endif
            #if defined(LIGHTMAP_ON)
            #endif
            #ifdef VARYINGS_NEED_FOG_AND_VERTEX_LIGHT
                result.fogCoord = varyings.fogFactorAndVertexLight.x;
                COPY_TO_LIGHT_COORDS(result, varyings.fogFactorAndVertexLight.yzw);
            #endif
        
            DEFAULT_UNITY_TRANSFER_VERTEX_OUTPUT_STEREO(varyings, result);
        }
        
        void SurfaceVertexToVaryings(v2f_surf surfVertex, inout Varyings result)
        {
            result.positionCS = surfVertex.pos;
            // viewDirectionWS is never filled out in the legacy pass' function. Always use the value computed by SRP
            // World Tangent isn't an available input on v2f_surf
        
            #if UNITY_ANY_INSTANCING_ENABLED
            #endif
            #if UNITY_SHOULD_SAMPLE_SH
            #if !defined(LIGHTMAP_ON)
            #endif
            #endif
            #if defined(LIGHTMAP_ON)
            #endif
            #ifdef VARYINGS_NEED_FOG_AND_VERTEX_LIGHT
                result.fogFactorAndVertexLight.x = surfVertex.fogCoord;
                COPY_FROM_LIGHT_COORDS(result.fogFactorAndVertexLight.yzw, surfVertex);
            #endif
        
            DEFAULT_UNITY_TRANSFER_VERTEX_OUTPUT_STEREO(surfVertex, result);
        }
        
        // --------------------------------------------------
        // Main
        
        #include "Packages/com.unity.shadergraph/Editor/Generation/Targets/BuiltIn/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
        #include "Packages/com.unity.shadergraph/Editor/Generation/Targets/BuiltIn/Editor/ShaderGraph/Includes/Varyings.hlsl"
        #include "Packages/com.unity.shadergraph/Editor/Generation/Targets/BuiltIn/Editor/ShaderGraph/Includes/ShadowCasterPass.hlsl"
        
        ENDHLSL
        }
        Pass
        {
            Name "DepthOnly"
            Tags
            {
                "LightMode" = "DepthOnly"
            }
        
        // Render State
        Cull [_BUILTIN_CullMode]
        Blend [_BUILTIN_SrcBlend] [_BUILTIN_DstBlend]
        ZTest LEqual
        ZWrite On
        ColorMask 0
        
        // Debug
        // <None>
        
        // --------------------------------------------------
        // Pass
        
        HLSLPROGRAM
        
        // Pragmas
        #pragma target 3.0
        #pragma multi_compile_instancing
        #pragma vertex vert
        #pragma fragment frag
        
        // Keywords
        #pragma shader_feature_local_fragment _ _BUILTIN_AlphaClip
        #pragma shader_feature_local_fragment _ _BUILTIN_ALPHATEST_ON
        // GraphKeywords: <None>
        
        // Defines
        #define _NORMALMAP 1
        #define _NORMAL_DROPOFF_TS 1
        #define ATTRIBUTES_NEED_NORMAL
        #define ATTRIBUTES_NEED_TANGENT
        #define ATTRIBUTES_NEED_TEXCOORD0
        #define VARYINGS_NEED_TEXCOORD0
        #define FEATURES_GRAPH_VERTEX
        /* WARNING: $splice Could not find named fragment 'PassInstancing' */
        #define SHADERPASS SHADERPASS_DEPTHONLY
        #define BUILTIN_TARGET_API 1
        #ifdef _BUILTIN_SURFACE_TYPE_TRANSPARENT
        #define _SURFACE_TYPE_TRANSPARENT _BUILTIN_SURFACE_TYPE_TRANSPARENT
        #endif
        #ifdef _BUILTIN_ALPHATEST_ON
        #define _ALPHATEST_ON _BUILTIN_ALPHATEST_ON
        #endif
        #ifdef _BUILTIN_AlphaClip
        #define _AlphaClip _BUILTIN_AlphaClip
        #endif
        #ifdef _BUILTIN_ALPHAPREMULTIPLY_ON
        #define _ALPHAPREMULTIPLY_ON _BUILTIN_ALPHAPREMULTIPLY_ON
        #endif
        
        
        // custom interpolator pre-include
        /* WARNING: $splice Could not find named fragment 'sgci_CustomInterpolatorPreInclude' */
        
        // Includes
        #include "Packages/com.unity.shadergraph/Editor/Generation/Targets/BuiltIn/ShaderLibrary/Shim/Shims.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
        #include "Packages/com.unity.shadergraph/Editor/Generation/Targets/BuiltIn/ShaderLibrary/Core.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
        #include "Packages/com.unity.shadergraph/Editor/Generation/Targets/BuiltIn/ShaderLibrary/Lighting.hlsl"
        #include "Packages/com.unity.shadergraph/Editor/Generation/Targets/BuiltIn/Editor/ShaderGraph/Includes/LegacySurfaceVertex.hlsl"
        #include "Packages/com.unity.shadergraph/Editor/Generation/Targets/BuiltIn/ShaderLibrary/ShaderGraphFunctions.hlsl"
        
        // --------------------------------------------------
        // Structs and Packing
        
        // custom interpolators pre packing
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPrePacking' */
        
        struct Attributes
        {
             float3 positionOS : POSITION;
             float3 normalOS : NORMAL;
             float4 tangentOS : TANGENT;
             float4 uv0 : TEXCOORD0;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(ATTRIBUTES_NEED_INSTANCEID)
             uint instanceID : INSTANCEID_SEMANTIC;
            #endif
        };
        struct Varyings
        {
             float4 positionCS : SV_POSITION;
             float4 texCoord0;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        struct SurfaceDescriptionInputs
        {
             float4 uv0;
        };
        struct VertexDescriptionInputs
        {
             float3 ObjectSpaceNormal;
             float3 ObjectSpaceTangent;
             float3 ObjectSpacePosition;
        };
        struct PackedVaryings
        {
             float4 positionCS : SV_POSITION;
             float4 texCoord0 : INTERP0;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        
        PackedVaryings PackVaryings (Varyings input)
        {
            PackedVaryings output;
            ZERO_INITIALIZE(PackedVaryings, output);
            output.positionCS = input.positionCS;
            output.texCoord0.xyzw = input.texCoord0;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        
        Varyings UnpackVaryings (PackedVaryings input)
        {
            Varyings output;
            output.positionCS = input.positionCS;
            output.texCoord0 = input.texCoord0.xyzw;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        
        
        // --------------------------------------------------
        // Graph
        
        // Graph Properties
        CBUFFER_START(UnityPerMaterial)
        float4 _Color_Texture_TexelSize;
        float4 _Normal_Texture_TexelSize;
        float4 _ORM_Texture_TexelSize;
        float4 _Emissive_Texture_TexelSize;
        float _Emission;
        float _Param_Roughness;
        float _Param_Metalic;
        float _Param_AO;
        CBUFFER_END
        
        
        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        TEXTURE2D(_Color_Texture);
        SAMPLER(sampler_Color_Texture);
        TEXTURE2D(_Normal_Texture);
        SAMPLER(sampler_Normal_Texture);
        TEXTURE2D(_ORM_Texture);
        SAMPLER(sampler_ORM_Texture);
        TEXTURE2D(_Emissive_Texture);
        SAMPLER(sampler_Emissive_Texture);
        
        // -- Property used by ScenePickingPass
        #ifdef SCENEPICKINGPASS
        float4 _SelectionID;
        #endif
        
        // -- Properties used by SceneSelectionPass
        #ifdef SCENESELECTIONPASS
        int _ObjectId;
        int _PassValue;
        #endif
        
        // Graph Includes
        // GraphIncludes: <None>
        
        // Graph Functions
        // GraphFunctions: <None>
        
        // Custom interpolators pre vertex
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPreVertex' */
        
        // Graph Vertex
        struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
        };
        
        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            description.Position = IN.ObjectSpacePosition;
            description.Normal = IN.ObjectSpaceNormal;
            description.Tangent = IN.ObjectSpaceTangent;
            return description;
        }
        
        // Custom interpolators, pre surface
        #ifdef FEATURES_GRAPH_VERTEX
        Varyings CustomInterpolatorPassThroughFunc(inout Varyings output, VertexDescription input)
        {
        return output;
        }
        #define CUSTOMINTERPOLATOR_VARYPASSTHROUGH_FUNC
        #endif
        
        // Graph Pixel
        struct SurfaceDescription
        {
            float Alpha;
            float AlphaClipThreshold;
        };
        
        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            UnityTexture2D _Property_8c9189612f044695b5e413fa751834bc_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_Color_Texture);
            float4 _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_8c9189612f044695b5e413fa751834bc_Out_0_Texture2D.tex, _Property_8c9189612f044695b5e413fa751834bc_Out_0_Texture2D.samplerstate, _Property_8c9189612f044695b5e413fa751834bc_Out_0_Texture2D.GetTransformedUV(IN.uv0.xy) );
            float _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_R_4_Float = _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_RGBA_0_Vector4.r;
            float _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_G_5_Float = _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_RGBA_0_Vector4.g;
            float _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_B_6_Float = _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_RGBA_0_Vector4.b;
            float _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_A_7_Float = _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_RGBA_0_Vector4.a;
            surface.Alpha = _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_A_7_Float;
            surface.AlphaClipThreshold = 0.5;
            return surface;
        }
        
        // --------------------------------------------------
        // Build Graph Inputs
        
        VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);
        
            output.ObjectSpaceNormal =                          input.normalOS;
            output.ObjectSpaceTangent =                         input.tangentOS.xyz;
            output.ObjectSpacePosition =                        input.positionOS;
        #if UNITY_ANY_INSTANCING_ENABLED
        #else // TODO: XR support for procedural instancing because in this case UNITY_ANY_INSTANCING_ENABLED is not defined and instanceID is incorrect.
        #endif
        
            return output;
        }
        SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
        
            
        
        
        
        
        
        
            #if UNITY_UV_STARTS_AT_TOP
            #else
            #endif
        
        
            output.uv0 = input.texCoord0;
        #if UNITY_ANY_INSTANCING_ENABLED
        #else // TODO: XR support for procedural instancing because in this case UNITY_ANY_INSTANCING_ENABLED is not defined and instanceID is incorrect.
        #endif
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
        #else
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        #endif
        #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        
                return output;
        }
        
        void BuildAppDataFull(Attributes attributes, VertexDescription vertexDescription, inout appdata_full result)
        {
            result.vertex     = float4(attributes.positionOS, 1);
            result.tangent    = attributes.tangentOS;
            result.normal     = attributes.normalOS;
            result.texcoord   = attributes.uv0;
            result.vertex     = float4(vertexDescription.Position, 1);
            result.normal     = vertexDescription.Normal;
            result.tangent    = float4(vertexDescription.Tangent, 0);
            #if UNITY_ANY_INSTANCING_ENABLED
            #endif
        }
        
        void VaryingsToSurfaceVertex(Varyings varyings, inout v2f_surf result)
        {
            result.pos = varyings.positionCS;
            // World Tangent isn't an available input on v2f_surf
        
        
            #if UNITY_ANY_INSTANCING_ENABLED
            #endif
            #if UNITY_SHOULD_SAMPLE_SH
            #if !defined(LIGHTMAP_ON)
            #endif
            #endif
            #if defined(LIGHTMAP_ON)
            #endif
            #ifdef VARYINGS_NEED_FOG_AND_VERTEX_LIGHT
                result.fogCoord = varyings.fogFactorAndVertexLight.x;
                COPY_TO_LIGHT_COORDS(result, varyings.fogFactorAndVertexLight.yzw);
            #endif
        
            DEFAULT_UNITY_TRANSFER_VERTEX_OUTPUT_STEREO(varyings, result);
        }
        
        void SurfaceVertexToVaryings(v2f_surf surfVertex, inout Varyings result)
        {
            result.positionCS = surfVertex.pos;
            // viewDirectionWS is never filled out in the legacy pass' function. Always use the value computed by SRP
            // World Tangent isn't an available input on v2f_surf
        
            #if UNITY_ANY_INSTANCING_ENABLED
            #endif
            #if UNITY_SHOULD_SAMPLE_SH
            #if !defined(LIGHTMAP_ON)
            #endif
            #endif
            #if defined(LIGHTMAP_ON)
            #endif
            #ifdef VARYINGS_NEED_FOG_AND_VERTEX_LIGHT
                result.fogFactorAndVertexLight.x = surfVertex.fogCoord;
                COPY_FROM_LIGHT_COORDS(result.fogFactorAndVertexLight.yzw, surfVertex);
            #endif
        
            DEFAULT_UNITY_TRANSFER_VERTEX_OUTPUT_STEREO(surfVertex, result);
        }
        
        // --------------------------------------------------
        // Main
        
        #include "Packages/com.unity.shadergraph/Editor/Generation/Targets/BuiltIn/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
        #include "Packages/com.unity.shadergraph/Editor/Generation/Targets/BuiltIn/Editor/ShaderGraph/Includes/Varyings.hlsl"
        #include "Packages/com.unity.shadergraph/Editor/Generation/Targets/BuiltIn/Editor/ShaderGraph/Includes/DepthOnlyPass.hlsl"
        
        ENDHLSL
        }
        Pass
        {
            Name "Meta"
            Tags
            {
                "LightMode" = "Meta"
            }
        
        // Render State
        Cull Off
        
        // Debug
        // <None>
        
        // --------------------------------------------------
        // Pass
        
        HLSLPROGRAM
        
        // Pragmas
        #pragma target 3.0
        #pragma vertex vert
        #pragma fragment frag
        
        // Keywords
        #pragma shader_feature _ _SMOOTHNESS_TEXTURE_ALBEDO_CHANNEL_A
        #pragma shader_feature_local_fragment _ _BUILTIN_SURFACE_TYPE_TRANSPARENT
        #pragma shader_feature_local_fragment _ _BUILTIN_AlphaClip
        #pragma shader_feature_local_fragment _ _BUILTIN_ALPHATEST_ON
        // GraphKeywords: <None>
        
        // Defines
        #define _NORMALMAP 1
        #define _NORMAL_DROPOFF_TS 1
        #define ATTRIBUTES_NEED_NORMAL
        #define ATTRIBUTES_NEED_TANGENT
        #define ATTRIBUTES_NEED_TEXCOORD0
        #define ATTRIBUTES_NEED_TEXCOORD1
        #define ATTRIBUTES_NEED_TEXCOORD2
        #define VARYINGS_NEED_TEXCOORD0
        #define FEATURES_GRAPH_VERTEX
        /* WARNING: $splice Could not find named fragment 'PassInstancing' */
        #define SHADERPASS SHADERPASS_META
        #define BUILTIN_TARGET_API 1
        #ifdef _BUILTIN_SURFACE_TYPE_TRANSPARENT
        #define _SURFACE_TYPE_TRANSPARENT _BUILTIN_SURFACE_TYPE_TRANSPARENT
        #endif
        #ifdef _BUILTIN_ALPHATEST_ON
        #define _ALPHATEST_ON _BUILTIN_ALPHATEST_ON
        #endif
        #ifdef _BUILTIN_AlphaClip
        #define _AlphaClip _BUILTIN_AlphaClip
        #endif
        #ifdef _BUILTIN_ALPHAPREMULTIPLY_ON
        #define _ALPHAPREMULTIPLY_ON _BUILTIN_ALPHAPREMULTIPLY_ON
        #endif
        
        
        // custom interpolator pre-include
        /* WARNING: $splice Could not find named fragment 'sgci_CustomInterpolatorPreInclude' */
        
        // Includes
        #include "Packages/com.unity.shadergraph/Editor/Generation/Targets/BuiltIn/ShaderLibrary/Shim/Shims.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
        #include "Packages/com.unity.shadergraph/Editor/Generation/Targets/BuiltIn/ShaderLibrary/Core.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
        #include "Packages/com.unity.shadergraph/Editor/Generation/Targets/BuiltIn/ShaderLibrary/Lighting.hlsl"
        #include "Packages/com.unity.shadergraph/Editor/Generation/Targets/BuiltIn/Editor/ShaderGraph/Includes/LegacySurfaceVertex.hlsl"
        #include "Packages/com.unity.shadergraph/Editor/Generation/Targets/BuiltIn/ShaderLibrary/ShaderGraphFunctions.hlsl"
        
        // --------------------------------------------------
        // Structs and Packing
        
        // custom interpolators pre packing
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPrePacking' */
        
        struct Attributes
        {
             float3 positionOS : POSITION;
             float3 normalOS : NORMAL;
             float4 tangentOS : TANGENT;
             float4 uv0 : TEXCOORD0;
             float4 uv1 : TEXCOORD1;
             float4 uv2 : TEXCOORD2;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(ATTRIBUTES_NEED_INSTANCEID)
             uint instanceID : INSTANCEID_SEMANTIC;
            #endif
        };
        struct Varyings
        {
             float4 positionCS : SV_POSITION;
             float4 texCoord0;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        struct SurfaceDescriptionInputs
        {
             float4 uv0;
        };
        struct VertexDescriptionInputs
        {
             float3 ObjectSpaceNormal;
             float3 ObjectSpaceTangent;
             float3 ObjectSpacePosition;
        };
        struct PackedVaryings
        {
             float4 positionCS : SV_POSITION;
             float4 texCoord0 : INTERP0;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        
        PackedVaryings PackVaryings (Varyings input)
        {
            PackedVaryings output;
            ZERO_INITIALIZE(PackedVaryings, output);
            output.positionCS = input.positionCS;
            output.texCoord0.xyzw = input.texCoord0;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        
        Varyings UnpackVaryings (PackedVaryings input)
        {
            Varyings output;
            output.positionCS = input.positionCS;
            output.texCoord0 = input.texCoord0.xyzw;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        
        
        // --------------------------------------------------
        // Graph
        
        // Graph Properties
        CBUFFER_START(UnityPerMaterial)
        float4 _Color_Texture_TexelSize;
        float4 _Normal_Texture_TexelSize;
        float4 _ORM_Texture_TexelSize;
        float4 _Emissive_Texture_TexelSize;
        float _Emission;
        float _Param_Roughness;
        float _Param_Metalic;
        float _Param_AO;
        CBUFFER_END
        
        
        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        TEXTURE2D(_Color_Texture);
        SAMPLER(sampler_Color_Texture);
        TEXTURE2D(_Normal_Texture);
        SAMPLER(sampler_Normal_Texture);
        TEXTURE2D(_ORM_Texture);
        SAMPLER(sampler_ORM_Texture);
        TEXTURE2D(_Emissive_Texture);
        SAMPLER(sampler_Emissive_Texture);
        
        // -- Property used by ScenePickingPass
        #ifdef SCENEPICKINGPASS
        float4 _SelectionID;
        #endif
        
        // -- Properties used by SceneSelectionPass
        #ifdef SCENESELECTIONPASS
        int _ObjectId;
        int _PassValue;
        #endif
        
        // Graph Includes
        // GraphIncludes: <None>
        
        // Graph Functions
        
        void Unity_Branch_float4(float Predicate, float4 True, float4 False, out float4 Out)
        {
            Out = Predicate ? True : False;
        }
        
        // Custom interpolators pre vertex
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPreVertex' */
        
        // Graph Vertex
        struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
        };
        
        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            description.Position = IN.ObjectSpacePosition;
            description.Normal = IN.ObjectSpaceNormal;
            description.Tangent = IN.ObjectSpaceTangent;
            return description;
        }
        
        // Custom interpolators, pre surface
        #ifdef FEATURES_GRAPH_VERTEX
        Varyings CustomInterpolatorPassThroughFunc(inout Varyings output, VertexDescription input)
        {
        return output;
        }
        #define CUSTOMINTERPOLATOR_VARYPASSTHROUGH_FUNC
        #endif
        
        // Graph Pixel
        struct SurfaceDescription
        {
            float3 BaseColor;
            float3 Emission;
            float Alpha;
            float AlphaClipThreshold;
        };
        
        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            UnityTexture2D _Property_29d95cca61c84013ba8453d2eba10e9a_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_Color_Texture);
            float4 _SampleTexture2D_1d46dbc4d51248578b3c5b19a9c762b6_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_29d95cca61c84013ba8453d2eba10e9a_Out_0_Texture2D.tex, _Property_29d95cca61c84013ba8453d2eba10e9a_Out_0_Texture2D.samplerstate, _Property_29d95cca61c84013ba8453d2eba10e9a_Out_0_Texture2D.GetTransformedUV(IN.uv0.xy) );
            float _SampleTexture2D_1d46dbc4d51248578b3c5b19a9c762b6_R_4_Float = _SampleTexture2D_1d46dbc4d51248578b3c5b19a9c762b6_RGBA_0_Vector4.r;
            float _SampleTexture2D_1d46dbc4d51248578b3c5b19a9c762b6_G_5_Float = _SampleTexture2D_1d46dbc4d51248578b3c5b19a9c762b6_RGBA_0_Vector4.g;
            float _SampleTexture2D_1d46dbc4d51248578b3c5b19a9c762b6_B_6_Float = _SampleTexture2D_1d46dbc4d51248578b3c5b19a9c762b6_RGBA_0_Vector4.b;
            float _SampleTexture2D_1d46dbc4d51248578b3c5b19a9c762b6_A_7_Float = _SampleTexture2D_1d46dbc4d51248578b3c5b19a9c762b6_RGBA_0_Vector4.a;
            float _Property_17ea8ffc961b4ffd871836de5084ef86_Out_0_Boolean = _Emission;
            UnityTexture2D _Property_411dbbb2322442ebba4716107ea863fe_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_Emissive_Texture);
            float4 _SampleTexture2D_a57be8c4d236480f8104751aa7f681ab_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_411dbbb2322442ebba4716107ea863fe_Out_0_Texture2D.tex, _Property_411dbbb2322442ebba4716107ea863fe_Out_0_Texture2D.samplerstate, _Property_411dbbb2322442ebba4716107ea863fe_Out_0_Texture2D.GetTransformedUV(IN.uv0.xy) );
            float _SampleTexture2D_a57be8c4d236480f8104751aa7f681ab_R_4_Float = _SampleTexture2D_a57be8c4d236480f8104751aa7f681ab_RGBA_0_Vector4.r;
            float _SampleTexture2D_a57be8c4d236480f8104751aa7f681ab_G_5_Float = _SampleTexture2D_a57be8c4d236480f8104751aa7f681ab_RGBA_0_Vector4.g;
            float _SampleTexture2D_a57be8c4d236480f8104751aa7f681ab_B_6_Float = _SampleTexture2D_a57be8c4d236480f8104751aa7f681ab_RGBA_0_Vector4.b;
            float _SampleTexture2D_a57be8c4d236480f8104751aa7f681ab_A_7_Float = _SampleTexture2D_a57be8c4d236480f8104751aa7f681ab_RGBA_0_Vector4.a;
            float4 _Branch_45ebf603e9cf4ff3a4a6dbcc35b2c9e5_Out_3_Vector4;
            Unity_Branch_float4(_Property_17ea8ffc961b4ffd871836de5084ef86_Out_0_Boolean, _SampleTexture2D_a57be8c4d236480f8104751aa7f681ab_RGBA_0_Vector4, float4(0, 0, 0, 0), _Branch_45ebf603e9cf4ff3a4a6dbcc35b2c9e5_Out_3_Vector4);
            UnityTexture2D _Property_8c9189612f044695b5e413fa751834bc_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_Color_Texture);
            float4 _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_8c9189612f044695b5e413fa751834bc_Out_0_Texture2D.tex, _Property_8c9189612f044695b5e413fa751834bc_Out_0_Texture2D.samplerstate, _Property_8c9189612f044695b5e413fa751834bc_Out_0_Texture2D.GetTransformedUV(IN.uv0.xy) );
            float _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_R_4_Float = _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_RGBA_0_Vector4.r;
            float _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_G_5_Float = _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_RGBA_0_Vector4.g;
            float _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_B_6_Float = _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_RGBA_0_Vector4.b;
            float _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_A_7_Float = _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_RGBA_0_Vector4.a;
            surface.BaseColor = (_SampleTexture2D_1d46dbc4d51248578b3c5b19a9c762b6_RGBA_0_Vector4.xyz);
            surface.Emission = (_Branch_45ebf603e9cf4ff3a4a6dbcc35b2c9e5_Out_3_Vector4.xyz);
            surface.Alpha = _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_A_7_Float;
            surface.AlphaClipThreshold = 0.5;
            return surface;
        }
        
        // --------------------------------------------------
        // Build Graph Inputs
        
        VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);
        
            output.ObjectSpaceNormal =                          input.normalOS;
            output.ObjectSpaceTangent =                         input.tangentOS.xyz;
            output.ObjectSpacePosition =                        input.positionOS;
        #if UNITY_ANY_INSTANCING_ENABLED
        #else // TODO: XR support for procedural instancing because in this case UNITY_ANY_INSTANCING_ENABLED is not defined and instanceID is incorrect.
        #endif
        
            return output;
        }
        SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
        
            
        
        
        
        
        
        
            #if UNITY_UV_STARTS_AT_TOP
            #else
            #endif
        
        
            output.uv0 = input.texCoord0;
        #if UNITY_ANY_INSTANCING_ENABLED
        #else // TODO: XR support for procedural instancing because in this case UNITY_ANY_INSTANCING_ENABLED is not defined and instanceID is incorrect.
        #endif
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
        #else
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        #endif
        #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        
                return output;
        }
        
        void BuildAppDataFull(Attributes attributes, VertexDescription vertexDescription, inout appdata_full result)
        {
            result.vertex     = float4(attributes.positionOS, 1);
            result.tangent    = attributes.tangentOS;
            result.normal     = attributes.normalOS;
            result.texcoord   = attributes.uv0;
            result.texcoord1  = attributes.uv1;
            result.texcoord2  = attributes.uv2;
            result.vertex     = float4(vertexDescription.Position, 1);
            result.normal     = vertexDescription.Normal;
            result.tangent    = float4(vertexDescription.Tangent, 0);
            #if UNITY_ANY_INSTANCING_ENABLED
            #endif
        }
        
        void VaryingsToSurfaceVertex(Varyings varyings, inout v2f_surf result)
        {
            result.pos = varyings.positionCS;
            // World Tangent isn't an available input on v2f_surf
        
        
            #if UNITY_ANY_INSTANCING_ENABLED
            #endif
            #if UNITY_SHOULD_SAMPLE_SH
            #if !defined(LIGHTMAP_ON)
            #endif
            #endif
            #if defined(LIGHTMAP_ON)
            #endif
            #ifdef VARYINGS_NEED_FOG_AND_VERTEX_LIGHT
                result.fogCoord = varyings.fogFactorAndVertexLight.x;
                COPY_TO_LIGHT_COORDS(result, varyings.fogFactorAndVertexLight.yzw);
            #endif
        
            DEFAULT_UNITY_TRANSFER_VERTEX_OUTPUT_STEREO(varyings, result);
        }
        
        void SurfaceVertexToVaryings(v2f_surf surfVertex, inout Varyings result)
        {
            result.positionCS = surfVertex.pos;
            // viewDirectionWS is never filled out in the legacy pass' function. Always use the value computed by SRP
            // World Tangent isn't an available input on v2f_surf
        
            #if UNITY_ANY_INSTANCING_ENABLED
            #endif
            #if UNITY_SHOULD_SAMPLE_SH
            #if !defined(LIGHTMAP_ON)
            #endif
            #endif
            #if defined(LIGHTMAP_ON)
            #endif
            #ifdef VARYINGS_NEED_FOG_AND_VERTEX_LIGHT
                result.fogFactorAndVertexLight.x = surfVertex.fogCoord;
                COPY_FROM_LIGHT_COORDS(result.fogFactorAndVertexLight.yzw, surfVertex);
            #endif
        
            DEFAULT_UNITY_TRANSFER_VERTEX_OUTPUT_STEREO(surfVertex, result);
        }
        
        // --------------------------------------------------
        // Main
        
        #include "Packages/com.unity.shadergraph/Editor/Generation/Targets/BuiltIn/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
        #include "Packages/com.unity.shadergraph/Editor/Generation/Targets/BuiltIn/Editor/ShaderGraph/Includes/Varyings.hlsl"
        #include "Packages/com.unity.shadergraph/Editor/Generation/Targets/BuiltIn/Editor/ShaderGraph/Includes/LightingMetaPass.hlsl"
        
        ENDHLSL
        }
        Pass
        {
            Name "SceneSelectionPass"
            Tags
            {
                "LightMode" = "SceneSelectionPass"
            }
        
        // Render State
        Cull Off
        
        // Debug
        // <None>
        
        // --------------------------------------------------
        // Pass
        
        HLSLPROGRAM
        
        // Pragmas
        #pragma target 3.0
        #pragma multi_compile_instancing
        #pragma vertex vert
        #pragma fragment frag
        
        // Keywords
        #pragma shader_feature_local_fragment _ _BUILTIN_SURFACE_TYPE_TRANSPARENT
        #pragma shader_feature_local_fragment _ _BUILTIN_AlphaClip
        #pragma shader_feature_local_fragment _ _BUILTIN_ALPHATEST_ON
        // GraphKeywords: <None>
        
        // Defines
        #define _NORMALMAP 1
        #define _NORMAL_DROPOFF_TS 1
        #define ATTRIBUTES_NEED_NORMAL
        #define ATTRIBUTES_NEED_TANGENT
        #define ATTRIBUTES_NEED_TEXCOORD0
        #define VARYINGS_NEED_TEXCOORD0
        #define FEATURES_GRAPH_VERTEX
        /* WARNING: $splice Could not find named fragment 'PassInstancing' */
        #define SHADERPASS SceneSelectionPass
        #define BUILTIN_TARGET_API 1
        #define SCENESELECTIONPASS 1
        #ifdef _BUILTIN_SURFACE_TYPE_TRANSPARENT
        #define _SURFACE_TYPE_TRANSPARENT _BUILTIN_SURFACE_TYPE_TRANSPARENT
        #endif
        #ifdef _BUILTIN_ALPHATEST_ON
        #define _ALPHATEST_ON _BUILTIN_ALPHATEST_ON
        #endif
        #ifdef _BUILTIN_AlphaClip
        #define _AlphaClip _BUILTIN_AlphaClip
        #endif
        #ifdef _BUILTIN_ALPHAPREMULTIPLY_ON
        #define _ALPHAPREMULTIPLY_ON _BUILTIN_ALPHAPREMULTIPLY_ON
        #endif
        
        
        // custom interpolator pre-include
        /* WARNING: $splice Could not find named fragment 'sgci_CustomInterpolatorPreInclude' */
        
        // Includes
        #include "Packages/com.unity.shadergraph/Editor/Generation/Targets/BuiltIn/ShaderLibrary/Shim/Shims.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
        #include "Packages/com.unity.shadergraph/Editor/Generation/Targets/BuiltIn/ShaderLibrary/Core.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
        #include "Packages/com.unity.shadergraph/Editor/Generation/Targets/BuiltIn/ShaderLibrary/Lighting.hlsl"
        #include "Packages/com.unity.shadergraph/Editor/Generation/Targets/BuiltIn/Editor/ShaderGraph/Includes/LegacySurfaceVertex.hlsl"
        #include "Packages/com.unity.shadergraph/Editor/Generation/Targets/BuiltIn/ShaderLibrary/ShaderGraphFunctions.hlsl"
        
        // --------------------------------------------------
        // Structs and Packing
        
        // custom interpolators pre packing
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPrePacking' */
        
        struct Attributes
        {
             float3 positionOS : POSITION;
             float3 normalOS : NORMAL;
             float4 tangentOS : TANGENT;
             float4 uv0 : TEXCOORD0;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(ATTRIBUTES_NEED_INSTANCEID)
             uint instanceID : INSTANCEID_SEMANTIC;
            #endif
        };
        struct Varyings
        {
             float4 positionCS : SV_POSITION;
             float4 texCoord0;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        struct SurfaceDescriptionInputs
        {
             float4 uv0;
        };
        struct VertexDescriptionInputs
        {
             float3 ObjectSpaceNormal;
             float3 ObjectSpaceTangent;
             float3 ObjectSpacePosition;
        };
        struct PackedVaryings
        {
             float4 positionCS : SV_POSITION;
             float4 texCoord0 : INTERP0;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        
        PackedVaryings PackVaryings (Varyings input)
        {
            PackedVaryings output;
            ZERO_INITIALIZE(PackedVaryings, output);
            output.positionCS = input.positionCS;
            output.texCoord0.xyzw = input.texCoord0;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        
        Varyings UnpackVaryings (PackedVaryings input)
        {
            Varyings output;
            output.positionCS = input.positionCS;
            output.texCoord0 = input.texCoord0.xyzw;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        
        
        // --------------------------------------------------
        // Graph
        
        // Graph Properties
        CBUFFER_START(UnityPerMaterial)
        float4 _Color_Texture_TexelSize;
        float4 _Normal_Texture_TexelSize;
        float4 _ORM_Texture_TexelSize;
        float4 _Emissive_Texture_TexelSize;
        float _Emission;
        float _Param_Roughness;
        float _Param_Metalic;
        float _Param_AO;
        CBUFFER_END
        
        
        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        TEXTURE2D(_Color_Texture);
        SAMPLER(sampler_Color_Texture);
        TEXTURE2D(_Normal_Texture);
        SAMPLER(sampler_Normal_Texture);
        TEXTURE2D(_ORM_Texture);
        SAMPLER(sampler_ORM_Texture);
        TEXTURE2D(_Emissive_Texture);
        SAMPLER(sampler_Emissive_Texture);
        
        // -- Property used by ScenePickingPass
        #ifdef SCENEPICKINGPASS
        float4 _SelectionID;
        #endif
        
        // -- Properties used by SceneSelectionPass
        #ifdef SCENESELECTIONPASS
        int _ObjectId;
        int _PassValue;
        #endif
        
        // Graph Includes
        // GraphIncludes: <None>
        
        // Graph Functions
        // GraphFunctions: <None>
        
        // Custom interpolators pre vertex
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPreVertex' */
        
        // Graph Vertex
        struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
        };
        
        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            description.Position = IN.ObjectSpacePosition;
            description.Normal = IN.ObjectSpaceNormal;
            description.Tangent = IN.ObjectSpaceTangent;
            return description;
        }
        
        // Custom interpolators, pre surface
        #ifdef FEATURES_GRAPH_VERTEX
        Varyings CustomInterpolatorPassThroughFunc(inout Varyings output, VertexDescription input)
        {
        return output;
        }
        #define CUSTOMINTERPOLATOR_VARYPASSTHROUGH_FUNC
        #endif
        
        // Graph Pixel
        struct SurfaceDescription
        {
            float Alpha;
            float AlphaClipThreshold;
        };
        
        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            UnityTexture2D _Property_8c9189612f044695b5e413fa751834bc_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_Color_Texture);
            float4 _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_8c9189612f044695b5e413fa751834bc_Out_0_Texture2D.tex, _Property_8c9189612f044695b5e413fa751834bc_Out_0_Texture2D.samplerstate, _Property_8c9189612f044695b5e413fa751834bc_Out_0_Texture2D.GetTransformedUV(IN.uv0.xy) );
            float _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_R_4_Float = _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_RGBA_0_Vector4.r;
            float _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_G_5_Float = _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_RGBA_0_Vector4.g;
            float _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_B_6_Float = _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_RGBA_0_Vector4.b;
            float _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_A_7_Float = _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_RGBA_0_Vector4.a;
            surface.Alpha = _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_A_7_Float;
            surface.AlphaClipThreshold = 0.5;
            return surface;
        }
        
        // --------------------------------------------------
        // Build Graph Inputs
        
        VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);
        
            output.ObjectSpaceNormal =                          input.normalOS;
            output.ObjectSpaceTangent =                         input.tangentOS.xyz;
            output.ObjectSpacePosition =                        input.positionOS;
        #if UNITY_ANY_INSTANCING_ENABLED
        #else // TODO: XR support for procedural instancing because in this case UNITY_ANY_INSTANCING_ENABLED is not defined and instanceID is incorrect.
        #endif
        
            return output;
        }
        SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
        
            
        
        
        
        
        
        
            #if UNITY_UV_STARTS_AT_TOP
            #else
            #endif
        
        
            output.uv0 = input.texCoord0;
        #if UNITY_ANY_INSTANCING_ENABLED
        #else // TODO: XR support for procedural instancing because in this case UNITY_ANY_INSTANCING_ENABLED is not defined and instanceID is incorrect.
        #endif
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
        #else
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        #endif
        #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        
                return output;
        }
        
        void BuildAppDataFull(Attributes attributes, VertexDescription vertexDescription, inout appdata_full result)
        {
            result.vertex     = float4(attributes.positionOS, 1);
            result.tangent    = attributes.tangentOS;
            result.normal     = attributes.normalOS;
            result.texcoord   = attributes.uv0;
            result.vertex     = float4(vertexDescription.Position, 1);
            result.normal     = vertexDescription.Normal;
            result.tangent    = float4(vertexDescription.Tangent, 0);
            #if UNITY_ANY_INSTANCING_ENABLED
            #endif
        }
        
        void VaryingsToSurfaceVertex(Varyings varyings, inout v2f_surf result)
        {
            result.pos = varyings.positionCS;
            // World Tangent isn't an available input on v2f_surf
        
        
            #if UNITY_ANY_INSTANCING_ENABLED
            #endif
            #if UNITY_SHOULD_SAMPLE_SH
            #if !defined(LIGHTMAP_ON)
            #endif
            #endif
            #if defined(LIGHTMAP_ON)
            #endif
            #ifdef VARYINGS_NEED_FOG_AND_VERTEX_LIGHT
                result.fogCoord = varyings.fogFactorAndVertexLight.x;
                COPY_TO_LIGHT_COORDS(result, varyings.fogFactorAndVertexLight.yzw);
            #endif
        
            DEFAULT_UNITY_TRANSFER_VERTEX_OUTPUT_STEREO(varyings, result);
        }
        
        void SurfaceVertexToVaryings(v2f_surf surfVertex, inout Varyings result)
        {
            result.positionCS = surfVertex.pos;
            // viewDirectionWS is never filled out in the legacy pass' function. Always use the value computed by SRP
            // World Tangent isn't an available input on v2f_surf
        
            #if UNITY_ANY_INSTANCING_ENABLED
            #endif
            #if UNITY_SHOULD_SAMPLE_SH
            #if !defined(LIGHTMAP_ON)
            #endif
            #endif
            #if defined(LIGHTMAP_ON)
            #endif
            #ifdef VARYINGS_NEED_FOG_AND_VERTEX_LIGHT
                result.fogFactorAndVertexLight.x = surfVertex.fogCoord;
                COPY_FROM_LIGHT_COORDS(result.fogFactorAndVertexLight.yzw, surfVertex);
            #endif
        
            DEFAULT_UNITY_TRANSFER_VERTEX_OUTPUT_STEREO(surfVertex, result);
        }
        
        // --------------------------------------------------
        // Main
        
        #include "Packages/com.unity.shadergraph/Editor/Generation/Targets/BuiltIn/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
        #include "Packages/com.unity.shadergraph/Editor/Generation/Targets/BuiltIn/Editor/ShaderGraph/Includes/Varyings.hlsl"
        #include "Packages/com.unity.shadergraph/Editor/Generation/Targets/BuiltIn/Editor/ShaderGraph/Includes/DepthOnlyPass.hlsl"
        
        ENDHLSL
        }
        Pass
        {
            Name "ScenePickingPass"
            Tags
            {
                "LightMode" = "Picking"
            }
        
        // Render State
        Cull [_BUILTIN_CullMode]
        
        // Debug
        // <None>
        
        // --------------------------------------------------
        // Pass
        
        HLSLPROGRAM
        
        // Pragmas
        #pragma target 3.0
        #pragma multi_compile_instancing
        #pragma vertex vert
        #pragma fragment frag
        
        // Keywords
        #pragma shader_feature_local_fragment _ _BUILTIN_SURFACE_TYPE_TRANSPARENT
        #pragma shader_feature_local_fragment _ _BUILTIN_AlphaClip
        #pragma shader_feature_local_fragment _ _BUILTIN_ALPHATEST_ON
        // GraphKeywords: <None>
        
        // Defines
        #define _NORMALMAP 1
        #define _NORMAL_DROPOFF_TS 1
        #define ATTRIBUTES_NEED_NORMAL
        #define ATTRIBUTES_NEED_TANGENT
        #define ATTRIBUTES_NEED_TEXCOORD0
        #define VARYINGS_NEED_TEXCOORD0
        #define FEATURES_GRAPH_VERTEX
        /* WARNING: $splice Could not find named fragment 'PassInstancing' */
        #define SHADERPASS ScenePickingPass
        #define BUILTIN_TARGET_API 1
        #define SCENEPICKINGPASS 1
        #ifdef _BUILTIN_SURFACE_TYPE_TRANSPARENT
        #define _SURFACE_TYPE_TRANSPARENT _BUILTIN_SURFACE_TYPE_TRANSPARENT
        #endif
        #ifdef _BUILTIN_ALPHATEST_ON
        #define _ALPHATEST_ON _BUILTIN_ALPHATEST_ON
        #endif
        #ifdef _BUILTIN_AlphaClip
        #define _AlphaClip _BUILTIN_AlphaClip
        #endif
        #ifdef _BUILTIN_ALPHAPREMULTIPLY_ON
        #define _ALPHAPREMULTIPLY_ON _BUILTIN_ALPHAPREMULTIPLY_ON
        #endif
        
        
        // custom interpolator pre-include
        /* WARNING: $splice Could not find named fragment 'sgci_CustomInterpolatorPreInclude' */
        
        // Includes
        #include "Packages/com.unity.shadergraph/Editor/Generation/Targets/BuiltIn/ShaderLibrary/Shim/Shims.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
        #include "Packages/com.unity.shadergraph/Editor/Generation/Targets/BuiltIn/ShaderLibrary/Core.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
        #include "Packages/com.unity.shadergraph/Editor/Generation/Targets/BuiltIn/ShaderLibrary/Lighting.hlsl"
        #include "Packages/com.unity.shadergraph/Editor/Generation/Targets/BuiltIn/Editor/ShaderGraph/Includes/LegacySurfaceVertex.hlsl"
        #include "Packages/com.unity.shadergraph/Editor/Generation/Targets/BuiltIn/ShaderLibrary/ShaderGraphFunctions.hlsl"
        
        // --------------------------------------------------
        // Structs and Packing
        
        // custom interpolators pre packing
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPrePacking' */
        
        struct Attributes
        {
             float3 positionOS : POSITION;
             float3 normalOS : NORMAL;
             float4 tangentOS : TANGENT;
             float4 uv0 : TEXCOORD0;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(ATTRIBUTES_NEED_INSTANCEID)
             uint instanceID : INSTANCEID_SEMANTIC;
            #endif
        };
        struct Varyings
        {
             float4 positionCS : SV_POSITION;
             float4 texCoord0;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        struct SurfaceDescriptionInputs
        {
             float4 uv0;
        };
        struct VertexDescriptionInputs
        {
             float3 ObjectSpaceNormal;
             float3 ObjectSpaceTangent;
             float3 ObjectSpacePosition;
        };
        struct PackedVaryings
        {
             float4 positionCS : SV_POSITION;
             float4 texCoord0 : INTERP0;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        
        PackedVaryings PackVaryings (Varyings input)
        {
            PackedVaryings output;
            ZERO_INITIALIZE(PackedVaryings, output);
            output.positionCS = input.positionCS;
            output.texCoord0.xyzw = input.texCoord0;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        
        Varyings UnpackVaryings (PackedVaryings input)
        {
            Varyings output;
            output.positionCS = input.positionCS;
            output.texCoord0 = input.texCoord0.xyzw;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        
        
        // --------------------------------------------------
        // Graph
        
        // Graph Properties
        CBUFFER_START(UnityPerMaterial)
        float4 _Color_Texture_TexelSize;
        float4 _Normal_Texture_TexelSize;
        float4 _ORM_Texture_TexelSize;
        float4 _Emissive_Texture_TexelSize;
        float _Emission;
        float _Param_Roughness;
        float _Param_Metalic;
        float _Param_AO;
        CBUFFER_END
        
        
        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        TEXTURE2D(_Color_Texture);
        SAMPLER(sampler_Color_Texture);
        TEXTURE2D(_Normal_Texture);
        SAMPLER(sampler_Normal_Texture);
        TEXTURE2D(_ORM_Texture);
        SAMPLER(sampler_ORM_Texture);
        TEXTURE2D(_Emissive_Texture);
        SAMPLER(sampler_Emissive_Texture);
        
        // -- Property used by ScenePickingPass
        #ifdef SCENEPICKINGPASS
        float4 _SelectionID;
        #endif
        
        // -- Properties used by SceneSelectionPass
        #ifdef SCENESELECTIONPASS
        int _ObjectId;
        int _PassValue;
        #endif
        
        // Graph Includes
        // GraphIncludes: <None>
        
        // Graph Functions
        // GraphFunctions: <None>
        
        // Custom interpolators pre vertex
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPreVertex' */
        
        // Graph Vertex
        struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
        };
        
        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            description.Position = IN.ObjectSpacePosition;
            description.Normal = IN.ObjectSpaceNormal;
            description.Tangent = IN.ObjectSpaceTangent;
            return description;
        }
        
        // Custom interpolators, pre surface
        #ifdef FEATURES_GRAPH_VERTEX
        Varyings CustomInterpolatorPassThroughFunc(inout Varyings output, VertexDescription input)
        {
        return output;
        }
        #define CUSTOMINTERPOLATOR_VARYPASSTHROUGH_FUNC
        #endif
        
        // Graph Pixel
        struct SurfaceDescription
        {
            float Alpha;
            float AlphaClipThreshold;
        };
        
        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            UnityTexture2D _Property_8c9189612f044695b5e413fa751834bc_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_Color_Texture);
            float4 _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_8c9189612f044695b5e413fa751834bc_Out_0_Texture2D.tex, _Property_8c9189612f044695b5e413fa751834bc_Out_0_Texture2D.samplerstate, _Property_8c9189612f044695b5e413fa751834bc_Out_0_Texture2D.GetTransformedUV(IN.uv0.xy) );
            float _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_R_4_Float = _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_RGBA_0_Vector4.r;
            float _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_G_5_Float = _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_RGBA_0_Vector4.g;
            float _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_B_6_Float = _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_RGBA_0_Vector4.b;
            float _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_A_7_Float = _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_RGBA_0_Vector4.a;
            surface.Alpha = _SampleTexture2D_576b5c4be53e4145ba41169f26219eac_A_7_Float;
            surface.AlphaClipThreshold = 0.5;
            return surface;
        }
        
        // --------------------------------------------------
        // Build Graph Inputs
        
        VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);
        
            output.ObjectSpaceNormal =                          input.normalOS;
            output.ObjectSpaceTangent =                         input.tangentOS.xyz;
            output.ObjectSpacePosition =                        input.positionOS;
        #if UNITY_ANY_INSTANCING_ENABLED
        #else // TODO: XR support for procedural instancing because in this case UNITY_ANY_INSTANCING_ENABLED is not defined and instanceID is incorrect.
        #endif
        
            return output;
        }
        SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
        
            
        
        
        
        
        
        
            #if UNITY_UV_STARTS_AT_TOP
            #else
            #endif
        
        
            output.uv0 = input.texCoord0;
        #if UNITY_ANY_INSTANCING_ENABLED
        #else // TODO: XR support for procedural instancing because in this case UNITY_ANY_INSTANCING_ENABLED is not defined and instanceID is incorrect.
        #endif
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
        #else
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        #endif
        #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        
                return output;
        }
        
        void BuildAppDataFull(Attributes attributes, VertexDescription vertexDescription, inout appdata_full result)
        {
            result.vertex     = float4(attributes.positionOS, 1);
            result.tangent    = attributes.tangentOS;
            result.normal     = attributes.normalOS;
            result.texcoord   = attributes.uv0;
            result.vertex     = float4(vertexDescription.Position, 1);
            result.normal     = vertexDescription.Normal;
            result.tangent    = float4(vertexDescription.Tangent, 0);
            #if UNITY_ANY_INSTANCING_ENABLED
            #endif
        }
        
        void VaryingsToSurfaceVertex(Varyings varyings, inout v2f_surf result)
        {
            result.pos = varyings.positionCS;
            // World Tangent isn't an available input on v2f_surf
        
        
            #if UNITY_ANY_INSTANCING_ENABLED
            #endif
            #if UNITY_SHOULD_SAMPLE_SH
            #if !defined(LIGHTMAP_ON)
            #endif
            #endif
            #if defined(LIGHTMAP_ON)
            #endif
            #ifdef VARYINGS_NEED_FOG_AND_VERTEX_LIGHT
                result.fogCoord = varyings.fogFactorAndVertexLight.x;
                COPY_TO_LIGHT_COORDS(result, varyings.fogFactorAndVertexLight.yzw);
            #endif
        
            DEFAULT_UNITY_TRANSFER_VERTEX_OUTPUT_STEREO(varyings, result);
        }
        
        void SurfaceVertexToVaryings(v2f_surf surfVertex, inout Varyings result)
        {
            result.positionCS = surfVertex.pos;
            // viewDirectionWS is never filled out in the legacy pass' function. Always use the value computed by SRP
            // World Tangent isn't an available input on v2f_surf
        
            #if UNITY_ANY_INSTANCING_ENABLED
            #endif
            #if UNITY_SHOULD_SAMPLE_SH
            #if !defined(LIGHTMAP_ON)
            #endif
            #endif
            #if defined(LIGHTMAP_ON)
            #endif
            #ifdef VARYINGS_NEED_FOG_AND_VERTEX_LIGHT
                result.fogFactorAndVertexLight.x = surfVertex.fogCoord;
                COPY_FROM_LIGHT_COORDS(result.fogFactorAndVertexLight.yzw, surfVertex);
            #endif
        
            DEFAULT_UNITY_TRANSFER_VERTEX_OUTPUT_STEREO(surfVertex, result);
        }
        
        // --------------------------------------------------
        // Main
        
        #include "Packages/com.unity.shadergraph/Editor/Generation/Targets/BuiltIn/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
        #include "Packages/com.unity.shadergraph/Editor/Generation/Targets/BuiltIn/Editor/ShaderGraph/Includes/Varyings.hlsl"
        #include "Packages/com.unity.shadergraph/Editor/Generation/Targets/BuiltIn/Editor/ShaderGraph/Includes/DepthOnlyPass.hlsl"
        
        ENDHLSL
        }
    }
    CustomEditor "UnityEditor.ShaderGraph.GenericShaderGraphMaterialGUI"
    CustomEditorForRenderPipeline "UnityEditor.Rendering.BuiltIn.ShaderGraph.BuiltInLitGUI" ""
    CustomEditorForRenderPipeline "UnityEditor.ShaderGraphLitGUI" "UnityEngine.Rendering.Universal.UniversalRenderPipelineAsset"
    FallBack "Hidden/Shader Graph/FallbackError"
}