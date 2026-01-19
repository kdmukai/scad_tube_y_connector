// Y-Connector for 18mm Tubes to 3/4" PVC
// Visualize via: https://ochafik.com/openscad2

// Incoming tube parameters
incoming_tube_od = 18;  // Outside diameter of incoming tubes
incoming_fit_clearance = 0.3;
incoming_socket_id = incoming_tube_od + incoming_fit_clearance;
incoming_socket_depth = 40;

// Central tube parameters (fits inside 3/4" PVC Schedule 40)
pvc_inner_diameter = 20.93;
pvc_fit_clearance = 0.3;
central_tube_length = 25;
pvc_insert_length = 20;  // Length of section that fits into PVC
pvc_insert_od = pvc_inner_diameter - pvc_fit_clearance * 2;

// Connector parameters
wall_thickness = 2;
branch_angle = 35;  // Angle from vertical for each branch
central_tube_id = incoming_socket_id;  // Inside diameter matches branch sockets
central_tube_od = incoming_socket_id + wall_thickness * 2;  // Outside diameter matches branch sockets

// Y-Connector
difference() {
    // Outer shell
    union() {
        // Central tube
        cylinder(d=central_tube_od, h=central_tube_length, $fn=128);
        
        // PVC insert section at bottom
        translate([0, 0, -pvc_insert_length])
            cylinder(d=pvc_insert_od, h=pvc_insert_length, $fn=128);
        
        // Left branch socket
        translate([0, 0, central_tube_length])
            rotate([0, branch_angle, 0])
            cylinder(d=incoming_socket_id + wall_thickness * 2, h=incoming_socket_depth, $fn=128);
        
        // Right branch socket  
        translate([0, 0, central_tube_length])
            rotate([0, -branch_angle, 0])
            cylinder(d=incoming_socket_id + wall_thickness * 2, h=incoming_socket_depth, $fn=128);
    }
    
    // Inner cavities
    union() {
        // Central tube cavity (extends through PVC insert)
        translate([0, 0, -pvc_insert_length - 0.5])
            cylinder(d=central_tube_id, h=central_tube_length + pvc_insert_length + 5, $fn=128);
        
        // Left branch socket cavity
        translate([0, 0, central_tube_length - 0.5])
            rotate([0, branch_angle, 0])
            cylinder(d=incoming_socket_id, h=incoming_socket_depth + 1, $fn=128);
        
        // Right branch socket cavity
        translate([0, 0, central_tube_length - 0.5])
            rotate([0, -branch_angle, 0])
            cylinder(d=incoming_socket_id, h=incoming_socket_depth + 1, $fn=128);
    }
}

