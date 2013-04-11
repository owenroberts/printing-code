import processing.pdf.*;

void setup() {
  size(1280, 800);
  beginRecord(PDF, "imgs/" + getClass() + day() + hour() + minute() + second() +".pdf");
  background(255);
  noStroke();
  colorMode(HSB, 360, 100, 100);

  Grid grid = new Grid(4, 100);
  //grid.display();

  for (int i = 0; i < grid.cols; i++) {
    Column c1 = grid.columns[i];
    painting(random(360), c1.x, c1.y, c1.w, c1.h);
  }
}

void painting(float _c, float _x, float _y, float _w, float _h) {

  pushMatrix();
  translate(_x, _y);
  fill(_c, 80, 80);
  rect(_w/2 - _w/4, _h/2 - _h/6, _w/2, _h/3);
  float newcolor=0;
  switch((int)random(2)) {
  case 0:
     newcolor = (_c + random(300,330))%360;
    break;
  case 1:
     newcolor = (_c + random(30, 60))%360;
    break;
  }
  println(newcolor);
  fill(newcolor, 80, 80);
  rect(_w/2 - _w/4, _h/2 - _h/6, _w/2, _h/24);
  rect(_w/2 - _w/4, _h - _h/3 - _h/24, _w/2, _h/24);
  popMatrix();
}

void draw() {}

void keyPressed() {
  if (key == ENTER) {
    endRecord();
  }
}

