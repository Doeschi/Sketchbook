class Particle {
  PVector position;
  PVector velocity;

  Particle() {
    position = new PVector(random(width), random(height));
    velocity = new PVector(0, 0);
  }

  void update(PVector force) {

    force.setMag(0.50);

    velocity.add(force);
    velocity.limit(1.00);

    position.add(velocity);

    if (position.x < 0) {
      position.x = width - 1;
    } else if (position.x >= width) {
      position.x = 0;
    }

    if (position.y < 0) {
      position.y = height - 1;
    } else if (position.y >= height) {
      position.y = 0;
    }
  }

  void show() {
    stroke(#26005E, 2);
    point(position.x, position.y);
  }
}
