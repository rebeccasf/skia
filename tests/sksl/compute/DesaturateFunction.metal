#include <metal_stdlib>
#include <simd/simd.h>
using namespace metal;
struct Inputs {
    uint3 sk_ThreadPosition;
};
struct Outputs {
};
struct Globals {
    texture2d<half, access::read> src;
    texture2d<half, access::write> dest;
};
void desaturate_vTT(Inputs _in, texture2d<half, access::read> src, texture2d<half, access::write> dest) {
    half4 color = src.read(_in.sk_ThreadPosition.xy);
    color.xyz = half3(dot(color.xyz, half3(0.2199999988079071h, 0.67000001668930054h, 0.10999999940395355h)));
    dest.write(color, _in.sk_ThreadPosition.xy);
}
kernel void computeMain(texture2d<half, access::read> src [[texture(0)]], texture2d<half, access::write> dest [[texture(1)]], uint3 sk_ThreadPosition [[thread_position_in_grid]]) {
    Globals _globals{src, dest};
    (void)_globals;
    Inputs _in = { sk_ThreadPosition };
    Outputs _out = {  };
    if (_in.sk_ThreadPosition.x < _globals.src.get_width() && _in.sk_ThreadPosition.y < _globals.src.get_height()) {
        desaturate_vTT(_in, _globals.src, _globals.dest);
    }
    return;
}
