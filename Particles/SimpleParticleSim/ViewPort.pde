class ViewPort { //<>//
  float x1, y1, x2, y2;
  float referenceWidth, referenceHeight;
  float scale;

  public ViewPort(float x1, float y1, float x2, float y2) {
    this.x1 = x1;
    this.y1 = y1;
    this.x2 = x2;
    this.y2 = y2;
    this.scale = 1.0;
    this.referenceWidth = abs(x2 - x1);
    this.referenceHeight = abs(y2 - y1);
  }

  public boolean isInViewPort(Particle p) {
    return !(p.pos.x + p.radius < x1 || p.pos.x - p.radius > x2 || p.pos.y + p.radius < y1 || p.pos.y - p.radius > y2);
  }

  public boolean isInViewPort(Boundary b) {
    return !(b.rightEdge < x1 || b.leftEdge > x2 || b.bottomEdge < y1 || b.topEdge > y2);
  }

  public void zoomIn() {
    scale += 0.1;
    updateViewPort();
  }

  public void zoomOut() {
    scale -= 0.1;

    if (scale < 0.1) {
      scale = 0.1;
    }

    updateViewPort();
  }

  public void move() {
    float deltaX = map(mouseX, 0, width, x1, x2) - map(pmouseX, 0, width, x1, x2);
    float deltaY = map(mouseY, 0, height, y1, y2) - map(pmouseY, 0, height, y1, y2);

    x1 -= deltaX;
    x2 -= deltaX;

    y1 -= deltaY;
    y2 -= deltaY;
  }

  private void updateViewPort() {
    float currentWidth = x2 - x1;
    float newWidth = referenceWidth * (1 / scale);

    float leftFactor = map(mouseX, 0, width, 0, 1);

    float widthDifference = currentWidth - newWidth;
    x1 += widthDifference * leftFactor;
    x2 -= widthDifference * (1 - leftFactor);

    float currentHeight = y2 - y1;
    float newHeight = referenceHeight * (1 / scale);

    float topFactor = map(mouseY, 0, height, 0, 1);
    float heightDifference = currentHeight - newHeight;
    y1 += heightDifference * topFactor;
    y2 -= heightDifference * (1 - topFactor);
  }
}
