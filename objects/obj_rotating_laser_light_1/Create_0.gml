hp = instance_create_layer(x,y,LAYER_ENVIRONMENT, obj_health);
hp.initialise(1, 1);

hp.on_death.set(function(){
    explode();
    instance_destroy();
});

lights = [
    instance_create_layer(x,y,LAYER_LIGHTING,obj_light),
    instance_create_layer(x,y,LAYER_LIGHTING,obj_light),
    instance_create_layer(x,y,LAYER_LIGHTING,obj_light),
    instance_create_layer(x,y,LAYER_LIGHTING,obj_light)
]

lights[0].initialise(light_size, colour,    light_fov, 0.001);
lights[1].initialise(light_size, colour,    light_fov, 0.001);
lights[2].initialise(light_size, colour,    light_fov, 0.001);
lights[3].initialise(light_size, colour,    light_fov, 0.001);

angles = [];
var length = array_length(lights);
for (var i = 0; i < length; i++){
    // evenly spaced around;
    angles[i] = i * (360 / length);
}

function update_lights(){
    for(var i = 0; i < array_length(lights); i++){
        var instance = lights[i];
        // instance.size = light_size + (light_size*obj_lighting_manager.music_sync_factor);
        instance.fov = light_fov + (light_fov * obj_lighting_manager.music_sync_factor);

        // clamp within 360 to avoid floating point errors.
		angles[i] += reverse == true? -orbit_speed : orbit_speed;
        if(angles[i] >= 360){
            angles[i] -= 360;
        }

        // set positions.
        instance.x = x +(sprite_width*0.5) + lengthdir_x(orbit_radius, angles[i]);
        instance.y = y +(sprite_height*0.5) + lengthdir_y(orbit_radius, angles[i]);

        // set direction for light to point in.
        instance.dir = point_direction(x+(sprite_width*0.5),y+(sprite_height*0.5),instance.x,instance.y);
    }
}

function explode(){
    instance_create_layer(x+8,y+8,LAYER_ENVIRONMENT,obj_explosion_electric);
    instance_create_layer(x+8,y+8,LAYER_ENVIRONMENT,obj_element_zone_electric);
    instance_destroy();
}