shader_type canvas_item;

uniform float outline_width : hint_range(0, 10) = 1.0;
uniform vec4 outline_color : source_color = vec4(1.0, 0.0, 0.0, 1.0);

void fragment() {
    vec4 original_color = texture(TEXTURE, UV);
    vec2 pixel_size = TEXTURE_PIXEL_SIZE;

    float alpha = 0.0;
    alpha += texture(TEXTURE, UV + vec2(0.0, -outline_width) * pixel_size).a;
    alpha += texture(TEXTURE, UV + vec2(0.0, outline_width) * pixel_size).a;
    alpha += texture(TEXTURE, UV + vec2(-outline_width, 0.0) * pixel_size).a;
    alpha += texture(TEXTURE, UV + vec2(outline_width, 0.0) * pixel_size).a;

    // Check if we're on an edge
    float edge = step(1.0, alpha) * (1.0 - original_color.a);

    // Set color to outline color on edges, transparent elsewhere
    COLOR = vec4(outline_color.rgb, edge * outline_color.a);
}