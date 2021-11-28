// variables
ArrayList<Circle> circles;
ArrayList<PVector> intersectionPoints;

Circle mouseCircle;
boolean showMouseCircle;
boolean showIntersectionPoints;

// parameters meant to be changed in draw


void setup() {
  size(800, 600, P2D);

  intersectionPoints = new ArrayList();

  //initRandomCircles();
  initRegularCircles();
  mouseCircle = new Circle(new PVector(width/2, height/2), 50);

  smooth(4);
  textSize(15);
  textAlign(LEFT, TOP);
  noLoop();
}

void keyPressed() {
  if (key == 's' || key == 'S') {
    showMouseCircle = !showMouseCircle;
  } else if (key == 'i' || key == 'I') {
    showIntersectionPoints = !showIntersectionPoints;
  } else return;

  redraw();
}

void mouseDragged() {
  redraw();
}

void mouseWheel(MouseEvent event) {
  if (event.getCount() < 0) {
    mouseCircle.radius += 5;
  } else {
    mouseCircle.radius -= 5;
  }

  redraw();
}

void draw() {
  background(220);

  // color and stroke for the circles
  noFill();
  strokeWeight(1);
  stroke(0);
  // draw circles
  for (Circle c : circles) {
    c.show();
  }

  // draw mouse circle
  if (showMouseCircle) {
    mouseCircle.pos.x = mouseX;
    mouseCircle.pos.y = mouseY;

    mouseCircle.show();
  }

  // draw intersection points
  if (showIntersectionPoints) {
    intersectionPoints.clear();

    for (int i = 0; i < circles.size(); i++) {
      Circle c = circles.get(i);
      for (int j = i; j < circles.size(); j++) {
        Circle otherC = circles.get(j);
        c.addIntersectionPoints(otherC, intersectionPoints);
      }
    }

    if (showMouseCircle) {
      for (Circle c : circles) {
        mouseCircle.addIntersectionPoints(c, intersectionPoints);
      }
    }

    strokeWeight(5);
    stroke(0, 0, 255);
    for (PVector v : intersectionPoints) {
      point(v.x, v.y);
    }
  }

  fill(0);
  text("click and drag mouse\nshow/hide the mouse circle with 'c'\nshow/hide intersection points with 'i'", 10, 10);

  println(frameRate);
}

void initRandomCircles() {
  circles = new ArrayList();

  for (int i = 0; i < 10; i++) {
    float radius = random(40, 100);
    PVector pos = new PVector(random(radius, width - radius), random(radius, height - radius));

    circles.add(new Circle(pos, radius));
  }
}

void initRegularCircles() {
  circles = new ArrayList();
  float radius = 60;
  int maxIteration = 1;

  Circle centerCircle = new Circle(new PVector(width/2, height/2), radius);
  Circle topCircle = new Circle(new PVector(width/2, height/2 - radius), radius);
  Circle rightCircle = new Circle(new PVector(width/2 + radius, height/2), radius);
  Circle bottomCircle = new Circle(new PVector(width/2, height/2 + radius), radius);
  Circle leftCircle = new Circle(new PVector(width/2 - radius, height/2), radius);
  
  circles.add(centerCircle);
  circles.add(topCircle);
  circles.add(rightCircle);
  circles.add(bottomCircle);
  circles.add(leftCircle);

  int circleIndex = -1;
  int intersectionIndex = 0;

  for (int iteration = 0; iteration < maxIteration; iteration++) {

     //checking if a new circle intersects with some other circles
     
     // 
    for (int i = circles.size() - 1; i > circleIndex; i--) {
      Circle c = circles.get(i);

      for (int j = i - 1; j >= 0; j--) {
        Circle otherC = circles.get(j);
        c.addIntersectionPoints(otherC, intersectionPoints);
      }
    }

    circleIndex = circles.size();

    //for (int i = 0; i < circles.size(); i++) {
    //  Circle c = circles.get(i);
    //  for (int j = i + 1; j < circles.size(); j++) {
    //    Circle otherC = circles.get(j);
    //    c.addIntersectionPoints(otherC, intersectionPoints);
    //  }
    //}

    // creating a new circle for every new intersection
    for (int j = intersectionIndex; j < intersectionPoints.size(); j++) {
      PVector intersection = intersectionPoints.get(j);
      circles.add(new Circle(intersection, radius));
      intersectionIndex++;
    }
  }
}
