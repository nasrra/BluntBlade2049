/// @description Insert description here
// You can write your code in this editor
function check_collisions(){
    if(place_meeting(x,y,obj_player) == true){
        obj_player.hp.heal(heal_amount);
        audiomanager_play_pickup_health();
        instance_destroy();
    }
}
light = obj_lighting_manager.create_light_source(x+8,y+8,20,c_green);