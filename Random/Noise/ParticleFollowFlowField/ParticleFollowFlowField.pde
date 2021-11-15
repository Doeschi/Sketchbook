// inspired by https://www.youtube.com/watch?v=BjoM9oKOAKY  //<>// //<>// //<>// //<>// //<>// //<>//

PVector[][] vectorField;
int fieldWidth;
int fieldHeight;
float vectorLen = 20;

float zOff = 0;
float increment = 0.1;

Particle[] particles;
int numberOfParticles = 10_000;

void setup() {
  size(800, 600);

  int seed = int(random(0, MAX_INT));
  println("Seed: ", seed);
  noiseSeed(seed);

  initVectorField();
  updateVectorField();

  initParticles();
  
  strokeWeight(2);
  background(0);
  
}

void draw() {
  increment = 0.100;

  //drawVectorField();
  drawParticles();

  updateVectorField();
  updateParticles();
  
  
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

  zOff += 0.005;
}

void drawVectorField() {
  stroke(0, 10);

  pushMatrix();
  translate(vectorLen / 2, vectorLen / 2);

  for (int y = 0; y < vectorField.length; y++) {
    for (int x = 0; x < vectorField[y].length; x++) {

      pushMatrix();

      float translateX = x * (width / fieldWidth);
      float translateY = y * (height / fieldHeight);

      translate(translateX, translateY);
      rotate(vectorField[y][x].heading());
      
      line(0, 0, vectorLen, 0);
      popMatrix();
    }
  }

  popMatrix();
}

void initParticles() {
  particles = new Particle[numberOfParticles];

  for (int i = 0; i < particles.length; i++) {
    particles[i] = new Particle();
  }
}

void updateParticles() {
  for (int i = 0; i < particles.length; i++) {

    // find index of closest vector
    int xIndex = floor(particles[i].position.x / vectorLen);
    int yIndex = floor(particles[i].position.y / vectorLen);

    try {
      PVector closestVector = vectorField[yIndex][xIndex];
      particles[i].update(closestVector);
    }
    catch(ArrayIndexOutOfBoundsException e) {
      println("err");
    }
  }
}

void drawParticles() {
  for (int i = 0; i < particles.length; i++) {
    particles[i].show();
  }
}
