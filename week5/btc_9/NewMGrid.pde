class NewMGrid
{
  int cols;
  int rows;
  float gutterSize;
  float w;
  float h;
  float x;
  float y;
  Module[][] modules;
  float moduleWidth;
  float moduleHeight;

  NewMGrid(int _cols, int _rows, float _gutterSize, float _width, float _height, float _x, float _y)
  {
    cols = _cols;
    rows = _rows;
    gutterSize = _gutterSize;
    w = _width;
    h = _height;
    x = _x;
    y = _y;
    

    modules = new Module[cols][rows];

    // cache the width of each column. Remember to cast as float, otherwise the columns will not line up
    // First we find the width of the page without the pagemargin
    float actualPageWidth = (w);
    // then we find the gutter sizes. We subtract by 1 as the furthermost right module will not have a right-side gutter
    float totalGutterWidth = (cols-1) * gutterSize;
    // then we simply find the column size by subtracting the gutterwidth from the page size and dividing by number of cols
    moduleWidth = (actualPageWidth - totalGutterWidth) / (float)cols;

    // cache the height of each column. This is the exact same calculation as before, and we should probably put
    float actualPageHeight = (h);
    float totalGutterHeight = (rows-1) * gutterSize;
    moduleHeight = (h - totalGutterHeight) / (float)rows;

    float diff = moduleHeight / 3;
    float diffDiff = diff/(((float) rows - 1)/2);

    for (int i = 0; i < cols; i++)
    {
      for (int j = 0; j < rows; j++)
      {
        modules[i][j] = new Module();
        modules[i][j].x = x + (i*moduleWidth) + (i*gutterSize);
        if ( j > 0) { 
          modules[i][j].y = y + j*(moduleHeight + diff) - (fact(j-1))*diffDiff + (j*gutterSize);
        } 
        else {
          modules[i][j].y = y + j*(moduleHeight + diff) + (j*gutterSize);
        }
        modules[i][j].w = moduleWidth;
        modules[i][j].h = (moduleHeight + diff) - j*diffDiff;
        //println("j: " + j + " " + j*(diff/(((float) rows - 1)/2)));
      }
    }
  }

  float fact(float _i) {
    float r = 1;
    float i = _i;
    if (i < 1) {
      return 0;
    }
    while (i > 1) {
      r = r+i;
      i--;
    }
    return r;
  }

  void display()   
  {
    noFill();
    stroke(120, 100, 100);

    // draw the big bounding box
    //rect(pageMargin, pageMargin, width - (2*pageMargin), height - (2*pageMargin));

    // draw all modules
    for (int i = 0; i < cols; i++)
    {
      for (int j = 0; j < rows; j++)
      {
        rect(modules[i][j].x, modules[i][j].y, modules[i][j].w, modules[i][j].h);

      }
    }
  }
}

