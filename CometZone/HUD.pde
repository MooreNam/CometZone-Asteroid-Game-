
public void HUDSetup() {
    //imageMode(CENTER);
}

public void HUDDraw() {
  cam.beginHUD();
  fill(50, 250,50,  128);
  rect(0, 0, width, 30);
  fill(255);
  text("" + nfc(frameRate, 2), 10, 18);
//lives  
    text("lives: " + lives, 100, 18);
    
    text("score: " + score, 200, 18);

  cam.endHUD();
}
