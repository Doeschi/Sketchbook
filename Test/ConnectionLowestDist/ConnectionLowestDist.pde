int numberOfPoints = 200;
PVector[] points;


void setup() {
  size(800, 600);
  initPoints();
}


void draw() {

  for (PVector point : points) {

    float lowestDist = MAX_FLOAT;
    float secondLowestDist = MAX_FLOAT;
    
    PVector p1 = null;
    PVector p2 = null;

    for (PVector otherPoint : points) {
      if (point == otherPoint) {
        continue;
      }

      float distance = dist(point.x, point.y, otherPoint.x, otherPoint.y);

      if (distance < lowestDist) {
        secondLowestDist = lowestDist;
        lowestDist = distance;
        
        p2 = p1;
        p1 = otherPoint;
        
      } else if ( distance < secondLowestDist) {
        secondLowestDist = distance;
        p2 = otherPoint;
      }
    }
    
    line(point.x, point.y, p1.x, p1.y);
    line(point.x, point.y, p2.x, p2.y);
    line(p1.x, p1.y, p2.x, p2.y);
    
    
  }
}


void initPoints() {
  points = new PVector[numberOfPoints];

  for (int i = 0; i < numberOfPoints; i++) {
    points[i] = new PVector(random(width), random(height));
  }
}
