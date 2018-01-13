---
title: "TDA362 CG: exam notes"
categories:
  - TDA362 
  - Exam
tags:
  - Exam
  - OpenGL
  - Notes
  - Computer Graphics 
gallery:
  - url: /assets/sets/gdb-remote-clion/toolchains.PNG
    image_path: /assets/files/gdb-remote-clion/toolchains.PNG
    alt: "toolchains config"
    title: "Toolchains config"

---


# Pipeline

## 1. Real time graphics *pipeline* consists of three parts:
- application stage
- geometry stage
- resterization stage

## 2. Examples of what is done in them:
- application stage: 
-- VFC, 
-- animation;
- geometry stage: 
-- transformation + per vertex shading (lighting)
- resterization stage: 
-- rasterization, 
-- texturing, 
-- interpolation of per-vertex values from vertex shader, 
-- z-test,
-- fragment shading

## 3. How to determine if each part step is performance bottle-neck for the rendering:
- application stage:
-- swap glVertex to glColor 
- gometry stage:
-- remove all light sources
- rasterization stage:
- change window size

## 4. Acumulation buffer usage examples (ie. examples of effect using accumulation buffer):
- motion blur: blend together several frames
- depth-of-field: 
-- blend images from slightly modifies camera positions
- soft shadows: 
-- render hard shadows from several light sources and blend the shadow contributions

## 5. What do vertex shader, purpose?
- computes vertex positions and projects from 3D to 2D
- precomputes values, eg. per-vertex lighting

## 6. Explain what z-buffer is used for and how it works:
- use z-buffer (depth) to store the depth of closest object at each pixel found so far. 
- as we render each polygon, compare the depth of each pixel to depth in z buffer
- if less, place shade of pixel in color buffer and update z buffer

## 7. The geometry stage: list all spaces that a 3D vertex (typically) will be transformed throught on its way from model space to screen space:
- 0. model space/object coordinates
- 1. world space
- 2. camera/view space/eye coordinates
- 3. projection space/homogeneous coordinates/clip space/unit cude
- 4. normalized device coordinates/after perspective division/homogenization step
- 5. screen space (window coordinates)

## 8. Pipeline: Explain the rendering pipeline and corresponding hardware and draw figure:
- see lecture 1, or full-time wrapup slide 5
- 0.5p for each of:
-- application stage:
-- geometry stage with vertex + geometry shader
-- rasterization stage with pixel shader (+ merge)

## 9. Pipeline: Explain screen tearing
- see lecture 1
- solved by double buffering and syncing buffer swapping with the vblank


# Transforms

## 10. What is rigid body transformation?
- rotations and translations
- no change in size or shape

## 11. Assume u are creating a system where u have a rotation matrix R, scaling matrix S, and a translation matrix T, to define a objects transformation. For a vertex v of the object, show how you compute the transformated vertex v'. (Use the recommended order of the matrices, as one line-answer v'=... is enough.)
- v' = (TRS)v

## 12. State a simple 4x4-matrix M that performs a projection. Also explain which plane your matrix projects onto and what type of projection it is.
- plane z=0: orthographic (parallel) projection
- M = [[1,0,0,0],[0,1,0,0],[0,0,0,0],[0,0,0,0]]

## 13. Vectors and Transforms: What is the ModelViewProjectionMatrix? What does it do?
- the matrix that transforms from modelspace (via worldspace) into viewspace
- and finally into unit- or projection space (or normalized device coordinates or 
   homogeneous coordinates)

## 14. Vectors and Transforms: What is the matrix to transform the normals, if matrix M is used to transform the positon?
- (M^(-1))^T

## 15. Vectors and Transforms: Quaternions: Describe how to perform a rotation of a point  or a vector p, by O[deg.], around an axis u using quartenions:
- q = (sinO*u, cosO), p_rot = qpq^(-1)


## 16. Which two classes of transformations are part of Rigid Body transformations:
- translation
- rotation

## 17. Compute the objects model-to-world matrix
 
- world space: [x,y,z]
- model space: [c,b,a]
            
 y            b
 w  x      a  o  
z              c

- M_model-to-world = [[c_x, b_x, a_x, o_x],[c_y, b_y, a_y, o_y],[c_z,b_z,a_z,o_z],[0,0,0,1]]

## 18. Create 4x4-matrix that performs a uniform scaling, d, in x-, y- and z, by utilizing the homogenization step. You must show how the homogenization step leads to scaling.

M = [[1,0,0,0],[0,1,0,0],[0,0,1,0],[0,0,0,1],[0,0,0,1/d]]
p = (x,y,z,1)
Mp = (x,y,z,1/d)

Homogenization: p' = ((x,y,z,1/d)/(1/d)) = (xd,yd,zd,1)

# Shading, antialiasing and texturing

## 19. What is the difference between supersampling and multisampling?
- multisampling only runs the fragment shader once per fragmen (not once per sample-inside-each-pixel)
- ie. multisampling shares computations, eg. executes fragment shader for only one sample but takes several depth samples

## 20. Draw the Quincunx pattern and state weights per sample
- 1 sample in each of the four pixel corners (with weight = 1/8) and 1 sample in the pixel center (with weight = 0.5)

## 21. Assume that your graphics hardware support the tent filter and sinc filter. You want maximum quality when enlarging your textures. Which filter would u choose? Motivate for points.
- The sinc-filter is ideal
- It uses all texels for each sample and cuts too high frequencies

## 22. Which types of filters are common in real-time computer graphics for minification of 2d textures? 
- nearest (box)
- bilinear filtering (tent) with and without mipmapping
- trilinear filtering with mipmapping
- anisotropic filtering

## 23. Which types of filters are common in real-time computer graphics for magnification of 2d textures?
- nearest (box filter)
- (bi)linear (tent filter)
- (mipmapping is wrong)

## 24. What is mipmap hierarchy?
- A prefiltered hierarchy of halved (in both x- and y-) resolutions where each texel is the average of the 2x2 texels at the corresponding position of the lower level

## 25. How do you prevent fully transparent part of for instance a billboard to update the z-buffer when the billboard is drawn to the frame buffer (with standard z-test and updating enabled)?
- you kill the fragments in the fragment shader if alpha is zero

## 26. How often are the vertex shader, geometry shader and fragment shader executed when one triangle is sent as input for drawing by the hardware? Explain.
- vertex shader: Three
- geometry shader: once
- fragment shader: once per non-occluded fragment (unless supersampling schemes are used, which executes the fragment shader per fragment sample)

## 27. How much more memory does a mipmap hierarchy require compared to just using the base texture?
- 1/3 or ~33%

## 28. Which is fastest to compute for a GPU - Phong shading or Gouraud shading? Motivate!
- Phong shading is more expensive, since full lighting is computed per pixel instead of just per vertex and interpolated for each pixel
- if triangles are on average smaller than a pixel, then vice versa could be true

# Global Illumination and visual appearance

## 29. Which are the 3 components in the real-time illumination model? It is sufficient to just state the names. (Emission is often included as the fourth component.)
- ambient
- diffuse
- specular

## 30. Compute the reflection ray, r, given n and l, where n is the surface normal and l is the incoming ray with direction towards the surface.
- r = l - 2*(norm(n).dot.l)norm(n), n - needs to be normalized, l - not necessarily

## 31. Is alpha channel in the color buffer required for correct rendering of transparent objects? Motivate your answer.
- No, you state the transparency using the alpha value of the color of the object.
- The alpha value, a, decides the interpolation factor between:
-- the source color c (the objects color)
-- and the destination color d (the color of the pixel in the frame buffer)
- Eg. Color = ac + (1 - a)d
- The alpha channel in the color buffer does not need to be involved
- For correct blending of the transparency, draw the transparent objects in back-to-front order

## 32. Is the rendering of transparent objects order dependant? Motivate.
- Yes, the blending operator is order dependent (unless you have a pure additive or multiplicative blending - but both are used for classic transparency)
 
## What is a BRDF? (You can answer by stating what the abbreviation BRDF stands for and assuming f() is a BRDF and describe its input parameters and what it returns)
- Bidirectional Reflection Distribution Function
- The function f(omega_i, omega_j) returns how much of the radiance from the incoming direction omega_i that is reflected in the outgoing direction omega_o.

## What is a BRDF? (You can answer by stating what the abreviation ”BRDF” stands for and assuming f() is a BRDF and describe its input parameters and what it returns.)
- Bidirectional Reflection Distribution Function. The function f(ωi, ωo) returns how much of the radiance from the incoming direction ωi that is reflected in the outgoing direction ωo. 0.5 points for each correct answer of: BRDF abreviation, ωi, ωo and return value.

## Two separate photon maps are constructed during photon mapping. Which and why?
Answer: Caustics map and Global map (slowly varying illumination). The reason is that for correctness, the global map uses an even distribution of shot photons from the light source. For efficiency reasons, this is violated for the caustics map, when instead photons are fired in the directions of specular objects to capture the caustics effects. Physical correctness of the light intensity is typically much less visible in the latter case.

## Why do we want to use Final Gather when using photon mapping?
Answer: Because using the global photon map for primary rays will result in poor low-pass filtering. I.e., give a blotchy (noisy) looking result. A blotchy result in the second recursion level/for secondary rays is less severe, since indirect illumination is a low-frequency phenomenon.)

## There are several other algorithms for global illumination than just photon mapping. Name and explain at least two of them.
Answer: Path Tracing, Bidirectional path tracing, Monte Carlo Ray Tracing, Metropolis Light Transport, (Radiosity). See lecture slides for explanations.

##  Describe the algorithm for photon mapping.
Answer: Caustics map, Global Map (for indirect lighting), shoot photons from light source, store at diffuse surfaces. Ray trace from eye and use the maps for their respective contribution. Grow spheres to estimate intensity. Russian Roulette to decide if semi-diffuse materials are considered specular or diffuse.

## Describe path tracing and explain what the benefit is (compared to standard Monte Carlo Ray Tracing).
Answer: Randomly shoot one path per ray – no exponential ray tree. Reason: to
have equally many of the important primary rays as rays at the end of the paths.

## This is ”the rendering equation”. Explain this equation by describing all the components of the equation.

L_o = L_e = int_{omega} f_r(x,omega,omega')L_i(x,omega')(omega'.dot.n)domega'  
fr is the BRDF, w’ is incoming direction, n is normal at point x, is hemisphere ”around” x and n, Li is incoming radiance, x is position on surface, w is outgoing direction vector.
Lo(x,w)=Le(x, w)+Lr(x, w)
I.e.,: outgoing radiance =emitted + reflected radiance. The integral is the reflected
radiance in direction w.

# Collision detection, spatial data structures and speedup techniques

## Describe the z-fail-algorithm.
Answer: Create shadow quads from the silhouettes of the shadow caster (as seen from light source). Cap shadow volume with the shadow caster’s front facing polygons (as seen from light source). Also cap at far end (often done by pushing the back-facing triangles towards infinity). Render ambient contribution to color buffer. Set depth test to GL_GREATER and turn off updating of z-buffer, Render backfacing (as seen from camera) shadow volume polygons to stencil buffer, incrementing stencil values. Render front facing shadow volume polygons to stencil buffer, decrementing stencil values. Render diff+spec lighting contribution to color buffer where stecil buffer = 0.

## Write pseudo code for collision detection between 2 bounding volume hierarchies.

## 33. OpenGL: Assume that you have enabled backface culling. How does the hardware determine if a triangle will be backfacing of frontfacing?(Drawing and image can be usefull)
- The vertices v0,v1,v2 are projected onto the screen and if they appear in anticlockwise order (right hand side rule):
-- the triangle is (by default) assumed to be front facing. 
- Otherwise, backfacing. (The order could be reversed by specifying CW-order.)


## 34. To draw transparent objects using for instance OpenGL, you typically divide the triangles in two groups: the transparent ones and the opaque ones.
- Which of these groups needs to be sorted: the transparent triangles
- Why: for correct blending
- In which order: back to front

## 35. Normally you would want to draw all geometry that is in front of the camera. So why is a near and far plane used for the view frustrum?
- Near plane is used to avoid a degenerate projection plane. 
- Far plane can be used to get better z-precision in the buffer.

## 38. Spatial datastructures: Draw a simple scene and visually divide it into:
### - an Axis Aligned Bounding Box hierarchy,
### - an Octree or Quadtree
### - an Axis Aligned Binary Space Partitioning Tree,
### - a grid,
### - and a recursive or hierarchical grid
### You can do all your drawings  in 2D for simplicity and you may use different hierarchies. (You dont need to show the corresponding tree structures). The differences in the spatial divisions between the five types of data structures should be clear for your examples for any score.

## 39. Collision detection: Why the sweep-and-prune algorithm is efficient in course pruning non-colliding objects?
- Uses bubble-sort (or insertion sort)
- Which have expected resorting runtime of already almost sorted input
- In O(1) instead of O(nlogn) where n is number of elements
### Flip bits of matrices could also give 1p (for max of 2p)
### See sweep and prune
-- Collision detection for x,y,z-axes, sort start and end of AABBs, active interval list, update sort using bubble sort, 
  flip bits of matrices

## 41. Write pseudo-code for hierarchical view frustrum culling
### ...

## 42. Describe a top-down approach to build an Axis Aligned BSP-tree for a scene.
- Create minimal AABB around the whole scene. Split along an axis. Recursively split the 2 parts alongs a new axis. Terminate if empty node:
-- triangles < threshold 
-- or level >= max recursion depth
-- (Axis sligned: x-,y-,z-axis are split planes.)

## 43. Shortly explain Occlusion Culling, Detail Culling, View Frustrum Culling, Portal Culling, Backface Culling and Levels of Detail:
### ...

## 44. Whate is difference between a kD-tree and Axis aligned BSP-tree? 
- Axis aligned BSP-tree with fixed split plane order eg: x-, y-, z-, y-, y-, z...

## 45. Describe the Separating Axis Theorem

## 46. Give the names of six of the most common spatial data structures within computer graphics, except the three menitioned above.
- Axis Aligned BSP tree,
- kd-tree, BVH
- polygon aligned BSP tree,
- grid
- octree
- quadtree
- hierarchical grids
- recursive grids
- Bounding Volume Hierarchies such as Sphere hierarchy/AABB/OBB/(kDOP)

# Ray Tracing and Shadows

## What is a shadow cache? Explain what it is good for and how it works.
Answer: pointer to previous intersected triangle (primitive) by the shadow rays. 
Null, if last shadow ray had no intersection. Reason: speedup, potentially avoiding
tree traversal.

## What is shadow cache? Explain what it is good for and how it works.
- Pointer to previous intersected triangle (primitive) by the shadow rays. 
- Null if last shadow ray had no intersection.
- Reason: speedup, potentially avoiding tree traversal.

## 40. Describe the advantage and disadvantage of using ray tracing for collision detection compared to using bounding volume hierarchies
- Advantage: ray tracing typically a lot faster
- Disadvantage: cannot do exact collision detection (only sampling based)


## Describe the structure of a typical ray tracer by using the functions main(), trace(), shade(), and findClosestIntersection(). Ie., describe what these functions do and which functions they call (who calls who).
- main() calls trace() for each pixel
- trace() returns the color of the closest intersected points, calls findClosesIntersection() and then calls shade() for the point
- shade() computes colors + calls trace recursively for reflection/refraction ray

## Describe what makes Path Tracing efficient
- Spawning many rays at each bounce would result in ray tree
- Most work is spent on the many rays at the bottom of the tree which have least impact on the pixel
- Path tracing only follows one randomly chosen spawned ray per bounce resulting in a ray path
- Instead many paths are traced per pixel
- The advantage is that and equal amount of rays is traced at each level of bounces
- Better balance between spent work and importance

## Describe the advantages and disadvantages of shadow maps vs shadow volumes. You should mention at least a total of four important bullets.
- SM pros: 
-- any resterizable geometry, constant cost per rasterized fragment from camers view (basically just a texture lookup), fast
- SM cons:
-- jagged shadows / resolution problems, biasing
- SV pros: 
-- sharp shadows
- SV cons:
-- 3 or 4 rendering passes (and thus ofter slower than shadow maps)
-- lots of polygons and fill

## Describe the advantages and disadvantages of shadow maps vs shadow volumes. You should mention at least a total of four important bullets (1p per unique bullet).
Answer:
- SM - Pros: any rasterizable geometry, constant cost per rasterized fragment from the camera’s view (basically just a texture lookup), fast, Cons: jagged shadows / resolution problems, biasing.
SV - Pros: sharp shadows. Cons: 3 or 4 rendering passes (and thus often slower than shadow maps), lots of polygons and fill.

## Describe the shadow map algorithm
-- 1. Render a shadow (depth) map from the light source.
-- 2. Render image from the eye. For each generated pixel, transform/warp the x,y,z coordinate to light space and compare the depth with the stored depth value in the shadow map (at the pixel position (x,y).
-- If greater → point is in shadow.
-- Else → point is not in shadow.
- (Bias/offset is necessary due to disretization and precision problems.)

## Describe how to compute soft shadows in ray tracing.
Answer: e.g., shoot several shadow rays to different light samples. It is also OK
to answer for path tracing – choosing one random light sample.

## Draw a common recursive pattern for adaptive super-sampling (it is appropriate to draw the one taught in this course). Provide start samples and samples after one recursion step.
Answer: see ray tracing lecture slides

## Explain skippointer tree. What is the advantage?

## Explain ”shadow cache”

## What is a shadow cache? Explain what it is good for and how it works.
Answer: pointer to previous intersected triangle (primitive) by the shadow rays.
Null, if last shadow ray had no intersection. Reason: speedup, potentially avoiding
tree traversal.

## Describe how to compute soft shadows in ray tracing.
Answer: e.g., shoot several shadow rays to different light samples. It is also OK
to answer for path tracing – choosing one random light sample.

## Describe the advantages and disadvantages of shadow maps vs shadow volumes. You should mention at least a total of four important bullets (1p per unique bullet).
Answer:
SM - Pros: any rasterizable geometry, constant cost per rasterized fragment
from the camera’s view (basically just a texture lookup), fast, Cons: jagged
shadows / resolution problems, biasing.
SV - Pros: sharp shadows. Cons: 3 or 4 rendering passes (and thus often
slower than shadow maps), lots of polygons and fill.


# Aliasing 

## 41. Draw RGSS, FlipQuad, Quincunx and 8 rooks. State the weights for each sample point:
### see lecture slides

## 42. Explain jittering, what is the advantage compared to other sampling schemes?
### see...

## 43. Explain how tri-linear filtering works, draw picture
### see...

## 44. Explain how anisotropic filtering works
### see...

# Intersection tests

## 36. Describe a method for a ray-polygon intersection test. You may assume that the polygon is convex.
- See lecture intersections: convert to a point-in-2D-polygon test and use the crossing number algorithm / even-odd rule.

## 37. Describe a test which determines whether or not a sphere and a plane intersect.
- Insert the sphere center into the plane equation. 
- If the result is smaller that the radius, there is an intersection:
- Ie. n.dot.c + d <= r


## 45. Compute analytically, the intersection between a ray and a sphere
- write down the equations for both objects and find the common colution(s):
-- ray : p = o + td
-- sphere : |vec(p)-vec(c)| = r;
-- square: (vec(p) - vec(c)).dot.(vec(p)-vec(c)) = r^2
- insert ray into sphere and solve for t

## 46. Describe a method/algorithm for computing the intersection between a ray and a triangle (both defined in 3D).
- compute the ray intersection point with the triangle plane:
-- similar to above but with a plane instead of a sphere)
- then do a point-in-polygon test (in 2D) according to one of the following
-- 1) sum of angles = 360[deg.] if point is inside, otherwise = 0
-- 2) the crossing test (see slides RTR-book), compute the number of crossings between a horizontal line and the edges of the polygon:
--- odd number = inside
--- even number = outside
-- 3) use a point-triangle test: 
--- check the point against all triangles formed by one vertex and each of the other vertices:
---- if inside odd number, point is inside polygon, otherwise outside,
--- (see bonus OH page: 269), 
--- requires that you state how to solve point-triangle intersection test

## Describe two methods/algorithms to determine if a 2D point is inside a 2D polygon (i.e., point in polygon test). Convex polygon can be assumed.
Answer: (Your answers of course have to be more detailed than below and also explain how this is calculated):
1) angle sum = 360 instead of 0.
2)”The Crossings Test” (s 583). Count crossings between (horizontal) line and the polygon edges. Odd number = inside, even number = outside.
3) Check if point is inside the triangles formed by one vertex and the other vertices. If inside odd number -> point is inside polygon, else outside. (See Bondesson’s OH-slides on the course home page, p: 227).
4) Split into triangles and check them (naive way but OK)
5) (Use Plücker coordinates - but for 2D.)
6) Test point against edges with 2D cross product.

## Why does not (classic) environment mapping (e.g., the ones taught in the course)
work well for planar reflections? (Your answer can preferably include an
illustration. As an example, you could use a man standing on a floor, where the
man should reflect in the reflective floor.)
Answer: the environment map is, for each pixel-to-be-shaded, assumed to be
centered on that pixel. Reflection vectors often change little on planar surfaces,
and the environment-map pixel is only dependent on the reflection vector (not its
origin). Another way to say this is that the environment map represents
surrounding geometry infinitely far away.

# Curves

## Sketch one non-continuous curve and one C0-continuous curve (and mark
which is which).

## Explain what Cx-continuity means and what G1-continuity means for curves.
Answer: Cx-continuity means that the derivatives of order 0 (or 1) to k exists and
are continuous. G1-continuity means that the tangent vectors between each curve
segment have equal directions, but their lengths (strengths) may vary.

## State the type of curve that each image represents. C hoose between Interpolation-curve, Hermite-curve and Bezier-curve. Motivate your choice:

## Describe how curve drawing using B-splines work, given a set of control points. (I.e., explain B-splines). Hint: state the expression for the curve p(u) = Σ…, sketch the basisfunction and give the intervals, sketch and/or state the blendfunctions Bi for the points pi.

## Sketch one non-continuous curve and one C0-continuous curve (and mark which is
which).
Answer:

## In which ways are NURBS more general than B-Splines?
Answer: control points can be set at non-uniform intervals and they can have different weights.

## Assume p=(4,9,0,2). Perform the homogenization step on p.
Answer:

## Manually normalize the vector x=(0,4,1).
Answer:

# Math

## Assume p=(4,2,1,3). Perform the homogenization step on p.
Answer: p=(4/3, 2/3, 1/3, 1).

## Manually normalize the vector x=(3,1,2).
Answer: x=x/|x| = (3,1,2) / sqrt(32+12+22) = (3,1,2)/sqrt(14).


# Hardware

## Linear interpolation of (u,v) in screen space does not give perspective correct texturing. Describe how perspective correct texture interpolation can be achieved.
Answer: In screen space, linearly interpolate (u/w, v/w, 1/w) from each vertex.
Then, per pixel: ui = (u/w)i / (1/w)i, (i=screen space interpolated value)



## Assume that you are a hardware designer of a modern GPU working at some company. What would be the main point on your wish list: being able to increase the core clock frequency or being able to increase the memory bandwidth? Motivate! 
Answer: A possible answer: you would typically want to increase the bandwidth. See graphics hardware leciture regarding bandwidth usage.

## There are 4 main taxonomies of hardware, based on where in the GPU-pipeline sorting in screen space is done. Which are these four? (Names are enough. You do not need to describe them if you don't want to.)
Answer: Sort-first: sort the triangles spatially before the geometry stage.
Sort-middle: sort the triangles spatially after the geometry stage.
Sort last fragment: sort the rasterized fragments spatially.
Sort last image: Have a frame buffer per pipeline. Merge the frame buffers after full
rendering.
(See lecture 12.)

## State at least 4 bandwidth reducing techniques used on graphics cards.
Answer:
– Texture caching with prefetching
– Texture compression
– Z-compression
– Z-occlusion testing (HyperZ)
– (Pipelining)
– threads

## Sketch the architecture for a modern graphics card, e.g. the Geforce 8800. You can use the major functional blocks that we have mentioned in the course.
