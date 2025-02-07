#pragma header
uniform float PIXEL_SIZE = 1.0;

void main() {
    vec2 fragCoord = openfl_TextureCoordv*openfl_TextureSize.xy;
    vec2 uv = fragCoord.xy/openfl_TextureSize.xy;
    vec4 col = texture2D(bitmap, uv);

    float plx = openfl_TextureSize.x * PIXEL_SIZE / 200.0;
    float ply = openfl_TextureSize.y * PIXEL_SIZE / 75.0;

    float dx = plx * (1.0 / openfl_TextureSize.x);
    float dy = ply * (1.0 / openfl_TextureSize.y);

    uv.x = dx * floor(uv.x / dx);
    uv.y = dy * floor(uv.y / dy);

    gl_FragColor = col;
}