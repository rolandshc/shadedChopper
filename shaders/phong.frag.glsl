#version 400

uniform vec3 lightPosition;

in vec3 interpolatedNormal;
in vec3 interpolatedPosition;
in vec3 interpolatedColor;

// This is the output variable of the fragment shader
// We configure this to be "output 0" for our fragment shader
// in the main program using glBindFragDataLocation
out vec4 fragColor;

void main(void) {

    /**
     * --Task--
     * Do the same Phong's lighting/reflection model calculation that you did in Gouraud vertex shader before.
     */
      // 3. Find the direction towards the viewer, normalize.

     vec3 n = normalize(interpolatedNormal);

     vec3 v = normalize(-interpolatedPosition);

     // 4. Find the direction towards the light source, normalize.

     vec3 l = normalize(lightPosition - interpolatedPosition);

     vec3 r = reflect(-l,n);


    vec3 color = interpolatedColor *( 0.3 + max(0.0,dot(n,l))+ pow(max(0.0,dot(v,r)), 200.0));; //Assign your calculation here instead
    //vec3 color = interpolatedColor;

    fragColor = vec4(color, 1.0);



}
