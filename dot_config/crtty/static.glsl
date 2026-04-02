#version 330 core
in vec2 v_uv;
out vec4 o_color;
uniform sampler2D u_input;
uniform float u_time;

float rand(vec2 co) {
    return fract(sin(dot(co, vec2(12.9898, 78.233))) * 43758.5453);
}

void main() {
    vec4 term = texture(u_input, v_uv);
    float slow_time = floor(u_time * 12.0) / 12.0;
    float noise = rand(v_uv + slow_time);
    float static_strength = 0.18;
    o_color = vec4(term.rgb + vec3(noise * static_strength), 1.0);
}
