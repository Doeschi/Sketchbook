// source: https://mathworld.wolfram.com/Chord.html //<>//

class Circle {

  PVector pos;
  float radius;

  public Circle(PVector pos, float radius) {
    this.pos = pos;
    this.radius = radius;
  }

  public void addIntersectionPoints(Circle otherCircle, ArrayList<PVector> points) {
    // vector between the two centers
    PVector direction = PVector.sub(otherCircle.pos, pos);

    float centerDistance = direction.mag();

    if (centerDistance <= radius + otherCircle.radius) {
      // magnitude (distance) to the chord, which lies between the two intersction points
      float magnitude = ((radius*radius - otherCircle.radius*otherCircle.radius) + centerDistance*centerDistance) / (2 * centerDistance);
      PVector distanceFromCenterToChord = direction.copy().setMag(magnitude);

      // calc half the lenght of the chord with pythagoras
      float halfChordLength = sqrt(radius*radius - distanceFromCenterToChord.mag()*distanceFromCenterToChord.mag());
      // create a vector pointing from the distanceFromCenterToChord to the circle intersections
      PVector halfChord = distanceFromCenterToChord.copy().rotate(HALF_PI);
      halfChord.setMag(halfChordLength);

      float baseX = pos.x + distanceFromCenterToChord.x;
      float baseY = pos.y + distanceFromCenterToChord.y;

      // only add new intersections if they doesnt exists yet
      // first intersection
      if (pointDoesNotExists(baseX + halfChord.x, baseY + halfChord.y, points)) {
        points.add(new PVector(baseX + halfChord.x, baseY + halfChord.y));
      }
      
      // second intersection, if there is one
      if (pointDoesNotExists(baseX - halfChord.x, baseY - halfChord.y, points)) {
        points.add(new PVector(baseX - halfChord.x, baseY - halfChord.y));
      }
    }
  }

  private boolean pointDoesNotExists(float newX, float newY, ArrayList<PVector> points) {
    for (PVector p : points) {
      if (p.x == newX && p.y == newY) {
        return false;
      }
    }

    return true;
  }

  public void show() {
    ellipse(pos.x, pos.y, radius*2, radius*2);
  }
}
