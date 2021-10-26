 //<>// //<>//
PVector[][] vectorField;
int fieldWidth = 120;
int fieldHeight = 80;
float vectorLen = 5;

PVector ballPos;
PVector ballVel;

float zOff = 0;
float increment = 0.02;

void setup() {
  size(600, 400);

  int seed = int(random(0, MAX_INT));
  println("Seed: ", seed);
  noiseSeed(seed);

  initVectorField();
  ballPos = new PVector(random(0, width), random(0, height));
  ballVel = new PVector(1, 0);

  stroke(0);
  strokeWeight(1);
}  

void draw() {
  background(255);
  translate(vectorLen / 2, vectorLen / 2);

  drawVectorField();
  drawBall();
  updateVectorField();
  updateBall();
  
  println(frameRate);
}


void initVectorField() {

  vectorField = new PVector[fieldHeight][fieldWidth];

  float xOff = 0;
  for (int y = 0; y < vectorField.length; y++) {
    xOff += increment;
    float yOff = 0;
    for (int x = 0; x < vectorField[y].length; x++) {
      yOff += increment;
      vectorField[y][x] = new PVector(1, 0).setHeading(noise(xOff, yOff, zOff) * TWO_PI);
    }
  }
}

void updateVectorField() {

  float xOff = 0;
  for (int y = 0; y < vectorField.length; y++) {
    xOff += increment;
    float yOff = 0;
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
      pushMatrix();

      float translateX = x * (width / fieldWidth);
      float translateY = y * (height / fieldHeight);

      translate(translateX, translateY);

      float toX = cos(vectorField[y][x].heading()) * vectorLen;
      float toY = sin(vectorField[y][x].heading()) * vectorLen;
      
      line(0, 0, toX, toY);
      popMatrix();
    }
  }
}

void updateBall() {
  moveBall();
}

void moveBall() {
  int xIndex = int(ballPos.x / (width / fieldWidth));
  int yIndex = int(ballPos.y / (height / fieldHeight));

  ballVel.setHeading(vectorField[yIndex][xIndex].heading());
  ballPos.add(ballVel);
  checkBallPos();
}

void checkBallPos() {
  if (ballPos.x < 0 || ballPos.x > width || ballPos.y < 0 || ballPos.y > height) {
    ballPos.set(random(0, width), random(0, height));
    moveBall();
  }
}

void drawBall() {
  fill(255, 0, 0);
  circle(ballPos.x, ballPos.y, 5);
}
