/// @description Insert description here
// You can write your code in this editor
if(gamemanager_is_tutorial_complete() == false){
	gamemanager_set_tutorial_complete();
}
else{
	for(var i = 0; i < array_length(text_instances); i++){
		instance_destroy(text_instances[i]);
	}
	layer_set_visible(LAYER_TUTORIAL, false);
}
