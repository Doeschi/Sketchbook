class Particle {
  float radius;
  float mass;
  PVector pos;
  PVector vel;
  color col;

  public Particle(float x, float y, float radius, float mass,PVector initialVel, color col) {
    this.radius = radius;
    this.mass = mass;
    this.pos = new PVector(x, y);
    this.vel = initialVel;
    this.col = col;
  }

  public void move() {
    pos.add(vel);
  }

  public void avoidBorder() {
    if (pos.x < radius) {
      vel.x = -vel.x;
      pos.x = radius;
    } else if (pos.x + radius > width) {
      vel.x = -vel.x;
      pos.x = width - radius;
    }

    if (pos.y < radius) {
      vel.y = -vel.y;
      pos.y = radius;
    } else if (pos.y + radius > height) {
      vel.y = -vel.y;
      pos.y = height - radius;
    }
  }

  public void render() {
    noStroke();
    fill(col);
    circle(map(pos.x, viewPort.x1, viewPort.x2, 0, width),  map(pos.y, viewPort.y1, viewPort.y2, 0, height), radius * 2 * viewPort.scale);
  }
}
