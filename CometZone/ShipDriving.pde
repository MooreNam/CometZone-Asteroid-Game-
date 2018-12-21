//Background Stars
int maxSize = 50;//number of stars

int mult = 1000;
float size = 0.5; //starSize
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
float turning = 0.12;

PVector vel;
PVector acc;
PVector sDir;
float speedLimit = 5;

PVector SpawnPoint;


void ShipDrivingSetup() {


  midPoint = new PVector(width/2, height/2, 0);
  SpawnPoint = new PVector(width*0.25,height/2);
  pos = new PVector(width*0.25, height/2,0);
  vel = new PVector();
  acc = new PVector();
  sDir = new PVector(0, 1, 0);

  ShipDrivingInit();



 
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




void tracers() {
  for (int i = maxSize -1; i > 0; i--) { //Move each tracer back in array

    posh[i] = posh[i-1];

    sizes[i] = sizes[i-1]*shrinkscale;  //Shrink tracer as moving through array

    velh[i] = velh[i-1];
  }

  if (thrustBool) {
    posh[0] = new PVector(pos.x, pos.y);

    velh[0] = new PVector (random(-sDir.x -.2, -sDir.x +.2), random(-sDir.y-.2,-sDir.y+.2),0);

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
    translate(cos(dir)*speed, sin(dir)*speed);

    ellipse(posh[i].x, posh[i].y, sizes[i]/3, sizes[i]/3);

    popMatrix();
    //sphere(posh[i].x, posh[i].y, sizes[i]/3, sizes[i]/3);
  }
}


void ShipDriving() {
  Gravity();
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
    sDir.rotate(-turning);
    //dir -= .05;
  }
  if (rightBool) {
    sDir.rotate(turning);
    // dir += .05;
  } 

  if (thrustBool) { //Increase Speed
    //speed += .1;
    acc = sDir.copy().mult(0.5);
  } else { //Decrease Speed
    vel.mult(0.98);
    //speed *= 0.99;
  }
  vel.limit(speedLimit);
  //  speed = constrain(speed, 0, 4); //speedlimit
}


void ShipDrivingDraw() {
  noStroke();
  tracers();
  
  ShipDriving();
    HitDetection();

  //cam.lookAt(pos.x, pos.y, 0, 0, 500);
  
}
