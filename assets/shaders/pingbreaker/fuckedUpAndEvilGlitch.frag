#pragma header
vec2 uv = openfl_TextureCoordv.xy;
vec2 fragCoord = openfl_TextureCoordv*openfl_TextureSize;
vec2 iResolution = openfl_TextureSize;
uniform float iTime;
#define iChannel0 bitmap
#define texture flixel_texture2D
#define fragColor gl_FragColor
#define mainImage main

#define PI 3.1415
void mainImage(){
     float i = iTime;
    
    vec2 uv = fragCoord.xy / iResolution.xy;
    
    uv-=.5;
    vec4 n = vec4(1.0);
    uv+=.5;
    vec4 c = texture(iChannel0,uv);
    float d = length(fragCoord.xy-iResolution.xy*.5)*10.0*.0001;
    c.rgb = sin(cos(mod(c.rgb,n.rgb)*PI*2.0+d)*PI*2.0+i+2.0*d);
    
    fragColor = c;
}