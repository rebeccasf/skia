#include <metal_stdlib>
#include <simd/simd.h>
using namespace metal;
struct Uniforms {
    half2 ah;
    half2 bh;
    float2 af;
    float2 bf;
};
struct Inputs {
};
struct Outputs {
    half4 sk_FragColor [[color(0)]];
};
float cross_length_2d_ff2f2(float2 a, float2 b) {
    return a.x * b.y - a.y * b.x;
}
half cross_length_2d_hh2h2(half2 a, half2 b) {
    return a.x * b.y - a.y * b.x;
}
fragment Outputs fragmentMain(Inputs _in [[stage_in]], constant Uniforms& _uniforms [[buffer(0)]], bool _frontFacing [[front_facing]], float4 _fragCoord [[position]]) {
    Outputs _out;
    (void)_out;
    _out.sk_FragColor.x = cross_length_2d_hh2h2(_uniforms.ah, _uniforms.bh);
    _out.sk_FragColor.y = half(cross_length_2d_ff2f2(_uniforms.af, _uniforms.bf));
    return _out;
}
