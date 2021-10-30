float angleIncrease;
float offsetIncrease;
float waveScale;
float pointSpacing;

float angleOffset = 0;

color closeColor;
color farColor;

void setup() {
  size(800, 600);
  closeColor = color(#FD5E53);
  farColor = color(#FFE373);
  noStroke();
}


void draw() {

  angleIncrease = 0.275;
  offsetIncrease = 0.100;
  pointSpacing = 2.5;
  waveScale = 8;

  background(220);

  translate(mouseX, mouseY);

  for (float rotation = 0; rotation < TWO_PI; rotation += PI/16) {

    rotate(rotation);

    float ang = angleOffset;

    for (float x = 0; x < width/2; x += pointSpacing) {
      
      float y = (sin(ang) * waveScale) - (sin(angleOffset) * waveScale);
      color col = lerpColor(closeColor, farColor, map(dist(x, y, 0, 0), 0, width, 0, 1));
      
      fill(col);
      ellipse(x, y, 10, 5);
      ang += angleIncrease;
    }
  }

  angleOffset += offsetIncrease;
  println(frameRate);
}
