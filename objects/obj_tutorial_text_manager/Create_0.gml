/// @description Insert description here
// You can write your code in this editor
if(gamemanager_is_tutorial_complete() == false){
	layer_set_visible(LAYER_TUTORIAL, true);
	gamemanager_set_tutorial_complete();
}
else{
	layer_set_visible(LAYER_TUTORIAL, false);
}
