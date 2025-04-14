function sh_damage_flash_controller(_id, _color) constructor{
    id = _id;
    shader = sh_damage_flash;
    colour = _color;
    decay_step = 0;
    flash_amount = 0;
    alpha = 0;

    function invoke(_amount, _time_in_seconds){
        if(_amount == 0){
            exit;
        }
        var time_per_flash = _time_in_seconds / _amount;
        decay_step = 1 / (time_per_flash * room_speed); // fade from 1 to 0 over time_per_flash seconds
        flash_amount = _amount - 1;
        alpha = 1;
    }

    // lerp the flash, used in the alarm function.
    function decay(){
        alpha -= decay_step;
        // if there are more than one flashes queued, start again.
        if(alpha <= 0 && flash_amount > 0){
            flash_amount -= 1;
            show_debug_message("again!");
            alpha = 1;
        }
    }

    function draw(){
        if(alpha > 0){
            shader_set(shader)
            draw_sprite_ext(id.sprite_index, id.image_index, id.x, id.y, id.image_xscale, id.image_yscale, id.image_angle, colour, alpha);
            decay();
            shader_reset();
        }
    }
}