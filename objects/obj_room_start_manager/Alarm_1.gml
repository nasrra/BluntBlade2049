/// @description Insert description here
// You can write your code in this editor
if(layer_get_visible("ControllerPopUp") == false){
	audiomanager_play_controller_pop_up();
	layer_set_visible("ControllerPopUp", true);
	alarm_set(1,240);
}
else{
	audiomanager_play_controller_pop_up();
	layer_set_visible("ControllerPopUp", false);
	alarm_set(3,60);
}
