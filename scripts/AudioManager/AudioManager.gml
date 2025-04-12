function audiomanager_revolver_shot(){
    audio_play_sound(snd_revolver_1,0,false,1,0,random_range(0.8,1.1));
}

function audiomanager_shotgun_shot(){
    var i = irandom_range(0,2);
    switch(i){
        case 0:
            audio_play_sound(snd_shotgun_1,0,false,1,0,random_range(0.8,1.1));
            break;
        case 1:
            audio_play_sound(snd_shotgun_2,0,false,1,0,random_range(0.8,1.1));
            break;
    }
}