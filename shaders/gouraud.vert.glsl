#version 400

uniform mat4 projectionMatrix;
uniform mat4 viewMatrix;
uniform mat4 modelMatrix;
uniform vec3 lightPosition;

layout(location=0) in vec3 position; //Need to define specific attribute locations
layout(location=1) in vec3 color;    //In order to switch the shaders
layout(location=2) in vec3 normal;   //Between Phong and Gouraud

out vec3 interpolatedColor; //We want to interpolate the color between the vertices
out vec3 interpolatedNormal;

void main(void) {
    mat4 modelViewMatrix = viewMatrix * modelMatrix;               //Used to transform points from local space to world space
    mat3 normalMatrix = transpose(inverse(mat3(modelViewMatrix))); //Used to transform normal vectors from world space to camera space

     gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);

    /**
     * --Task--
     *
     * 1. Calculate the vertexPosition in the camera space.
     * 2. Calculate the correct normal in the camera space.
     * 3. Find the direction towards the viewer, normalize.
     * 4. Find the direction towards the light source, normalize.
     *
     * Implement Phong's lighting / reflection model:
     * - Ambient term you can just add
     * - Use the values calculated before for the diffuse/Lambertian term
     * - For Phong's specular, find the reflection of the light ray from the point
     *   See: https://www.opengl.org/sdk/docs/man/html/reflect.xhtml
     *   Use a value like 200 for the shininess
     */

     // 1. Calculate the vertexPosition in the camera space.

     vec3 vertexPosition = (modelViewMatrix *  vec4(position, 1.0)).xyz;

     //2. Calculate the correct normal in the camera space.

     vec3 n = normalize(normalMatrix * normal);

     // 3. Find the direction towards the viewer, normalize.

     vec3 v = normalize(-vertexPosition);

     // 4. Find the direction towards the light source, normalize.

     vec3 l =normalize(lightPosition - vertexPosition);

     vec3 r = reflect(-l,n);


     interpolatedColor = color *( 0.3 + max(0.0,dot(n,l))+ pow(max(0.0,dot(v,r)), 200.0));

}
