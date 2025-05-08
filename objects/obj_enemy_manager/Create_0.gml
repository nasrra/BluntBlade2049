/// @description Insert description here
// You can write your code in this editor
spawners = [];
waves = [];
alive_enemies = 0;
current_wave = -1;
// loop_waves = false;
loop_waves = false;
function add_enemy(){
    alive_enemies += 1;
}

function remove_enemy(){
    alive_enemies -= 1;
    if(alive_enemies <= 0 && roommanager_get_room_cleared(room) == false){
        spawn_next_wave();
        if(current_wave >= array_length(waves)){
            current_wave = -1;
            roommanager_set_room_cleared(room, true);
            roommanager_decrement_floor_rooms_to_clear();
            var text = instance_create_layer(0,0,LAYER_TEXT, obj_text_wave);
            if(roommanager_is_floor_cleared() == false){
                text.initialise("ROOM CLEARED!", 6.5, 0, false);
            }
            else{
                text.initialise("FLOOR CLEARED!", 6.5, 0, false);
            }
            text.start_lifetime_timer(240);
            obj_lighting_manager.set_room_clear_shadow_opacity();
            audiomanager_play_room_cleared();
            obj_door_manager.unlock_doors();
        }
    }
}

function spawn_next_wave(){
    spawn_wave(++current_wave);
}

function spawn_wave(_wave_index){
    if(_wave_index >= array_length(waves)){
        exit;
    }
    var wave = waves[_wave_index];
    // show_debug_message("spawning wave of enemies");
    for(var i = 0; i < array_length(wave); ++i){
        if(wave[i] != undefined){
            var spawner = spawners[i];
            instance_create_layer(spawner.x, spawner.y, LAYER_ENEMY, wave[i]);
            add_enemy();
        }
    }
}
