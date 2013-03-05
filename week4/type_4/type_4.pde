import geomerative.*;

boolean firstLetter = true;

color color1;
color color2;
color color3;

void setup() {
  size(1280, 800);
  colorMode(HSB, 360, 100, 100);
  background(360);
  noFill();
  noLoop();
  strokeWeight(5);
  strokeJoin(ROUND);
  strokeCap(SQUARE);

  color1 = color(300, 65, 90);
  int leftHue = (300 + 240) % 360;
  int rightHue = (300 + 120) % 360;
  color2 = color(leftHue, 65, 90);
  color3 = color(rightHue, 65, 90);


  RCommand.setSegmentLength(20);
  RCommand.setSegmentator(RCommand.UNIFORMLENGTH);
}

void draw() {
  RG.init(this);
  RFont font = new RFont("FreeSansNoPunch.ttf", 300, RFont.LEFT);
  RFont leviFont = new RFont("levifont4.ttf", 300, RFont.LEFT);

  RGroup group = font.toGroup("fuck a bitch").toPolygonGroup();
  RGroup group2 = leviFont.toGroup("FUCK A BITCH").toPolygonGroup();



  // COMBINED
  for (int k = 0; k < group.elements.length; k++) {

    RPolygon polygon = (RPolygon) group.elements[k];
    RPolygon levi = (RPolygon) group2.elements[k];

    if (firstLetter) {
      translate((polygon.getWidth() / 2), (height / 4) + (polygon.getHeight() / 2));
      firstLetter = false;
    }

    int counter = 0;
    for ( int i = 0; i < levi.contours.length; i++) {
      RContour lContour = levi.contours[i];
      if (i > polygon.contours.length - 1) {
        counter++;
      } 
      RContour pContour = polygon.contours[i - counter];

      beginShape();

      int counter2 = 0;
      for ( int j = 0; j < lContour.points.length; j++) {
        RPoint lPoint = lContour.points[j];
        if ( j > pContour.points.length - 1) {
          counter2++;
        }
        RPoint pPoint = pContour.points[j - counter2];
        vertex((pPoint.x + lPoint.x) / 2, (pPoint.y + lPoint.y) / 2);
        //ellipse((pPoint.x + lPoint.x) / 2, (pPoint.y + lPoint.y) / 2, 2, 2);
        //ellipse(pPoint.x, pPoint.y, 2, 2);
        //ellipse(lPoint.x, lPoint.y, 2, 2);
      }
      endShape();
    }
  }


  firstLetter = true;
  //FREESANS
  for (int k = 0; k < group.elements.length; k++) {

    RPolygon polygon = (RPolygon) group.elements[k];

    if (firstLetter) {
      translate((polygon.getWidth() / 2), (height / 3) + (polygon.getHeight() / 2));
      firstLetter = false;
    }

    for ( int i = 0; i < polygon.contours.length; i++) {
      RContour pContour = polygon.contours[i];
      beginShape();

      for ( int j = 0; j < pContour.points.length; j++) {
        RPoint pPoint = pContour.points[j];
        stroke(color1);
        vertex(pPoint.x, pPoint.y);
      }

      endShape();
    }
  }

  //LEVIFONT
  for (int k = 0; k < group2.elements.length; k++) {

    RPolygon levi = (RPolygon) group2.elements[k];
    RPolygon polygon = (RPolygon) group.elements[k];

    for ( int i = 0; i < levi.contours.length; i++) {
      RContour lContour = levi.contours[i];
      beginShape();

      for ( int j = 0; j < lContour.points.length; j++) {
        RPoint lPoint = lContour.points[j];
        stroke(color2 );
        vertex(lPoint.x, lPoint.y);
      }

      endShape();
    }
  }
}

