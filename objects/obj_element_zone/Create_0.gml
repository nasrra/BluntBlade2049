/// @description Insert description here
// You can write your code in this editor
element_type = undefined;
player_entered = false;

function check_collisions(){
    if(place_meeting(x,y,obj_player) == true){
		if(player_entered == false){
			obj_player.element_status.set_status(element_type);
			audiomanager_play_pick_up_power_up();
			player_entered = true;
		}
    }
	else{
		player_entered = false;
	}
}