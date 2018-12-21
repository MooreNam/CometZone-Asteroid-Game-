import peasy.*;
import ddf.minim.*;
int gameState;
int lives;
int score;
int highScore;
PeasyCam cam;


/*
gamestates:
 0 - start
 1 - plaing
 2 - died
 */



void setup() {
   midPoint = new PVector(width/2, height/2, mult/2); 

  smooth(8);
  size(1250, 700, P3D);
  
  frameRate(40);

  ShipDrivingSetup();
  BulletsSetup();
  HUDSetup();
  SoundSetup();
  AsteroidMainSetup();
  StarBackgroundSetup();
  AsteroidSpawningSetup();

  score = 0;
  gameState = 0;
  lives = 3;
}


void keyPressed() {

  if (gameState == 1) {
    ShipDrivingKeyPressed();
    BulletsKeyPressed();
    SoundKeyPressed();
  }// end if
}//end keyPressed


void keyReleased() {

  if (gameState ==0) {
    if (keyCode == ' ') {
      gameState = 1;
    }
  } else if (gameState == 1) {
    ShipDrivingKeyReleased();
    SoundKeyReleased();
  }
  else if(gameState == 2){
    lives = 3;
    if (keyCode == ' ') {
      ShipDrivingSetup();
      score = 0;
      gameState = 1;
  }
  }
  
}//end keyReleased


void draw() {
  
  if (gameState == 0) {
    
      cam = new PeasyCam(this, midPoint.x, midPoint.y, 0, 500);

    background(240, 70, 25);
    text("Welcome to Comet Zone!", width/2-70, height/2-30);
    text("Press the spacebar to start", width/2-77, height/2+30);


  cam.lookAt(width/2, height/2, 0, 100);
  } else if (gameState == 1) {
    //background(0);
    StarBackgroundDraw();
    ShipDrivingDraw();
    AsteroidMainDraw();
    BulletsDraw();
    HUDDraw();
    
    
  } else if (gameState == 2) {
      cam = new PeasyCam(this, midPoint.x, midPoint.y, 0, 500);

    background(240, 70, 25);
    text("You are Dead x-x", width/2-40, height/2-60);
    text("Score: " + score, width/2-80, height/2);
    text("HighScore: " + highScore, width/2+60, height/2);
    text("Press the spacebar to try again!", width/2-77, height/2+50);
  }
  MusicSound();
}//end draw
