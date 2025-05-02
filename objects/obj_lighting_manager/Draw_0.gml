/// @description Insert description here
// You can write your code in this editor
var _light_u_position = light_u_position;
var _light_u_size = light_u_size;
var _light_u_fov = light_u_fov;
var _light_u_direction = light_u_direction;
var _light_u_strength = light_u_strength;
var _shadow_u_position = shadow_u_position;
var _shadow_u_cam_pos = shadow_u_cam_pos;
var _vb = vb;
var _view_x = camera_get_view_x(0);
var _view_y = camera_get_view_y(0);
var matrix = matrix_build(-_view_x, -_view_y, 0, 0, 0, 0, 1, 1, 1);

// Set up world matrix and draw base scene
matrix_set(matrix_world, matrix);
surface_set_target(lighting_surface);
draw_clear_alpha(c_black, 0);

var surf_x = obj_camera.target_x * 0.5;
var surf_y = obj_camera.target_y * 0.5;
var surf_scale = 0.5;

// Low-opacity base pass
draw_surface_ext(application_surface, surf_x, surf_y, surf_scale, surf_scale, 0, c_white, shadow_opacity);

// Render lights and shadows
with (obj_light) {
    var lx = (x - obj_camera.target_x * 0.5);
    var ly = (y - obj_camera.target_y * 0.5);


    // SHADOW PASS
    gpu_set_blendmode_ext_sepalpha(bm_zero, bm_one, bm_one, bm_zero);
    shader_set(sh_shadow);
    shader_set_uniform_f(_shadow_u_position, lx, ly);
    shader_set_uniform_f(_shadow_u_cam_pos, surf_x, surf_y);
    // shader_set_uniform_f(_shadow_u_position, lx - lx, ly - ly);
    // Pass the world matrix to the shader
    // var u_matrix = shader_get_uniform(sh_shadow, "u_matrix");
    // shader_set_uniform_matrix(u_matrix);    
    vertex_submit(_vb, pr_trianglelist, -1);

    // LIGHT PASS
    gpu_set_blendmode_ext_sepalpha(bm_inv_dest_alpha, bm_one, bm_zero, bm_zero);
    shader_set(sh_light);
    shader_set_uniform_f(_light_u_position, lx, ly);
    shader_set_uniform_f(_light_u_size, size);
    shader_set_uniform_f(_light_u_fov, fov);
    shader_set_uniform_f(_light_u_direction, dir);
    shader_set_uniform_f(_light_u_strength, strength);
    draw_surface_ext(application_surface, surf_x, surf_y, surf_scale, surf_scale, 0, colour, 1);
}

// Composite final image
shader_reset();
gpu_set_blendmode_ext(bm_zero, bm_src_alpha);
draw_surface_ext(application_surface, surf_x, surf_y, surf_scale, surf_scale, 0, c_white, 1);

surface_reset_target();
matrix_set(matrix_world, matrix_build_identity());

gpu_set_blendmode_ext(bm_dest_alpha, bm_inv_dest_alpha);
draw_surface_ext(lighting_surface, surf_x, surf_y, 1, 1, 0, c_white, 1);
gpu_set_blendmode(bm_normal);