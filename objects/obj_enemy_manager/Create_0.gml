/// @description Insert description here
// You can write your code in this editor
spawners = [];
waves = [];
alive_enemies = 0;
current_wave = 0;
// loop_waves = false;
loop_waves = false;
function add_enemy(){
    alive_enemies += 1;
}

function remove_enemy(){
    alive_enemies -= 1;
    if(alive_enemies <= 0 && roommanager_get_room_cleared(room) == false){
        spawn_wave(current_wave);
        current_wave +=1;
        if(current_wave >= array_length(waves) && loop_waves == true){
            current_wave = 0;
        }
    }
}

function spawn_wave(_wave_index){
    if(_wave_index >= array_length(waves)){
        roommanager_set_room_cleared(room, true);
        obj_lighting_manager.set_room_clear_shadow_opacity();
        var text = instance_create_layer(0,0,LAYER_TEXT, obj_text_wave_screen_space);
        text.initialise("ROOM CLEARED!", 6.5, 0);
        audiomanager_play_room_cleared();
        exit;
    }
    var wave = waves[_wave_index];
    show_debug_message("spawning wave of enemies");
    for(var i = 0; i < array_length(wave); ++i){
        if(wave[i] != undefined){
            var spawner = spawners[i];
            instance_create_layer(spawner.x, spawner.y, LAYER_ENEMY, wave[i]);
            add_enemy();
        }
    }
}
