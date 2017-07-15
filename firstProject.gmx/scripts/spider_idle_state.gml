/// spider_idle_state()
if (instance_exists(Player)) {
    var dist = distance_to_object(Player);
    
    if (dist < sight && alarm[0] <= 0) {
        image_speed = .5;
        
        // Make sure we face the player
        if (Player.x != x) {
            image_xscale = sign(Player.x-x);
        }
    }
}
