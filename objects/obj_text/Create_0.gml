/// @description Insert description here
// You can write your code in this editor

on_lifetime_end = new EventAction();

function initialise(_text, _scale, _angle){
    text = _text;
    scale = _scale;
    angle = _angle;
}

function base_initialise(_text, _scale, _angle){
    text = _text;
    scale = _scale;
    angle = _angle;
}

function start_destroy_timer(_time_in_frames){
    alarm_set(0,_time_in_frames);
}

function start_lifetime_timer(_time_in_frames){
    alarm_set(1,_time_in_frames);
}