shader_type spatial;
render_mode skip_vertex_transform;

uniform sampler2D heightmap;
uniform float displacement;

void vertex() {
	vec4 heightmap_sample = texture(heightmap, VERTEX.xz);
	float heightmap_displacement = heightmap_sample.x;
    VERTEX = (MODELVIEW_MATRIX * vec4(VERTEX + NORMAL * heightmap_displacement * displacement, 1.0)).xyz;
	COLOR = vec4(vec3(heightmap_displacement), 1.0);
}

void fragment() {
	ALBEDO = COLOR.xyz;
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
