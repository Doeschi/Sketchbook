PVector firstPoint;
PVector secondPoint;

color colfirstPoint;
color colsecondPoint;

void setup() {
  size(800, 600);
  firstPoint = new PVector(random(width), random(height));
  secondPoint = new PVector(random(width), random(height));
  
  colfirstPoint = color(255, 0, 0);
  colsecondPoint = color(0, 0, 255);
  
  strokeCap(ROUND);
}

void draw() {

  secondPoint.x = mouseX;
  secondPoint.y = mouseY;

  loadPixels();

  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      float dist1 = dist(x, y, firstPoint.x, firstPoint.y);
      float dist2 = dist(x, y, secondPoint.x, secondPoint.y);

      if (dist1 < dist2) {
        pixels[x + (y * width)] = color(255, 0, 0);
      } else {
        pixels[x + (y * width)] = colsecondPoint;
      }
    }
  }

  updatePixels();

  strokeWeight(1);
  fill(0, 100);
  circle(firstPoint.x, firstPoint.y, 30);
  circle(secondPoint.x, secondPoint.y, 30);
 
  strokeWeight(4);
  line(firstPoint.x, firstPoint.y, secondPoint.x, secondPoint.y);
}
