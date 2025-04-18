




// GENERIC.

function handle_value(_val_string, _target_val, _speed, _alarm_index, _fx){
    show_debug_message(_val_string);
    var val = fx_get_parameter(_fx, _val_string);
    var calc_val = lerp(val, _target_val, _speed);
    val = abs(val-_target_val) < 0.025 ? _target_val : calc_val;
    fx_set_parameter(_fx, _val_string, val);
    if(val != _target_val){
        alarm_set(_alarm_index, 1);
    }
}





// DESATURATE.

desaturate_alarm_index = 0;
desaturate_target_intensity = undefined;
desaturate_speed = undefined;
desaturate_fx = layer_get_fx("DesaturateFX");

function reset_desaturuate(){
    layer_set_visible("DesaturateFX", true);
    fx_set_parameter(desaturate_fx,"g_Intensity", 0);
}

function turn_on_desaturate(_speed){
    desaturate_speed = _speed;
    desaturate_target_intensity = 0.75;
    alarm_set(desaturate_alarm_index, 1);
}

function handle_desaturate(){
    handle_value("g_Intensity", desaturate_target_intensity, desaturate_speed, desaturate_alarm_index, desaturate_fx);
}

function turn_off_desaturate(_speed){
    desaturate_target_intensity = 0;
    alarm_set(desaturate_alarm_index, 1);
}

reset_desaturuate();



// VIGNETTE.

vignette_alarm_index = 1;
vignette_target_edge_1 = undefined;
vignette_speed = undefined;
vignette_fx = layer_get_fx("VignetteFX");

function reset_vignette(){
    layer_set_visible("VignetteFX", true);
    fx_set_parameter(vignette_fx,"g_VignetteEdges", [1.25,1.25]);
    fx_set_parameter(vignette_fx,"g_VignetteSharpness", 2);
}
reset_vignette();

function turn_on_vignette(_speed){
    vignette_speed = _speed;
    vignette_target_edge_1 = 0.75;
    alarm_set(vignette_alarm_index, 1);
}

function handle_vignette(){
    var val_array = fx_get_parameter(vignette_fx, "g_VignetteEdges");
    var val = val_array[0];
    var calc_val = lerp(val, vignette_target_edge_1, vignette_speed);
    val_array[0] = abs(val-vignette_target_edge_1) < 0.1? vignette_target_edge_1 : calc_val;
    fx_set_parameter(vignette_fx, "g_VignetteEdges", val_array);
    if(val != vignette_target_edge_1){
        alarm_set(vignette_alarm_index, 1);
    }
}

function turn_off_vignette(_speed){
    vignette_speed = _speed;
    vignette_target_edge_1 = 1.25;
    alarm_set(vignette_alarm_index, 1);
}





// RGB NOISE.

rgb_noise_alarm_index = 2;
rgb_noise_target_intensity = undefined;
rgb_noise_speed = undefined;
rgb_noise_fx = layer_get_fx("RGBNoiseFX");

function reset_rgb_noise(){
    layer_set_visible("RGBNoiseFX", true);
    fx_set_parameter(rgb_noise_fx, "g_RGBNoiseIntensity", 0);
    fx_set_parameter(rgb_noise_fx, "g_RGBNoiseAnimation", 0.001);
}
reset_rgb_noise();

function turn_on_rgb_noise(_speed){
    rgb_noise_speed = _speed;
    rgb_noise_target_intensity = 0.15;
    alarm_set(rgb_noise_alarm_index, 1);
}

function handle_rgb_noise(){
    handle_value("g_RGBNoiseIntensity", rgb_noise_target_intensity, rgb_noise_speed, rgb_noise_alarm_index, rgb_noise_fx);
}

function turn_off_rgb_noise(_speed){
    rgb_noise_speed = _speed;
    rgb_noise_target_intensity = 0;
    alarm_set(rgb_noise_alarm_index, 1);
}





// OldFilm / Fliker

old_film_alarm_index = 3;
old_film_fx = layer_get_fx("OldFilmFX");

function reset_old_film(){
    layer_set_visible("OldFilmFX", true);
    fx_set_parameter(old_film_fx, "g_OldFilmFlickerIntensity", .15);
    fx_set_parameter(old_film_fx, "g_OldFilmFlickerSpeed", 30);
    fx_set_parameter(old_film_fx, "g_OldFilmJitterIntensity", 3);
    fx_set_parameter(old_film_fx, "g_OldFilmSaturation", 1);
    fx_set_parameter(old_film_fx, "g_OldFilmSpeckIntensity", 0);
    fx_set_parameter(old_film_fx, "g_OldFilmBarScale", 0); // 20
    fx_set_parameter(old_film_fx, "g_OldFilmBarSpeed", 0); // 20
    fx_set_parameter(old_film_fx, "g_OldFilmBarFrequency",128); // 4
    fx_set_parameter(old_film_fx, "g_OldFilmRingScale", 0);
    fx_set_parameter(old_film_fx, "g_OldFilmRingSharpness", 0);
    fx_set_parameter(old_film_fx, "g_OldFilmRingIntensity", 0);
}

reset_old_film();