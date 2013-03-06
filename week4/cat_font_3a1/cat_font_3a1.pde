import geomerative.*;


RShape catshp;
RShape catpolyshp;

RFont font;
RGroup fontgroup;

color color1;
color color2;
color color3;
color black;

void setup() {
  size(1200, 800);
  colorMode(HSB, 360, 100, 100);
  background(360);
  strokeWeight(2);
  strokeJoin(ROUND);
  strokeCap(SQUARE);

  noFill();
  //noLoop();

  color1 = color(300, 65, 90);
  int leftHue = (300 + 240) % 360;
  int rightHue = (300 + 120) % 360;
  color2 = color(leftHue, 65, 90);
  color3 = color(rightHue, 65, 90);
  black = color(0, 0, 0);

  RG.init(this);
  //RCommand.setSegmentator(RCommand.ADAPTATIVE);
  RCommand.setSegmentator(RCommand.UNIFORMLENGTH);
  //RCommand.setSegmentLength(10);
  //font = new RFont("FreeSansNoPunch.ttf", 100, RFont.CENTER);
  //fontgroup = font.toGroup("a").toPolygonGroup();


  catshp = RG.loadShape("cat-small.svg");
  //catshp = RG.centerIn(catshp, g, 100);
  float pointSeparation = 5;
  RG.setPolygonizer(RG.UNIFORMLENGTH);
  RG.setPolygonizerLength(pointSeparation);
  catpolyshp = RG.polygonize(catshp);
}

void draw() {
  background(360);

  //translate(catpolyshp.width/2, catpolyshp.height/2);
  translate(100, 100);
  //RG.shape(catpolyshp);

  RPoint[] catpoints = catpolyshp.getPoints();
  
  //RCommand.setSegmentLength(map(height - mouseY, 0, height, 0, 100));
  RCommand.setSegmentLength(10);
  font = new RFont("FreeSansNoPunch.ttf", mouseX, RFont.LEFT);
  fontgroup = font.toGroup("cat").toPolygonGroup();

  for (int i = 0; i < catpoints.length; i++) {
    stroke(color3);
    ellipse(catpoints[i].x, catpoints[i].y, 2, 2);
  }

  for (int k = 0; k < fontgroup.elements.length; k++) {
    RPolygon fontpolygon = (RPolygon) fontgroup.elements[k];

    for (int j = 0; j < fontpolygon.contours.length; j++) {
      RContour fontcontour = fontpolygon.contours[j];

      beginShape();

      int index = 0;
      if (catpoints.length < fontcontour.points.length) {
        index = catpoints.length;
      } 
      else {
        index = fontcontour.points.length;
      }

      RPoint catpoint;
      RPoint fontpoint;
      for (int h = 0; h < index; h++) {
        catpoint = catpoints[h]; 
        fontpoint = fontcontour.points[h];


        stroke(black);
        vertex(((catpoint.x + k*catpolyshp.width) + fontpoint.x)/2, (catpoint.y + fontpoint.y)/2 + catpolyshp.height/4);
        //vertex((catpoint.x + fontpoint.x),(catpoint.y + fontpoint.y));
      }
      endShape();

      beginShape();
      print(" text:" + fontcontour.points.length);
      println(" cat:" + catpoints.length);
      for (int l = 0; l < fontcontour.points.length; l++) {
        fontpoint = fontcontour.points[l];
        stroke(color3);
        ellipse(fontpoint.x + catpolyshp.width/2, fontpoint.y + catpolyshp.height, 2, 2);
      }
      endShape();
    }
  }
}

