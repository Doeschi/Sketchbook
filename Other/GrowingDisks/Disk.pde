public class Disk {

  private PVector pos;
  private float radius;
  private float sizeChangeRate;
  private boolean growing;
  private boolean isToSmall;

  public Disk(PVector pos) {
    this.pos = pos;
    sizeChangeRate = 0.5;
    radius = 1;
    growing = true;
  }

  public void update() {
    if (growing) {
      radius += sizeChangeRate;
    } else {
      radius -= sizeChangeRate;
    }

    if (radius < 1) {
      isToSmall = true;
    } else if (pos.x - radius < 0 || pos.x + radius > width || pos.y - radius < 0 || pos.y + radius > height) {
      startShrink();
    }
  }

  public void checkIntersection(Disk other) {
    float distance = dist(this.pos.x, this.pos.y, other.pos.x, other.pos.y);

    if (distance < this.radius + other.radius) {
      this.startShrink();
      other.startShrink();
    }
  }

  public boolean positionIsInDiskSpace(float newX, float newY) {
    if (dist(this.pos.x, this.pos.y, newX, newY) < radius + 10) {
      return true;
    }

    return false;
  }

  public void show() {
    fill(map(radius, 0, 300, 0, 360), 100, 100);
    circle(pos.x, pos.y, radius*2);
  }

  public boolean isToSmall() {
    return isToSmall;
  }

  public void startShrink() {
    growing = false;
  }
}
