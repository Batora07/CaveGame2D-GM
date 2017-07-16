/// move_state()

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
        audio_play_sound(snd_jump, 5, false);
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

if (right || left) {
    hspd += (right-left) * acc;
    hspd_dir = right - left;
    
    if (hspd > spd) hspd = spd;
    if (hspd < -spd) hspd = -spd; 
} else {
    apply_friction(acc);
}

if (hspd != 0){
    image_xscale = sign(hspd);
}

// Play the landing sound
if (place_meeting(x, y+vspd+1, Solid) && vspd > 0) {
    audio_emitter_pitch(audio_em, random_range(.8, 1.2));
    audio_emitter_gain(audio_em, .2);
    audio_play_sound_on(audio_em, snd_step, false, 6);
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
    
    // play the ledge grab sound
    audio_emitter_pitch(audio_em, 1.5);
    audio_emitter_gain(audio_em, .1);
    audio_play_sound_on(audio_em, snd_step, false, 6);
}
