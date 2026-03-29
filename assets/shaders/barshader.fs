#if defined(VERTEX) || __VERSION__ > 100 || defined(GL_FRAGMENT_PRECISION_HIGH)
    #define MY_HIGHP_OR_MEDIUMP highp
#else
    #define MY_HIGHP_OR_MEDIUMP mediump
#endif

extern MY_HIGHP_OR_MEDIUMP vec2 barshader;
extern MY_HIGHP_OR_MEDIUMP float iTime;
extern MY_HIGHP_OR_MEDIUMP vec4 uie_details;
extern MY_HIGHP_OR_MEDIUMP float uie_scale;
extern MY_HIGHP_OR_MEDIUMP float uie_rot;
extern MY_HIGHP_OR_MEDIUMP float screen_scale;

#define PI 3.14159265

float psin(float x) {
    return (sin(x*PI)+1.0)/2.0;
}

vec4 RGBtoHSV(vec4 rgb)
{
    vec4 hsv;
    float minVal = min(min(rgb.r, rgb.g), rgb.b);
    float maxVal = max(max(rgb.r, rgb.g), rgb.b);
    float delta = maxVal - minVal;

    // Value
    hsv.z = maxVal;

    // Saturation
    if (maxVal != 0.0)
        hsv.y = delta / maxVal;
    else {
        // r = g = b = 0, s = 0, v is undefined
        hsv.y = 0.0;
        hsv.x = -1.0;
        return hsv;
    }

    // Hue
    if (rgb.r == maxVal)
        hsv.x = (rgb.g - rgb.b) / delta;      // between yellow & magenta
    else if (rgb.g == maxVal)
        hsv.x = 2.0 + (rgb.b - rgb.r) / delta;  // between cyan & yellow
    else
        hsv.x = 4.0 + (rgb.r - rgb.g) / delta;  // between magenta & cyan

    hsv.x = hsv.x * (1.0 / 6.0);
    if (hsv.x < 0.0)
        hsv.x += 1.0;

    // Alpha
    hsv.w = rgb.a;

    return hsv;
}

vec4 HSVtoRGB(vec4 hsv) {
    vec4 rgb;

    float h = hsv.x * 6.0;
    float c = hsv.z * hsv.y;
    float x = c * (1.0 - abs(mod(h, 2.0) - 1.0));
    float m = hsv.z - c;

    if (h < 1.0) {
        rgb = vec4(c, x, 0.0, hsv.a);
    } else if (h < 2.0) {
        rgb = vec4(x, c, 0.0, hsv.a);
    } else if (h < 3.0) {
        rgb = vec4(0.0, c, x, hsv.a);
    } else if (h < 4.0) {
        rgb = vec4(0.0, x, c, hsv.a);
    } else if (h < 5.0) {
        rgb = vec4(x, 0.0, c, hsv.a);
    } else {
        rgb = vec4(c, 0.0, x, hsv.a);
    }

    rgb.rgb += m;

    return rgb;
}

vec4 effect( vec4 colour, Image texture, vec2 texture_coords, vec2 screen_coords )
{
    vec4 tex = colour;
    vec2 uv = (screen_coords - uie_details.xy) / (uie_details.zw);
    uv *= 3.0; // compensates

    if (iTime > 2.0*iTime+barshader.y+uie_scale+uie_rot) {
        tex.r = 1.0;
    }

    uv.x += iTime*0.6;

    // tex.rgb = vec3(max(uv.x, uv.y));
    vec3 primary_colour = vec3(0.051, 0.4471, 0.902);
    vec3 secondary_colour = vec3(0.7686, 0.5882, 1.0);
    primary_colour.r += sin(barshader.y)/100.0;
    float v = psin(uv.y+psin(uv.x));

    tex.rgb = (primary_colour*v) + (secondary_colour*(1.0-v));
    tex = RGBtoHSV(tex);
    // tex.r += psin(uv.x);
    tex = HSVtoRGB(tex);

    

    return tex;
}