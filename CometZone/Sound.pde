Minim minim;

AudioPlayer gun, rocket, background, astroidDestroyed;

boolean moving;


void SoundSetup() {
  minim = new Minim(this);

      //loading files
      
      gun = minim.loadFile("RetroLaserGun.wav");
      rocket = minim.loadFile("RumblingEngine.wav");
      background = minim.loadFile("PeacefulBackgroundMusic.wav");
      astroidDestroyed = minim.loadFile("SoftPoppingSound.aiff");
      

     
}




void SoundKeyPressed() {
  if (gameState == 1) {
    if (keyCode == ' ' ) {
      gun.rewind();
      gun.play();
    }
if (keyCode == UP ) {
      moving = true;
    }
  }
}

void SoundKeyReleased() {
 
if (keyCode == UP ) {
       moving = false;
       rocket.pause();
    }
  }
  
  
  void MusicSound (){
    background.play();
    if(background.position() == background.length()){
      background.rewind();
    }
    
    
    if(moving == true && gameState == 1){
      rocket.play();
      if(rocket.position() == rocket.length()){
       rocket.rewind(); 
      }
      else if (moving == false){
       rocket.pause();
       rocket.rewind();
      }
    }
    
    if(AsteroidDestroyed){
      astroidDestroyed.play();
      astroidDestroyed.rewind();
      AsteroidDestroyed = false;
    }
    
    
  }
