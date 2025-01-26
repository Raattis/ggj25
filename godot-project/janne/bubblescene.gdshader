shader_type canvas_item;

const int BUBBLES_COUNT = 512;
const float PI_HALF = PI / 2.0;

uniform sampler2D tex_bg; //: repeat_enable;
uniform vec3 bubble_color : source_color;
uniform float aspect_ratio;
uniform float bubbles_active_count;
uniform vec2 bubbles_pos[BUBBLES_COUNT];
uniform float bubbles_radius[BUBBLES_COUNT];
uniform float bubbles_extra[BUBBLES_COUNT];
uniform vec3 light_pos;

void vertex() {
	// Called for every vertex the material is visible on.
}

float sdCircle( vec2 p, float r ) {
	return length(p) - r;
}

vec3 normal_circle(vec2 p, float r) {
	return normalize(
			vec3(
				sin(clamp(p.x, -1., 1.) / r * PI_HALF),
				sin(clamp(p.y, -1., 1.) / r * PI_HALF),
				cos(length(p) / r * PI_HALF)
		)
	);
}

void fragment() {
	// Called for every pixel the material is visible on.
	vec2 pos = vec2(aspect_ratio, 1.0) * (UV - vec2(0.5));
	float dist = 99999999.0;
	vec3 normal = vec3(1,1,1);
	float metasum = 0.0;
	float extra = 0.0;
	for (int i = 0; i < BUBBLES_COUNT; ++i) {
		float fi = float(i);
		vec2 p = pos - bubbles_pos[i];
		float r = bubbles_radius[i];

		float sd = sdCircle(p, r);
		if (sd < dist) {
			normal = normal_circle(p, r);
			extra = bubbles_extra[i];
			dist = sd;
		}

		metasum += 1.0 - smoothstep(0.0, r * 1.3, length(p));
	}

	vec2 UV_rippled = UV + sin(TIME + UV.y * 16.) * 0.01 + cos(TIME + UV.x * 14.) * 0.01;

	if (metasum < 0.3) {
		//COLOR = texture(tex_bg, pos);
		COLOR = texture(tex_bg, UV_rippled);
	} else {
		float light = -dot(normalize(vec3(pos, -.25)), normal) * 1.4;
		vec4 refracted_sample = texture(
			tex_bg,
			UV_rippled - normal.xy * (log(normal.z * 1.13)) * 0.12 // Heretic math
		);
		COLOR = vec4(
			mix(
				(bubble_color + extra) * light,
				refracted_sample.xyz,
				1. - normal.z * 0.4
			),
			1.0
		);
	}
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
