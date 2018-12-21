
boolean AsteroidDestroyed = false;

boolean mainCollideAsteroid = false;


void HitDetection() {
//asteroids and bullets
  for (int i = 1; i < asteroids.size(); i++) {
//    if (hitTarget(asteroids.get(0).pos, asteroids.get(i).pos, asteroids.get(0).siz, asteroids.get(i).siz)) {
//        score-= 10;
//mainCollideAsteroid = true;      
//      }
    
    for(int j = 0; j < posB.size(); j++){
      
      if(hitTarget(asteroids.get(i).pos, posB.get(j), asteroids.get(i).siz, bulletSize)){
       asteroids.get(i).dead = true;
       score += 25;
       AsteroidDestroyed = true;
     }
    }
  }





//player and main asteroid
  if (hitTarget(main.pos, pos, main.siz, 20)) {

    ShipDrivingSetup();;
    lives--;
  }
  if (lives <= 0) {
    if(score > highScore){
      highScore = score;
    }
    gameState = 2;
  }
  
}
