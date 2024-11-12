shader_type canvas_item;

uniform vec4 fill_color : source_color = vec4(1.0, 0.0, 0.0, 1.0);

void fragment() {
    vec4 original_color = texture(TEXTURE, UV);

    // Use the original alpha, but replace the color with the fill color
    COLOR = vec4(fill_color.rgb, original_color.a);
}