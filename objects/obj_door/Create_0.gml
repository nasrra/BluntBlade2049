/// @description Insert description here
// You can write your code in this editor
player_entered = false;
locked = false;
room_transition_movement = undefined;
room_to_goto_enter_point = undefined; // the door the player enters from in the next room.

light = instance_create_layer(x,y-sprite_height*0.66,LAYER_LIGHTING, obj_light);
light.initialise(300,c_white, 140, 1);
light.dir = 270;

function handle_collisions(){
    if(locked == false && player_entered == false && place_meeting(x,y,obj_player) == true){
        if(room_transition_movement == undefined){
            show_debug_message("[ERROR]: door transition movement is undefined!");
            exit;
        }
        player_entered = true;
        obj_player.block_input();
        roommanager_set_room_to_load(room_to_goto, room_to_goto_enter_point);
        obj_ui_manager.start_room_transition(room_transition_movement, RoomTransitionSetup.EXIT);
    }
}

function get_exit_position(){
    return new Vector2(x+exit_position_x, y+exit_position_y);
}

function set_locked(){
    locked = true;
    sprite_index = sprite_locked;
    light.colour = c_red;
}

function set_unlocked(){
    locked = false;
    sprite_index = sprite_unlocked;
    light.colour = c_white;
}