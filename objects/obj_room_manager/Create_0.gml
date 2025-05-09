/// @description Insert description here
// You can write your code in this editor
// audiomanager_play_music();

function handle_starting_room(){
    if(global.current_floor != room || global.current_floor == undefined){
	    global.current_floor = room;
	    roommanager_set_floor_rooms_to_clear(8);
	    var text = instance_create_layer(0,0,LAYER_TEXT, obj_text_wave);
	    text.initialise(floor_name, 6.5, 0, false);
	    text.start_lifetime_timer(240);
    }
}