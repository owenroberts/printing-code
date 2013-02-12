//same thing as wet_dry 1 but with pdf export
// this changes resolution to 72 in case that matters

int circleResolution = 16;
float circleRadius = 28.5;
float displaceAmount = 1.2;
float[] x = new float[circleResolution];
float[] y = new float[circleResolution];

int frame = 0;

import processing.pdf.*;
float print_width = 17;
float print_height = 6;
float make_bigger = 72;


void setup() {

  size(round(print_width * make_bigger), round(print_height * make_bigger));

  float angle = radians(360/float(circleResolution));
  for (int i=0; i<circleResolution; i++) {
    x[i] = cos(angle*i) * circleRadius;
    y[i] = sin(angle*i) * circleRadius;
  }



  beginRecord(PDF, "imgs/grab" + year() + "_" + month()+ "_" + day() + "_" + hour() + "_" + minute() + "_" + second() + "_" + millis() + ".pdf");

  stroke(0, 255);
  background(255);

  for (int h = 0; h < 50; h++) {
    if (frame == 0) {
      translate(0, 2*circleRadius);
    } 
    else {
      // calculate new points
      for (int i=0; i<circleResolution; i++) {
        x[i] += random(-displaceAmount, displaceAmount);
        y[i] += random(-displaceAmount, displaceAmount);
      }
    }
    frame++;
    println(frame);
    // calculate new points
    for (int i=0; i<circleResolution; i++) {
      x[i] += random(-displaceAmount, displaceAmount);
      y[i] += random(-displaceAmount, displaceAmount);
    }


    strokeWeight(0.75);
    noFill();

    translate(frame*circleRadius, -circleRadius);


    beginShape();

    // we need a start vertex point
    vertex(x[circleResolution-1], y[circleResolution-1]);

    // then draw all the points
    for (int i=0; i<circleResolution; i++) {
      vertex(x[i], y[i]);
    }

    // and two end points (the last is the control point)
    vertex(x[0], y[0]);
    vertex(x[1], y[1]);

    endShape();


    translate(circleRadius, 2*circleRadius);

    strokeWeight(0.75);

    beginShape();

    // we need a start vertex point
    curveVertex(x[circleResolution-1], y[circleResolution-1]);

    // then draw all the points
    for (int i=0; i<circleResolution; i++) {
      curveVertex(x[i], y[i]);
    }

    // and two end points (the last is the control point)
    curveVertex(x[0], y[0]);
    curveVertex(x[1], y[1]);

    endShape();
  }

  endRecord();
}

