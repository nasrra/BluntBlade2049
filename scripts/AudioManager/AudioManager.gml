function audiomanager_play_revolver_shot(){
    audio_play_sound(snd_revolver_1,0,false,1,0,random_range(0.8,1.1));
}

function audiomanager_play_shotgun_shot(){
    var i = irandom_range(0,1);
    switch(i){
        case 0:
            audio_play_sound(snd_shotgun_1,0,false,1,0,random_range(0.8,1.1));
            break;
        case 1:
            audio_play_sound(snd_shotgun_2,0,false,1,0,random_range(0.8,1.1));
            break;
    }
}

function audiomanager_play_parry(){
    var i = irandom_range(0,2);
    switch(i){
        case 0:
            audio_play_sound(snd_parry_1,0,false,1,0,random_range(0.8,1));
            break;
        case 1:
            audio_play_sound(snd_parry_2,0,false,1,0,random_range(0.8,1));
            break;
        case 2:
            audio_play_sound(snd_parry_3,0,false,1,0,random_range(0.8,1));
            break;
    }
}

function audiomanager_play_hit_glitch(){
    var i = irandom_range(0,1);
    switch(i){
        case 0:
            audio_play_sound(snd_hit_glitch_1,0,true,1,0,random_range(0.8,1));
            break;
        case 1:
            audio_play_sound(snd_hit_glitch_2,0,true,1,0,random_range(0.8,1));
            break;
    }
}

function audiomanager_stop_hit_glitch(){
    audio_stop_sound(snd_hit_glitch_1);    
    audio_stop_sound(snd_hit_glitch_2);
}


function audiomanager_play_burst_rifle_shot(){
    var i = irandom_range(0,1);
    switch(i){
        case 0:
            audio_play_sound(snd_burst_rifle_1,0,false,1,0,random_range(0.8,1));
            break;
        case 1:
            audio_play_sound(snd_burst_rifle_2,0,false,1,0,random_range(0.8,1));
            break;
    }
}

function audiomanager_play_explosion(){
    var i = irandom_range(0,2);
    switch(i){
        case 0:
            audio_play_sound(snd_explosion_1,0,false,1,0,random_range(0.8,1));
            break;
        case 1:
            audio_play_sound(snd_explosion_2,0,false,1,0,random_range(0.8,1));
            break;
        case 2:
            audio_play_sound(snd_explosion_3,0,false,1,0,random_range(0.8,1));
            break;
    }
}

function audiomanager_play_player_damaged(){
    audio_play_sound(snd_player_damaged, 0,false, 1,0, random_range(0.85,1.05));
}

function audiomanager_play_pickup_health(){
    audio_play_sound(snd_pickup_health, 0, false, 1, 0, random_range(0.85,1.05));
}

function audiomanager_play_parry_element_fire(){
    audio_play_sound(snd_parry_element_fire, 0, false, 1, 0, random_range(0.9,1.05));
}

function audiomanager_play_pick_up_power_up(){
    audio_play_sound(snd_pickup_power_up, 0, false, 1, 0, random_range(0.9,1.05));
}

function audiomanager_play_electric_loop(){
    audio_play_sound(snd_electric_loop, 0, true, 1, 0, random_range(0.8,1));
}

function audiomanager_stop_electric_loop(){
    audio_stop_sound(snd_electric_loop);
}

function audiomanager_play_electric_burst(){
    // if( audio_exists(snd_electric_burst_1) == true ||
    //     audio_exists(snd_electric_burst_2) == true){
    //         exit;
    // }
    var i = irandom_range(0,1);
    switch(i){
        case 0:
            audio_play_sound(snd_electric_burst_1, 0, false, 1, 0, random_range(0.8, 1));
            break;
        case 1:
            audio_play_sound(snd_electric_burst_2, 0, false, 1, 0, random_range(0.8, 1));
            break;
    }
}

function audiomanager_play_thunder(){
    var i = irandom_range(0,1);
    switch(i){
        case 0:
            audio_play_sound(snd_thunder_1, 0, false, 1, 0, random_range(0.8, 1));
            break;
        case 1:
            audio_play_sound(snd_thunder_2, 0, false, 1, 0, random_range(0.8, 1));
            break;
    }
}