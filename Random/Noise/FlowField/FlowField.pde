PVector[][] vectorField; //<>//
int fieldWidth;
int fieldHeight;
float vectorLen = 5;

float zOff = 0;
float increment = 0.02;

void setup() {
  size(800, 600);

  int seed = int(random(0, MAX_INT));
  println("Seed: ", seed);
  noiseSeed(seed);

  initVectorField();
  updateVectorField();

  stroke(0);
  strokeWeight(1);
}  

void draw() {
  increment = 0.020;
  
  background(255);
  translate(vectorLen / 2, vectorLen / 2);

  drawVectorField();
  updateVectorField();
  
  println(frameRate);
}

void initVectorField() {
  fieldWidth = int(width / vectorLen);
  fieldHeight = int(height / vectorLen);
  
  vectorField = new PVector[fieldHeight][fieldWidth];

  for (int y = 0; y < vectorField.length; y++) {
    for (int x = 0; x < vectorField[y].length; x++) {
      vectorField[y][x] = new PVector(1, 0);
    }
  }
}

void updateVectorField() {
  float xOff = 0;
  float yOff;
  for (int y = 0; y < vectorField.length; y++) {
    xOff += increment;
    yOff = 0;
    for (int x = 0; x < vectorField[y].length; x++) {
      yOff += increment;
      vectorField[y][x].setHeading(noise(xOff, yOff, zOff) * TWO_PI);
    }
  }

  zOff += 0.01;
}

void drawVectorField() {
  for (int y = 0; y < vectorField.length; y++) {
    for (int x = 0; x < vectorField[y].length; x++) {

      float fromX = x * (width / fieldWidth);
      float fromY = y * (height / fieldHeight);

      float toX = fromX + cos(vectorField[y][x].heading()) * vectorLen;
      float toY = fromY + sin(vectorField[y][x].heading()) * vectorLen;
      
      line(fromX, fromY, toX, toY);
    }
  }
}
