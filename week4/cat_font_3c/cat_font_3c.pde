import geomerative.*;


RShape catshp;
RShape catpolyshp;

RFont font;
RGroup fontgroup;

color color1;
color color2;
color color3;
color black;

float[][] points;

int counter = 0;

void setup() {
  String[] lines = loadStrings("points.txt");
  points = new float[lines.length][2];
  for (int i = 0; i < lines.length; i++) {
    String[] line = splitTokens(lines[i]);
    points[i][0] = float(line[0]);
    points[i][1] = float(lines[1]);
  }


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



  int box = 100;
  translate(0, 0);
  for (int x = 1; x < (width*height)/(box*box); x++) {
    if (counter < points.length) {
      translate(box, 0);
      if (x % (width/box) == 0) {
        translate(-width, box);
      }
      stroke(color1);
      //rect(0, 0, box, box);
      stroke(black);

      //line(0,0,box,box);

      RCommand.setSegmentLength(map(points[counter][1], 0, height, 0, 100));
      font = new RFont("FreeSansNoPunch.ttf", int(points[counter][0]), RFont.CENTER);
      fontgroup = font.toGroup("type").toPolygonGroup();

      counter++;

      float pointSeparation = 25;
      RG.setPolygonizer(RG.UNIFORMLENGTH);
      RG.setPolygonizerLength(pointSeparation);
      catpolyshp = RG.polygonize(catshp);

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
            vertex( ((catpoint.x + fontpoint.x)/2)*0.2, ((catpoint.y + fontpoint.y)/2)*0.2 + box/2);
          }
          endShape();

          //print(" mouseX:" + mouseX);
          //print(" mouseY:" + mouseY);
          //print(" text:" + fontcontour.points.length);
          //println(" cat:" + catpoints.length);
        }
      }
    }
  }
}

