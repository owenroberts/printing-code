import geomerative.*;


void setup() {
  size(512, 512);
  background(255);
  colorMode(HSB, 360, 100, 100);


  String[] gs = {
    "GI", "AN", "TS", "TE", "PS"
  };
  int margin = 5;

  int colorbase = (int)random(360);
  println(colorbase);


  ModularGrid grid = new ModularGrid(gs.length, gs.length, 5, margin);
  //grid.display();

  Module n = grid.modules[0][0];

  PFont font = loadFont("Helvetica-96.vlw");
  textFont(font, n.h);
  textSize(n.h);
  textAlign(LEFT, TOP);

  for (int i = 0; i < grid.cols; i++) {
    for (int j = 0; j < grid.rows; j++) {
      Module m = grid.modules[i][j];
      int r = grid.cols;
      if ((int)random(r) == 0) {
        pushMatrix();
        fill(0, 0, 0);
        translate(m.x, m.y);
        text(gs[i], 0, 0);
        popMatrix();
      } 
      else {
        HSBColor ranColor = new HSBColor(colorbase, random(100), random(100));
        fill(ranColor.h, ranColor.s, ranColor.b);
        stroke(ranColor.h, ranColor.s, ranColor.b);
        int sw = (int)random(4);
        switch(sw) {
        case 0:
          drawSpiral((int)m.x, (int)m.y, (int)m.w, (int)m.h);
          break;
        case 1:
          drawShape(50, m.x + m.w/2, m.y + m.h/2, m.w/3);
          break;
        case 2:
          drawPlus(m.x, m.y, m.w, m.h, 30);
          break;
        case 3:
          drawFootball(m.x, m.y, m.w, m.h);
          break;
        }
      }
    }
  }
}

void drawSpiral(int _x, int _y, int _w, int _h) {
  int x = _x;
  int y = _y;
  int w = _w;
  int h = _h;

  pushMatrix();
  translate(x + w/2, y+h/2);
  stroke(0, 0, 0);

  beginShape();
  for (int i=0;i<random(25,30);i++)
  {
    curveVertex((i*2)*sin(i/0.9), (i*2)*cos(i/0.9));
  }
  endShape();
  popMatrix();
}

void drawShape(int numVertices, float x, float y, float r)
{
  pushMatrix();
  translate(x, y);
  noStroke();


  float vertexDegree = 360 / numVertices;

  beginShape();
  for (int i = 0; i < numVertices; i++)
  {
    float vertexX = cos(radians(i * vertexDegree) - QUARTER_PI) * r;
    float vertexY = sin(radians(i * vertexDegree) - QUARTER_PI) * r;
    vertex(vertexX, vertexY);
  }
  endShape();
  popMatrix();
}

void drawPlus(float _x, float _y, float _w, float _h, float margin) {
  noStroke();

  float x = _x;
  float y = _y;
  float w = _w;
  float h = _h;
  float m = margin;

  pushMatrix();
  translate(x+w/2, y+h/2);
  rectMode(CENTER);
  rect(0, 0, w/5, h-m);
  rect(0, 0, w-m, h/5);
  popMatrix();
}

void drawFootball(float _x, float _y, float _w, float _h) {
  pushMatrix();
  translate(_x, _y);
  beginShape();
  vertex(_w, 0);
  bezierVertex(_w, 0, 0, 0, 0, _h);
  bezierVertex(_w, _w, _w, 0, _w, 0);
  endShape();

  strokeWeight(5);
  stroke(0, 0, 100);
  float seam = _w/2;
  float laces = seam/5;
  float w = _w/2;
  translate(_w/2-seam/2, _w/2);
  rotate(-0.8);
  line(0, laces, seam, laces);
  for (int i = 0; i < 5; i++) {
    line(i*laces+laces/2, laces/2, i*laces+laces/2, 1.5*laces);
  }
  popMatrix();
}

