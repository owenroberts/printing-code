// adds pdf grabbing

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
  
  //println((width/rectSize) - 20);
  
  for(int i = 0; i < (width - 20)/(rectSize+spacing); i++)
  {
    for(int j = 0; j < (height - 20)/(rectSize+rectSize); j++)
    { 
      println("i:" + i + " j:" + j);
      TColor ranColor = range.getColor();
      fill(ranColor.hue(), ranColor.saturation(), ranColor.brightness());
      rect(i * (rectSize + spacing) + random(dist), j * (rectSize + spacing) + random(dist), rectSize, rectSize);
    }  
  }
  
  
  endRecord();

}
