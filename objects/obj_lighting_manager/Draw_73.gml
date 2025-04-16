/// @description Insert description here
// You can write your code in this editor
// Set blend mode to multiply

// // draw_surface(application_surface,0,0);
gpu_set_blendmode_ext(bm_dest_color, bm_zero);
// // Draw the lighting surface
draw_surface_ext(lighting_surface, 0, 0, 2, 2, 0, c_white, 1);

// // Reset to normal blend mode
gpu_set_blendmode(bm_normal);