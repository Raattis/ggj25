shader_type spatial;
render_mode skip_vertex_transform;

uniform sampler2D heightmap;
uniform float displacement;
uniform sampler2D albedo;

void vertex() {
	vec4 heightmap_sample = texture(heightmap, VERTEX.xz);
	float heightmap_displacement = heightmap_sample.x;
    VERTEX = (MODELVIEW_MATRIX * vec4(VERTEX + NORMAL * heightmap_displacement * displacement, 1.0)).xyz;
	COLOR = vec4(vec3(heightmap_displacement), 1.0);
}

void fragment() {
	ALBEDO = COLOR.xyz * texture(albedo, UV).xyz;

	float caustic = texture(heightmap, UV * 5. + sin(TIME + cos((UV.x * 2.2 + UV.y * 1.4) * 8. + UV.y * 3.9))).x;
	caustic = caustic * caustic * 0.2;
	EMISSION = vec3(caustic);
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
// Called for every vertex the material is visible on.