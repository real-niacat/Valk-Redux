#if defined(VERTEX)||__VERSION__>100||defined(GL_FRAGMENT_PRECISION_HIGH)
#define PRECISION highp
#else
#define PRECISION mediump
#endif

// self.ARGS.send_to_shader[1] = math.min(self.VT.r*3, 1) + (math.sin(G.TIMERS.REAL/28) + 1) + (self.juice and self.juice.r*20 or 0) + self.tilt_var.amt
// self.ARGS.send_to_shader[2] = G.TIMERS.REAL
extern PRECISION vec2 jpeg;

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

// [Required]
// Apply dissolve effect (when card is being "burnt", e.g. when consumable is used)
vec4 dissolve_mask(vec4 tex,vec2 texture_coords,vec2 uv);

#define PI 3.14159265

const float dataLofi=.01;
const float dataThreshold=.01;
const float highFreqMultiplier=0.;
const int blockSize=8;

vec3 lofi(vec3 i,float j){
    return floor((i/j)+.5)*j;
}

vec2 img2tex(vec2 v){return v/texture_details.zw*image_details;}

vec3 yuv2rgb(vec3 yuv){
    return vec3(
        yuv.x+1.402*yuv.z,
        yuv.x-.344136*yuv.y-.714136*yuv.z,
        yuv.x+1.772*yuv.y
    );
}

vec3 unpack664(vec2 v){
    return vec3(
        mod(v.x*255.,64.),
        floor(v.x*255./64.)+4.*mod(v.y*255.,16.),
        floor(v.y*255./16.)
    )/vec3(63.,63.,15.);
}

vec4 effect(vec4 colour,Image texture,vec2 texture_coords,vec2 screen_coords)
{
    float original_alpha=Texel(texture,texture_coords).a;
    if(jpeg.y>jpeg.y*2.){colour.a=0.;}
    
    vec2 coord=screen_coords;
    vec2 blockOrigin=.5+floor(coord/float(blockSize))*float(blockSize);
    
    vec2 delta=mod(coord,float(blockSize));
    vec3 sum=vec3(0.);
    for(int iy=0;iy<blockSize;iy++){
        for(int ix=0;ix<blockSize;ix++){
            vec2 fdelta=vec2(float(ix),float(iy));
            vec2 freq=fdelta/float(blockSize)*PI;
            float wave=cos(delta.x*freq.x)*cos(delta.y*freq.y);
            vec4 tex=Texel(texture,(blockOrigin+fdelta));
            vec3 fuck=unpack664(tex.zy);
            vec3 val=vec3(tex.x-128./255.,fuck.xy-32./63.)/pow(2.,fuck.z*15.);
            val=0.<dataLofi?lofi(val,dataLofi):val;
            val*=length(val)<dataThreshold?0.:1.+length(fdelta)*highFreqMultiplier;
            sum+=wave*val*4.;
        }
    }

    vec4 tex = vec4(yuv2rgb(sum), 1) * Texel(texture, texture_coords);
    
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
        