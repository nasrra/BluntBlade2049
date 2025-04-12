/// @description Insert description here
// You can write your code in this editor
target      = obj_player;
path        = undefined;

// create a grid of cells to check a path against.
grid = mp_grid_create(0,0,room_width/8,room_height/8, 8, 8);

mp_grid_add_instances(grid, obj_environment, 0);