
/**
 lower corners
 .  .    v1, v2
 .  .    v3, v4
 
 upper corners
 .  .    v5, v6
 .  .    v7, v8
 
 **/

PVector v1, v2, v3, v4, v5, v6, v7, v8;
color v1Col, v2Col, v3Col, v4Col, v5Col, v6Col, v7Col, v8Col;

float cubeSize = 100;

void setup() {
  size(600, 500, P3D);

  colorMode(HSB, 360, 100, 100);
  noStroke();

  initCubeCorners();
  initCubeColors();
}

void draw() {
  background(220);

  translate(width / 2, height / 2, 0);
  scale((0.2 + abs(sin(radians(frameCount)))) * 1.5);
  rotateX(map(height-mouseY, 0, width, 0, TWO_PI));
  rotateY(map(width-mouseX, 0, height, 0, TWO_PI));

  beginShape(QUADS);

  // lower
  drawVertex(v1, v1Col);
  drawVertex(v2, v2Col);
  drawVertex(v4, v4Col);
  drawVertex(v3, v3Col);

  // back
  drawVertex(v1, v1Col);
  drawVertex(v2, v2Col);
  drawVertex(v6, v6Col);
  drawVertex(v5, v5Col);

  // upper
  drawVertex(v5, v5Col);
  drawVertex(v6, v6Col);
  drawVertex(v8, v8Col);
  drawVertex(v7, v7Col);

  // front
  drawVertex(v3, v3Col);
  drawVertex(v4, v4Col);
  drawVertex(v8, v8Col);
  drawVertex(v7, v7Col);

  // left
  drawVertex(v1, v1Col);
  drawVertex(v3, v3Col);
  drawVertex(v7, v7Col);
  drawVertex(v5, v5Col);

  // right
  drawVertex(v2, v2Col);
  drawVertex(v4, v4Col);
  drawVertex(v8, v8Col);
  drawVertex(v6, v6Col);
  endShape();
}

void initCubeCorners() {
  float halfCubeSize = cubeSize / 2;

  v1 = new PVector(-halfCubeSize, halfCubeSize, -halfCubeSize);
  v2 = new PVector( halfCubeSize, halfCubeSize, -halfCubeSize);
  v3 = new PVector(-halfCubeSize, halfCubeSize, halfCubeSize);
  v4 = new PVector( halfCubeSize, halfCubeSize, halfCubeSize);

  v5 = new PVector(-halfCubeSize, -halfCubeSize, -halfCubeSize);
  v6 = new PVector( halfCubeSize, -halfCubeSize, -halfCubeSize);
  v7 = new PVector(-halfCubeSize, -halfCubeSize, halfCubeSize);
  v8 = new PVector( halfCubeSize, -halfCubeSize, halfCubeSize);
}

void initCubeColors(){
  v1Col = color(0, 100, 100);
  v2Col = color(45, 100, 100);
  v3Col = color(90, 100, 100);
  v4Col = color(135, 100, 100);
  
  v5Col = color(180, 100, 100);
  v6Col = color(225, 100, 100);
  v7Col = color(270, 100, 100);
  v8Col = color(315, 100, 100);
}

void drawVertex(PVector pos, color col) {
  fill(col);
  vertex(pos.x, pos.y, pos.z);
}
