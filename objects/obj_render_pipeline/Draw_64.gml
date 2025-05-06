/// @description Insert description here
// You can write your code in this editor
obj_text_manager.draw_screen_space();
obj_ui_manager.draw();
gpu_set_blendmode_ext(bm_one, bm_zero);
draw_application_surface_crt_lines();
obj_ui_manager.draw_room_transition_when_active();
gpu_set_blendmode(bm_normal);