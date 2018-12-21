



//Background Stars
int maxSize = 50;//number of stars

int mult = 1000;
float size = 0.5; //starSize
PVector[] pos1 = new PVector [maxSize]; //star positions
PVector midPoint; //For PeasyCam

//Tracers
float startSize = 30; // this is the tracers starting size
PVector[] posh = new PVector[maxSize];
PVector[] velh = new PVector[maxSize];
PVector[] acch = new PVector[maxSize];
float [] sizes = new float[maxSize];
float shrinkscale = 0.99;
float velscale = 2;

//Ship Control
PVector pos; //Position of ship
float dir = 0;     // Angle of ship
float speed = 0;   // Speed of ship
boolean leftBool, rightBool, thrustBool; 

PVector vel;
PVector acc;
PVector sDir;
float speedLimit = 4;

void ShipDrivingSetup() {
  size(600, 600, P3D);
  frameRate(120);

  midPoint = new PVector(width/2, height/2, 0);
  pos = new PVector(width/2, height/2);
  vel = new PVector();
  acc = new PVector();
  sDir = new PVector(0, 1, 0);

  ShipDrivingInit();
  // below is for star background
  //midPoint = new PVector(width/2, height/2, mult/2);

  cam = new PeasyCam(this, midPoint.x, midPoint.y, 0, 500);
  //cam = new PeasyCam(this, 100, 100, 100, 100);
  cam.setMinimumDistance(50);
  cam.setMaximumDistance(500);
  cam.lookAt(width/2, height/2, 0, 100);
 // cam.setActive(false);

  for (int i = 1; i < maxSize; i++) {
    pos1[i] =  (PVector.random3D());
    pos1[i].mult(mult);
    //  pos1[i].add(midPoint);
  }
}
void ShipDrivingInit() {
  //initialize arrays
  for (int i = 0; i < maxSize; i++) {
    posh[i] = new PVector(-1000, -1000);
    velh[i] = PVector.random2D();
    velh[i].mult(velscale);
    acch[i] = new PVector(0, 0);

    sizes[i] = startSize;
  }
}

void offEdge() {
  if (pos.x > width) {
    pos.x = 0;
  } else if (pos.x < 0) {
    pos.x = width;
  } else if (pos.y > height) {
    pos.y = 0;
  } else if (pos.y < 0) {
    pos.y = height;
  }
}

void ShipDrivingKeyPressed() {
  if (keyCode == LEFT) {
    leftBool = true;
  }
  if (keyCode == RIGHT) {
    rightBool = true;
  }
  if (keyCode == UP) {
    thrustBool = true;
  }
}

void ShipDrivingKeyReleased() { //Better control for ship (multiple keys at once without confusing keys for others)
  if (keyCode == LEFT) {
    leftBool = false;
  }
  if (keyCode == RIGHT) {
    rightBool = false;
  }
  if (keyCode == UP) {
    thrustBool = false;
  }
}


void starBackground() {
  for (int i=1; i < maxSize; i++) {  //Background stars
    pushMatrix();
    fill(255. -(float)i/maxSize*255, 255, 255);
    translate(pos1[i].x, pos1[i].y, pos1[i].z);
    sphere(random(size, size*2));
    popMatrix();
  }
}

void tracers() {
  for (int i = maxSize -1; i > 0; i--) { //Move each tracer back in array

    posh[i] = posh[i-1];

    sizes[i] = sizes[i-1]*shrinkscale;  //Shrink tracer as moving through array

    velh[i] = velh[i-1];
  }

  if (thrustBool) {
    posh[0] = new PVector(pos.x, pos.y);

    velh[0] = PVector.random2D();

    velh[0].mult(velscale);

    sizes[0] = startSize;
  } else { // If not pressing thrust, Then spawn Tracers out of screen

    posh[0] = new PVector(-1000, -1000);
  }

  for (int i = 0; i < maxSize; i++) {
    posh[i].add(velh[i]);
    fill(255, 100 - (float)i/maxSize*254., 0, 255. - (float)i/15*254.);
    //fill(50 + (float)i/maxSize*205, 128+127*sin((float)frameCount* PI/60), 127. - cos((float)frameCount*PI/30), 255. - (float)i/maxSize*254.);
    pushMatrix();
    println(dir);
    translate(cos(dir)*speed, sin(dir)*speed);

    ellipse(posh[i].x, posh[i].y, sizes[i]/3, sizes[i]/3);

    popMatrix();
    //sphere(posh[i].x, posh[i].y, sizes[i]/3, sizes[i]/3);
  }
}


void shipDriving() {

  vel.add(acc);
  pos.add(vel);
  acc.set(0, 0, 0);

  fill(255);
  pushMatrix();
  translate(pos.x, pos.y);
  rotate(sDir.heading());
  stroke(1);
  box(30, 10, 10);
  popMatrix();

  if (leftBool) { //add to rotation
    sDir.rotate(-0.05);
    //dir -= .05;
  }
  if (rightBool) {
    sDir.rotate(0.05);
    // dir += .05;
  } 

  if (thrustBool) { //Increase Speed
    //speed += .1;
    acc = sDir.copy().mult(0.05);
  } else { //Decrease Speed
    vel.mult(0.98);
    //speed *= 0.99;
  }
  vel.limit(speedLimit);
  //  speed = constrain(speed, 0, 4); //speedlimit
  offEdge();
}


void ShipDrivingDraw() {
  background(0);
  noStroke();
  tracers();
  shipDriving();
  cam.lookAt(pos.x, pos.y, 0, 0, 500);
}
