/// move_state()
var right = keyboard_check(vk_right);
var left = keyboard_check(vk_left);
var up = keyboard_check(vk_up);
var up_release = keyboard_check_released(vk_up);
var down = keyboard_check(vk_down);

// gravity
if (!place_meeting(x, y+1, Solid)) {
    vspd += grav;
    
    //Player is in the air
    sprite_index = spr_player_jump;
    image_speed = 0;
    image_index = (vspd > 0);
    
    // Control the jump height
    if (up_release && vspd < jmpHeightMin) {
        vspd = jmpHeightMin;
    }
} else {
    vspd = 0;  
    // we're on the ground => jump
    if (up) {
        vspd = jmpHeightMax;
    }
    
    // Player is on the ground
    if (hspd == 0){
        sprite_index = spr_player_idle;
    } else {
        sprite_index = spr_player_walk;
        image_speed = .6;
    }
}

// Move the Player
if (right) {
    hspd = spd;
}
 
if (left) {
    hspd = -spd;
    hspd_dir = -1;
}

if (hspd != 0){
    image_xscale = sign(hspd);
}

//  friction
if (!right && !left) {
    hspd = 0;
}

move(Solid);

/// Check for ledge grab state
var falling = y-yprevious > 0;
// character collision is 16 px  - If there is not a wall at our previous position
var wasnt_wall = !position_meeting(x+17 * image_xscale, yprevious, Solid);
// wall at our current position
var is_wall = position_meeting(x+17 * image_xscale, y, Solid);

if (falling && wasnt_wall && is_wall) {
    hspd = 0;
    vspd = 0;
    
    //move against the ledge
    while (!place_meeting(x+image_xscale, y, Solid)) {
        x += image_xscale;
    }
    
    // make sure we are the right height
    while (position_meeting(x+17 * image_xscale, y-1, Solid)){
        y-=1;
    }
    
    sprite_index = spr_player_ledge_grab;
    state = ledge_grab_state;
}
