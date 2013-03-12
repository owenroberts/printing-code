import geomerative.*;


void setup() {
  size(int(800/1.2), int(1200/1.2));
  background(255);
  colorMode(HSB, 360, 100, 100);
  noFill();

  //SETTING UP MANUSCRIPT GRID
  ColumnGrid columnGrid = new ColumnGrid(1, 25);
  //columnGrid.display();

  //Basic Mod Grid
  ModularGrid basicGrid = new ModularGrid(1, 3, 5, 100);
  //basicGrid.display();
  Module b1 = basicGrid.modules[0][0];

  //New MODULAR GRID
  NewMGrid moduleGrid = new NewMGrid(1, 5, 5, b1.w, b1.h, b1.x, b1.y );
  //moduleGrid.display();

  Module m1 = moduleGrid.modules[0][0];
  float fontSize = m1.h/1.2;
  String btc = "A MARVELOVS";
  String btct = "B BABABABAB";
  drawText(btc, btct, fontSize, m1.x, m1.y);

  Module m2 = moduleGrid.modules[0][1];
  fontSize = m2.h/1.6;
  String linetwo = "hystory intitulede,  Beware the";
  String linetwot = "Baaaaaa aaaaaaaaa, Baaaaa aaaaa";
  drawText(linetwo, linetwot, fontSize, m2.x, m2.y);

  Module m3 = moduleGrid.modules[0][2];
  fontSize = m3.h/1.5;
  String linethree = "Cat.  Conteyning diuers wounder-";
  String linethreet = "BABa Bababababab ababab abababab";
  drawText(linethree, linethreet, fontSize, m3.x, m3.y);

  Module m4 = moduleGrid.modules[0][3];
  fontSize = m4.h/1.5;
  String linefour = "full and incredible matters.";
  String linefourt = "Babb aba abaabaabab abababbb";
  drawText(linefour, linefourt, fontSize, m4.x, m4.y);

  Module m5 = moduleGrid.modules[0][4];
  fontSize = m5.h/1.5;
  String linefive = "Very pleasant and mery to read.";
  String linefivet = "Babb abaaaaab aab aaaa ba aaaba";
  drawText(linefive, linefivet, fontSize, m5.x, m5.y);

  //THE BOTTOM TEXT
  Module b3 = basicGrid.modules[0][2];

  //New MODULAR GRID
  NewMGrid bottomGrid = new NewMGrid(1, 5, 5, b3.w, b3.h, b3.x, b3.y );
  //bottomGrid.display();

  Module bg1 = bottomGrid.modules[0][0];
  fontSize = bg1.h/1.8;
  String blone = "¶ IMPRINTED IN LONDON, IN";
  String blonet = "B ABAAABBAB AB AABBAB, ABB";
  drawText(blone, blonet, fontSize, bg1.x, bg1.y);

  Module bg2 = bottomGrid.modules[0][1];
  fontSize = bg2.h/1.5;
  String bltwo = "Fleetestrete at the signe of the";
  String bltwot = "Ba Baaabaabaaba ab bba abaaa ab aaa";
  drawText(bltwo, bltwot, fontSize, bg2.x, bg2.y);

  Module bg3 = bottomGrid.modules[0][2];
  fontSize = bg3.h/1.5;
  String blthree = "Faulcon by Wylliam Gryffith:";
  String blthreet = "Baabaaa ba Aabbbaa Baabbbbab";
  drawText(blthree, blthreet, fontSize, bg3.x, bg3.y);

  Module bg4 = bottomGrid.modules[0][3];
  fontSize = bg4.h/1.6;
  String blfour = "and are to be sold at his shop in S. Dunstons";
  String blfourt = "Bab aaa ba ba aabb ab baa abaa ba A. Baaabaaaa";
  drawText(blfour, blfourt, fontSize, bg4.x, bg4.y);

  Module bg5 = bottomGrid.modules[0][4];
  fontSize = m5.h/1.5;
  String blfive = "Church-yarde. Anno 1570.";
  String blfivet = "Bbaaab-aaaba. Aaaa ABAB.aaa";
  drawText(blfive, blfivet, fontSize, bg5.x, bg5.y);

  ModularGrid border = new ModularGrid( 11, 12, 2, 25);
  //border.display();
  boolean flip = true;
  for (int i = 0; i < border.modules.length; i++) {
    for (int j = 0; j < border.modules[i].length; j++) {
      if (i == 0 || j == 0 || i == border.modules.length-1 || j== border.modules[i].length - 1) {
        Module mod = border.modules[i][j];
        if (flip) {
          catShape(mod.x + mod.w/2, mod.y + mod.h/2);
          flip = false;
        } 
        else {
          pushMatrix();
          rotate(PI);
          catShape(-mod.x - mod.w/2, - mod.y - mod.h/2);
          popMatrix();
          flip = true;
        }
      }
    }
  }

}


void drawText(String _line, String _catline, float _fontSize, float _x, float _y) {

  String line = _line;
  String catline = _catline;
  float fontSize = _fontSize;

  //SETTING UP FONT
  RG.init(this);
  RFont freefont = new RFont("TimesNewRoman.ttf", int(fontSize), RFont.LEFT);
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
          catp.x -= 50;
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

void catShape(float _x, float _y) {

  float x = _x;
  float y =_y;
  
  RShape catshp;
  RShape catpolyshp;

  RFont font;
  RGroup fontgroup;
  
  

  strokeWeight(1.2);
  strokeJoin(ROUND);
  strokeCap(SQUARE);

  RG.init(this);
  RCommand.setSegmentLength(50);
  RCommand.setSegmentator(RCommand.UNIFORMLENGTH);
  catshp = RG.loadShape("cat.svg");
  catshp = RG.centerIn(catshp, g, 100);

  RCommand.setSegmentLength(50);
  font = new RFont("FreeSansNoPunch.ttf", 200, RFont.CENTER);
  fontgroup = font.toGroup("a").toPolygonGroup();

  float pointSeparation = 50;
  RG.setPolygonizer(RG.UNIFORMLENGTH);
  RG.setPolygonizerLength(pointSeparation);
  catpolyshp = RG.polygonize(catshp);
  
  pushMatrix();
  translate(x, y);

  RPoint[] catpoints = catpolyshp.getPoints();


  for (int k = 0; k < fontgroup.elements.length; k++) {
    RPolygon fontpolygon = (RPolygon) fontgroup.elements[k];

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

        vertex(((catpoint.x + fontpoint.x)/2)/6, ((catpoint.y + fontpoint.y)/2)/6);
      }
      endShape();
    }
  }
  popMatrix();
}

