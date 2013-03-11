import geomerative.*;

RGroup freegroup;
RGroup catgroup;
RFont freefont;
RFont catfont;
RPolygon polygon;

void setup() {
  size(int(800/1.2), int(1200/1.2));
  background(255);
  colorMode(HSB, 360, 100, 100);
  
  //SETTING UP MANUSCRIPT GRID
  ColumnGrid columnGrid = new ColumnGrid(1, 25);
  columnGrid.display();
  
  //MODULAR GRID
  ModularGrid moduleGrid = new ModularGrid(1, 20, 5, 75);
  moduleGrid.display();
  float fontSize = moduleGrid.moduleHeight;
  
  //SETTING UP FONT
  RG.init(this);
  freefont = new RFont("FreeSansNoPunch.ttf", int(fontSize), RFont.LEFT);
  catfont = new RFont("CatFont1.ttf", int(fontSize), RFont.LEFT);
  RCommand.setSegmentator(RCommand.UNIFORMLENGTH);
  RCommand.setSegmentLength(8);
  freegroup = freefont.toGroup("Beware the cat").toPolygonGroup();
  catgroup = catfont.toGroup("BBBBBBBBBBBB").toPolygonGroup();
    
  
  
  
  
  
  
  Module m1 = moduleGrid.modules[0][0];
  drawText(freegroup, catgroup, m1.x, m1.y);

}

void drawText(RGroup _font, RGroup _catfont, float _x, float _y) {
  
  RGroup freegroup = _font;
  RGroup catgruop = _catfont;
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
          stroke(0, 0, 0);
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
