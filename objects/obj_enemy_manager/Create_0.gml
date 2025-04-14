/// @description Insert description here
// You can write your code in this editor
spawners = [];
waves = [];
alive_enemies = 0;
current_wave = 0;
loop_waves = false;

function add_enemy(){
    alive_enemies += 1;
}

function remove_enemy(){
    alive_enemies -= 1;
    if(alive_enemies <= 0){
        spawn_wave(current_wave);
        current_wave +=1;
        if(current_wave >= array_length(waves) && loop_waves == true){
            current_wave = 0;
        }
    }
}

function spawn_wave(_wave_index){
    if(_wave_index >= array_length(waves)){
        exit;
    }
    var wave = waves[_wave_index];
    show_debug_message("spawning wave of enemies");
    for(var i = 0; i < array_length(wave); ++i){
        if(wave[i] != undefined){
            var spawner = spawners[i];
            show_debug_message(i);
            show_debug_message(spawner.spawner_id);
            instance_create_layer(spawner.x, spawner.y, "Enemies", wave[i]);
            add_enemy();
        }
    }
}