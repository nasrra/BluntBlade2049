precision lowp float;

varying vec2 position;
varying vec4 colour;
varying vec2 v_vTexcoord;

uniform vec2 u_position;
uniform float u_size;
uniform float u_strength;
uniform float u_direction;
uniform float u_fov;

const float PI = 3.14159265;
const float DOUBLE_PI = 6.28318531;

void main() {
    vec2 distance = position - u_position;

    float distSq = dot(distance, distance);
    float adjustedDist = sqrt(distSq + u_size * u_size) - u_size + 1.0 - u_strength;
    float strength = 1.0 / adjustedDist;

    float direction = radians(u_direction);
    float fov = 0.5 * radians(u_fov);

    if (fov < PI) {
        float angle = atan(-distance.y, distance.x);
        float delta = abs(mod(angle + DOUBLE_PI, DOUBLE_PI) - direction);
        delta = min(delta, DOUBLE_PI - delta);
        if (delta > fov) {
            strength = 0.0;
        }
    }

    vec4 frag = texture2D(gm_BaseTexture, v_vTexcoord);
    gl_FragColor = colour * vec4(vec3(strength), 1.0) * frag;
}
