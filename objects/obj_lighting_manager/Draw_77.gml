/// @description Insert description here
// You can write your code in this editor
/// @description Insert description here
// You can write your code in this editor
draw_clear_alpha(c_black, 1);
gpu_set_blendmode_ext(bm_one, bm_zero);
draw_surface_ext(application_surface, 0,0,1,1,0,c_white,1);
// surface_copy(crt_surface, 0,0,application_surface);
// draw_crt_lines();
gpu_set_blendmode(bm_normal);