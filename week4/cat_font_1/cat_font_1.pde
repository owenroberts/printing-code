import geomerative.*;


RShape catshp;
RShape catpolyshp;

RFont font;
RGroup fontgroup;

void setup() {
  size(1200, 800);
  
  noFill();

  RG.init(this);
  font = new RFont("FreeSansNoPunch.ttf", 900, RFont.LEFT);
  fontgroup = font.toGroup("a").toPolygonGroup();
  

  catshp = RG.loadShape("cat.svg");
  catshp = RG.centerIn(catshp, g, 100);

  RCommand.setSegmentLength(4);
  RCommand.setSegmentator(RCommand.UNIFORMLENGTH);
}

void draw() {
  background(255);

  float pointSeparation = 25;
  RG.setPolygonizer(RG.UNIFORMLENGTH);
  RG.setPolygonizerLength(pointSeparation);
  catpolyshp = RG.polygonize(catshp);
  translate(catpolyshp.width/2, catpolyshp.height/2);
  //RG.shape(catpolyshp);

  RPoint[] catpoints = catpolyshp.getPoints();

  for (int i = 0; i < catpoints.length; i++) {
    ellipse(catpoints[i].x, catpoints[i].y, 2, 2);
  }

  for (int k = 0; k < fontgroup.elements.length; k++) {
    RPolygon fontpolygon = (RPolygon) fontgroup.elements[k];

    for (int j = 0; j < fontpolygon.contours.length; j++) {
      RContour fontcontour = fontpolygon.contours[j];

      beginShape();

      int counter = 0;
      for (int h = 0; h < catpoints.length; h++) {
        println(counter);
        println(h);
        //grab the two points
        RPoint catpoint = catpoints[h];
        if (counter == fontcontour.points.length - 1) {
          counter = 0;
        }
        else {
          counter++;
        }
        RPoint fontpoint = fontcontour.points[counter];
        vertex((catpoint.x + fontpoint.x)/2,(catpoint.y + fontpoint.y)/2);
        
      }
      endShape();
    }
  }
}

