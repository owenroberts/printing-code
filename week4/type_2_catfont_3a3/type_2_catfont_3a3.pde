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

  //noFill();
  //noLoop();

  color1 = color(300, 65, 90);
  int leftHue = (300 + 240) % 360;
  int rightHue = (300 + 120) % 360;
  color2 = color(leftHue, 65, 90);
  color3 = color(rightHue, 65, 90);
  black = color(0, 0, 0);

  RG.init(this);
  freefont = new RFont("FreeSansNoPunch.ttf", 100, RFont.LEFT);
  catfont = new RFont("CatFont1.ttf", 100, RFont.LEFT);

  RCommand.setSegmentator(RCommand.UNIFORMLENGTH);
}
void draw() {
  background(360);

  RCommand.setSegmentLength(map(mouseY, 0, width, 0, 100));
  freegroup = freefont.toGroup("abcdefghijklmnopqrstuvwxyz").toPolygonGroup();
  RCommand.setSegmentLength(map(mouseX, 0, width, 0, 100));
  catgroup = catfont.toGroup("BBBBBBBBBBBBBBBBBBBBBBBBBB").toPolygonGroup();

  boolean firstLetter = true;

  for (int k = 0; k < freegroup.elements.length; k++) {
    RPolygon free = (RPolygon) freegroup.elements[k];
    RPolygon cat = (RPolygon) catgroup.elements[k];

    if (firstLetter) {
      translate(50, 50 + free.getHeight());
      firstLetter = false;
    }
    RContour catc;
    for (int i = 0; i < free.contours.length; i++) {
      RContour freec = free.contours[i];
      if (i < cat.contours.length) {
        catc = cat.contours[i];
      } else {
        catc = cat.contours[0];
      }

      beginShape();

      for (int j = 0; j < freec.points.length; j++) {
        RPoint freep = freec.points[j];
        if (j < catc.points.length) {
          RPoint catp = catc.points[j];
          vertex((freep.x + catp.x) / 2, (freep.y + catp.y) / 2);
        } 
        else {
          vertex(freep.x, freep.y);
        }
      }
      endShape();
    }
  }
  
  RCommand.setSegmentLength(map(mouseY, 0, width, 0, 100));
  catgroup = freefont.toGroup("abcdefghijklmnopqrstuvwxyz").toPolygonGroup();
  RCommand.setSegmentLength(map(mouseX, 0, width, 0, 100));
  freegroup = catfont.toGroup("BBBBBBBBBBBBBBBBBBBBBBBBBB").toPolygonGroup();

  firstLetter = true;

  for (int k = 0; k < freegroup.elements.length; k++) {
    RPolygon free = (RPolygon) freegroup.elements[k];
    RPolygon cat = (RPolygon) catgroup.elements[k];

    if (firstLetter) {
      translate(0, height/2);
      firstLetter = false;
    }
    RContour catc;
    for (int i = 0; i < free.contours.length; i++) {
      RContour freec = free.contours[i];
      if (i < cat.contours.length) {
        catc = cat.contours[i];
      } else {
        catc = cat.contours[0];
      }

      beginShape();

      for (int j = 0; j < freec.points.length; j++) {
        RPoint freep = freec.points[j];
        if (j < catc.points.length) {
          RPoint catp = catc.points[j];
          vertex((freep.x + catp.x) / 2, (freep.y + catp.y) / 2);
        } 
        else {
          vertex(freep.x, freep.y);
        }
      }
      endShape();
    }
  }
}

