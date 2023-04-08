// inspiration: https://www.youtube.com/watch?v=ThhdlMbGT5g

// variables
ArrayList<Particle> particles;
int initialNumberOfParticles = 10;

int colorWheel = 0;
float timeStep = 1.0f/60.0f;

float restitution = 0.85;
float minRadius = 0.5;
float maxRadius = 1.0;
boolean renderParticles = true;
boolean renderQuadTree = false;

QuadTree quadTree;
ViewPort viewPort;

// parameters meant to be changed in draw


void setup() {
  size(800, 600, P2D);
  colorMode(HSB, 360, 100, 100);
  viewPort = new ViewPort(0, 0, width, height);
  initParticles();
}


void draw() {
  background(258, 60, 18);
  println(frameRate, particles.size(), quadTree.getMaxDepth());

  buildQuadTree();

  for (int i = 0; i < particles.size(); i++) {
    Particle p = particles.get(i);
    p.move();
    handleBallCollision(p);
    p.avoidBorder();
    if (renderParticles && viewPort.isInViewPort(p)) {
      p.render();
    }
  }

  if (renderQuadTree) {
    quadTree.render();
  }

  if (mousePressed) {
    PVector initialVel = new PVector(mouseX - pmouseX, mouseY - pmouseY).limit(5);
    float radius = pickParticleRadius();
    float mass = pickParticleMass(radius);
    Particle p = new Particle(mouseX + random(-1, 1), mouseY + random(-1, 1), radius, mass, initialVel, pickParticleColor());
    particles.add(p);
  }

  if (frameCount % 10 == 0) {
    PVector initialVel = new PVector(1, 1).mult(random(1, 2));
    float heading = radians((frameCount / 1) % 360);
    initialVel.setHeading(heading);
    float radius = pickParticleRadius();
    float mass = pickParticleMass(radius);
    particles.add(new Particle(width / 2, height / 2, radius, mass, initialVel, pickParticleColor()));
  }
}

void keyPressed() {
  if (key == 'p') {
    renderParticles = !renderParticles;
  } else if (key == 'q') {
    renderQuadTree = !renderQuadTree;
  } else if (key == 'r') {
    initParticles();
  }
}

void handleBallCollision(Particle p) {
  float maxRelevantDist = (maxRadius * 2) + 2;
  ArrayList<Particle> nearbyParticles = quadTree.query(p.pos.x - maxRelevantDist, p.pos.y - maxRelevantDist, p.pos.x + maxRelevantDist, p.pos.y + maxRelevantDist);

  for (Particle otherP : nearbyParticles) {
    PVector dir = PVector.sub(otherP.pos, p.pos);
    float distance = PVector.dist(p.pos, otherP.pos);

    if (distance == 0.0 || distance > p.radius + otherP.radius) {
      continue;
    }

    dir.mult(1.0 / distance);

    float correctionFactor = (p.radius + otherP.radius - distance) / 2.0;
    p.pos.add(PVector.mult(dir, -correctionFactor));
    otherP.pos.add(PVector.mult(dir, correctionFactor));

    float v1 = p.vel.dot(dir);
    float v2 = otherP.vel.dot(dir);

    float m1 = p.mass;
    float m2 = otherP.mass;

    float newV1 = (m1 * v1 + m2 * v2 - m2 * (v1 - v2) * restitution) / (m1 + m2);
    float newV2 = (m1 * v1 + m2 * v2 - m1 * (v2 - v1) * restitution) / (m1 + m2);

    p.vel.add(PVector.mult(dir, newV1 - v1));
    otherP.vel.add(PVector.mult(dir, newV2 - v2));
  }
}

void buildQuadTree() {
  quadTree.reset();

  for (Particle p : particles) {
    quadTree.insert(p);
  }
}

float pickParticleRadius() {
  return random(minRadius, maxRadius);
}

float pickParticleMass(float radius) {
  return PI * radius * radius;
}

color pickParticleColor() {
  colorWheel = (colorWheel + 1) % 360;
  return color(colorWheel, 65, 100);
}

void initParticles() {
  particles = new ArrayList(initialNumberOfParticles);
  quadTree = new QuadTree(new Boundary(width / 2, height / 2, width / 2, height / 2), 20, 1);

  for (int i = 0; i < initialNumberOfParticles; i++) {
    PVector initialVel = PVector.random2D().setMag(random(1, 2));
    float radius = pickParticleRadius();
    float mass = pickParticleMass(radius);
    Particle p = new Particle(random(width), random(height), radius, mass, initialVel, pickParticleColor());
    particles.add(p);
    quadTree.insert(p);
  }
}
