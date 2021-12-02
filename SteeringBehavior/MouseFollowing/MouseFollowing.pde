// source: Sebastian Lague - https://www.youtube.com/watch?v=X-iSQQgOd1A&t=307s (at 5:07)

// variables
PVector pos;
PVector vel;

boolean easingIsActive;

// parameters meant to be changed in draw
float maxSpeed;
float steerStrength;
float easing;

void setup() {
  size(800, 600);

  pos = new PVector(width/2, height/2);
  vel = new PVector(0, 0);
  
  easingIsActive = true;
}

void mouseClicked() {
  easingIsActive = !easingIsActive;
  println("EasingIsActive: " + easingIsActive);
}

void draw() {
  maxSpeed = 2.00;
  steerStrength = 0.05;

  if (easingIsActive) {
    easing = 0.03;
  } else {
    easing = 1;
  }

  background(220);

  PVector desiredDirection = new PVector(mouseX - pos.x, mouseY - pos.y);
  PVector desiredVelocity = PVector.mult(desiredDirection, easing).limit(maxSpeed);
  PVector desiredSteeringForce = PVector.sub(desiredVelocity, vel).mult(steerStrength);
  PVector accelerationForce = desiredSteeringForce.limit(steerStrength);

  if (accelerationForce.mag() > 0.00001) {
    vel.add(accelerationForce);
    vel.limit(maxSpeed);
    pos.add(vel);
  }

  fill(30);
  circle(pos.x, pos.y, 20);
}
