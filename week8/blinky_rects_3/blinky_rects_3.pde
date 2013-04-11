import processing.pdf.*;

float d = 5;
float num = 8;
int[][] quads = new int[(int)num][8];

void setup() {

  size(800, 700);
  beginRecord(PDF, "imgs/" + getClass() + day() + hour() + minute() + second() +".pdf");

  //noStroke();

  background(255);
  colorMode(HSB, 360, 100, 100);
  fill(0, 80, 80);

  for (int i = 0; i < num; i++) 
    drawRect(i);

  for (int h = 0; h < num; h++) {
    print(h + " --- ");
    for (int k = 0; k < 8; k++) {
      print(k + ": " + quads[h][k] + ", ");
    }
    println();
  }
}

void drawRect(int n) {

  boolean check = false;

  int side = (int)random(50, 200);
  int x = (int)random(width-side);
  int y = (int)random(height-side);
  quads[n][0] = x;
  quads[n][1] = y;
  quads[n][2] = x + side + (int)random(-d, d);
  quads[n][3] = y + (int)random(-d, d);
  quads[n][4] = x + side + (int)random(-d, d);
  quads[n][5] = y + side + (int)random(d, d);
  quads[n][6] = x + (int)random(-d, d);
  quads[n][7] =  y + side + (int)random(-d, d);


  for (int i = 0; i < n; i++) {
    if (overlap(quads[i], quads[n])) 
      check = true;
    if (overlap(quads[n], quads[i])) 
      check = true;
    
  }

  println(n+" "+check);

  if (check) {
    fill(0, 0);
    quad(quads[n][0], quads[n][1], quads[n][2], quads[n][3], 
    quads[n][4], quads[n][5], quads[n][6], quads[n][7]);
    drawRect(n);
  } 
  else {
    fill(0, 80, 80);  
    quad(quads[n][0], quads[n][1], quads[n][2], quads[n][3], 
    quads[n][4], quads[n][5], quads[n][6], quads[n][7]);
  }
}

boolean overlap(int[] sh1, int[] sh2) {
  println();
  print("sh1" + " --- ");
  for (int k = 0; k < 8; k++) {
    print(k + ": " + sh1[k] + ", ");
  }
  println();
  print("sh2" + " --- ");
  for (int k = 0; k < 8; k++) {
    print(k + ": " + sh2[k] + ", ");
  }
  println();

  boolean x = false;
  boolean y = false;

  if (sh1[0] >= sh2[0] && sh1[0] <= sh2[4]) {
    x = true;
  } 
  if (sh1[4] >= sh2[0] && sh1[4] <= sh2[4]) {
    x = true;
  } 
  if (sh1[1] >= sh2[1] && sh1[1] <= sh2[5]) {
    y = true;
  } 
  if (sh1[5] >= sh2[1] && sh1[5] <= sh2[5]) {
    y = true;
  } 

  if (x && y) {
    return true;
  }  else {
    return false;
  }
}

void draw() {
}

void keyPressed() {
  if (key == ENTER) {
    endRecord();
  }
}

