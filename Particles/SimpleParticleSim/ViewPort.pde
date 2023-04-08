class ViewPort {
  float x1, y1, x2, y2;

  public ViewPort(float x1, float y1, float x2, float y2) {
    this.x1 = x1;
    this.y1 = y1;
    this.x2 = x2;
    this.y2 = y2;
  }

  public float mapScreenCordX(float x) {
    return map(x, 0, width, x1, x2);
  }

  public float mapScreenCordY(float y) {
    return  map(y, 0, height, y1, y2);
  }

  public boolean isInViewPort(Particle p) {
    return !(p.pos.x + p.radius < x1 || p.pos.x - p.radius > x2 || p.pos.y + p.radius < y1 || p.pos.y - p.radius > y2);
  }
}
