// position of the pixel.
varying vec2 position;
varying vec4 colour;

// position of the light.
uniform vec2 u_position;

uniform float u_size;

uniform float u_strength;

void main() {
    vec2 delta = position - u_position;
    float distance = length(delta);

    // Map distance to a [0,1] falloff where 0 is center, 1 is edge of light radius
    float attenuation = 1.0 - clamp(distance / u_size, 0.0, 1.0);

    // Now use both attenuation and strength
    float final_intensity = attenuation * u_strength;

    vec3 base_color = colour.rgb * final_intensity;
    float alpha = colour.a * final_intensity;

    gl_FragColor = vec4(base_color, alpha);
}


