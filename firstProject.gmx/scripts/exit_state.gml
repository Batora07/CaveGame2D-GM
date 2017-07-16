/// exit_state()
if (image_alpha > 0) {
    image_alpha -= .25;
} else {
    if (room != room_last) {
        room_goto_next();    
    } else { 
        // Calculate the score
        score = PlayerStats.sapphires;
        
        // open the highscores
        ini_open("Settings.ini");
        PlayerStats.highScore = ini_read_real("Score", "Highscore", 0);
        
        // A new highscorecase
        if (score > PlayerStats.highScore) {
            PlayerStats.highScore = score;
            ini_write_real("Score", "Highscore", PlayerStats.highScore);
        }
        // close the ini_file
        ini_close();
        
        room_goto(rm_highscore);
    }
}
