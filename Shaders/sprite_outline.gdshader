shader_type canvas_item;

uniform bool enable_outline = false;
uniform vec4 outline_color: source_color;
uniform float line_thickness : hint_range(0, 10) = 1.0;

void fragment() {
	vec4 texture_color = texture(TEXTURE, UV);
	if (enable_outline) {
		vec2 size = TEXTURE_PIXEL_SIZE * line_thickness;
		float outline = texture(TEXTURE, UV + vec2(-size.x, 0)).a;
		outline += texture(TEXTURE, UV + vec2(0, size.y)).a;
		outline += texture(TEXTURE, UV + vec2(size.x, 0)).a;
		outline += texture(TEXTURE, UV + vec2(0, -size.y)).a;
		outline += texture(TEXTURE, UV + vec2(-size.x, size.y)).a;
		outline += texture(TEXTURE, UV + vec2(size.x, size.y)).a;
		outline += texture(TEXTURE, UV + vec2(-size.x, -size.y)).a;
		outline += texture(TEXTURE, UV + vec2(size.x, -size.y)).a;
		outline = min(outline, 1.0);
	
		vec4 color = texture(TEXTURE, UV);
		COLOR = mix(color, outline_color, outline - color.a);
	} else {
		COLOR = texture_color;
	}
}
