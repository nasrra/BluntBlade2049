/// @description Insert description here
// You can write your code in this editor
var _light_u_position = light_u_position;
var _light_u_size = light_u_size;
var _light_u_fov = light_u_fov;
var _light_u_direction = light_u_direction;
var _light_u_strength = light_u_strength;
var _shadow_u_position = shadow_u_position;
var _vb = vb;
var _scale_factor = scale_factor;
var _view_x = view_xview[0];
var _view_y = view_yview[0];

matrix_set(matrix_world, matrix_build(-_view_x,-_view_y,0,0,0,0,1,1,1));
surface_set_target(lighting_surface);
draw_clear_alpha(c_black, 0);

with(obj_light){
    
    // setting pixels covered by shadow to black with an opacity of 1, 
    // settings pixels not covered to be the source pixel colour with an opacity of 0 (where the light will draw).
    gpu_set_blendmode_ext_sepalpha(bm_zero, bm_one, bm_one, bm_zero);
    shader_set(sh_shadow);
    shader_set_uniform_f(_shadow_u_position, x *_scale_factor, y*_scale_factor);
    // submit the quad vertex buffer for drawing. 
    vertex_submit(_vb, pr_trianglelist,-1); // <-- computers draw triangles lol :)

    // bm_inv_des_alpha: targeting pixels with an alpha of 0.

    gpu_set_blendmode_ext_sepalpha(bm_inv_dest_alpha, bm_one, bm_zero, bm_zero);
    shader_set(sh_light);
    // setting the shader light position to this light instance.
    shader_set_uniform_f(_light_u_position, x*_scale_factor, y*_scale_factor);
    shader_set_uniform_f(_light_u_size, size);
    shader_set_uniform_f(_light_u_fov, fov);
    shader_set_uniform_f(_light_u_direction, dir);
    shader_set_uniform_f(_light_u_strength, strength);
    draw_rectangle_color(_view_x,_view_y, _view_x+960, _view_y+540, colour, colour, colour, colour, 0);
}
surface_reset_target();

matrix_set(matrix_world, matrix_build(0,0,0,0,0,0,1,1,1));

gpu_set_blendmode_ext(bm_zero, bm_src_color);
shader_set(sh_shadow_surface);;
draw_surface_ext(lighting_surface, 0, 0, 2, 2, 0, c_white, 0.8);
gpu_set_blendmode(bm_normal);

shader_reset();