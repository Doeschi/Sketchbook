// variables
PImage img;
PGraphics imgCanvas;

float angle = 0;
int radius = 100;

void setup() {
  size(800, 600, P2D);

  imgCanvas = createGraphics(800, 600, P2D);
  img = loadImage("wallpaper101.jpg");
}


void draw() {
  background(220);

  imgCanvas.beginDraw();
  imgCanvas.background(0);
  imgCanvas.translate(mouseX, mouseY);
  imgCanvas.rotate(angle);
  imgCanvas.translate(-mouseX, -mouseY);
  imgCanvas.image(img, 0, 0, width, height);
  imgCanvas.endDraw();

  copy(imgCanvas,
    int(mouseX - radius/2), int(mouseY - radius/2), radius, radius,
    int(mouseX - radius/2), int(mouseY - radius/2), radius, radius
    );

  if (mousePressed) {
    angle += PI/32;
  } else {
    angle = 0;
  }
}
