// Made with Amplify Shader Editor v1.9.1.5
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "UITest"
{
	Properties
	{
		_EdgeTex("EdgeTex", 2D) = "white" {}
		[HDR]_EdgeTexCol("EdgeTexCol", Color) = (0,0,0,0)
		_BackgroundTex("BackgroundTex", 2D) = "white" {}
		[HDR]_BackgroundTexCol("BackgroundTexCol", Color) = (0,0,0,0)
		_ExtendTex("ExtendTex", 2D) = "white" {}
		_ExtendSize("ExtendSize", Vector) = (0.1,0.1,0,0)
		_ExtendStrenthOffset_AddMulPow("ExtendStrenthOffset_Add/Mul/Pow", Vector) = (0,1,0.2,0)
		_ExtendDistanceOffset_AddMulPow("ExtendDistanceOffset_Add/Mul/Pow", Vector) = (0,1,1,0)
		[HDR]_ExtendEdgeCol("ExtendEdgeCol", Color) = (1.521569,2.384314,4,1)
		_ExtendEdgeSize("ExtendEdgeSize", Float) = 1.25
		[HDR]_EdgeBrightSquareCol("EdgeBrightSquareCol", Color) = (0.5330188,0.8087932,1,1)
		_EdgeBrightSquare_AddMultPow("EdgeBrightSquare_Add/Mult/Pow", Vector) = (0,0,0,0)
		_EdgeBrightSquareReduceMult_DisProgress("EdgeBrightSquareReduceMult_Dis/Progress", Vector) = (1,1,0,0)
		_EdgeBrightSquareNoiseStrength_MinMax("EdgeBrightSquareNoiseStrength_Min/Max", Vector) = (1,1,0,0)
		_ImageTex("ImageTex", 2D) = "white" {}
		[HDR]_ImageTexCol("ImageTexCol", Color) = (1,1,1,1)
		_ImageNoiseStrength("ImageNoiseStrength", Float) = 0.005
		_ImageNoisePanSpeedSecondNoiseOffset("ImageNoisePanSpeed/SecondNoiseOffset", Vector) = (0,0,0,0)
		_GlithTex("GlithTex", 2D) = "white" {}
		_GlithTex_TillingOffset("GlithTex_Tilling/Offset", Vector) = (1,1,0,0)
		_GlithTexReference_TillingOffset("GlithTexReference_Tilling/Offset", Vector) = (1,1,0,0)
		_GlithTexStepPanNoise_ScalePowMult("GlithTexStep/PanNoise_Scale/Pow/Mult", Vector) = (0.99,5,20,1)
		_GlithPanSpeed("GlithPanSpeed", Vector) = (0,0,0,0)
		_GlithRed_OffsetStrengthColorStrength("GlithRed_OffsetStrength/ColorStrength", Vector) = (0.2,10,0,0)
		_Progress("Progress", Range( 0 , 1)) = 0
		_ProgressRemapValue_12("ProgressRemapValue_1/2", Vector) = (0,0.5,0.5,1)
		_ProgressRemapValue_3("ProgressRemapValue_3/-", Vector) = (0,0.5,0.5,1)

	}
	
	SubShader
	{
		
		
		Tags { "RenderType"="Transparent" }
	LOD 100

		CGINCLUDE
		#pragma target 3.0
		ENDCG
		Blend SrcAlpha OneMinusSrcAlpha
		AlphaToMask Off
		Cull Back
		ColorMask RGBA
		ZWrite Off
		ZTest LEqual
		Offset 0 , 0
		
		
		
		Pass
		{
			Name "Unlit"

			CGPROGRAM

			

			#ifndef UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX
			//only defining to not throw compilation error over Unity 5.5
			#define UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(input)
			#endif
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile_instancing
			#include "UnityCG.cginc"
			#include "UnityShaderVariables.cginc"


			struct appdata
			{
				float4 vertex : POSITION;
				float4 color : COLOR;
				float4 ase_texcoord : TEXCOORD0;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};
			
			struct v2f
			{
				float4 vertex : SV_POSITION;
				#ifdef ASE_NEEDS_FRAG_WORLD_POSITION
				float3 worldPos : TEXCOORD0;
				#endif
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_texcoord2 : TEXCOORD2;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			uniform float4 _NewPos[4];
			uniform float4 _OriPos[4];
			uniform float4 _EdgeTexCol;
			uniform sampler2D _EdgeTex;
			uniform float _Progress;
			uniform float4 _ProgressRemapValue_12;
			uniform float4 _BackgroundTexCol;
			uniform sampler2D _BackgroundTex;
			uniform float4 _ImageTexCol;
			uniform sampler2D _ImageTex;
			uniform sampler2D _GlithTex;
			uniform float4 _ImageNoisePanSpeedSecondNoiseOffset;
			uniform float4 _GlithTex_TillingOffset;
			uniform float4 _GlithTexReference_TillingOffset;
			uniform float _ImageNoiseStrength;
			uniform float4 _GlithTexStepPanNoise_ScalePowMult;
			uniform float2 _GlithPanSpeed;
			uniform float2 _GlithRed_OffsetStrengthColorStrength;
			uniform float4 _EdgeBrightSquareCol;
			uniform float2 _ExtendSize;
			uniform float4 _ProgressRemapValue_3;
			uniform float3 _EdgeBrightSquare_AddMultPow;
			uniform float2 _EdgeBrightSquareNoiseStrength_MinMax;
			uniform float2 _EdgeBrightSquareReduceMult_DisProgress;
			uniform sampler2D _ExtendTex;
			uniform float4 _ExtendStrenthOffset_AddMulPow;
			uniform float3 _ExtendDistanceOffset_AddMulPow;
			uniform float _ExtendEdgeSize;
			uniform float4 _ExtendEdgeCol;
			float3 mod2D289( float3 x ) { return x - floor( x * ( 1.0 / 289.0 ) ) * 289.0; }
			float2 mod2D289( float2 x ) { return x - floor( x * ( 1.0 / 289.0 ) ) * 289.0; }
			float3 permute( float3 x ) { return mod2D289( ( ( x * 34.0 ) + 1.0 ) * x ); }
			float snoise( float2 v )
			{
				const float4 C = float4( 0.211324865405187, 0.366025403784439, -0.577350269189626, 0.024390243902439 );
				float2 i = floor( v + dot( v, C.yy ) );
				float2 x0 = v - i + dot( i, C.xx );
				float2 i1;
				i1 = ( x0.x > x0.y ) ? float2( 1.0, 0.0 ) : float2( 0.0, 1.0 );
				float4 x12 = x0.xyxy + C.xxzz;
				x12.xy -= i1;
				i = mod2D289( i );
				float3 p = permute( permute( i.y + float3( 0.0, i1.y, 1.0 ) ) + i.x + float3( 0.0, i1.x, 1.0 ) );
				float3 m = max( 0.5 - float3( dot( x0, x0 ), dot( x12.xy, x12.xy ), dot( x12.zw, x12.zw ) ), 0.0 );
				m = m * m;
				m = m * m;
				float3 x = 2.0 * frac( p * C.www ) - 1.0;
				float3 h = abs( x ) - 0.5;
				float3 ox = floor( x + 0.5 );
				float3 a0 = x - ox;
				m *= 1.79284291400159 - 0.85373472095314 * ( a0 * a0 + h * h );
				float3 g;
				g.x = a0.x * x0.x + h.x * x0.y;
				g.yz = a0.yz * x12.xz + h.yz * x12.yw;
				return 130.0 * dot( m, g );
			}
			

			
			v2f vert ( appdata v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
				UNITY_TRANSFER_INSTANCE_ID(v, o);

				float4 ase_clipPos = UnityObjectToClipPos(v.vertex);
				float4 screenPos = ComputeScreenPos(ase_clipPos);
				o.ase_texcoord1 = screenPos;
				
				o.ase_texcoord2.xy = v.ase_texcoord.xy;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord2.zw = 0;
				float3 vertexValue = float3(0, 0, 0);
				#if ASE_ABSOLUTE_VERTEX_POS
				vertexValue = v.vertex.xyz;
				#endif
				vertexValue = vertexValue;
				#if ASE_ABSOLUTE_VERTEX_POS
				v.vertex.xyz = vertexValue;
				#else
				v.vertex.xyz += vertexValue;
				#endif
				o.vertex = UnityObjectToClipPos(v.vertex);

				#ifdef ASE_NEEDS_FRAG_WORLD_POSITION
				o.worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
				#endif
				return o;
			}
			
			fixed4 frag (v2f i ) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID(i);
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(i);
				fixed4 finalColor;
				#ifdef ASE_NEEDS_FRAG_WORLD_POSITION
				float3 WorldPosition = i.worldPos;
				#endif
				float2 _Vector5 = float2(1440,2560);
				float4 screenPos = i.ase_texcoord1;
				float4 ase_screenPosNorm = screenPos / screenPos.w;
				ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
				float4 break104 = ase_screenPosNorm;
				float4 appendResult106 = (float4(( _Vector5.x * break104.x ) , ( _Vector5.y * break104.y ) , 0.0 , 0.0));
				float4 ScreenPos_Pixel127 = appendResult106;
				float4 break86 = ( ScreenPos_Pixel127 - float4( ( _OriPos[0] * float2( 1,1 ) ), 0.0 , 0.0 ) );
				float OriLength74 = ( ( _OriPos[3] - _OriPos[0] ) * float2( 1,1 ) ).x;
				float OriWidth78 = ( ( _OriPos[1] - _OriPos[0] ) * float2( 1,1 ) ).y;
				float2 appendResult89 = (float2(( break86.x / OriLength74 ) , ( break86.y / OriWidth78 )));
				float2 OriUV192 = appendResult89;
				float4 break136 = ( ScreenPos_Pixel127 - float4( ( _NewPos[0] * float2( 1,1 ) ), 0.0 , 0.0 ) );
				float NewLength153 = ( ( _NewPos[3] - _NewPos[0] ) * float2( 1,1 ) ).x;
				float NewWidth154 = ( ( _NewPos[1] - _NewPos[0] ) * float2( 1,1 ) ).y;
				float2 appendResult137 = (float2(( break136.x / NewLength153 ) , ( break136.y / NewWidth154 )));
				float2 NewUV193 = appendResult137;
				float ProgressValue166 = _Progress;
				float clampResult182 = clamp( ProgressValue166 , _ProgressRemapValue_12.x , _ProgressRemapValue_12.y );
				float FirstProgressValue180 = (0.0 + (clampResult182 - _ProgressRemapValue_12.x) * (1.0 - 0.0) / (_ProgressRemapValue_12.y - _ProgressRemapValue_12.x));
				float2 lerpResult162 = lerp( OriUV192 , NewUV193 , FirstProgressValue180);
				float2 RemapUV359 = lerpResult162;
				float4 tex2DNode5 = tex2D( _EdgeTex, RemapUV359 );
				float4 tex2DNode191 = tex2D( _BackgroundTex, RemapUV359 );
				float temp_output_305_0 = step( 0.05 , tex2DNode191.a );
				float clampResult185 = clamp( ProgressValue166 , _ProgressRemapValue_12.z , _ProgressRemapValue_12.w );
				float SecondProgressValue187 = (0.0 + (clampResult185 - _ProgressRemapValue_12.z) * (1.0 - 0.0) / (_ProgressRemapValue_12.w - _ProgressRemapValue_12.z));
				float2 appendResult561 = (float2(_ImageNoisePanSpeedSecondNoiseOffset.x , _ImageNoisePanSpeedSecondNoiseOffset.y));
				float2 appendResult513 = (float2(_GlithTex_TillingOffset.x , _GlithTex_TillingOffset.y));
				float2 appendResult514 = (float2(_GlithTex_TillingOffset.z , _GlithTex_TillingOffset.w));
				float2 texCoord556 = i.ase_texcoord2.xy * appendResult513 + appendResult514;
				float2 panner558 = ( 1.0 * _Time.y * appendResult561 + texCoord556);
				float2 appendResult564 = (float2(( _ImageNoisePanSpeedSecondNoiseOffset.x * _ImageNoisePanSpeedSecondNoiseOffset.z ) , ( _ImageNoisePanSpeedSecondNoiseOffset.y * _ImageNoisePanSpeedSecondNoiseOffset.w )));
				float2 appendResult516 = (float2(_GlithTexReference_TillingOffset.x , _GlithTexReference_TillingOffset.y));
				float2 appendResult517 = (float2(_GlithTexReference_TillingOffset.z , _GlithTexReference_TillingOffset.w));
				float2 texCoord555 = i.ase_texcoord2.xy * appendResult516 + appendResult517;
				float2 panner557 = ( 1.0 * _Time.y * appendResult564 + texCoord555);
				float2 texCoord505 = i.ase_texcoord2.xy * appendResult513 + appendResult514;
				float2 texCoord503 = i.ase_texcoord2.xy * appendResult516 + appendResult517;
				float temp_output_468_0 = step( _GlithTexStepPanNoise_ScalePowMult.x , ( 1.0 - max( tex2D( _GlithTex, texCoord505 ).r , tex2D( _GlithTex, texCoord503 ).r ) ) );
				float2 texCoord470 = i.ase_texcoord2.xy * float2( 1,1 ) + float2( 0,0 );
				float2 panner471 = ( 1.0 * _Time.y * _GlithPanSpeed + texCoord470);
				float simplePerlin2D469 = snoise( panner471*_GlithTexStepPanNoise_ScalePowMult.y );
				simplePerlin2D469 = simplePerlin2D469*0.5 + 0.5;
				float2 panner498 = ( 1.0 * _Time.y * ( _GlithPanSpeed * float2( 1,-1 ) ) + texCoord470);
				float simplePerlin2D494 = snoise( panner498*5.0 );
				simplePerlin2D494 = simplePerlin2D494*0.5 + 0.5;
				float2 appendResult464 = (float2(( ( ( 1.0 - max( tex2D( _GlithTex, panner558 ).r , tex2D( _GlithTex, panner557 ).r ) ) * _ImageNoiseStrength ) + ( temp_output_468_0 * pow( min( simplePerlin2D469 , simplePerlin2D494 ) , _GlithTexStepPanNoise_ScalePowMult.z ) * _GlithTexStepPanNoise_ScalePowMult.w ) ) , 0.0));
				float4 color522 = IsGammaSpace() ? float4(1,0,0,1) : float4(1,0,0,1);
				float temp_output_531_0 = ( temp_output_468_0 * _GlithTexStepPanNoise_ScalePowMult.w * pow( max( simplePerlin2D469 , simplePerlin2D494 ) , _GlithTexStepPanNoise_ScalePowMult.z ) );
				float2 appendResult538 = (float2(temp_output_531_0 , 0.0));
				float4 appendResult519 = (float4(( tex2D( _ImageTex, ( appendResult464 + RemapUV359 ) ) + ( color522 * step( 0.1 , tex2D( _ImageTex, ( RemapUV359 + ( appendResult538 * _GlithRed_OffsetStrengthColorStrength.x ) ) ).a ) * _GlithRed_OffsetStrengthColorStrength.y * temp_output_531_0 ) )));
				float4 ImageCol461 = saturate( appendResult519 );
				float2 texCoord364 = i.ase_texcoord2.xy * float2( 1,1 ) + float2( 0,0 );
				float2 ExtendSize246 = _ExtendSize;
				float2 break370 = ExtendSize246;
				float2 appendResult374 = (float2(( 1.0 / break370.x ) , ( 1.0 / break370.y )));
				float2 FlooredUV396 = ( floor( ( texCoord364 * appendResult374 ) ) / appendResult374 );
				float clampResult266 = clamp( ProgressValue166 , _ProgressRemapValue_3.x , _ProgressRemapValue_3.y );
				float ThirdProgressValue268 = (0.0 + (clampResult266 - _ProgressRemapValue_3.x) * (1.0 - 0.0) / (_ProgressRemapValue_3.y - _ProgressRemapValue_3.x));
				float2 _Vector0 = float2(1,1);
				float2 ExtendStartPos232 = ( ( ( ( _OriPos[2] * _Vector0 ) + ( _Vector0 * _OriPos[0] ) ) / 2.0 ) / float2( 1440,2560 ) );
				float simplePerlin2D376 = snoise( ( FlooredUV396 * step( 0.0 , ( ThirdProgressValue268 - pow( ( ( distance( ExtendStartPos232 , FlooredUV396 ) + _EdgeBrightSquare_AddMultPow.x ) * _EdgeBrightSquare_AddMultPow.y ) , _EdgeBrightSquare_AddMultPow.z ) ) ) )*50.0 );
				simplePerlin2D376 = simplePerlin2D376*0.5 + 0.5;
				float FlooredExtendDistance425 = distance( ExtendStartPos232 , FlooredUV396 );
				float EdgeBrightSquareValue387 = saturate( ( ( (_EdgeBrightSquareNoiseStrength_MinMax.x + (simplePerlin2D376 - 0.0) * (_EdgeBrightSquareNoiseStrength_MinMax.y - _EdgeBrightSquareNoiseStrength_MinMax.x) / (1.0 - 0.0)) * FlooredExtendDistance425 * _EdgeBrightSquareReduceMult_DisProgress.x ) - ( ThirdProgressValue268 * _EdgeBrightSquareReduceMult_DisProgress.y ) ) );
				float4 lerpResult406 = lerp( ( _ImageTexCol * ImageCol461 ) , _EdgeBrightSquareCol , EdgeBrightSquareValue387);
				float2 texCoord234 = i.ase_texcoord2.xy * float2( 1,1 ) + float2( 0,0 );
				float2 break248 = ExtendSize246;
				float2 appendResult238 = (float2(fmod( texCoord234.x , break248.x ) , fmod( texCoord234.y , break248.y )));
				float2 FlooredAndRemapedUV399 = (float2( 0,0 ) + (appendResult238 - float2( 0,0 )) * (float2( 1,1 ) - float2( 0,0 )) / (ExtendSize246 - float2( 0,0 )));
				float4 ExtendStrenthOffset258 = _ExtendStrenthOffset_AddMulPow;
				float4 break260 = ExtendStrenthOffset258;
				float temp_output_254_0 = pow( ( ( tex2D( _ExtendTex, FlooredAndRemapedUV399 ).r + break260.x ) * break260.y ) , break260.z );
				float2 texCoord216 = i.ase_texcoord2.xy * float2( 1,1 ) + float2( 0,0 );
				float ExtendDistance309 = distance( ExtendStartPos232 , texCoord216 );
				float3 ExtendDistanceOffset272 = _ExtendDistanceOffset_AddMulPow;
				float3 break275 = ExtendDistanceOffset272;
				float temp_output_281_0 = ( (1.0 + (ThirdProgressValue268 - 0.0) * (0.0 - 1.0) / (1.0 - 0.0)) + pow( ( ( ExtendDistance309 + break275.x ) * break275.y ) , break275.z ) );
				float temp_output_253_0 = ( 1.0 - step( temp_output_254_0 , temp_output_281_0 ) );
				float4 lerpResult289 = lerp( ( ( _EdgeTexCol * tex2DNode5 * tex2DNode5.a ) + ( _BackgroundTexCol * tex2DNode191 * temp_output_305_0 * SecondProgressValue187 ) ) , ( lerpResult406 * step( 0.0 , ImageCol461.w ) * temp_output_253_0 ) , ( ImageCol461.w * temp_output_305_0 * temp_output_253_0 ));
				float4 temp_output_326_0 = ( lerpResult289 + ( ImageCol461.w * saturate( ( temp_output_253_0 - ( 1.0 - step( ( temp_output_254_0 - _ExtendEdgeSize ) , temp_output_281_0 ) ) ) ) * _ExtendEdgeCol ) );
				float4 appendResult344 = (float4(temp_output_326_0.rgb , saturate( temp_output_326_0.a )));
				
				
				finalColor = appendResult344;
				return finalColor;
			}
			ENDCG
		}
	}
	CustomEditor "ASEMaterialInspector"
	
	Fallback Off
}
/*ASEBEGIN
Version=19105
Node;AmplifyShaderEditor.GlobalArrayNode;45;-1381.67,3577.185;Inherit;False;_NewPos;0;4;2;True;False;0;1;True;Object;-1;4;0;INT;0;False;2;INT;0;False;1;INT;0;False;3;INT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.GlobalArrayNode;44;-1384.991,3726.169;Inherit;False;_OriPos;0;4;2;True;False;0;1;True;Object;-1;4;0;INT;0;False;2;INT;0;False;1;INT;0;False;3;INT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.DynamicAppendNode;106;-1349.004,2793.816;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;102;-1619.718,2611.296;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;105;-1613.024,2817.977;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;104;-1951.853,2818.175;Inherit;False;FLOAT4;1;0;FLOAT4;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.ScreenPosInputsNode;50;-2322.253,2813.221;Float;False;0;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;127;-985.6438,2790.255;Inherit;False;ScreenPos_Pixel;-1;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;73;-1629.689,4397.611;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;77;-1619.355,4724.151;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;92;-1384.183,4724.635;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.BreakToComponentsNode;94;-1219.026,4724.936;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.Vector2Node;95;-1626.61,4845.458;Inherit;False;Constant;_Vector3;Vector 3;2;0;Create;True;0;0;0;False;0;False;1,1;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.BreakToComponentsNode;97;-1231.279,4399.81;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.RegisterLocalVarNode;78;-1012.498,4745.445;Inherit;False;OriWidth;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;98;-1633.728,4507.309;Inherit;False;Constant;_Vector4;Vector 3;2;0;Create;True;0;0;0;False;0;False;1,1;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;96;-1396.436,4399.508;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GlobalArrayNode;71;-1870.054,4343.668;Inherit;False;MyGlobalArray;3;1;0;False;False;0;1;False;Instance;44;4;0;INT;0;False;2;INT;0;False;1;INT;0;False;3;INT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GlobalArrayNode;72;-1870.053,4477.158;Inherit;False;MyGlobalArray;0;1;0;False;False;0;1;False;Instance;44;4;0;INT;0;False;2;INT;0;False;1;INT;0;False;3;INT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GlobalArrayNode;76;-1872.223,4791.32;Inherit;False;MyGlobalArray;0;1;0;False;False;0;1;False;Instance;44;4;0;INT;0;False;2;INT;0;False;1;INT;0;False;3;INT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GlobalArrayNode;75;-1870.437,4670.209;Inherit;False;MyGlobalArray;1;1;0;False;False;0;1;False;Instance;44;4;0;INT;0;False;2;INT;0;False;1;INT;0;False;3;INT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;147;-1657.471,5704.082;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;148;-1647.137,6030.622;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;149;-1411.965,6031.105;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.BreakToComponentsNode;150;-1246.808,6031.407;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.Vector2Node;151;-1654.392,6151.929;Inherit;False;Constant;_Vector8;Vector 3;2;0;Create;True;0;0;0;False;0;False;1,1;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.BreakToComponentsNode;152;-1259.061,5706.281;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.Vector2Node;155;-1661.51,5813.78;Inherit;False;Constant;_Vector9;Vector 3;2;0;Create;True;0;0;0;False;0;False;1,1;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;156;-1424.218,5705.979;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GlobalArrayNode;157;-1897.836,5650.139;Inherit;False;MyGlobalArray;3;1;0;False;False;0;1;False;Instance;45;4;0;INT;0;False;2;INT;0;False;1;INT;0;False;3;INT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GlobalArrayNode;158;-1897.835,5783.629;Inherit;False;MyGlobalArray;0;1;0;False;False;0;1;False;Instance;45;4;0;INT;0;False;2;INT;0;False;1;INT;0;False;3;INT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GlobalArrayNode;160;-1898.219,5976.68;Inherit;False;MyGlobalArray;1;1;0;False;False;0;1;False;Instance;45;4;0;INT;0;False;2;INT;0;False;1;INT;0;False;3;INT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GlobalArrayNode;159;-1900.005,6097.791;Inherit;False;MyGlobalArray;0;1;0;False;False;0;1;False;Instance;45;4;0;INT;0;False;2;INT;0;False;1;INT;0;False;3;INT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;153;-1043.736,5702.608;Inherit;False;NewLength;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;154;-1044.562,6050.488;Inherit;False;NewWidth;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;166;-4746.297,2825.884;Inherit;False;ProgressValue;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;89;2415.046,2775.481;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;87;2236.808,2655.619;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;79;1990.236,2816.783;Inherit;False;74;OriLength;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;80;1989.124,2915.797;Inherit;False;78;OriWidth;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;88;2239.045,2896.798;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;52;1704.961,2654.515;Inherit;False;2;0;FLOAT4;0,0,0,0;False;1;FLOAT2;0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;115;1424.255,2763.543;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector2Node;116;1155.63,2846.214;Inherit;False;Constant;_Vector6;Vector 6;2;0;Create;True;0;0;0;False;0;False;1,1;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.GetLocalVarNode;128;1386.539,2648.623;Inherit;False;127;ScreenPos_Pixel;1;0;OBJECT;;False;1;FLOAT4;0
Node;AmplifyShaderEditor.BreakToComponentsNode;136;2016.567,3321.329;Inherit;False;FLOAT4;1;0;FLOAT4;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.DynamicAppendNode;137;2418.516,3442.438;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;138;2240.279,3322.576;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;141;2242.514,3563.755;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;142;1708.431,3321.472;Inherit;False;2;0;FLOAT4;0,0,0,0;False;1;FLOAT2;0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;143;1427.725,3430.5;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector2Node;144;1159.101,3513.171;Inherit;False;Constant;_Vector7;Vector 6;2;0;Create;True;0;0;0;False;0;False;1,1;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.GetLocalVarNode;146;1390.009,3315.581;Inherit;False;127;ScreenPos_Pixel;1;0;OBJECT;;False;1;FLOAT4;0
Node;AmplifyShaderEditor.GetLocalVarNode;139;1993.706,3483.74;Inherit;False;153;NewLength;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;140;1992.594,3582.754;Inherit;False;154;NewWidth;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;86;2013.097,2654.371;Inherit;False;FLOAT4;1;0;FLOAT4;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.RegisterLocalVarNode;192;2819.189,2773.54;Inherit;False;OriUV;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;193;2814.728,3439.112;Inherit;False;NewUV;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;163;-5222.474,2826.363;Inherit;False;Property;_Progress;Progress;25;0;Create;True;0;0;0;False;0;False;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;239;1911.964,5690.341;Inherit;False;Property;_ExtendSize;ExtendSize;5;0;Create;True;0;0;0;False;0;False;0.1,0.1;0.05,0.025;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RegisterLocalVarNode;272;2283.99,5061.757;Inherit;False;ExtendDistanceOffset;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.Vector3Node;271;1720.893,5061.717;Inherit;False;Property;_ExtendDistanceOffset_AddMulPow;ExtendDistanceOffset_Add/Mul/Pow;7;0;Create;True;0;0;0;False;0;False;0,1,1;0,0.6,1;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RegisterLocalVarNode;258;2232.288,6383.664;Inherit;False;ExtendStrenthOffset;-1;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.Vector4Node;257;1853.935,6383.429;Inherit;False;Property;_ExtendStrenthOffset_AddMulPow;ExtendStrenthOffset_Add/Mul/Pow;6;0;Create;True;0;0;0;False;0;False;0,1,0.2,0;0,1,0.02,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;246;2226.955,5689.191;Inherit;False;ExtendSize;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;309;2365.561,6907.544;Inherit;False;ExtendDistance;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DistanceOpNode;218;2084.863,6914;Inherit;False;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;216;1711.8,7014.212;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;233;1720.475,6910.012;Inherit;False;232;ExtendStartPos;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;423;1599.656,7414.278;Inherit;False;232;ExtendStartPos;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;424;1614.987,7527.89;Inherit;False;396;FlooredUV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DistanceOpNode;421;1962.117,7416.985;Inherit;True;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GlobalArrayNode;145;1147.023,3424.864;Inherit;False;MyGlobalArray;0;1;0;False;False;0;1;False;Instance;45;4;0;INT;0;False;2;INT;0;False;1;INT;0;False;3;INT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GlobalArrayNode;51;1143.552,2757.907;Inherit;False;MyGlobalArray;0;1;0;False;False;0;1;False;Instance;44;4;0;INT;0;False;2;INT;0;False;1;INT;0;False;3;INT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;74;-1015.954,4396.137;Inherit;False;OriLength;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;173;-5818.727,4469.963;Inherit;False;166;ProgressValue;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;182;-5428.444,4476.932;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;181;-5090.011,4476.516;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;180;-4747.002,4472.44;Inherit;False;FirstProgressValue;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector4Node;190;-5849.62,4756.482;Inherit;False;Property;_ProgressRemapValue_12;ProgressRemapValue_1/2;26;0;Create;True;0;0;0;False;0;False;0,0.5,0.5,1;0,0.3,0,0.4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ClampOpNode;185;-5433.2,5111.158;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;186;-5094.767,5110.742;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;187;-4751.758,5106.666;Inherit;False;SecondProgressValue;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;184;-5823.482,5104.188;Inherit;False;166;ProgressValue;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;266;-5444.531,5774.777;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;267;-5106.098,5774.361;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;269;-5834.812,5767.808;Inherit;False;166;ProgressValue;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector4Node;265;-5856.982,5945.451;Inherit;False;Property;_ProgressRemapValue_3;ProgressRemapValue_3/-;27;0;Create;True;0;0;0;False;0;False;0,0.5,0.5,1;0.2,1,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;268;-4763.088,5770.285;Inherit;False;ThirdProgressValue;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;101;-1990.912,2582.761;Inherit;False;Constant;_Vector5;Vector 5;2;0;Create;True;0;0;0;False;0;False;1440,2560;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;436;1570.446,4316.052;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;438;1571.746,4527.951;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;434;1793.374,4419.488;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GlobalArrayNode;431;1297.593,4546.614;Inherit;False;MyGlobalArray;0;1;0;False;False;0;1;False;Instance;44;4;0;INT;0;False;2;INT;0;False;1;INT;0;False;3;INT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;437;1311.746,4404.454;Inherit;False;Constant;_Vector0;Vector 0;20;0;Create;True;0;0;0;False;0;False;1,1;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleDivideOpNode;435;1992.374,4419.488;Inherit;False;2;0;FLOAT2;0,0;False;1;FLOAT;2;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;439;1786.93,4541.438;Inherit;False;Constant;_Float1;Float 1;20;0;Create;True;0;0;0;False;0;False;2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GlobalArrayNode;432;1300.473,4311.585;Inherit;False;MyGlobalArray;2;1;0;False;False;0;1;False;Instance;44;4;0;INT;0;False;2;INT;0;False;1;INT;0;False;3;INT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;440;2322.166,4421.125;Inherit;False;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector2Node;441;1964.296,4528.792;Inherit;False;Constant;_Vector1;Vector 1;20;0;Create;True;0;0;0;False;0;False;1440,2560;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RegisterLocalVarNode;232;2662.957,4416.896;Inherit;False;ExtendStartPos;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;234;1279.987,9159.144;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;238;1843.574,9184.476;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TFHCRemapNode;237;2110.831,9185.418;Inherit;False;5;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT2;1,1;False;3;FLOAT2;0,0;False;4;FLOAT2;1,1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.FmodOpNode;240;1580.814,9375.836;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FmodOpNode;235;1578.218,9183.602;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;248;1360.744,9376.024;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.WireNode;249;1361.949,9321.641;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;366;1254.816,8153.41;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.FloorOpNode;365;1452.049,8153.403;Inherit;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;364;970.4269,8154.2;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleDivideOpNode;368;1949.599,8153.636;Inherit;True;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;418;1521.252,8405.146;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;371;813.3368,8404.337;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;372;816.7245,8548.299;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;370;600.3768,8547.253;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.DynamicAppendNode;374;1006.838,8404.31;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;367;602.8417,8399.973;Inherit;False;Constant;_Float0;Float 0;16;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;369;317.1356,8541.272;Inherit;False;246;ExtendSize;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;247;1100.071,9371.17;Inherit;False;246;ExtendSize;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;326;18446.05,5184.825;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.DynamicAppendNode;344;19047.08,5185.003;Inherit;False;FLOAT4;4;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.BreakToComponentsNode;345;18647.61,5312.045;Inherit;False;COLOR;1;0;COLOR;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SaturateNode;346;18804.81,5383.206;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;289;17721.77,5186.611;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;228;17230.48,5210.906;Inherit;False;3;3;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;213;13860.46,6192.238;Inherit;True;Property;_ExtendTex;ExtendTex;4;0;Create;True;0;0;0;False;0;False;-1;None;cc85d3656c7b6fe468261daae3280d9c;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;253;15654.45,6222.12;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;260;13935.5,6506.595;Inherit;False;FLOAT4;1;0;FLOAT4;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SimpleAddOpNode;255;14381.74,6220.341;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;256;14643.88,6220.997;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;254;14951.12,6222.145;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;0.2;False;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;225;15311.09,6221.975;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0.75;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;274;14301.17,7184.299;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;276;14046.26,7184.417;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;281;15007.65,6985.699;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;287;14609.33,6984.416;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;1;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;275;13720.53,7386.119;Inherit;False;FLOAT3;1;0;FLOAT3;0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.GetLocalVarNode;251;14269.08,6980.016;Inherit;False;268;ThirdProgressValue;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;310;13350.61,7180.308;Inherit;False;309;ExtendDistance;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;273;13335.17,7380.886;Inherit;False;272;ExtendDistanceOffset;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.PowerNode;277;14623.09,7183.471;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;335;15644.7,7523.001;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;338;15990.72,7524.947;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;342;15334.92,7522.87;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;339;16842.8,7478.356;Inherit;True;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;347;16648.05,7501.396;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;322;14978.62,7541.904;Inherit;False;Property;_ExtendEdgeSize;ExtendEdgeSize;9;0;Create;True;0;0;0;False;0;False;1.25;0.02;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;201;15097.28,3119.909;Inherit;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;203;15100.9,4031.392;Inherit;False;4;4;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;5;14403.19,2924.653;Inherit;True;Property;_EdgeTex;EdgeTex;0;0;Create;True;0;0;0;False;0;False;-1;None;1667ac62a7b818b4e8d5394083e49abf;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;202;14449.17,2717.669;Inherit;False;Property;_EdgeTexCol;EdgeTexCol;1;1;[HDR];Create;True;0;0;0;False;0;False;0,0,0,0;0.6745283,0.7239303,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;198;14435.29,4097.229;Inherit;False;187;SecondProgressValue;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;200;15627.52,4005.7;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StepOpNode;305;14760.41,4006.237;Inherit;False;2;0;FLOAT;0.05;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;361;14092.71,3856.04;Inherit;False;359;RemapUV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ColorNode;204;14449.71,3598.083;Inherit;False;Property;_BackgroundTexCol;BackgroundTexCol;3;1;[HDR];Create;True;0;0;0;False;0;False;0,0,0,0;0.4481132,0.6614736,1,0.2745098;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;360;14096.24,2948.595;Inherit;False;359;RemapUV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ColorNode;341;16372.72,7793.994;Inherit;False;Property;_ExtendEdgeCol;ExtendEdgeCol;8;1;[HDR];Create;True;0;0;0;False;0;False;1.521569,2.384314,4,1;0.4214911,1.197922,4.237095,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleSubtractOpNode;337;16367.25,7501.808;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;259;13564.55,6501.007;Inherit;False;258;ExtendStrenthOffset;1;0;OBJECT;;False;1;FLOAT4;0
Node;AmplifyShaderEditor.GetLocalVarNode;400;13481.61,6216.804;Inherit;False;399;FlooredAndRemapedUV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;191;14404.53,3832.183;Inherit;True;Property;_BackgroundTex;BackgroundTex;2;0;Create;True;0;0;0;False;0;False;-1;None;6423e72b4c057864f805004487d6624e;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;0;19404.4,5184.807;Float;False;True;-1;2;ASEMaterialInspector;100;5;UITest;0770190933193b94aaa3065e307002fa;True;Unlit;0;0;Unlit;2;True;True;2;5;False;;10;False;;0;5;False;;10;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;True;True;2;False;;True;3;False;;True;True;0;False;;0;False;;True;1;RenderType=Transparent=RenderType;True;2;False;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;0;;0;0;Standard;1;Vertex Position,InvertActionOnDeselection;1;0;0;1;True;False;;False;0
Node;AmplifyShaderEditor.LerpOp;406;16735.43,4881.967;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;405;16002.42,4714.793;Inherit;False;Property;_EdgeBrightSquareCol;EdgeBrightSquareCol;10;1;[HDR];Create;True;0;0;0;False;0;False;0.5330188,0.8087932,1,1;3.890195,17.83033,23.96863,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;351;16040.7,4563.958;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;388;15991.84,4924.868;Inherit;False;387;EdgeBrightSquareValue;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;270;15572.99,4344.685;Inherit;False;Property;_ImageTexCol;ImageTexCol;15;1;[HDR];Create;True;0;0;0;False;0;False;1,1,1,1;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;463;15603.13,4582.842;Inherit;False;461;ImageCol;1;0;OBJECT;;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;297;17220.89,5541.533;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;399;2400.215,9180.229;Inherit;False;FlooredAndRemapedUV;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;396;2330.314,8149.205;Inherit;False;FlooredUV;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;425;2350.753,7413.531;Inherit;False;FlooredExtendDistance;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;169;14442.31,3190.338;Inherit;False;180;FirstProgressValue;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;306;15283.49,5508.278;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;298;16354.92,5235.431;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;419;5416.859,7943.927;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DistanceOpNode;392;5401.562,8086.104;Inherit;True;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;394;4998.058,7992.151;Inherit;False;232;ExtendStartPos;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;403;5997.882,8088.849;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;404;6242.494,8089.096;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;354;6595.041,8089.326;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;83.1;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;402;5366.728,8362.585;Inherit;False;Property;_EdgeBrightSquare_AddMultPow;EdgeBrightSquare_Add/Mult/Pow;11;0;Create;True;0;0;0;False;0;False;0,0,0;0,0.5,1;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.GetLocalVarNode;356;6595.167,7966.786;Inherit;False;268;ThirdProgressValue;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;357;7050.32,8067.939;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;417;5013.908,8105.715;Inherit;False;396;FlooredUV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;390;7881.174,8022.745;Inherit;True;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.StepOpNode;378;7435.39,8046.275;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NoiseGeneratorNode;376;8219.229,8016.915;Inherit;True;Simplex2D;True;False;2;0;FLOAT2;0,0;False;1;FLOAT;50;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;410;9552.379,8020.804;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;407;9850.521,8022.339;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;413;9023.42,8020.749;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;428;8631.203,8020.494;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;427;8187.939,8277.216;Inherit;False;Property;_EdgeBrightSquareNoiseStrength_MinMax;EdgeBrightSquareNoiseStrength_Min/Max;13;0;Create;True;0;0;0;False;0;False;1,1;0.6,1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.GetLocalVarNode;414;8209.584,8463.182;Inherit;False;425;FlooredExtendDistance;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;415;8185.397,8596.534;Inherit;False;Property;_EdgeBrightSquareReduceMult_DisProgress;EdgeBrightSquareReduceMult_Dis/Progress;12;0;Create;True;0;0;0;False;0;False;1,1;1,1.2;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;416;9278.547,8279.447;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;411;8987.724,8274.432;Inherit;False;268;ThirdProgressValue;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;387;10177.18,8017.52;Inherit;False;EdgeBrightSquareValue;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;488;16036.12,5471.539;Inherit;False;FLOAT4;1;0;FLOAT4;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SimpleMinOpNode;501;6686.52,4994.924;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector4Node;452;5842.646,5221.391;Inherit;False;Property;_GlithTexStepPanNoise_ScalePowMult;GlithTexStep/PanNoise_Scale/Pow/Mult;22;0;Create;True;0;0;0;False;0;False;0.99,5,20,1;0.95,5,20,1;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.NoiseGeneratorNode;469;6266.242,4990.069;Inherit;True;Simplex2D;True;False;2;0;FLOAT2;0,0;False;1;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;470;5246.486,4992.85;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;493;5271.122,5215.805;Inherit;False;Property;_GlithPanSpeed;GlithPanSpeed;23;0;Create;True;0;0;0;False;0;False;0,0;0.25,0.3;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;497;5286.279,5521.177;Inherit;False;Constant;_Vector2;Vector 2;22;0;Create;True;0;0;0;False;0;False;1,-1;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.NoiseGeneratorNode;494;6274.539,5472.168;Inherit;True;Simplex2D;True;False;2;0;FLOAT2;0,0;False;1;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;498;5918.993,5478.098;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;1,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;496;5617.707,5502.092;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;491;6785.41,5280.903;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;522;8730.561,5155.432;Inherit;False;Constant;_Color0;Color 0;24;0;Create;True;0;0;0;False;0;False;1,0,0,1;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WireNode;492;7235.562,5296.94;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMaxOpNode;529;6680.069,5452.095;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;472;7137.513,4992.522;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;15;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;444;7614.29,4969.958;Inherit;True;3;3;0;FLOAT;0;False;1;FLOAT;0.1;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;530;7134.11,5453.051;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;15;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;531;7614.047,5405.441;Inherit;True;3;3;0;FLOAT;0;False;1;FLOAT;0.1;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;533;6787.493,5281.639;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;534;7234.707,5298.627;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;517;4897.985,4606.628;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;513;4901.126,4195.74;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;514;4901.878,4309.175;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector4Node;508;4495.263,4168.274;Inherit;False;Property;_GlithTex_TillingOffset;GlithTex_Tilling/Offset;20;0;Create;True;0;0;0;False;0;False;1,1,0,0;2,0.5,0,0.5;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;516;4898.422,4495.793;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.StepOpNode;468;7148.677,4513.917;Inherit;True;2;0;FLOAT;0.99;False;1;FLOAT;-0.1;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector4Node;515;4460.974,4529.948;Inherit;False;Property;_GlithTexReference_TillingOffset;GlithTexReference_Tilling/Offset;21;0;Create;True;0;0;0;False;0;False;1,1,0,0;1,0.25,0,-0.5;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WireNode;490;6837.623,4828.533;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;489;6266.619,4916.175;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;471;5912.859,4994.217;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;1,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;420;7585.953,7927.589;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;264;8053.615,5154.545;Inherit;False;359;RemapUV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;538;8058.636,5405.493;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;539;8398.887,5380.396;Inherit;True;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;523;9268.802,5161.562;Inherit;False;4;4;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;537;8693.862,5351.401;Inherit;True;Property;_ImageTex1;ImageTex;14;0;Create;True;0;0;0;False;0;False;-1;None;332852ccb99b4834eb14ac7198307377;True;0;False;white;Auto;False;Instance;212;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;541;8234.257,5474.769;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0.2;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;543;8935.137,5568.259;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;546;8941.381,5659.495;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;547;7875.495,5719.827;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;542;7889.772,5557.16;Inherit;False;Property;_GlithRed_OffsetStrengthColorStrength;GlithRed_OffsetStrength/ColorStrength;24;0;Create;True;0;0;0;False;0;False;0.2,10;0.2,2;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.StepOpNode;548;9041.512,5279.466;Inherit;False;2;0;FLOAT;0.1;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMaxOpNode;506;6271.166,4535.594;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;483;6703.603,4536.739;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;481;5846.19,4530.311;Inherit;True;Property;_GlithTex;GlithTex;19;0;Create;True;0;0;0;False;0;False;-1;None;0bc3ae06e8ef4ee4fb1804f98dafb475;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;504;5848.206,4142.152;Inherit;True;Property;_GlithTex1;GlithTex;19;0;Create;True;0;0;0;False;0;False;-1;None;0bc3ae06e8ef4ee4fb1804f98dafb475;True;0;False;white;Auto;False;Instance;481;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMaxOpNode;551;6283.011,3739.412;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;552;6715.448,3740.556;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;554;5860.051,3345.969;Inherit;True;Property;_GlithTex3;GlithTex;19;0;Create;True;0;0;0;False;0;False;-1;None;0bc3ae06e8ef4ee4fb1804f98dafb475;True;0;False;white;Auto;False;Instance;481;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;503;5253.742,4558.844;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;505;5259.839,4170.74;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;0.5,0.5;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;555;5249.167,3761.655;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;556;5255.264,3373.551;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;0.5,0.5;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;557;5529.876,3761.429;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;558;5529.015,3373.299;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;564;5291.804,3910.314;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;561;5293.063,3517.398;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;562;4899.593,3827.209;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;563;4903.091,3930.971;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector4Node;560;4533.885,3491.123;Inherit;False;Property;_ImageNoisePanSpeedSecondNoiseOffset;ImageNoisePanSpeed/SecondNoiseOffset;17;0;Create;True;0;0;0;False;0;False;0,0,0,0;1,0,0.5,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;553;5858.035,3734.128;Inherit;True;Property;_GlithTex2;GlithTex;19;0;Create;True;0;0;0;False;0;False;-1;None;0bc3ae06e8ef4ee4fb1804f98dafb475;True;0;False;white;Auto;False;Instance;481;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;194;7157.548,1903.378;Inherit;False;192;OriUV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.LerpOp;162;7703.467,2218.94;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;195;7158.328,2080.939;Inherit;False;193;NewUV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;167;7133.848,2258.386;Inherit;False;180;FirstProgressValue;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;359;8145.588,2217.467;Inherit;False;RemapUV;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;549;7152.257,3741.404;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0.005;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;550;8072.869,4947.69;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;520;9902.23,4758.468;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.DynamicAppendNode;519;10264.81,4761.081;Inherit;False;FLOAT4;4;0;FLOAT4;0,0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SaturateNode;525;10572.51,4762.327;Inherit;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SamplerNode;212;9020.332,4749.045;Inherit;True;Property;_ImageTex;ImageTex;14;0;Create;True;0;0;0;False;0;False;-1;None;332852ccb99b4834eb14ac7198307377;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;464;8398.769,4778.51;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;448;8728.391,4777.543;Inherit;True;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;461;10892.82,4760.749;Inherit;False;ImageCol;-1;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;565;6691.101,3976.271;Inherit;False;Property;_ImageNoiseStrength;ImageNoiseStrength;16;0;Create;True;0;0;0;False;0;False;0.005;0.005;0;0;0;1;FLOAT;0
WireConnection;106;0;102;0
WireConnection;106;1;105;0
WireConnection;102;0;101;1
WireConnection;102;1;104;0
WireConnection;105;0;101;2
WireConnection;105;1;104;1
WireConnection;104;0;50;0
WireConnection;127;0;106;0
WireConnection;73;0;71;0
WireConnection;73;1;72;0
WireConnection;77;0;75;0
WireConnection;77;1;76;0
WireConnection;92;0;77;0
WireConnection;92;1;95;0
WireConnection;94;0;92;0
WireConnection;97;0;96;0
WireConnection;78;0;94;1
WireConnection;96;0;73;0
WireConnection;96;1;98;0
WireConnection;147;0;157;0
WireConnection;147;1;158;0
WireConnection;148;0;160;0
WireConnection;148;1;159;0
WireConnection;149;0;148;0
WireConnection;149;1;151;0
WireConnection;150;0;149;0
WireConnection;152;0;156;0
WireConnection;156;0;147;0
WireConnection;156;1;155;0
WireConnection;153;0;152;0
WireConnection;154;0;150;1
WireConnection;166;0;163;0
WireConnection;89;0;87;0
WireConnection;89;1;88;0
WireConnection;87;0;86;0
WireConnection;87;1;79;0
WireConnection;88;0;86;1
WireConnection;88;1;80;0
WireConnection;52;0;128;0
WireConnection;52;1;115;0
WireConnection;115;0;51;0
WireConnection;115;1;116;0
WireConnection;136;0;142;0
WireConnection;137;0;138;0
WireConnection;137;1;141;0
WireConnection;138;0;136;0
WireConnection;138;1;139;0
WireConnection;141;0;136;1
WireConnection;141;1;140;0
WireConnection;142;0;146;0
WireConnection;142;1;143;0
WireConnection;143;0;145;0
WireConnection;143;1;144;0
WireConnection;86;0;52;0
WireConnection;192;0;89;0
WireConnection;193;0;137;0
WireConnection;272;0;271;0
WireConnection;258;0;257;0
WireConnection;246;0;239;0
WireConnection;309;0;218;0
WireConnection;218;0;233;0
WireConnection;218;1;216;0
WireConnection;421;0;423;0
WireConnection;421;1;424;0
WireConnection;74;0;97;0
WireConnection;182;0;173;0
WireConnection;182;1;190;1
WireConnection;182;2;190;2
WireConnection;181;0;182;0
WireConnection;181;1;190;1
WireConnection;181;2;190;2
WireConnection;180;0;181;0
WireConnection;185;0;184;0
WireConnection;185;1;190;3
WireConnection;185;2;190;4
WireConnection;186;0;185;0
WireConnection;186;1;190;3
WireConnection;186;2;190;4
WireConnection;187;0;186;0
WireConnection;266;0;269;0
WireConnection;266;1;265;1
WireConnection;266;2;265;2
WireConnection;267;0;266;0
WireConnection;267;1;265;1
WireConnection;267;2;265;2
WireConnection;268;0;267;0
WireConnection;436;0;432;0
WireConnection;436;1;437;0
WireConnection;438;0;437;0
WireConnection;438;1;431;0
WireConnection;434;0;436;0
WireConnection;434;1;438;0
WireConnection;435;0;434;0
WireConnection;435;1;439;0
WireConnection;440;0;435;0
WireConnection;440;1;441;0
WireConnection;232;0;440;0
WireConnection;238;0;235;0
WireConnection;238;1;240;0
WireConnection;237;0;238;0
WireConnection;237;2;249;0
WireConnection;240;0;234;2
WireConnection;240;1;248;1
WireConnection;235;0;234;1
WireConnection;235;1;248;0
WireConnection;248;0;247;0
WireConnection;249;0;247;0
WireConnection;366;0;364;0
WireConnection;366;1;374;0
WireConnection;365;0;366;0
WireConnection;368;0;365;0
WireConnection;368;1;418;0
WireConnection;418;0;374;0
WireConnection;371;0;367;0
WireConnection;371;1;370;0
WireConnection;372;0;367;0
WireConnection;372;1;370;1
WireConnection;370;0;369;0
WireConnection;374;0;371;0
WireConnection;374;1;372;0
WireConnection;326;0;289;0
WireConnection;326;1;339;0
WireConnection;344;0;326;0
WireConnection;344;3;346;0
WireConnection;345;0;326;0
WireConnection;346;0;345;3
WireConnection;289;0;200;0
WireConnection;289;1;228;0
WireConnection;289;2;297;0
WireConnection;228;0;406;0
WireConnection;228;1;298;0
WireConnection;228;2;253;0
WireConnection;213;1;400;0
WireConnection;253;0;225;0
WireConnection;260;0;259;0
WireConnection;255;0;213;1
WireConnection;255;1;260;0
WireConnection;256;0;255;0
WireConnection;256;1;260;1
WireConnection;254;0;256;0
WireConnection;254;1;260;2
WireConnection;225;0;254;0
WireConnection;225;1;281;0
WireConnection;274;0;276;0
WireConnection;274;1;275;1
WireConnection;276;0;310;0
WireConnection;276;1;275;0
WireConnection;281;0;287;0
WireConnection;281;1;277;0
WireConnection;287;0;251;0
WireConnection;275;0;273;0
WireConnection;277;0;274;0
WireConnection;277;1;275;2
WireConnection;335;0;342;0
WireConnection;335;1;281;0
WireConnection;338;0;335;0
WireConnection;342;0;254;0
WireConnection;342;1;322;0
WireConnection;339;0;488;3
WireConnection;339;1;347;0
WireConnection;339;2;341;0
WireConnection;347;0;337;0
WireConnection;201;0;202;0
WireConnection;201;1;5;0
WireConnection;201;2;5;4
WireConnection;203;0;204;0
WireConnection;203;1;191;0
WireConnection;203;2;305;0
WireConnection;203;3;198;0
WireConnection;5;1;360;0
WireConnection;200;0;201;0
WireConnection;200;1;203;0
WireConnection;305;1;191;4
WireConnection;337;0;253;0
WireConnection;337;1;338;0
WireConnection;191;1;361;0
WireConnection;0;0;344;0
WireConnection;406;0;351;0
WireConnection;406;1;405;0
WireConnection;406;2;388;0
WireConnection;351;0;270;0
WireConnection;351;1;463;0
WireConnection;297;0;488;3
WireConnection;297;1;306;0
WireConnection;297;2;253;0
WireConnection;399;0;237;0
WireConnection;396;0;368;0
WireConnection;425;0;421;0
WireConnection;306;0;305;0
WireConnection;298;1;488;3
WireConnection;419;0;417;0
WireConnection;392;0;394;0
WireConnection;392;1;417;0
WireConnection;403;0;392;0
WireConnection;403;1;402;1
WireConnection;404;0;403;0
WireConnection;404;1;402;2
WireConnection;354;0;404;0
WireConnection;354;1;402;3
WireConnection;357;0;356;0
WireConnection;357;1;354;0
WireConnection;390;0;420;0
WireConnection;390;1;378;0
WireConnection;378;1;357;0
WireConnection;376;0;390;0
WireConnection;410;0;413;0
WireConnection;410;1;416;0
WireConnection;407;0;410;0
WireConnection;413;0;428;0
WireConnection;413;1;414;0
WireConnection;413;2;415;1
WireConnection;428;0;376;0
WireConnection;428;3;427;1
WireConnection;428;4;427;2
WireConnection;416;0;411;0
WireConnection;416;1;415;2
WireConnection;387;0;407;0
WireConnection;488;0;463;0
WireConnection;501;0;469;0
WireConnection;501;1;494;0
WireConnection;469;0;471;0
WireConnection;469;1;452;2
WireConnection;494;0;498;0
WireConnection;498;0;470;0
WireConnection;498;2;496;0
WireConnection;496;0;493;0
WireConnection;496;1;497;0
WireConnection;491;0;452;3
WireConnection;492;0;452;4
WireConnection;529;0;469;0
WireConnection;529;1;494;0
WireConnection;472;0;501;0
WireConnection;472;1;491;0
WireConnection;444;0;468;0
WireConnection;444;1;472;0
WireConnection;444;2;492;0
WireConnection;530;0;529;0
WireConnection;530;1;533;0
WireConnection;531;0;468;0
WireConnection;531;1;534;0
WireConnection;531;2;530;0
WireConnection;533;0;452;3
WireConnection;534;0;452;4
WireConnection;517;0;515;3
WireConnection;517;1;515;4
WireConnection;513;0;508;1
WireConnection;513;1;508;2
WireConnection;514;0;508;3
WireConnection;514;1;508;4
WireConnection;516;0;515;1
WireConnection;516;1;515;2
WireConnection;468;0;490;0
WireConnection;468;1;483;0
WireConnection;490;0;489;0
WireConnection;489;0;452;1
WireConnection;471;0;470;0
WireConnection;471;2;493;0
WireConnection;420;0;419;0
WireConnection;538;0;531;0
WireConnection;539;0;264;0
WireConnection;539;1;541;0
WireConnection;523;0;522;0
WireConnection;523;1;548;0
WireConnection;523;2;543;0
WireConnection;523;3;546;0
WireConnection;537;1;539;0
WireConnection;541;0;538;0
WireConnection;541;1;542;1
WireConnection;543;0;542;2
WireConnection;546;0;547;0
WireConnection;547;0;531;0
WireConnection;548;1;537;4
WireConnection;506;0;504;1
WireConnection;506;1;481;1
WireConnection;483;0;506;0
WireConnection;481;1;503;0
WireConnection;504;1;505;0
WireConnection;551;0;554;1
WireConnection;551;1;553;1
WireConnection;552;0;551;0
WireConnection;554;1;558;0
WireConnection;503;0;516;0
WireConnection;503;1;517;0
WireConnection;505;0;513;0
WireConnection;505;1;514;0
WireConnection;555;0;516;0
WireConnection;555;1;517;0
WireConnection;556;0;513;0
WireConnection;556;1;514;0
WireConnection;557;0;555;0
WireConnection;557;2;564;0
WireConnection;558;0;556;0
WireConnection;558;2;561;0
WireConnection;564;0;562;0
WireConnection;564;1;563;0
WireConnection;561;0;560;1
WireConnection;561;1;560;2
WireConnection;562;0;560;1
WireConnection;562;1;560;3
WireConnection;563;0;560;2
WireConnection;563;1;560;4
WireConnection;553;1;557;0
WireConnection;162;0;194;0
WireConnection;162;1;195;0
WireConnection;162;2;167;0
WireConnection;359;0;162;0
WireConnection;549;0;552;0
WireConnection;549;1;565;0
WireConnection;550;0;549;0
WireConnection;550;1;444;0
WireConnection;520;0;212;0
WireConnection;520;1;523;0
WireConnection;519;0;520;0
WireConnection;525;0;519;0
WireConnection;212;1;448;0
WireConnection;464;0;550;0
WireConnection;448;0;464;0
WireConnection;448;1;264;0
WireConnection;461;0;525;0
ASEEND*/
//CHKSM=996904FD0A2894F260AFF12C55C33A9DE357DC1E