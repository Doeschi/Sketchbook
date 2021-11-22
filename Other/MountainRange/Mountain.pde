public class Mountain {
  PVector[] vertecies;
  float highestPeak;

  public Mountain(float baseHeight, float heightFluctuation, float xInc) {
    vertecies = new PVector[number_of_mountain_vertecies];

    highestPeak = MIN_FLOAT;
    float xOff = random(10000);

    for (int i = 0; i < vertecies.length; i++) {
      float xCord = map(i, 0, number_of_mountain_vertecies -1, 0, width);
      float yCord = baseHeight + ((noise(xOff) - 0.5) * 2 * heightFluctuation);

      highestPeak = max(highestPeak, yCord);

      vertecies[i] = new PVector(xCord, yCord);
      xOff += xInc;
    }
  }

  public void show() {
    noStroke();
    beginShape();

    fill(bottomColor);
    vertex(width, 0);
    vertex(0, 0);

    for (PVector vert : vertecies) {

      float n = norm(vert.y, 0, highestPeak);
      fill(lerpColor(bottomColor, peakColor, n));
      vertex(vert.x, vert.y);
    }

    endShape(CLOSE);
  }
}
