// position of the pixel.
varying vec2 position;
varying vec4 colour;

// position of the light.
uniform vec2 u_position;

uniform float u_size;
uniform float u_strength;
uniform float u_direction;
uniform float u_fov;

#define PI 3.1415926538
#define DOUBLE_PI 6.2831853076

void main(){
    vec2 distance = position - u_position;

    // set the strength to get stronger the closer this pixel is to the light source's position.
    // float strength = 1./(sqrt(distance.x*distance.x + distance.y*distance.y + u_size*u_size)-u_size+1.-u_strength);
    float strength = 1./(sqrt(distance.x*distance.x + distance.y*distance.y + u_size*u_size)-u_size)*u_strength;

    float direction = radians(u_direction);
    float fov = radians(u_fov) * 0.5;

    // slice portions of the light if the fov is less that PI.
    // emulating a directional light.
    if(fov < PI){
        // get the angle of the current pixel.
        float rad = atan(-distance.y, distance.x);
        // the angular distance we are in the direction.
        float a_distance = abs(mod(rad+DOUBLE_PI,DOUBLE_PI) - direction);
        // getting the inner angle, not the outer for the directional light.
        a_distance = min(a_distance, DOUBLE_PI - a_distance);
        
        // slice the pixels light if it is not within our fov. 
        if(a_distance > fov){
            strength = 0.;
        }
    }

    gl_FragColor = colour * vec4(vec3(strength),1.);
}


