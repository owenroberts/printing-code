import processing.pdf.*;

int smin = 60;
int smax = 80;
int bmin = 60;
int bmax = 90;

int hmin = 45;
int hmax = 90;

void setup() {
  size(1280, 800);
  beginRecord(PDF, "imgs/" + getClass() + " " + day() + hour() + minute() + second() +".pdf");
  background(255);
  noStroke();
  colorMode(HSB, 360, 100, 100);
  float[] base = new float[4];
 
  base[0] = random(360);
  base[1] = (base[0] + random(hmin, hmax))%360;
  base[2] = (base[1] + random(hmin, hmax))%360;
  base[3] = (base[2] + random(hmin, hmax))%360;

  Grid grid = new Grid(4, 100);
  //grid.display();

  for (int i = 0; i < grid.cols; i++) {
    Column c1 = grid.columns[i];
    painting(base[i], c1.x, c1.y, c1.w, c1.h);
  }
}

void painting(float _c, float _x, float _y, float _w, float _h) {

  pushMatrix();
  translate(_x, _y);
  fill(_c, random(smin, smax), random(bmin, bmax));
  rect(_w/2 - _w/4, _h/2 - _h/6, _w/2, _h/3);
  float newcolor=0;
  switch((int)random(2)) {
  case 0:
    newcolor = (_c + random(360-hmax, 360-hmin))%360;
    break;
  case 1:
    newcolor = (_c + random(hmin, hmax))%360;
    break;
  }
  println(newcolor);
  fill(newcolor, random(smin, smax), random(smin, smax));
  rect(_w/2 - _w/4, _h/2 - _h/6, _w/2, _h/24);
  rect(_w/2 - _w/4, _h - _h/3 - _h/24, _w/2, _h/24);
  popMatrix();
}

void draw() {
}

void keyPressed() {
  if (key == ENTER) {
    endRecord();
  }
}

