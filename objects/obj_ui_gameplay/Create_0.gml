healthbar_heart_amount = 0;
healthbar_start_x = 10;
healthbar_start_y = 10;
healthbar_heart_spacing = 20;
healthbar_heart_scale = 4;

function update_healthbar(_amount){
    healthbar_heart_amount = _amount;
}

function draw_health_bar(){
    for(var i = 0; i < healthbar_heart_amount; i++){
        var x_offset = (healthbar_start_x * healthbar_heart_scale) + healthbar_heart_spacing * i * healthbar_heart_scale;
        var y_offset = healthbar_start_y * healthbar_heart_scale;
        draw_sprite_ext(
            spr_healthbar_heart,
            0, 
            x_offset, 
            y_offset, 
            healthbar_heart_scale, 
            healthbar_heart_scale,
            image_angle,
            image_blend,
            image_alpha
        );
    }
}