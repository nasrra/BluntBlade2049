
global.gamepad_main = undefined;
global.gamepads = [];
global.input_gamepad_move_x = undefined;
global.input_gamepad_move_y = undefined;





// MOVEMENT.

function input_get_keyboard_move_x(){
    return keyboard_check(ord("D")) - keyboard_check(ord("A"));
}

function input_get_keyboard_move_y(){
    return keyboard_check(ord("S")) - keyboard_check(ord("W"));
}

function input_get_gamepad_move_x(){
    return gamepad_axis_value(global.gamepad_main, gp_axislh);
}

function input_get_gamepad_move_y(){
    return gamepad_axis_value(global.gamepad_main, gp_axislv);
}
function input_get_move_x(){
    return (
        input_is_gamepad_connected() == false?
            input_get_keyboard_move_x():
            input_get_gamepad_move_x()
    );
}

function input_get_move_y(){
    return (
        input_is_gamepad_connected() == false? 
            input_get_keyboard_move_y():
            input_get_gamepad_move_y()
    );
}





// SHIELD SWIVEL.

function input_get_gamepad_aim_swivel_x(){
    return gamepad_axis_value(global.gamepad_main, gp_axisrh);
}

function input_get_gamepad_aim_swivel_y(){
    return gamepad_axis_value(global.gamepad_main, gp_axisrv);
}

function input_is_gamepad_connected(){
    return array_length(global.gamepads) > 0;
}

function input_get_keyboard_aim_swivel_left(){
    return keyboard_check(vk_left);
}

function input_get_keyboard_aim_swivel_right(){
    return keyboard_check(vk_right);
}





//

function input_get_gamepad_parry(){
    return gamepad_button_check(global.gamepad_main, gp_shoulderr);
}

function input_get_keyboard_parry(){
    return keyboard_check(vk_space);
}

function input_get_parry(){
    return(
        input_is_gamepad_connected() == false?
            input_get_keyboard_parry():
            input_get_gamepad_parry()
    );
}





// FUNCTIONS.

function handle_gamepad(_gamepad, _event_type){
    show_debug_message(_event_type);
    switch(_event_type){
        case "gamepad discovered":
            array_push(global.gamepads, _gamepad);
            gamepad_set_axis_deadzone(_gamepad, 0.1);    
        break;
        case "gamepad lost":
            var _index = array_get_index(global.gamepads, _gamepad);
            if(_index >= 0){
                array_delete(global.gamepads, _index, 1);
            }
        break;
    }

    // set to the first gamepad in the array of connected gamepads.
    global.gamepad_main = (array_length(global.gamepads) > 0? global.gamepads[0] : global.gamepad_main = undefined);
}