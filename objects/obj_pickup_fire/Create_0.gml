/// @description Insert description here
// You can write your code in this editor
function check_collisions(){
    if(place_meeting(x,y,obj_player) == true){
        obj_player.sword.element_type = ElementType.FIRE;
        audiomanager_play_pickup_power_up();
        instance_destroy();
    }
}
light = instance_create_layer(x,y,LAYER_LIGHTING,obj_light);
light.initialise(20,c_orange, 360);
light.start_pulse_random_size(25, 15, 40, 12, 0.15);