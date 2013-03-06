import geomerative.*;
import fontastic.*;

Fontastic f;

int version = 0;


RShape catshp;
RShape catpolyshp;
RPoint[] catpoints;

int butt = 1;

color color1;
color color2;
color color3;
color black;

void setup() {
  size(600, 400);
  fill(0);
  createFont();
  colorMode(HSB, 360, 100, 100);
  background(360);
  strokeWeight(2);
  strokeJoin(ROUND);
  strokeCap(SQUARE);

  //noFill();
  //noLoop();

  color1 = color(300, 65, 90);
  int leftHue = (300 + 240) % 360;
  int rightHue = (300 + 120) % 360;
  color2 = color(leftHue, 65, 90);
  color3 = color(rightHue, 65, 90);
  black = color(0, 0, 0);

  RG.init(this);


  
  
}

void draw() {
  background(360);

  PFont myFont = createFont(f.getTTFfilename(), 64);

  textFont(myFont);
  textAlign(CENTER, CENTER);
  text(Fontastic.alphabet, 0, Fontastic.alphabet.length/2, width/2, height/5);
  text(Fontastic.alphabet, Fontastic.alphabet.length/2, Fontastic.alphabet.length, width/2, height/5*2);

  text(Fontastic.alphabetLc, 0, Fontastic.alphabet.length/2, width/2, height/5*3);
  text(Fontastic.alphabetLc, Fontastic.alphabet.length/2, Fontastic.alphabet.length, width/2, height/5*4);

  noLoop();
}

void createFont() {
  RG.init(this);
  catshp = RG.loadShape("cat1.svg");
  //catshp = RG.centerIn(catshp, g, 100);
  float pointSeparation = 40;
  RG.setPolygonizer(RG.UNIFORMLENGTH);
  RG.setPolygonizerLength(pointSeparation);
  catpolyshp = RG.polygonize(catshp);
  catpoints = catpolyshp.getPoints();

  version++;

  if (f != null) { 
    f.cleanup();
  }

  f = new Fontastic(this, "CatFont" + nf(version, 4));

  f.setAuthor("Owen Ribbit");
  f.setVersion("1.0");
  f.setAdvanceWidth(600);

  // go through alphabet and create contours for each glyph
  for (char c : Fontastic.alphabet) {

    // create a PVector array with 4 random coordinates
    //PVector[] points = new PVector[catpoints.length];
    
    PVector[] points = new PVector[catpoints.length];
    //println(points[0].x + " " + catpoints[0]);
    for (int i = 0; i < catpoints.length; i++) {
      points[i] = new PVector();
      points[i].x = catpoints[i].x;
      points[i].y = catpoints[i].y;
    }

    
    f.addGlyph(c).addContour(points);

    PVector[] pointsLc = new PVector[points.length];

    // and to the same for lowercase characters. The contour gets scaled down by 50% in y.
    for (int i=0; i<pointsLc.length; i++) {
      pointsLc[i] = new PVector();
      pointsLc[i].x = points[i].x;
      pointsLc[i].y = points[i].y * 0.5;
    }

    f.addGlyph(Character.toLowerCase(c)).addContour(pointsLc);
  }

  f.buildFont();
  f.cleanup();
}

void keyPressed() {

  if (key == ' ') {
    createFont();
    loop();
  }
}

