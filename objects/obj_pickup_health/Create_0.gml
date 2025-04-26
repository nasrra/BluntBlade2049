/// @description Insert description here
// You can write your code in this editor
function check_collisions(){
    if(place_meeting(x,y,obj_player) == true){
        obj_player.hp.heal(heal_amount);
        audiomanager_play_pickup_health();
        instance_destroy();
    }
}
light = instance_create_layer(x+8,y+8,LAYER_LIGHTING,obj_light);
light.initialise(20,c_green);
