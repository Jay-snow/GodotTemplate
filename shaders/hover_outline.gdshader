shader_type canvas_item;

uniform float outline_width : hint_range(0, 10) = 1.0;
uniform vec4 outline_color : source_color = vec4(1.0, 0.0, 0.0, 1.0);
uniform bool hover_active = false;

void fragment() {
    vec4 original_color = texture(TEXTURE, UV);
    vec4 final_color = original_color;
    
    if (hover_active) {
        vec2 pixel_size = TEXTURE_PIXEL_SIZE;
        float alpha = original_color.a;
        alpha += texture(TEXTURE, UV + vec2(0.0, -outline_width) * pixel_size).a;
        alpha += texture(TEXTURE, UV + vec2(0.0, outline_width) * pixel_size).a;
        alpha += texture(TEXTURE, UV + vec2(-outline_width, 0.0) * pixel_size).a;
        alpha += texture(TEXTURE, UV + vec2(outline_width, 0.0) * pixel_size).a;
        final_color = mix(original_color, outline_color, step(1.0, alpha) - original_color.a);
    }
    
    COLOR = final_color;
}