int starmaxstarsize = 500;//the number of stars
float starmult = 2000;//the number you starmultiply the 3D sphere on which the stars exist by
float starsize = 5;//a number we select to use as the starsize of the spheres

PVector [] pos2 = new PVector[starmaxstarsize];//positions of the spheres
PVector starmidpoint;

void StarBackgroundSetup() {
  //starsize(800, 800, P3D);//starsize of window
  noStroke();//no outer circle on the ellipses

  starmidpoint = new PVector(width/2, height/2, starmult/2);


  for (int i = 1; i < starmaxstarsize; i++) {
    pos2[i] = (PVector.random3D());
    pos2[i].mult(starmult);
    pos2[i].add(starmidpoint);
  }
}

void StarBackgroundDraw() {
  background(0);
fill(255);
noStroke();
  for (int i = 1; i < starmaxstarsize; i++) {
    pushMatrix();
    fill(255. - (float)i/starmaxstarsize*255, 225, 255);
    translate(pos2[i].x, pos2[i].y, pos2[i].z);//move the origin to where we want the sphere
    //sphere(random(starsize, starsize+2));
      ellipse(random(starsize),random(starsize),random(starsize),random(starsize));

    popMatrix();
  }
}
