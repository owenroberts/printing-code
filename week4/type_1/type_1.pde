import geomerative.*;

RFont leviFont;
RFont font;
RPolygon polygon;

size(1280, 800);
colorMode(HSB, 360, 100, 100);
background(360);

RG.init(this);
font = new RFont("FreeSansNoPunch.ttf", 200, RFont.LEFT);
leviFont = new RFont("levifont4.ttf", 200, RFont.LEFT);

RCommand.setSegmentLength(10);
RCommand.setSegmentator(RCommand.UNIFORMLENGTH);

RGroup group = font.toGroup("type").toPolygonGroup();
boolean firstLetter = true;

for (int k = 0; k < group.elements.length; k++) {

  polygon = (RPolygon) group.elements[k];

  if (firstLetter) {
    translate((polygon.getWidth() / 2), (height / 4) + (polygon.getHeight() / 2));
    firstLetter = false;
  }
  
  for ( int i = 0; i < polygon.contours.length; i++) {
    RContour curContour = polygon.contours[i];
    beginShape();

    for ( int j = 0; j < curContour.points.length; j++) {
      RPoint curPoint = curContour.points[j];
      curPoint.x += random(-2, 2);
      curPoint.y += random(-2, 2);

      vertex(curPoint.x, curPoint.y);
    }
    endShape();
  }
}

RGroup group2 = leviFont.toGroup("TYPE").toPolygonGroup();
firstLetter = true;

for (int k = 0; k < group2.elements.length; k++) {

  RPolygon levi = (RPolygon) group2.elements[k];

  if (firstLetter) {
    translate(0, (height / 4) + (levi.getHeight() / 2));
    firstLetter = false;
  }
  
  for ( int i = 0; i < levi.contours.length; i++) {
    RContour curContour = levi.contours[i];
    beginShape();

    for ( int j = 0; j < curContour.points.length; j++) {
      RPoint curPoint = curContour.points[j];
      curPoint.x += random(-2, 2);
      curPoint.y += random(-2, 2);

      vertex(curPoint.x, curPoint.y);
    }
    endShape();
  }
}

