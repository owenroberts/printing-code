import geomerative.*;


void setup() {
  size(int(800/1.2), int(1200/1.2));
  background(255);
  colorMode(HSB, 360, 100, 100);
  
  //SETTING UP MANUSCRIPT GRID
  ColumnGrid columnGrid = new ColumnGrid(1, 25);
  columnGrid.display();
  
  //Basic Mod Grid
  ModularGrid basicGrid = new ModularGrid(1, 3, 5, 75);
  basicGrid.display();
  Module b1 = basicGrid.modules[0][0];
  
  //New MODULAR GRID
  NewMGrid moduleGrid = new NewMGrid(1, 5, 5, b1.w, b1.h, b1.x, b1.y );
  //moduleGrid.display();
  Module m1 = moduleGrid.modules[0][0];
  
  float fontSize = m1.h;
  String btc = "A MARVELOVS";
  drawText(btc, fontSize, m1.x, m1.y);
  
  Module m2 = moduleGrid.modules[0][1];
  fontSize = m2.h/1.5;
  String linetwo = "hystory intitulede, Beware the";
  drawText(linetwo, fontSize, m2.x, m2.y);
  
  Module m3 = moduleGrid.modules[0][2];
  fontSize = m3.h/1.5;
  String linethree = "Cat. Conteyning diuers wounder-";
  drawText(linethree, fontSize, m3.x, m3.y);

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
  RFont catfont = new RFont("CatFont2.ttf", int(fontSize), RFont.LEFT);
  RCommand.setSegmentator(RCommand.UNIFORMLENGTH);
  RCommand.setSegmentLength(4);
  RGroup freegroup = freefont.toGroup(line).toPolygonGroup();
  RGroup catgroup = catfont.toGroup(catline).toPolygonGroup();
  
  float x = _x;
  float y = _y;
  

  boolean firstLetter = true;
  pushMatrix();
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
  popMatrix();
}
