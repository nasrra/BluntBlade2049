/// @description Insert description here
// You can write your code in this editor
event_inherited();
function check_collisions(){
    if(place_meeting(x,y,obj_player) == true){
        obj_player.set_power_up_state(ElementType.FIRE);
        audiomanager_play_pickup_power_up();
        instance_destroy();
    }
}
light = instance_create_layer(x,y,LAYER_LIGHTING,obj_light);
light.initialise(360,c_orange, 360, 0.25);
light.start_pulse_random_size(360, 80, 80, 12, 0.15);
room_check();