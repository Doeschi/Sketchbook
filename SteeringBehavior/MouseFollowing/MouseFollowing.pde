// variables
PVector pos;
PVector vel;


void setup() {
  size(800, 600);

  pos = new PVector(width/2, height/2);
  vel = new PVector(0, 0);
}


void draw() {
  float maxSpeed = 120.00;
  float steerStrength = 0.05;

  background(255);

  PVector desiredDirection = new PVector(mouseX - pos.x, mouseY - pos.y);
  desiredDirection.normalize();

  PVector desiredVelocity = PVector.mult(desiredDirection, maxSpeed);
  PVector desiredSteeringForce = PVector.sub(desiredVelocity, vel).mult(steerStrength);
  PVector acceleration = desiredSteeringForce.copy().limit(steerStrength);

  vel.add(acceleration);
  vel.limit(maxSpeed);

  pos.add(vel);

  fill(0);
  circle(pos.x, pos.y, 20);
}
