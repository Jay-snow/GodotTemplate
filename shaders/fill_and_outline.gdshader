shader_type canvas_item;

uniform float outline_width : hint_range(0, 10) = 1.0;
uniform vec4 outline_color : source_color = vec4(1.0, 1.0, 1.0, 1.0);
uniform vec4 fill_color : source_color = vec4(1.0, 0.0, 0.0, 1.0);

void fragment() {
    vec4 original_color = texture(TEXTURE, UV);
    vec2 pixel_size = TEXTURE_PIXEL_SIZE;

    float alpha = original_color.a;
    alpha += texture(TEXTURE, UV + vec2(0.0, -outline_width) * pixel_size).a;
    alpha += texture(TEXTURE, UV + vec2(0.0, outline_width) * pixel_size).a;
    alpha += texture(TEXTURE, UV + vec2(-outline_width, 0.0) * pixel_size).a;
    alpha += texture(TEXTURE, UV + vec2(outline_width, 0.0) * pixel_size).a;

    vec4 outline = mix(vec4(0.0), outline_color, step(1.0, alpha) - original_color.a);
    vec4 fill = mix(vec4(0.0), fill_color, original_color.a);

    COLOR = mix(fill, outline, outline.a);
}