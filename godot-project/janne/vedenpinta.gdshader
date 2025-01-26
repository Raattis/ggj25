shader_type spatial;
render_mode skip_vertex_transform;


uniform float displacement;

void vertex() {
	vec3 vert_original = VERTEX;
	vec3 normal_original = NORMAL;

	vec3 phase = vec3(
		vert_original.x * 1.3 * (sin(TIME / 6. + sin(TIME * 0.3 + vert_original.z * 0.03 + TIME) + cos(TIME / 8. + vert_original.z / 8.)) / 8.) + TIME,
		0.,
		vert_original.z * 1.2 * (sin(TIME / 5. + PI + cos(TIME / 7. + vert_original.x / (TIME * 1.2)) + sin(TIME * 2.8 + vert_original.x / 5.)) / 5.) + TIME * 3.5
	);
	float asdf = sin(phase.x) + cos(phase.z);

    VERTEX = (MODELVIEW_MATRIX * vec4(vert_original + normal_original * asdf * displacement, 1.0)).xyz;
	NORMAL = vec3(cos(phase.x), 1., sin(phase.z));
	COLOR = vec4(vec3(1. - asdf / 2.) * vec3(0.4, 0.4, 1.0), 1.0);
}

void fragment() {
	// Called for every pixel the material is visible on.
	ALBEDO = COLOR.xyz;
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
