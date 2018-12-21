
Asteroid main;



ArrayList<Asteroid> asteroids = new ArrayList<Asteroid>();

PShape model;

PImage texture;
PVector center;

void AsteroidMainSetup() {
  AsteroidMainInit();
}

void AsteroidMainInit() {
  cam = new PeasyCam(this, width, height, 0, 600);
  center = new PVector(width/2, height/2, 0);
  texture = loadImage("texture.jpg");
  model = loadShape("ast.obj"); 
  model.setTexture(texture);

main = new Asteroid(asteroids, 5., model, center, new PVector(),false, false);


} 



void AsteroidMainDraw() {
  
  for (int i = 0; i < asteroids.size(); i++) {
    asteroids.get(i).update();
  }
  fill(255,45,0,80);
  ellipse(main.pos.x,main.pos.y, 300,300);
  
cam.lookAt(main.pos.x,main.pos.y,main.pos.z,600,0);

AsteroidSpawning();


}//end main
