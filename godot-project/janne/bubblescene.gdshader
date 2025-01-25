shader_type canvas_item;

const int BUBBLES_COUNT = 512;
const float PI_HALF = PI / 2.0;

uniform sampler2D tex_bg : repeat_enable;
uniform float aspect_ratio;
uniform float bubbles_active_count;
uniform vec2 bubbles_pos[BUBBLES_COUNT];
uniform float bubbles_radius[BUBBLES_COUNT];

void vertex() {
	// Called for every vertex the material is visible on.
}

float sdCircle( vec2 p, float r ) {
	return length(p) - r;
}

vec3 normal_circle(vec2 p, float r) {
	return //normalize(
			vec3(
				sin(clamp(p.x, -1., 1.) / r * PI_HALF),
				sin(clamp(p.y, -1., 1.) / r * PI_HALF),
				cos(length(p) / r * PI_HALF)
		//)
	);
}

void fragment() {
	// Called for every pixel the material is visible on.
	vec2 pos = vec2(aspect_ratio, 1.0) * (UV - vec2(0.5));
	float dist = 99999999.0;
	vec3 normal = vec3(1,1,1);
	float metasum = 0.0;
	for (int i = 0; i < BUBBLES_COUNT; ++i) {
		float fi = float(i);
		vec2 p = pos - bubbles_pos[i];
		float r = bubbles_radius[i];

		float sd = sdCircle(p, r);
		if (sd < dist) {
			normal = normal_circle(p, r);
			dist = sd;
		}

		metasum += 1.0 - smoothstep(0.0, r * 1.8, length(p));
	}

	if (metasum < 0.1) {
		COLOR = texture(tex_bg, pos);
	} else {
		float light = -dot(normalize(vec3(pos, 0.0)), normal);
		vec4 refracted_sample = texture(tex_bg, pos - normal.xy * 0.015);
		//COLOR = vec4(vec3(metasum, 0.6, 0.5) * light, 1.0);
		COLOR = vec4(mix(vec3(0.2, 1., 1.) * light, refracted_sample.xyz, 1. - normal.z * 0.7), 1.0);
		//COLOR = vec4(normal, 1.0);
	}
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
