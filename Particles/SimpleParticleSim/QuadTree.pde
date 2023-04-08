class QuadTree {
  int capacity;
  Boundary boundary;
  ArrayList<Particle> particles;

  boolean hasChildren;
  QuadTree topLeft;
  QuadTree topRight;
  QuadTree bottomLeft;
  QuadTree bottomRight;

  int depth;

  public QuadTree(Boundary boundary, int capacity, int depth) {
    this.boundary = boundary;
    this.capacity = capacity;
    this.particles = new ArrayList();
    this.hasChildren = false;
    this.depth = depth;
  }

  public int getMaxDepth() {
    if (hasChildren) {
      int[] depths = {topLeft.getMaxDepth(), topRight.getMaxDepth(), bottomLeft.getMaxDepth(), bottomRight.getMaxDepth()};
      return max(depths);
    } else {
      return depth;
    }
  }

  public void render() {
    if (hasChildren && viewPort.isInViewPort(boundary)) {
      stroke(depth * 30, 100,100);
      float x = map(boundary.x, viewPort.x1, viewPort.x2, 0, width);
      float y = map(boundary.y, viewPort.y1, viewPort.y2, 0, height);
      float w = boundary.w * viewPort.scale;
      float h = boundary.h * viewPort.scale;
      line(x - w, y, x + w, y);
      line(x, y - h, x, y + h);
      topLeft.render();
      topRight.render();
      bottomLeft.render();
      bottomRight.render();
    }
  }

  public boolean isInBoundary(float x1, float y1, float x2, float y2) {
    return !(x1 > boundary.rightEdge || x2 < boundary.leftEdge || y1 > boundary.bottomEdge || y2 < boundary.topEdge);
  }

  public ArrayList<Particle> query(float x1, float y1, float x2, float y2) {
    ArrayList<Particle> containingParticles = new ArrayList();

    if (!isInBoundary(x1, y1, x2, y2)) {
      return containingParticles;
    }

    if (hasChildren) {
      containingParticles.addAll(topLeft.query(x1, y1, x2, y2));
      containingParticles.addAll(topRight.query(x1, y1, x2, y2));
      containingParticles.addAll(bottomLeft.query(x1, y1, x2, y2));
      containingParticles.addAll(bottomRight.query(x1, y1, x2, y2));

      return containingParticles;
    } else {
      return particles;
    }
  }

  public void reset() {
    if (hasChildren) {
      topLeft.reset();
      topRight.reset();
      bottomLeft.reset();
      bottomRight.reset();
      hasChildren = false;
    } else {
      particles.clear();
    }
  }

  public void insert(Particle p) {
    if (hasChildren) {
      getCorrespondingTree(p).insert(p);
    } else {
      particles.add(p);

      if (particles.size() >= capacity) {
        subdivide();
      }
    }
  }

  private void subdivide() {
    hasChildren = true;

    Boundary topLeftBoundary = new Boundary(boundary.x - (boundary.w / 2), boundary.y - (boundary.h / 2), boundary.w / 2, boundary.h / 2);
    topLeft = new QuadTree(topLeftBoundary, capacity, depth + 1);

    Boundary topRightBoundary = new Boundary(boundary.x + (boundary.w / 2), boundary.y - (boundary.h / 2), boundary.w / 2, boundary.h / 2);
    topRight = new QuadTree(topRightBoundary, capacity, depth + 1);

    Boundary bottomLeftBoundary = new Boundary(boundary.x - (boundary.w / 2), boundary.y + (boundary.h / 2), boundary.w / 2, boundary.h / 2);
    bottomLeft = new QuadTree(bottomLeftBoundary, capacity, depth + 1);

    Boundary bottomRightBoundary = new Boundary(boundary.x + (boundary.w / 2), boundary.y + (boundary.h / 2), boundary.w / 2, boundary.h / 2);
    bottomRight = new QuadTree(bottomRightBoundary, capacity, depth + 1);

    for (Particle p : particles) {
      getCorrespondingTree(p).insert(p);
    }

    particles.clear();
  }

  private QuadTree getCorrespondingTree(Particle p) {
    if (p.pos.x <= boundary.x && p.pos.y <= boundary.y) {
      return topLeft;
    } else if (p.pos.x > boundary.x && p.pos.y <= boundary.y) {
      return topRight;
    } else if (p.pos.x <= boundary.x && p.pos.y > boundary.y) {
      return bottomLeft;
    } else {
      return bottomRight;
    }
  }
}
