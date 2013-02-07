/*  Properties
_________________________________________________________________ */

import processing.pdf.*;

// Set these variables to the print size you want (in inches)
// The resulting PDF will be this aspect ratio
float print_width = 17;
float print_height = 23;

// This will help make the sketch window bigger
float make_bigger = 40;


/*  Setup
_________________________________________________________________ */

void setup()
{
  size(round(print_width * make_bigger), round(print_height * make_bigger));

  beginRecord(PDF, "grab.pdf"); 
  background(255);
  
  stroke(0);
  
  ellipse(width/4, height/8-height/32, height/16, height/16); 
  
  fill(0);
  
  rect(width/12, height/8-height/16, height/24, height/16);
  
  triangle(-width/4, height/8-height/20, width/12, height/8-height/17, width/12, width/12 + height/16);
  
  endRecord();
}
