float d = 5;
float num = 8;
int[][] quads = new int[8][8];

void setup() {
  size(800, 700);
  noStroke();

  background(255);
  colorMode(HSB, 360, 100, 100);
  fill(0, 80, 80);

  for (int i = 0; i < num; i++) 
    drawRect(i);
}

void drawRect(int num) {

  boolean check = false;

  int side = (int)random(50, 200);
  int x = (int)random(width-side);
  int y = (int)random(height-side);
  quads[num][0] = x;
  quads[num][1] = y;
  quads[num][2] = x + side + (int)random(-d, d);
  quads[num][3] = y + (int)random(-d, d);
  quads[num][4] = x + side + (int)random(-d, d);
  quads[num][5] = y + side + (int)random(d, d);
  quads[num][6] = x + (int)random(-d, d);
  quads[num][7] =  y + side + (int)random(-d, d);

  for (int i = 0; i < num -1; i++) {
    if (overlap(quads[i], quads[num])) {
      check = true;
    }
  }

  if (check) {
    drawRect(num);
  } 
  else {  
    quad(quads[num][0], quads[num][1], quads[num][2], quads[num][3], 
    quads[num][4], quads[num][5], quads[num][6], quads[num][7]);
  }
}

boolean overlap(int[] sh1, int[] sh2) {
  if (sh1[0] >= sh2[0] && sh1[0] <= sh2[4]) {
    return true;
  } else if (sh1[4] >= sh2[0] && sh1[6] <= sh2[4]) {
    return true;
  } else if (sh1[2] >= sh2[2] && sh1[2] <= sh2[5]) {
    return true;
  } else if (sh1[5] >= sh2[2] && sh2[5] <= sh2[5]) {
    return true;
  } else {
    return false;
  }
  
}

