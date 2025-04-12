function sh_damage_flash_controller(_id, _color) constructor{
    id = _id;
    shader = sh_damage_flash;
    colour = _color;
    speed = 0;
    alpha = 0;

    function invoke(_speed){
        speed = _speed;
        alpha = 1;
    }

    // lerp the flash, used in the alarm function.
    function decay(){
        alpha -= speed;
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