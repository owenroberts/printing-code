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
  strokeWeight(2);
  strokeJoin(ROUND);
  strokeCap(SQUARE);

  color1 = color(300, 65, 90);
  int leftHue = (300 + 240) % 360;
  int rightHue = (300 + 120) % 360;
  color2 = color(leftHue, 65, 90);
  color3 = color(rightHue, 65, 90);


  RCommand.setSegmentLength(4);
  RCommand.setSegmentator(RCommand.UNIFORMLENGTH);
}

void draw() {
  RG.init(this);
  RFont font = new RFont("FreeSansNoPunch.ttf", 50, RFont.LEFT);

  RGroup group = font.toGroup("type").toPolygonGroup();
  RGroup group2 = font.toGroup("there once was a cat").toPolygonGroup();
  println(group2.elements.length);



  // COMBINED
  int counter3 = 0;
  for (int k = 0; k < group2.elements.length; k++) {
    
    if (k > group.elements.length - 1) {
      counter3++;
    }
      
    RPolygon word = (RPolygon) group.elements[k - counter3];
    RPolygon text = (RPolygon) group2.elements[k];

    if (firstLetter) {
      translate((text.getWidth() / 2), (height / 4) + (text.getHeight() / 2));
      firstLetter = false;
    }

    int counter = 0;
    for ( int i = 0; i < text.contours.length; i++) {
      RContour tContour = text.contours[i];
      if (i > word.contours.length - 1) {
        counter++;
      } 
      RContour wContour = word.contours[i - counter];

      beginShape();

      int counter2 = 0;
      for ( int j = 0; j < tContour.points.length; j++) {
        RPoint tPoint = tContour.points[j];
        if ( j > wContour.points.length - 1) {
          counter2++;
        }
        RPoint wPoint = wContour.points[j - counter2];
        vertex((tPoint.x + wPoint.x) / 2, (tPoint.y + wPoint.y) / 2);
        //ellipse((tPoint.x + wPoint.x) / 2, (tPoint.y + wPoint.y) / 2, 2, 2);
        //ellipse(wPoint.x, wPoint.y, 2, 2);
       // ellipse(tPoint.x, tPoint.y, 1, 1);
      }
      endShape();
    }
  }
}




