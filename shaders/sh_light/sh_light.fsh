// position of the pixel.
varying vec2 position;

// position of the light.
uniform vec2 u_position;

float size = 32.;

void main(){
    vec2 distance = position - u_position;

    // set the strength to get stronger the closer this pixel is to the light source's position.
    float strength = 1./(sqrt(distance.x*distance.x + distance.y*distance.y + size*size)-size);
    gl_FragColor = vec4(vec3(strength),1.);
}
