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
  strokeWeight(4);
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
  RCommand.setSegmentLength(1);
  RCommand.setSegmentator(RCommand.UNIFORMLENGTH);
  //font = new RFont("FreeSansNoPunch.ttf", 100, RFont.CENTER);
  //fontgroup = font.toGroup("a").toPolygonGroup();


  catshp = RG.loadShape("cat-smaller.svg");
  //catshp = RG.centerIn(catshp, g, 100);
}

void draw() {
  background(360);
  
  RCommand.setSegmentLength(1);
  font = new RFont("FreeSansNoPunch.ttf", 400, RFont.LEFT);
  fontgroup = font.toGroup("cat fuck").toPolygonGroup();

  float pointSeparation = 25;
  RG.setPolygonizer(RG.UNIFORMLENGTH);
  RG.setPolygonizerLength(pointSeparation);
  catpolyshp = RG.polygonize(catshp);
  //translate(catpolyshp.width/2, catpolyshp.height/2);
  translate(catpolyshp.width, height/2);
  //RG.shape(catpolyshp);

  RPoint[] catpoints = catpolyshp.getPoints();

  for (int i = 0; i < catpoints.length; i++) {
    stroke(color3);
    ellipse(catpoints[i].x, catpoints[i].y, 2, 2);
  }

  for (int k = 0; k < fontgroup.elements.length; k++) {
    RPolygon fontpolygon = (RPolygon) fontgroup.elements[k];

    for (int j = 0; j < fontpolygon.contours.length; j++) {
      RContour fontcontour = fontpolygon.contours[j];

      beginShape();

      int counter = 0;
      int index = 0;
      boolean cat = true;
      if (catpoints.length > fontcontour.points.length) {
        index = catpoints.length;
      } 
      else {
        index = fontcontour.points.length;
        cat = false;
      }
      
      RPoint catpoint;
      RPoint fontpoint;
      for (int h = 0; h < index; h++) {
        if (cat) {
          catpoint = catpoints[h];
          if (counter == fontcontour.points.length - 1) {
            counter = 0;
          }
          else {
            counter++;
          }
          fontpoint = fontcontour.points[counter];
        } 
        else {
          fontpoint = fontcontour.points[h];
          if (counter == catpoints.length - 1) {
            counter = 0;
          }
          else {
            counter++;
          }
          catpoint = catpoints[counter];
        }

        stroke(black);
        vertex(((catpoint.x + k*catpolyshp.width) + fontpoint.x)/2, (catpoint.y + fontpoint.y)/2 + catpolyshp.height/4);
        //vertex((catpoint.x + fontpoint.x),(catpoint.y + fontpoint.y));
      }
      endShape();

      beginShape();
      print("text: " + fontcontour.points.length);
      println("cat: " + catpoints.length);
      for (int l = 0; l < fontcontour.points.length; l++) {
        fontpoint = fontcontour.points[l];
        stroke(color2);
        ellipse(fontpoint.x, fontpoint.y + catpolyshp.height/2, 2, 2);
      }
      endShape();
    }
  }
}

