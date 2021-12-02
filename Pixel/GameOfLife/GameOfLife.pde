// source: https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life //<>// //<>//

// variables
color livingCellColor = color(91, 64, 211);
color deadCellColor = color(25);

float spawnProbability = 0.1;
int mouseSpreadRadius = 5;

void setup() {
  size(600, 400);
  smooth(0);
  frameRate(30);
  initField();
}

void draw() {
  loadPixels();

  int[] currentPixelState = new int[pixels.length];
  arrayCopy(pixels, currentPixelState);

  for (int y = 0; y < height; y++) {
    for (int x = 0; x < width; x++) {

      int pixelIdx = y * width + x;
      int livingNeighbours = 0;

      // count living neighbour
      for (int yNeighbour = y - 1; yNeighbour < y + 2; yNeighbour++) {
        for (int xNeighbour = x - 1; xNeighbour < x + 2; xNeighbour++) {

          // dont count yourself
          if (x == xNeighbour && y == yNeighbour) continue;

          int neighbourPixelIdx = yNeighbour * width + xNeighbour;
          try {
            if (currentPixelState[neighbourPixelIdx] == livingCellColor) livingNeighbours++;
          }
          catch(IndexOutOfBoundsException e) { /** do nothing **/
          }
        }
      }

      boolean alive = currentPixelState[pixelIdx] == livingCellColor;

      // changing a pixels color if it meets a rule of the game of life
      if (!alive && livingNeighbours == 3) {
        pixels[pixelIdx] = livingCellColor;
      } else if (alive && (livingNeighbours < 2 || livingNeighbours > 3)) {
        pixels[pixelIdx] = deadCellColor;
      }
    }
  }

  // create some living cells near the mouse, if the mouse is pressed
  if (mousePressed) {
    for (int i = 0; i < 10; i++) {
      int pixelIdx= (mouseY + int(random(mouseSpreadRadius))) * width + (mouseX + int(random(mouseSpreadRadius)));
      pixels[pixelIdx] = livingCellColor;
    }
  }
  
  updatePixels();
}

void initField() {
  loadPixels();

  for (int y = 0; y < height; y++) {
    for (int x = 0; x < width; x++) {

      int pixelIdx = y * width + x;
      float r = random(1);

      if (spawnProbability > r) {
        pixels[pixelIdx] = livingCellColor;
      } else {
        pixels[pixelIdx] = deadCellColor;
      }
    }
  }

  updatePixels();
}
