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
  frameRate(4);
  size(1200, 800);
  colorMode(HSB, 360, 100, 100);
  background(360);
  strokeWeight(1);
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
  RCommand.setSegmentator(RCommand.UNIFORMLENGTH);
  //RCommand.setSegmentLength(10);
  //font = new RFont("FreeSansNoPunch.ttf", 100, RFont.CENTER);
  //fontgroup = font.toGroup("a").toPolygonGroup();


  catshp = RG.loadShape("cat.svg");
  catshp = RG.centerIn(catshp, g, 100);
}

void draw() {
  background(360);
  
  print(mouseX + " ");
  println(mouseY);
  
  

  RCommand.setSegmentLength(map(height - mouseY, 0, height, 0, 100));
  font = new RFont("FreeSansNoPunch.ttf", mouseX, RFont.CENTER);
  fontgroup = font.toGroup("type").toPolygonGroup();

  float pointSeparation = 25;
  RG.setPolygonizer(RG.UNIFORMLENGTH);
  RG.setPolygonizerLength(pointSeparation);
  catpolyshp = RG.polygonize(catshp);
  //translate(catpolyshp.width/2, catpolyshp.height/2);
  translate(width/2, height/2);

  RPoint[] catpoints = catpolyshp.getPoints();

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
        vertex( ((catpoint.x + fontpoint.x)/2)*0.2, ((catpoint.y + fontpoint.y)/2)*0.2 );
      }
      endShape();
      
      
//      print(" mouseX:" + mouseX);
//      print(" mouseY:" + mouseY);
//      print(" text:" + fontcontour.points.length);
//      println(" cat:" + catpoints.length);

    }
  }
}

