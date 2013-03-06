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
  RCommand.setSegmentLength(10);
  RCommand.setSegmentator(RCommand.UNIFORMLENGTH);

  font = new RFont("FreeSansNoPunch.ttf", 300, RFont.LEFT);


  catshp = RG.loadShape("cat-small.svg");
  //catshp = RG.centerIn(catshp, g, 100);
  float pointSeparation = 40;
  RG.setPolygonizer(RG.UNIFORMLENGTH);
  RG.setPolygonizerLength(pointSeparation);
  catpolyshp = RG.polygonize(catshp);
}

void draw() {
  background(360);

  String myString = "cat";
  translate(-catpolyshp.width, 0);

  for (int i = 0; i < myString.length(); i++) {
    String str = str(myString.charAt(i));
    RCommand.setSegmentLength(map(mouseX, 0, width, 0, 100));  
    fontgroup = font.toGroup(str).toPolygonGroup();
    createLetter(fontgroup, catpolyshp, i);
  }
}

void createLetter(RGroup f, RShape c, int w) {

  catpolyshp = c;
  fontgroup = f;
  
  println(w);

  RPoint[] catpoints = catpolyshp.getPoints();

  translate(catpolyshp.width, 0);


  for (int k = 0; k < fontgroup.elements.length; k++) {
    textSize(14);
    fill(black);
    //text("k" + k, k*catpolyshp.width, catpolyshp.height);
    noFill();

    for (int i = 0; i < catpoints.length; i++) {
      stroke(color3);
      ellipse(catpoints[i].x + k*catpolyshp.width, catpoints[i].y, 1, 1);
    }

    RPolygon fontpolygon = (RPolygon) fontgroup.elements[k];
    //println(fontpolygon.width);

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
      float fontpolywidth = 0;
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

        if ( h < fontcontour.points.length) {
          if (fontcontour.points[h].x > fontpolywidth) {
            fontpolywidth = fontcontour.points[h].x;
          }
        }


        stroke(black);
        vertex(((catpoint.x + k*catpolyshp.width) + fontpoint.x)/2, (catpoint.y + fontpoint.y)/2 + catpolyshp.height/4);
        //vertex((catpoint.x + fontpoint.x),(catpoint.y + fontpoint.y));
      }
      endShape();

      beginShape();
      //print(" text:" + fontcontour.points.length);
      //println(" cat:" + catpoints.length);
      for (int l = 0; l < fontcontour.points.length; l++) {
        fontpoint = fontcontour.points[l];
        stroke(color2);
        ellipse(fontpoint.x + k*catpolyshp.width + (catpolyshp.width-fontpolywidth)/2, fontpoint.y + catpolyshp.height, 1, 1);
      }
      endShape();
    }
  }
}

