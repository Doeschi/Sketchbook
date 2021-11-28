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

    // distance between the lines of the circle
    float circumferenceDistance = centerDistance - (radius + otherCircle.radius);

    if (centerDistance < radius + otherCircle.radius) {
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
      if (pointDoesNotExists(round(baseX + halfChord.x), round(baseY + halfChord.y), points)) {
        points.add(new PVector(round(baseX + halfChord.x), round(baseY + halfChord.y)));
      }

      if (pointDoesNotExists(round(baseX - halfChord.x), round(baseY - halfChord.y), points)) {
        points.add(new PVector(round(baseX - halfChord.x), round(baseY - halfChord.y)));
      }
    }
    //else if (circumferenceDistance < 0.5 && circumferenceDistance > 0) {
    //  float magnitude = ((radius*radius - otherCircle.radius * otherCircle.radius) + centerDistance * centerDistance) / (2 * centerDistance);
    //  PVector heightOfChord = direction.copy().setMag(magnitude);
    //  PVector p = PVector.add(pos, heightOfChord);
    //  points.add(p);
    //}
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
