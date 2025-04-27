hp = instance_create_layer(x,y,LAYER_ENVIRONMENT, obj_health);
hp.initialise(1, 1);

hp.on_death.set(function(){
    instance_destroy();
});

lights = [
    instance_create_layer(x,y,LAYER_LIGHTING,obj_light),
    instance_create_layer(x,y,LAYER_LIGHTING,obj_light),
    instance_create_layer(x,y,LAYER_LIGHTING,obj_light),
    instance_create_layer(x,y,LAYER_LIGHTING,obj_light)
]

lights[0].initialise(500, c_aqua,    45);
lights[1].initialise(500, c_lime,    45);
lights[2].initialise(500, c_red,     45);
lights[3].initialise(500, c_orange,  45);

angles = [];
var length = array_length(lights);
for (var i = 0; i < length; i++){
    // evenly spaced around;
    angles[i] = i * (360 / length);
}

function update_lights(){
    for(var i = 0; i < array_length(lights); i++){
        var instance = lights[i];
        
        // clamp within 360 to avoid floating point errors.
		angles[i] += orbit_speed;
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