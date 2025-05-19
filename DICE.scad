/* 
    Author: Angel Roman
    Profile: https://makerworld.com/en/@DaTrapHouse
    Project: Parametric Dice Model
    Description:
        A scalable dice made by intersecting a cube and a sphere,
        then subtracting smaller spheres to simulate pips on all six faces.
        Easily customizable by adjusting `cube_size`.
*/

// === Parameters ===
cube_size = 10;
sphere_size = cube_size / 1.36;
dice_sphere_size = cube_size * 0.12;
dice_sphere_offset = dice_sphere_size * 2;
dice_offset = (cube_size / 2) - (dice_sphere_size / 2);

// === Dice Shape ===
difference() {
    // Base: intersection of cube and sphere
    intersection() {
        cube([cube_size, cube_size, cube_size], center=true);
        sphere(sphere_size);
    }

    // Face 1: bottom (Y-)
    translate([0, -dice_offset, 0])
        sphere(dice_sphere_size);

    // Face 2: top (Y+)
    translate([0, dice_offset, 0]) {
        for (x = [-dice_sphere_offset, dice_sphere_offset])
            for (z = [-dice_sphere_offset, 0, dice_sphere_offset])
                translate([x, 0, z])
                    sphere(dice_sphere_size);
    }

    // Face 3: back (Z-)
    translate([0, 0, -dice_offset]) {
        for (x = [-dice_sphere_offset, dice_sphere_offset])
            for (y = [-dice_sphere_offset, dice_sphere_offset])
                translate([x, y, 0])
                    sphere(dice_sphere_size);
    }

    // Face 4: front (Z+)
    translate([0, 0, dice_offset]) {
        for (pos = [
            [ dice_sphere_offset,  dice_sphere_offset],
            [ 0,                   0],
            [-dice_sphere_offset, -dice_sphere_offset]
        ])
            translate([pos[0], pos[1], 0])
                sphere(dice_sphere_size);
    }

    // Face 5: left (X-)
    translate([-dice_offset, 0, 0]) {
        for (pos = [
            [0,  dice_sphere_offset,  dice_sphere_offset],
            [0, -dice_sphere_offset, -dice_sphere_offset]
        ])
            translate(pos)
                sphere(dice_sphere_size);
    }

    // Face 6: right (X+)
    translate([dice_offset, 0, 0]) {
        for (pos = [
            [0, 0, 0],
            [0, -dice_sphere_offset, -dice_sphere_offset],
            [0, -dice_sphere_offset,  dice_sphere_offset],
            [0,  dice_sphere_offset, -dice_sphere_offset],
            [0,  dice_sphere_offset,  dice_sphere_offset]
        ])
            translate(pos)
                sphere(dice_sphere_size);
    }
}
