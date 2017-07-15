/// bat_idle_state()
image_index = spr_bat_idle;

// look for the player
if (instance_exists(Player)) {
    var dist = point_distance(x, y, Player.x, Player.y);
    
    if (dist < sight) {
        state = bat_chase_state;
    }
}
