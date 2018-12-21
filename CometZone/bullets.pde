//Global variables
ArrayList <PVector> velB = new ArrayList <PVector>();
ArrayList <PVector> posB = new ArrayList <PVector>();


float bulletSpeed = 20;
float bulletSize = 7;

//PVector pos;
//PVector sDir;
//var is for target\
PVector tpos;
void BulletsSetup() {


//  pos = new PVector(width/2, height/2, 0);
  sDir = new PVector(0, -1, 0);
  tpos = new PVector(random(0, width), (random(0, height/2)));
}


void BulletsKeyPressed() {
  if (keyCode == ' ') {
    posB.add(new PVector(pos.x, pos.y, pos.z));

    PVector tempv = new PVector(sDir.x, sDir.y, sDir.z).mult(bulletSpeed);
    //tempv.rotate(random(-PI/4., PI/4));
    velB.add(tempv);
  }
  if ( keyCode == RIGHT) {
    sDir.rotate(0.05);
  }
  if (keyCode == LEFT) {
    sDir.rotate(-0.05);
  } else {
  }
}



boolean detect(PVector pos1, PVector pos2, float rad) {
  boolean isFar = PVector.dist(pos1, pos2) > rad;
  return isFar;
}

void bullet() {
  for (int i = 0; i < posB.size(); i++) {
    PVector p = posB.get(i);
    PVector v = velB.get(i);

    p.add(v);

    noStroke();
    pushMatrix();
    translate(p.x, p.y, p.z);
    fill(255, 0, 0);
    sphere(bulletSize);
    popMatrix();


    if (detect(p, new PVector(width/2, height/2), width)) {
      posB.remove(p);
      velB.remove(v);
    }
    if (hitTarget(tpos, p, tSize, bulletSize)) {
      //move the target
      tpos = new PVector(random(0+tSize, width-tSize), (random(0+tSize, height-tSize)));
      //remove the bullet
      posB.remove(p);
      velB.remove(v);
      //if we remove this move to the next bullet
      continue;
    }
  }
}//end bullet



float tSize=50;





boolean hitTarget(PVector target, PVector bulletPos, float targetRad, float bulletRad) {

  return target.dist(bulletPos)<targetRad+bulletRad;
}

void BulletsDraw() {
  bullet();
}
