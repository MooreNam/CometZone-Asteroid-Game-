PVector SpawnAsteroid;

int side;

double AsteroidSpawnTimerStart;

double AsteroidSpawnTimer;

void AsteroidSpawningSetup(){
   AsteroidSpawnTimerStart = millis();
 
}

void AsteroidSpawning(){

  AsteroidSpawnTimer = millis()-AsteroidSpawnTimerStart;
  
  int i = 1;
  
if(AsteroidSpawnTimer > 3000 ){
       
       side = (int)random(1,4);
      
      if(side == 1){
        SpawnAsteroid = new PVector (random(0,width),0,0);
      }
      
      else if(side == 2){
                SpawnAsteroid = new PVector (width,random(0,height),0);

      }
      
      else if(side == 3){
                SpawnAsteroid = new PVector (random(0,width),height,0);

      }
      
      else if(side == 4){
 SpawnAsteroid= new PVector (width,random(0,height),0);

      }
      
 new Asteroid(asteroids, 1., model, SpawnAsteroid, new PVector(),true, false);
       
       AsteroidSpawnTimerStart = millis();
       
       i++;
}

 
}
