import geomerative.*;


void setup() {
  size(512, 512);
  background(255);
  colorMode(HSB, 360, 100, 100);


  String[] gs = {
    "GI", "AN", "TS", "TE", "PS"
  };
  int margin = 5;
  int check[] = new int[5];
  for (int i = 0; i < check.length; i++) {
    check[i] = 0;
  }
  int rch[] = new int[5];
  for (int i = 0; i < rch.length; i++) {
    rch[i] = 0;
  }
  int ach[][] = new int[5][5];
  for (int i = 0; i < 5; i++) {
    for (int j = 0; j < 5; j++) {
      ach[i][j] = 0;
    }
  }

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
        check[i] = 1;
        rch[j] = 1;
        ach[i][j] = 1;
      } 
      else {

        for (int k = 0; k < check.length; k++) {
          if (check[k] != 1) {
            pushMatrix();
            fill(0, 0, 0);
            int temp = (int)random(grid.rows);
            Module rm = grid.modules[k][temp];
            translate(rm.x, rm.y);
            text(gs[k], 0, 0);
            popMatrix();
            check[k] = 1;
            rch[temp] = 1;
            ach[k][temp] = 1;
          }
        }


        if (ach[i][j] != 1) {
          HSBColor ranColor = new HSBColor(colorbase, random(100), random(20, 100));
          fill(ranColor.h, ranColor.s, ranColor.b);
          stroke(ranColor.h, ranColor.s, ranColor.b);
          int sw = (int)random(3);
          switch(sw) {
          case 0:
            drawSpiral((int)m.x, (int)m.y, (int)m.w, (int)m.h);
            break;
          case 1:
            //drawShape(50, m.x + m.w/2, m.y + m.h/2, m.w/3);
            drawClock(50, m.x, m.y, m.w-random(m.w/1.5, m.w/2), m.w, m.h);
            //iceCreamCone(m.x, m.y, m.w, m.h);
            break;
          case 2:
            //drawPlus(m.x, m.y, m.w, m.h, 30);
            drawFootball(m.x, m.y, m.w, m.h, random(15,20));
            break;
          }
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
  strokeWeight(1);

  beginShape();
  for (int i=0;i<random(_w/5, _w/5+_w/10);i++)
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

void drawFootball(float _x, float _y, float _w, float _h, float _m) {
  float margin = _m;
  float w = _w - 2*margin;
  float h = _h - 2*margin;
  pushMatrix();
  translate(_x + 10, _y + 10);
  beginShape();
  vertex(w, 0);
  bezierVertex(w, 0, 0, 0, 0, h);
  bezierVertex(w, w, w, 0, w, 0);
  endShape();

  strokeWeight(5);
  stroke(0, 0, 100);
  float seam = w/2;
  float laces = seam/5;
  translate(w/2-seam/2, w/2);
  rotate(-0.8);
  line(0, laces, seam, laces);
  for (int i = 0; i < 5; i++) {
    line(i*laces+laces/2, laces/2, i*laces+laces/2, 1.5*laces);
  }
  popMatrix();
}

void drawClock(float _n, float _x, float _y, float _r, float _w, float _h) {
  pushMatrix();
  translate(_x+_w/2, _y+_h/2);
  float v = 400 / _n;
  stroke(0, 0, 0);
  strokeWeight(5);
  beginShape();
  for (int i = 0; i < _n; i++)
  {
    float vertexX = cos(radians(i * v) - QUARTER_PI) * _r;
    float vertexY = sin(radians(i * v) - QUARTER_PI) * _r;
    vertex(vertexX, vertexY);
  }
  endShape();

  int bh = (int) random(_n);
  int lh = (int)random(_n);

  for (int i = 0; i < _n; i++)
  {
    float vertexX = cos(radians(i * v) - QUARTER_PI) * _r/1.1;
    float vertexY = sin(radians(i * v) - QUARTER_PI) * _r/1.1;
    float vertexX1 = cos(radians(i * v) - QUARTER_PI) * _r/2;
    float vertexY1 = sin(radians(i * v) - QUARTER_PI) * _r/2;

    if (i == bh) {
      line(0, 0, vertexX, vertexY);
    } 
    if (i == lh) {
      line(0, 0, vertexX1, vertexY1);
    }
  }

  fill(0);
  ellipse(0, 0, _r/10, _r/10);

  popMatrix();
}

void iceCreamCone(float _x, float _y, float _w, float _h) {
  pushMatrix();
  translate(_x+_w/2, _y+_h/2);

  stroke(0);
  strokeWeight(1);

  ellipse(_w/4, 0, _h/4, _h/4); 
  
  quad(-_w/3, -_h/12, -_w/3, _h/12, 0, _h/8, 0, -_h/8);
  
  rectMode(CENTER);
  rect(0, 0, _h/6, _h/4);

  
  popMatrix();
}

