import geomerative.*;

size(1280, 800);
colorMode(HSB, 360, 100, 100);
background(360);

RG.init(this);
RFont font = new RFont("FreeSansNoPunch.ttf", 200, RFont.LEFT);
RFont leviFont = new RFont("levifont4.ttf", 200, RFont.LEFT);

RCommand.setSegmentLength(10);
RCommand.setSegmentator(RCommand.UNIFORMLENGTH);

RGroup group = font.toGroup("type").toPolygonGroup();
RGroup group2 = leviFont.toGroup("TYPE").toPolygonGroup();

boolean firstLetter = true;

for (int k = 0; k < group.elements.length; k++) {

  RPolygon polygon = (RPolygon) group.elements[k];
  RPolygon levi = (RPolygon) group2.elements[k];

  if (firstLetter) {
    translate((polygon.getWidth() / 2), (height / 4) + (polygon.getHeight() / 2));
    firstLetter = false;
  }

  for ( int i = 0; i < polygon.contours.length; i++) {
    RContour pContour = polygon.contours[i];
    RContour lContour = levi.contours[i];
    beginShape();

    for ( int j = 0; j < pContour.points.length; j++) {
      RPoint pPoint = pContour.points[j];
      if ( j < lContour.points.length) {
        RPoint lPoint = lContour.points[j];
        vertex(pPoint.x + lPoint.x / 2, pPoint.y + lPoint.y / 2);
      } else {
      vertex(pPoint.x, pPoint.y);
      }
    }
    endShape();
  }
}


