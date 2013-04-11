float d = 5;
float num = 8;



void setup() {
  size(800, 700);
  noStroke();

  background(255);
  colorMode(HSB, 360, 100, 100);
  fill(0, 80, 80);

  ModularGrid grid = new ModularGrid(8, 8, 5, 0);

  for (int i = 0; i < num; i++) {
    Module m = grid.modules[(int)random(grid.cols-1)][(int)random(grid.rows)];
    drawRect(m.x, m.y);
  }
}

void drawRect(float _x, float _y) {
  float side = random(50, 200);
  float x = _x + random(-d, d);
  float y = _y + random(-d, d);

  quad(x, y, 
  x + side + random(-d, d), y +random(-d, d), 
  x + side + random(-d, d), y + side + random(d, d), 
  x + random(-d, d), y + side + random(-d, d));

}

