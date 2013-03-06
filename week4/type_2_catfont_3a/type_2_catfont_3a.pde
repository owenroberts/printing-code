import geomerative.*;

RGroup freegroup;
RGroup catgroup;
RFont freefont;
RFont catfont;
RPolygon polygon;

color color1;
color color2;
color color3;
color black;



void setup() {
  size(1280, 800);
  colorMode(HSB, 360, 100, 100);
  background(360);

  strokeWeight(1);
  strokeJoin(ROUND);
  strokeCap(SQUARE);

  noLoop();

  color1 = color(300, 65, 90);
  int leftHue = (300 + 240) % 360;
  int rightHue = (300 + 120) % 360;
  color2 = color(leftHue, 65, 90);
  color3 = color(rightHue, 65, 90);
  black = color(0, 0, 0);

  RG.init(this);
  freefont = new RFont("FreeSansNoPunch.ttf", 200, RFont.LEFT);
  catfont = new RFont("CatFont1.ttf", 200, RFont.LEFT);

  RCommand.setSegmentator(RCommand.UNIFORMLENGTH);
}
void draw() {
  background(360);

  RCommand.setSegmentLength(10);
  freegroup = freefont.toGroup("cat").toPolygonGroup();
  RCommand.setSegmentLength(10);
  catgroup = catfont.toGroup("BBB").toPolygonGroup();

  boolean firstLetter = true;

  for (int k = 0; k < freegroup.elements.length; k++) {

    polygon = (RPolygon) freegroup.elements[k];

    if (firstLetter) {
      translate((polygon.getWidth() / 2), (height / 4) + (polygon.getHeight() / 2));
      firstLetter = false;
    }

    for ( int i = 0; i < polygon.contours.length; i++) {
      RContour curContour = polygon.contours[i];
      beginShape();

      for ( int j = 0; j < curContour.points.length; j++) {
        RPoint curPoint = curContour.points[j];
        ellipse(curPoint.x, curPoint.y, 1, 1);
      }
      endShape();
    }
  }
  
  firstLetter = true;

  for (int k = 0; k < catgroup.elements.length; k++) {

    polygon = (RPolygon) catgroup.elements[k];

    if (firstLetter) {
      translate((polygon.getWidth() / 2), (height / 2) + (polygon.getHeight() / 2));
      firstLetter = false;
    }

    for ( int i = 0; i < polygon.contours.length; i++) {
      RContour curContour = polygon.contours[i];
      beginShape();

      for ( int j = 0; j < curContour.points.length; j++) {
        RPoint curPoint = curContour.points[j];
        ellipse(curPoint.x, curPoint.y, 1, 1);
      }
      endShape();
    }
  }


    for (int k = 0; k < catgroup.elements.length; k++) {

      RPolygon free = (RPolygon) freegroup.elements[k];
      RPolygon cat = (RPolygon) catgroup.elements[k];

      if (firstLetter) {
        translate((free.getWidth() / 2), (height / 4) + (free.getHeight() / 2));
        firstLetter = false;
      }

      int contourindex = 0;
      println(free.contours.length + " " + cat.contours.length);
      if (free.contours.length > cat.contours.length) {
        contourindex = cat.contours.length;
      } 
      else {
        contourindex = free.contours.length;
      }

      RContour freecontour;
      RContour catcontour;
      for ( int i = 0; i < contourindex; i++) {
        catcontour = cat.contours[i];
        freecontour = free.contours[i];

        beginShape();

        int pointindex = 0;
        println(freecontour.points.length + " " + catcontour.points.length);
        if (freecontour.points.length > catcontour.points.length) {
          pointindex = catcontour.points.length;
        } 
        else {
          pointindex = freecontour.points.length;
        }

        RPoint catpoint;
        RPoint freepoint;
        for ( int j = 0; j < pointindex; j++) {
          catpoint = catcontour.points[j];
          freepoint = freecontour.points[j];

          stroke(black);
          vertex(freepoint.x + catpoint.x / 2, freepoint.y + catpoint.y / 2);

        }
      }
      endShape();
    }
  }


