/// @description Insert description here
// You can write your code in this editor
var _light_u_position = light_u_position;
var _shadow_u_position = shadow_u_position;
var _light_u_layer = light_u_layer;
var _shadow_u_layer = shadow_u_layer;
var _current_draw_layer = 0;
var _vb = vb;
var _scale_factor = scale_factor;

// enabling z coordinates to simulate light and shadow layers.
// Layer order: Light->Shadow.
gpu_set_ztestenable(1);
gpu_set_zwriteenable(1);

// the application_surface.
// var previous_surface = surface_get_target();
surface_set_target(lighting_surface);
draw_clear_alpha(c_black, 0);
with(obj_light){
    // submit the quad vertex buffer for drawing. 
    shader_set(sh_shadow);
    shader_set_uniform_f(_shadow_u_position, x *_scale_factor, y*_scale_factor);
    shader_set_uniform_f(_shadow_u_layer, _current_draw_layer);
    vertex_submit(_vb, pr_trianglelist,-1); // <-- computers draw triangles lol :)

    // set blend mode to additive as lights add/stack on top of eachother.
    gpu_set_blendmode(bm_add);
    shader_set(sh_light);
    // setting the shader light position to this light instance.
    shader_set_uniform_f(_light_u_position, x*_scale_factor, y*_scale_factor);
    shader_set_uniform_f(_light_u_layer, _current_draw_layer);
    draw_rectangle(0,0, room_width, room_height, 0);
    gpu_set_blendmode(bm_normal);


    // draw the next light and shadow ontop of the previous ones.
    _current_draw_layer--;
}
surface_reset_target();
shader_reset();
gpu_set_ztestenable(0);
gpu_set_zwriteenable(0)