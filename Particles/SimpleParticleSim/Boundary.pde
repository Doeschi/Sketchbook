class Boundary {
  float x, y;
  float w; // distance from center to left and right edge
  float h; // distance from center to upper and lower edge
  float leftEdge, rightEdge, topEdge, bottomEdge;

  public Boundary(float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    
    this.leftEdge = x - w;
    this.rightEdge = x + w;
    this.topEdge = y - h;
    this.bottomEdge = y + h;
  }
}
