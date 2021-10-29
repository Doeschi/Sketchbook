int numberOfPoints = 15;
PVector[] points;

void setup() {
  size(800, 600);

  initPoints();
}


void draw() {
  loadPixels();

  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {

      float lowestDist = MAX_FLOAT;

      for (PVector point : points) {
        lowestDist = min(lowestDist, dist(x, y, point.x, point.y));
      }
      
      float mouseDist =  dist(x, y, mouseX, mouseY);
      if(mouseDist < lowestDist){
        pixels[x + (y * width)] = color(0, 0, map(sin(mouseDist), -1, 1, 0, 255));
      } else{
        pixels[x + (y * width)] = color(map(lowestDist, 0, width/4, 0, 255), map(sin(lowestDist), -1, 1, 0, 255), 0);
      }
    }
  }

  updatePixels();

  //updatePoints();
}

void mousePressed() {
  initPoints();
}

void initPoints() {
  points = new PVector[numberOfPoints];

  for (int i = 0; i < numberOfPoints; i++) {
    points[i] = new PVector(random(width), random(height));
  }
}

void updatePoints() {
  for (PVector point : points) {
    point.add(PVector.random2D());
  }
}
