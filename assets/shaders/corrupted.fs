#if defined(VERTEX)||__VERSION__>100||defined(GL_FRAGMENT_PRECISION_HIGH)
#define PRECISION highp
#else
#define PRECISION mediump
#endif

// self.ARGS.send_to_shader[1] = math.min(self.VT.r*3, 1) + (math.sin(G.TIMERS.REAL/28) + 1) + (self.juice and self.juice.r*20 or 0) + self.tilt_var.amt
// self.ARGS.send_to_shader[2] = G.TIMERS.REAL
extern PRECISION vec2 corrupted;

extern PRECISION number dissolve;
extern PRECISION number time;
// [Note] sprite_pos_x _y is not a pixel position!
//        To get pixel position, you need to multiply
//        it by sprite_width _height (look flipped.fs)
// (sprite_pos_x, sprite_pos_y, sprite_width, sprite_height) [not normalized]
extern PRECISION vec4 texture_details;
// (width, height) for atlas texture [not normalized]
extern PRECISION vec2 image_details;
extern bool shadow;
extern PRECISION vec4 burn_colour_1;
extern PRECISION vec4 burn_colour_2;

#define PI 3.14159265359
#define SQRT2 .70710678118
const float mdct[64]=float[64](
    .707106769,.707106769,.707106769,.707106769,.707106769,.707106769,.707106769,.707106769,
    .980785251,.831469595,.555570245,.195090324,-.195090324,-.555570245,-.831469595,-.980785251,
    .923879504,.382683426,-.382683426,-.923879504,-.923879504,-.382683426,.382683426,.923879504,
    .831469595,-.195090324,-.980785251,-.555570245,.555570245,.980785251,.195090324,-.831469595,
    .707106769,-.707106769,-.707106769,.707106769,.707106769,-.707106769,-.707106769,.707106769,
    .555570245,-.980785251,.195090324,.831469595,-.831469595,-.195090324,.980785251,-.555570245,
    .382683426,-.923879504,.923879504,-.382683426,-.382683426,.923879504,-.923879504,.382683426,
    .195090324,-.555570245,.831469595,-.980785251,.980785251,-.831469595,.555570245,-.195090324
);

vec3 round_vec3(vec3 i,float nearest){
    return vec3(
        floor(.5+(i.x/nearest))*nearest,
        floor(.5+(i.y/nearest))*nearest,
        floor(.5+(i.z/nearest))*nearest
    );
}

vec3 dct_h(vec2 coords,Image texture){
    coords*=image_details;
    vec2 grid=floor(coords/8.)*8.;
    vec2 uv=fract(coords/8.)*8.;
    vec3 s=vec3(0);
    for(int i=0;i<8;i++){
        vec3 c=Texel(texture,(grid+vec2(i,floor(uv.y))+.5)/image_details).rgb;
        s+=c*mdct[int(uv.x)*8+i];
    }
    return s;
}

vec3 dct_v(vec2 coords,Image texture){
    coords*=image_details;
    vec2 grid=floor(coords/8.)*8.;
    vec2 uv=fract(coords/8.)*8.;
    
    vec3 s=vec3(0);
    for(int j=0;j<8;j++)
    {
        vec3 c=Texel(texture,(grid+vec2(floor(uv.x),j)+.5)/image_details).rgb;
        s+=c*mdct[int(uv.y)*8+j];
    }
    return s*.25;
}

vec3 idct_h(vec2 coords,Image texture){
    coords*=image_details;
    vec2 grid=floor(coords/8.)*8.;
    vec2 xy=fract(coords/8.)*8.;
    vec3 s=vec3(0.);
    
    for(int u=0;u<8;u++)
    {
        vec3 c=Texel(texture,(grid+vec2(u,xy.y-.5)+.5)/image_details).rgb;
        s+=c*mdct[u*8+int(xy.x)];
    }
    
    return s;
}

vec3 idct_v(vec2 coords,Image texture){
    coords*=image_details;
    vec2 grid=floor(coords/8.)*8.;
    vec2 xy=fract(coords/8.)*8.;
    vec3 s=vec3(0.);
    
    for(int v=0;v<8;v++)
    {
        vec3 c=Texel(texture,(grid+vec2(xy.x-.5,v)+.5)/image_details).rgb;
        s+=c*mdct[v*8+int(xy.y)];
    }
    
    return s;
}

float ms(float mult) {
    return mod(sin(corrupted.y)*mult, 1.0);
}

vec2 ms(vec2 inp, float xm, float ym, float off) {
    return vec2(
        mod(inp.x+sin(corrupted.y+off)*xm, 1),
        mod(inp.y+sin(corrupted.y+off)*ym, 1)
    );
}

// [Required]
// Apply dissolve effect (when card is being "burnt", e.g. when consumable is used)
vec4 dissolve_mask(vec4 tex,vec2 texture_coords,vec2 uv);

// This is what actually changes the look of card
vec4 effect(vec4 colour,Image texture,vec2 texture_coords,vec2 screen_coords)
{
    // a large portion of this shader's math was taken from https://www.shadertoy.com/view/X3dSRn
    // but required adaptation due to the differences between shadertoy and love2d
    vec3 col=vec3(1);
    col*=dct_h(ms(texture_coords, 0.0, 0.03, 0.0),texture);
    col*=dct_v(ms(texture_coords, 0.01, 0.0, 1.0),texture);
    col*=idct_h(ms(texture_coords, 0.02, 0.0, 32.0),texture);
    col*=idct_v(ms(texture_coords, 0.01, 0.07, 19.0),texture);
    col *= 100.0;
    vec4 otex = Texel(texture, texture_coords);
    if (col.x == 0.0 && col.y == 0.0 && col.z == 0.0) {col = otex.rgb;}
    // vec4 tex= vec4((otex.rgb+col)/2.0, otex.a);
    vec4 tex = vec4(col, otex.a);
    vec2 uv=(((texture_coords)*(image_details))-texture_details.xy*texture_details.ba)/texture_details.ba;
    
    return dissolve_mask(tex*colour,texture_coords,uv);
}

vec4 dissolve_mask(vec4 tex,vec2 texture_coords,vec2 uv)
{
    if(dissolve<.001){
        return vec4(shadow?vec3(0.,0.,0.):tex.xyz,shadow?tex.a*.3:tex.a);
    }
    
    float adjusted_dissolve=(dissolve*dissolve*(3.-2.*dissolve))*1.02-.01;//Adjusting 0.0-1.0 to fall to -0.1 - 1.1 scale so the mask does not pause at extreme values
    
    float t=time*10.+2003.;
    vec2 floored_uv=(floor((uv*texture_details.ba)))/max(texture_details.b,texture_details.a);
    vec2 uv_scaled_centered=(floored_uv-.5)*2.3*max(texture_details.b,texture_details.a);
    
    vec2 field_part1=uv_scaled_centered+50.*vec2(sin(-t/143.6340),cos(-t/99.4324));
    vec2 field_part2=uv_scaled_centered+50.*vec2(cos(t/53.1532),cos(t/61.4532));
    vec2 field_part3=uv_scaled_centered+50.*vec2(sin(-t/87.53218),sin(-t/49.));
    
    float field=(1.+(
            cos(length(field_part1)/19.483)+sin(length(field_part2)/33.155)*cos(field_part2.y/15.73)+
            cos(length(field_part3)/27.193)*sin(field_part3.x/21.92)))/2.;
            vec2 borders=vec2(.2,.8);
            
            float res=(.5+.5*cos((adjusted_dissolve)/82.612+(field+-.5)*3.14))
            -(floored_uv.x>borders.y?(floored_uv.x-borders.y)*(5.+5.*dissolve):0.)*(dissolve)
            -(floored_uv.y>borders.y?(floored_uv.y-borders.y)*(5.+5.*dissolve):0.)*(dissolve)
            -(floored_uv.x<borders.x?(borders.x-floored_uv.x)*(5.+5.*dissolve):0.)*(dissolve)
            -(floored_uv.y<borders.x?(borders.x-floored_uv.y)*(5.+5.*dissolve):0.)*(dissolve);
            
            if(tex.a>.01&&burn_colour_1.a>.01&&!shadow&&res<adjusted_dissolve+.8*(.5-abs(adjusted_dissolve-.5))&&res>adjusted_dissolve){
                if(!shadow&&res<adjusted_dissolve+.5*(.5-abs(adjusted_dissolve-.5))&&res>adjusted_dissolve){
                    tex.rgba=burn_colour_1.rgba;
                }else if(burn_colour_2.a>.01){
                    tex.rgba=burn_colour_2.rgba;
                }
            }
            
            return vec4(shadow?vec3(0.,0.,0.):tex.xyz,res>adjusted_dissolve?(shadow?tex.a*.3:tex.a):.0);
        }
        
        extern PRECISION vec2 mouse_screen_pos;
        extern PRECISION float hovering;
        extern PRECISION float screen_scale;
        
        #ifdef VERTEX
        vec4 position(mat4 transform_projection,vec4 vertex_position)
        {
            if(hovering<=0.){
                return transform_projection*vertex_position;
            }
            float mid_dist=length(vertex_position.xy-.5*love_ScreenSize.xy)/length(love_ScreenSize.xy);
            vec2 mouse_offset=(vertex_position.xy-mouse_screen_pos.xy)/screen_scale;
            float scale=.2*(-.03-.3*max(0.,.3-mid_dist))
            *hovering*(length(mouse_offset)*length(mouse_offset))/(2.-mid_dist);
            
            return transform_projection*vertex_position+vec4(0,0,0,scale);
        }
        #endif
        