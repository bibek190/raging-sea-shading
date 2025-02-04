uniform vec3 uDepthColor;
uniform vec3 uSurfaceColor;
uniform float uColorOffset;
uniform float uColorMultiplier;

varying float vElevation;
varying vec3 vNormal;
varying vec3 vPosition;

#include ../includes/directionalLight.glsl;




void main()
{
    

    // Base Color
    float mixStrength = (vElevation + uColorOffset) * uColorMultiplier;
    mixStrength = smoothstep(0.0,1.0,mixStrength);
    vec3 color = mix(uDepthColor, uSurfaceColor, mixStrength);

 // Light
    vec3 viewDirection = normalize(vPosition - cameraPosition);
    vec3 normal = normalize(vNormal);

   
    vec3 light = vec3(0.0);
    light += directionalLight(
        vec3(1.0),            //lightColor
        1.0,                 //light intensity
        normal,              //normal
        vec3(-1.0,0.5,0.0),   // lightposition
        viewDirection,         // View Direction
        30.0                  // Specular power
    );
    color *=light;


// Final color
    gl_FragColor = vec4(normal, 1.0);
    #include <tonemapping_fragment>
    #include <colorspace_fragment>
}