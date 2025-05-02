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
var surf_scale = 0.5;
var cam_tx = obj_camera.target_x;
var cam_ty = obj_camera.target_y;
var surf_x = cam_tx * 0.5;
var surf_y = cam_ty * 0.5;

matrix_set(matrix_world, matrix);
surface_set_target(lighting_surface);
draw_clear_alpha(c_black, 0);

// Low-opacity base pass
draw_surface_ext(application_surface, surf_x, surf_y, surf_scale, surf_scale, 0, c_white, shadow_opacity);

// Shadow/light passes
with (obj_light) {
    var lx = x - cam_tx * 0.5;
    var ly = y - cam_ty * 0.5;

    // Shadow pass
    gpu_set_blendmode_ext_sepalpha(bm_zero, bm_one, bm_one, bm_zero);
    shader_set(sh_shadow);
    shader_set_uniform_f(_shadow_u_position, lx, ly);
    shader_set_uniform_f(_shadow_u_cam_pos, surf_x, surf_y);
    vertex_submit(_vb, pr_trianglelist, -1);

    // Light pass
    gpu_set_blendmode_ext_sepalpha(bm_inv_dest_alpha, bm_one, bm_zero, bm_zero);
    shader_set(sh_light);
    shader_set_uniform_f(_light_u_position, lx, ly);
    shader_set_uniform_f(_light_u_size, size);
    shader_set_uniform_f(_light_u_fov, fov);
    shader_set_uniform_f(_light_u_direction, dir);
    shader_set_uniform_f(_light_u_strength, strength);
    draw_surface_ext(application_surface, surf_x, surf_y, surf_scale, surf_scale, 0, colour, 1);
}

// Composite
shader_reset();
gpu_set_blendmode_ext(bm_zero, bm_src_alpha);
draw_surface_ext(application_surface, surf_x, surf_y, surf_scale, surf_scale, 0, c_white, 1);

surface_reset_target();
matrix_set(matrix_world, matrix_build_identity()); // Optional
gpu_set_blendmode_ext(bm_dest_alpha, bm_inv_dest_alpha);
draw_surface_ext(lighting_surface, surf_x, surf_y, 1, 1, 0, c_white, 1);
gpu_set_blendmode(bm_normal);
