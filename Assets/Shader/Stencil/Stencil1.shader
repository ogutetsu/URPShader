Shader "Unlit/Stencil1"
{
    Properties
    {
        _Color ("color", Color) = (1, 0, 0, 1)
    }
    SubShader
    {
        Tags { "RenderType"="Transparent" }
        
        ZTest Always
        Stencil {
            Ref 2
            Comp Equal
        }

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            
            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float4 vertex : SV_POSITION;
            };

            
            fixed4 _Color;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                // sample the texture
                fixed4 col = _Color;
                if(col.a < 0.001) discard;
                return col;
            }
            ENDCG
        }
    }
}
