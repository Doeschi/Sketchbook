public class MountainRange {
  PShape mountainRange;

  public MountainRange(float baseHeight, float heightFluctuation, float xInc) {
    PVector[] vertecies = new PVector[number_of_mountain_vertecies];

    float highestPeak = MIN_FLOAT;
    float xOff = random(10000); // random perlin noise offset

    for (int i = 0; i < vertecies.length; i++) {
      float xCord = map(i, 0, number_of_mountain_vertecies -1, 0, width);
      float yCord = baseHeight + ((noise(xOff) - 0.5) * 2 * heightFluctuation);

      highestPeak = max(highestPeak, yCord);

      vertecies[i] = new PVector(xCord, yCord);
      xOff += xInc;
    }
    
    // creating the mountain range as a PShape
    mountainRange = createShape();
    mountainRange.beginShape();
    mountainRange.noStroke();

    mountainRange.fill(bottomColor);
    mountainRange.vertex(width, 0);
    mountainRange.vertex(0, 0);

    for (PVector vert : vertecies) {
      // normalize the height of the current vertext compared with the peak height
      // the normalized value is then used to get a lerpt color for the vertex
      float n = norm(vert.y, 0, highestPeak);
      mountainRange.fill(lerpColor(bottomColor, peakColor, n));
      mountainRange.vertex(vert.x, vert.y);
    }

    mountainRange.endShape(CLOSE);
  }

  public void show() {
    shape(mountainRange, 0, 0);
  }
}
