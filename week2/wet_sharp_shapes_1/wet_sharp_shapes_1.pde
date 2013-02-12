int circleResolution = 16;
float circleRadius = 28;
float displaceAmount = 2;
float[] x = new float[circleResolution];
float[] y = new float[circleResolution];


int frame = 0;

void setup() {

  size(1200, 800);
  //smooth();

  float angle = radians(360/float(circleResolution));
  for (int i=0; i<circleResolution; i++) {
    x[i] = cos(angle*i) * circleRadius;
    y[i] = sin(angle*i) * circleRadius;
  }

  stroke(0, 255);
  background(255);
}

void draw()
{

  while (frame*circleRadius < width) {
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

    /* later
     */
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
}

void keyPressed() {
  if (key == 's') {
    saveFrame("imgs/line-######.jpg");
  }
}

