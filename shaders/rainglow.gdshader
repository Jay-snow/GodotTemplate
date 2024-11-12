shader_type canvas_item;

uniform float outline_width : hint_range(0, 10) = 1.0;
uniform vec4 fill_color : source_color = vec4(1.0, 0.0, 0.0, 1.0);
uniform float cycle_speed : hint_range(0.1, 5.0) = 1.0;
uniform float glow_intensity : hint_range(0.1, 2.0) = 1.5;

vec3 hsv2rgb(vec3 c) {
    vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
    vec3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
    return c.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
}

void fragment() {
    vec4 original_color = texture(TEXTURE, UV);
    vec2 pixel_size = TEXTURE_PIXEL_SIZE;
    
    float alpha = original_color.a;
    alpha += texture(TEXTURE, UV + vec2(0.0, -outline_width) * pixel_size).a;
    alpha += texture(TEXTURE, UV + vec2(0.0, outline_width) * pixel_size).a;
    alpha += texture(TEXTURE, UV + vec2(-outline_width, 0.0) * pixel_size).a;
    alpha += texture(TEXTURE, UV + vec2(outline_width, 0.0) * pixel_size).a;
    
    // Generate rainbow color
    float hue = fract(TIME * cycle_speed * 0.1);
    vec3 rainbow_color = hsv2rgb(vec3(hue, 1.0, 1.0));
    
    // Add neon glow effect
    vec3 glow_color = rainbow_color * glow_intensity;
    vec4 outline_color = vec4(glow_color, 1.0);
    
    vec4 outline = mix(vec4(0.0), outline_color, step(1.0, alpha) - original_color.a);
    vec4 fill = mix(vec4(0.0), fill_color, original_color.a);
    
    COLOR = mix(fill, outline, outline.a);
}