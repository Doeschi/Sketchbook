public class Disk {

  private PVector pos;
  private float radius;

  private boolean growing;

  public Disk() {
    pos = new PVector();
    initDisk();
  }

  public void update(float sizeChange) {
    if (growing) {
      radius += sizeChange;
    } else {
      radius -= sizeChange;
    }

    if (radius < 1) {
      initDisk();
    } else if (pos.x - radius < 0 || pos.x + radius > width || pos.y - radius < 0 || pos.y + radius > height) {
      startShrink();
    }
  }

  public void checkIntersection(Disk other) {
    float distance = dist(this.pos.x, this.pos.y, other.pos.x, other.pos.y);

    if (distance < this.radius + other.radius) {
      this.startShrink();
      other.startShrink();

      //this.update();
      //other.update();
    }
  }

  public void startShrink() {
    growing = false;
  }

  public void initDisk() {
    pos.set(random(20, width - 20), random(20, height - 20));
    radius = 1;
    growing = true;
  }

  public void show() {
    fill(map(radius, 0, 300, 0, 360), 100, 100);
    circle(pos.x, pos.y, radius*2);
  }
}
