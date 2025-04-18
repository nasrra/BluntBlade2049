/// @description Insert description here
// You can write your code in this editor
if (collision_rectangle(x - 1, y - 1, x + sprite_width + 1, y + sprite_height + 1, obj_player, false, false)) {
    explode();
}