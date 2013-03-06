import geomerative.*;

size(1280, 800);
colorMode(HSB, 360, 100, 100);
background(360);

color color1;
color color2;
color color3;
color black;
strokeWeight(2);
strokeJoin(ROUND);
strokeCap(SQUARE);
color1 = color(300, 65, 90);
int leftHue = (300 + 240) % 360;
int rightHue = (300 + 120) % 360;
color2 = color(leftHue, 65, 90);
color3 = color(rightHue, 65, 90);
black = color(0, 0, 0);

RG.init(this);
RFont freefont = new RFont("FreeSansNoPunch.ttf", 200, RFont.LEFT);
RFont catfont = new RFont("CatFont1.ttf", 200, RFont.LEFT);

RCommand.setSegmentLength(mouseX);
RCommand.setSegmentator(RCommand.UNIFORMLENGTH);

RGroup freegroup = freefont.toGroup("CAT IS FAT").toPolygonGroup();
RGroup catgroup = catfont.toGroup("BBBBBB").toPolygonGroup();

boolean firstLetter = true;

for (int k = 0; k < catgroup.elements.length; k++) {

  RPolygon free = (RPolygon) freegroup.elements[k];
  RPolygon cat = (RPolygon) catgroup.elements[k];

  if (firstLetter) {
    translate((free.getWidth() / 2), (height / 4) + (free.getHeight() / 2));
    firstLetter = false;
  }

  int contourindex = 0;
  boolean catcs = true;
  if (free.contours.length < cat.contours.length) {
    contourindex = cat.contours.length;
  } 
  else {
    contourindex = free.contours.length; 
    catcs = false;
  }

  int contourcounter = 0;
  RContour freecontour;
  RContour catcontour;

  for ( int i = 0; i < contourindex; i++) {
    if (catcs) {
      catcontour = cat.contours[i];
      if (contourcounter == free.contours.length - 1) {
        contourcounter = 0;
      } 
      else {
        contourcounter++;
      }
      freecontour = free.contours[contourcounter];
    } 
    else {
      freecontour = free.contours[i];
      if (contourcounter == cat.contours.length - 1) {
        contourcounter = 0;
      } 
      else {
        contourcounter++;
      }
      catcontour = cat.contours[contourcounter];
    }

    beginShape();

    int pointindex = 0;
    boolean catps = true;
    if (freecontour.points.length < catcontour.points.length) {
      pointindex = catcontour.points.length;
    } 
    else {
      pointindex = freecontour.points.length;
      catps = false;
    }

    RPoint catpoint;
    RPoint freepoint;
    int pointcounter = 0;
    for ( int j = 0; j < pointindex; j++) {
      if (catps) {
        catpoint = catcontour.points[j];
        if (pointcounter == freecontour.points.length - 1) {
          pointcounter = 0;
        } 
        else {
          pointcounter++;
        }
        freepoint = freecontour.points[pointcounter];
      } 
      else {
        freepoint = freecontour.points[j];

        if (pointcounter == catcontour.points.length - 1) {
          pointcounter = 0;
        } 
        else {
          pointcounter++;
        }
        catpoint = catcontour.points[pointcounter];
      }

      stroke(black);
      vertex(freepoint.x + catpoint.x / 2, freepoint.y + catpoint.y / 2);
      stroke(color1);
      //vertex(catpoint.x, catpoint.y);
    }
  }
  endShape();
}

