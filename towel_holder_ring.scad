module fitting(length, radius) {
    rotate([0,90,0])
    translate([-abs(radius), 0, 0])
        cylinder(h=length, r=radius, $fn=20);
}

module half_rod(size, rod_1_len, rod_2_len, rod_3_len) {
    radius = -size / 2;

    // Connected to fitting
    translate([0, radius, 0])
        cube([rod_1_len, size, size]);

    // Connector of fitting rod and long rod
    translate([rod_1_len, radius, 0])
    rotate([0, 0, 90])
        cube([rod_2_len, size, size]);

    // Long rod
    translate([rod_1_len, rod_2_len + radius, 0])
    rotate([0, 0, 180])
        cube([rod_3_len, size, size]);
}

gap = 3.5 / 2;

fitting_length = 6;
fitting_radius = 9.9 / 2;
rod_size = 15;
rod_1_len = 68;
rod_2_len = 115;
rod_3_len = rod_1_len + fitting_length + gap;


// Left Fitting
translate([gap, 0, 0])
    fitting(fitting_length, fitting_radius);

// Left Half Rod
translate([fitting_length + gap, 0, 0])
    half_rod(rod_size,
        rod_1_len=rod_1_len,
        rod_2_len=rod_2_len,
        rod_3_len=rod_3_len);

// Right Fitting
translate([-fitting_length - gap, 0, 0])
    fitting(fitting_length, fitting_radius);

// Right Half Rod
rotate([0, 180, 0])
translate([fitting_length + gap, 0, -rod_size])
    half_rod(rod_size,
        rod_1_len=rod_1_len,
        rod_2_len=rod_2_len,
        rod_3_len=rod_3_len);
