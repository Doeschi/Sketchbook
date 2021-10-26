 //<>// //<>//
PImage img;
int radius = 30;

void setup() {
  size(600, 400);

  img = loadImage("wallpaper101.jpg");
}

void draw() {
  image(img, 0, 0, width, height);

  loadPixels();

  int fromX = max(mouseX - radius, 0);
  int toX   = min(mouseX + radius, width);

  int fromY = max(mouseY - radius, 0);
  int toY   = min(mouseY + radius, height-1);

  for (int y = fromY; y < toY; y++) {
    int leftMostCirclePixel = -1;
    int rightMostCirclePixel = -1;

    for (int x = fromX; x < toX; x++) {

      if (dist(x, y, mouseX, mouseY) < radius) {
        if (leftMostCirclePixel == -1) {
          leftMostCirclePixel = x;
        } else {
          rightMostCirclePixel = x;
        }
      }
    }

    int leftOffset = mouseX - leftMostCirclePixel;
    int rightOffset = rightMostCirclePixel - mouseX;
    try {
      for (int i = 0; i < leftMostCirclePixel; i++) {
        pixels[i + (y * width)] = pixels[i + (y * width) + leftOffset];
      }

      for (int i = width; i > rightMostCirclePixel; i--) {
        pixels[i + (y * width)] = pixels[i + (y * width) - rightOffset];
      }

      for (int i = leftMostCirclePixel; i <= rightMostCirclePixel; i++) {
        pixels[i + (y * width)] = color(255);
      }
    }
    catch(ArrayIndexOutOfBoundsException e) {
      print("CRASH");
      exit(); //<>//
    }
  }


  //for (int x = fromX; x < toX; x++) {
  //  for (int y = fromY; y < toY; y++) {
  //    if (dist(x, y, mouseX, mouseY) < radius) {
  //      pixels[x + (y * width)] = color(255);
  //    }
  //  }
  //}


  updatePixels();
}
