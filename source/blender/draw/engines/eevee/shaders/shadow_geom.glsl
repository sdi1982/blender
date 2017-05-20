
layout(std140) uniform shadow_render_block {
	mat4 ShadowMatrix[6];
	vec4 lampPosition;
	int layer;
};

layout(triangles) in;
layout(triangle_strip, max_vertices=3) out;

in vec4 vPos[];
in float lDist[];
flat in int face[];

out float linearDistance;

void main() {
	int f = face[0];
	gl_Layer = f;

	for (int v = 0; v < 3; ++v) {
		gl_Position = ShadowMatrix[f] * vPos[v];
		linearDistance = lDist[v];
		EmitVertex();
	}

	EndPrimitive();
}