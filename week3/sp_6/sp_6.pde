// adds pdf grabbing
// nah
// maybe this?
// is this dumb

import toxi.color.*;
import toxi.util.datatypes.*;

import processing.pdf.*;

int rectSize = 22;
int spacing = rectSize/2;

int dist = 6;

void setup() 
{
  size(1280, 800);

  beginRecord(PDF, "imgs/" + getClass().getName() + "_" + year() + "_" + month()+ "_" + day() + "_" + hour() + "_" + minute() + "_" + second() + ".pdf"); 

  background(255);
  noStroke();
  colorMode(HSB, 1, 1, 1);

  // create a color range object ranges of hue, saturation and brightness
  FloatRange h = new FloatRange(0.81, 0.8333);
  FloatRange s = new FloatRange(0.3, 0.33);
  FloatRange b = new FloatRange(0.95, 1);
  ColorRange range = new ColorRange(h, s, b, "My range");

  translate(10, 10);

  int w = (width - 20)/(rectSize+spacing);
  int hi = (height - 20)/(rectSize+rectSize);


  for (int i = 0; i < w; i++)
  {
    for (int j = 0; j < hi; j++)
    { 
      if (i > w/4 - 2 && i < w/4 + 2 && j > hi/3 - 3 && j < hi/3 + 3) {
        TColor ranColor = range.getColor();
        fill(ranColor.hue(), ranColor.saturation() - 0.2, ranColor.brightness());
        rect(i * (rectSize + spacing) + random(dist), j * (rectSize + spacing) + random(dist), rectSize, rectSize);
      } else if (i > w/2 - 2 &&  i < w/2 + 2 && j > hi/3 - 3 && j < hi/3 + 3) {
        TColor ranColor = range.getColor();
        fill(ranColor.hue(), ranColor.saturation() - 0.2, ranColor.brightness());
        rect(i * (rectSize + spacing) + random(dist), j * (rectSize + spacing) + random(dist), rectSize, rectSize);
      }
      else {
        TColor ranColor = range.getColor();
        fill(ranColor.hue(), ranColor.saturation(), ranColor.brightness());
        rect(i * (rectSize + spacing) + random(dist), j * (rectSize + spacing) + random(dist), rectSize, rectSize);
      }
    }


    /*
  for(int i = 0; i < (width - 20)/(rectSize+spacing); i++)
     {
     for(int j = 17; j < (height- 20)/(rectSize+spacing); j++)
     { 
     TColor ranColor = range.getColor();
     fill(ranColor.hue(), ranColor.saturation() - 0.2, ranColor.brightness());
     rect(i * (rectSize + spacing) + random(dist), j * (rectSize + spacing) + random(dist), rectSize, rectSize);
     }  
     }
     */
  }

  endRecord();
}

