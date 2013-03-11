import geomerative.*;


void setup() {
  size(int(800/1.2), int(1200/1.2));
  background(255);
  colorMode(HSB, 360, 100, 100);
  
  //SETTING UP MANUSCRIPT GRID
  ColumnGrid columnGrid = new ColumnGrid(1, 25);
  columnGrid.display();
  
  //MODULAR GRID
  NewMGrid moduleGrid = new NewMGrid(1, 8, 10, 75);
  moduleGrid.display();
  Module m1 = moduleGrid.modules[0][0];
  float fontSize = m1.h;
  String btc = "Beware the cat";
  drawText(btc, fontSize, m1.x, m1.y);

}

void drawText(String _line, float _fontSize, float _x, float _y) {
  
  String line = _line;
  String catline = "";
  for (int i = 0; i < line.length(); i++) {
    catline += "B";
  }
  float fontSize = _fontSize;
  
  //SETTING UP FONT
  RG.init(this);
  RFont freefont = new RFont("FreeSansNoPunch.ttf", int(fontSize), RFont.LEFT);
  RFont catfont = new RFont("CatFont1.ttf", int(fontSize), RFont.LEFT);
  RCommand.setSegmentator(RCommand.UNIFORMLENGTH);
  RCommand.setSegmentLength(8);
  RGroup freegroup = freefont.toGroup(line).toPolygonGroup();
  RGroup catgroup = catfont.toGroup(catline).toPolygonGroup();
  
  float x = _x;
  float y = _y;
  

  boolean firstLetter = true;
  for (int k = 0; k < freegroup.elements.length; k++) {
    RPolygon free = (RPolygon) freegroup.elements[k];
    RPolygon cat = (RPolygon) catgroup.elements[k];
    if (firstLetter) {
      translate(x, y + cat.getHeight());
      firstLetter = false;
    }
    RContour catc;
    for (int i = 0; i < free.contours.length; i++) {
      RContour freec = free.contours[i];
      if (i < cat.contours.length) {
        catc = cat.contours[i];
      } 
      else {
        catc = cat.contours[0];
      }
      beginShape();
      for (int j = 0; j < freec.points.length; j++) {
        RPoint freep = freec.points[j];
        if (j < catc.points.length) {
          RPoint catp = catc.points[j];
          catp.x -= 100;
          stroke(0, 0, 0);
          strokeWeight(1);
          vertex((freep.x + catp.x) / 2, (freep.y + catp.y) / 2);
        } 
        else {
          stroke(0, 0, 0);
          strokeWeight(1);
          vertex(freep.x, freep.y);
        }
      }
      endShape();
    }
  }
}
