#version 400

// Attributes passed from the geometry shader
in vec4 frag_color;
in vec2 tex_coord;
in float newOffset;
uniform float timer;

// Uniform (global) buffer
uniform sampler2D tex_samp;

// Simulation parameters (constants)
uniform vec3 object_color = vec3(0.8, 0.4, 0.03);
uniform vec3 end_color = vec3(1.0, 1.0, 1.0);

//a*(1-t) +(b*t)



void main (void)
{
    // Get pixel from texture
    vec4 outval = texture(tex_samp, tex_coord);
    // Adjust specified object color according to the grayscale texture value
	vec3 s = object_color*(1-mod(timer+newOffset, 4)/4.0) + end_color*mod(timer+newOffset,4)/4.0;
    outval = vec4(outval.r*s.r, outval.g*s.g, outval.b*s.b, sqrt(sqrt(outval.r))*frag_color.a);
    // Set output fragment color
    gl_FragColor = outval;
}
