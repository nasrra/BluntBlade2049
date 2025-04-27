/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();
light_size = 7500;
hurt_radius = 100;
hurt_frames = 10;
death_time = 120;
part_type = part_type_explosion_electric();
colour = make_colour_rgb(0,246,255);
audio = function(){
    audiomanager_play_explosion_electric();   
}
start();