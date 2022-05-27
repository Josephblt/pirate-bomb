shader_type canvas_item;

uniform vec4 line_color : hint_color = vec4(1);
uniform float inline_thickness : hint_range(0, 3) = 0.0;
uniform float outline_thickness : hint_range(0, 3) = 1.0;

void fragment() {
	ivec2 tex_size = textureSize(TEXTURE, 0);
	vec2 pixel_size = vec2(1.0 / float(tex_size.x), 1.0 / float(tex_size.y));
	
	vec2 inline_size = pixel_size * inline_thickness;
	vec2 outline_size = pixel_size * (inline_thickness + outline_thickness);
	
	float inline = texture(TEXTURE, UV + vec2(-inline_size.x, 0)).a;
	inline += texture(TEXTURE, UV + vec2(0, inline_size.y)).a;
	inline += texture(TEXTURE, UV + vec2(inline_size.x, 0)).a;
	inline += texture(TEXTURE, UV + vec2(0, -inline_size.y)).a;
	inline += texture(TEXTURE, UV + vec2(-inline_size.x, inline_size.y)).a;
	inline += texture(TEXTURE, UV + vec2(inline_size.x, inline_size.y)).a;
	inline += texture(TEXTURE, UV + vec2(-inline_size.x, -inline_size.y)).a;
	inline += texture(TEXTURE, UV + vec2(inline_size.x, -inline_size.y)).a;
	inline = min(inline, 1.0);
	
	float outline = texture(TEXTURE, UV + vec2(-outline_size.x, 0)).a;
	outline += texture(TEXTURE, UV + vec2(0, outline_size.y)).a;
	outline += texture(TEXTURE, UV + vec2(outline_size.x, 0)).a;
	outline += texture(TEXTURE, UV + vec2(0, -outline_size.y)).a;
	outline += texture(TEXTURE, UV + vec2(-outline_size.x, outline_size.y)).a;
	outline += texture(TEXTURE, UV + vec2(outline_size.x, outline_size.y)).a;
	outline += texture(TEXTURE, UV + vec2(-outline_size.x, -outline_size.y)).a;
	outline += texture(TEXTURE, UV + vec2(outline_size.x, -outline_size.y)).a;
	outline = min(outline, 1.0);
	
	vec4 tranparent = vec4(0.0);
	vec4 color = texture(TEXTURE, UV);
	
	if (inline >= outline) {
		COLOR = mix(color, tranparent, inline - color.a);
	} else {
		COLOR = mix(color, line_color, outline - color.a);
	}
}