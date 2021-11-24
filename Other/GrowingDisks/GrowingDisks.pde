// inspired by u/Aarwolf: https://www.reddit.com/r/processing/comments/qx2jh3/rings_are_added_to_circles_placed_randomly_until/

ArrayList<Disk> disks;
int maxNumberOfDisks = 50;

// parameters meant to be changed in draw
float sizeChange;

void setup() {
  size(800, 600);

  disks = new ArrayList<>();
  colorMode(HSB, 360, 100, 100);
}

void draw() {

  sizeChange = 0.50;

  background(0, 0, 20);
  noStroke();

  spawnNewDisk();

  // update and show Disks
  for (Disk d : disks){
    d.show();
    d.update();
  }
  
  // delete all the tiny disks
  for (int i = 0; i < disks.size(); i++) {
    Disk d = disks.get(i);

    if (d.isToSmall()) {
      disks.remove(d);
    }
  }

  // check if a disk hits another disk
  for (int i = 0; i < disks.size(); i++) {
    Disk d = disks.get(i);

    for (int j = i+1; j < disks.size(); j++) {
      d.checkIntersection(disks.get(j));
    }
  }

  // drawing a line from the disk the mouse is hovering above 
  // to its closest disk 
  for (Disk d : disks) {
    if (dist(mouseX, mouseY, d.pos.x, d.pos.y) < d.radius) {
      float lowestDist = MAX_FLOAT;
      Disk closestDisk = null;
      for (Disk otherD : disks) {
        if (d == otherD) {
          continue;
        }

        float distance = dist(d.pos.x, d.pos.y, otherD.pos.x, otherD.pos.y);
        if (distance < lowestDist) {
          lowestDist = distance;
          closestDisk = otherD;
        }
      }

      stroke(0, 0, 100);
      line(d.pos.x, d.pos.y, closestDisk.pos.x, closestDisk.pos.y);

      break;
    }
  }
}

void spawnNewDisk() {
  if (disks.size() < maxNumberOfDisks) {

    float newX = random(20, width - 20);
    float newY = random(20, height - 20);

    for (Disk d : disks) {
      if (d.positionIsInDiskSpace(newX, newY)) {
        return;
      }
    }

    disks.add(new Disk(new PVector(newX, newY)));
  }
}
