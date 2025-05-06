/// @description Insert description here
// You can write your code in this editor
if (collision_rectangle(
    (x - sprite_width*0.5) -1, 
    (y - sprite_width*0.5) -1, 
    (x + sprite_width*0.5) +1, 
    (y + sprite_width*0.5) +1, 
    obj_player, 
    false, 
    false)) 
{
    explode();
}