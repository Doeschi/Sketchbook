// inspired by u/Aarwolf: https://www.reddit.com/r/processing/comments/qx2jh3/rings_are_added_to_circles_placed_randomly_until/

Disk[] disks;
int numberOfDisks = 10;

// parameters meant to be changed in draw
float sizeChange;

void setup() {
  size(800, 600);

  disks = new Disk[numberOfDisks];
  for (int i = 0; i < disks.length; i++) {
    disks[i] = new Disk();
  }

  colorMode(HSB, 360, 100, 100);
}


void draw() {
  sizeChange = 0.50;

  background(0, 0, 20);
  noStroke();
  
  for (Disk d : disks) {
    d.show();
    d.update(sizeChange);
  }

  for (int i = 0; i < disks.length; i++) {
    Disk d = disks[i];

    for (int j = i+1; j < disks.length; j++) {
      d.checkIntersection(disks[j]);
    }
  }
  
  // debug
  
  //for (Disk d : disks) {
  //  if (dist(mouseX, mouseY, d.pos.x, d.pos.y) < d.radius) {
  //    float lowestDist = MAX_FLOAT;
  //    Disk closestDisk = null;
  //    for (Disk otherD : disks) {
  //      if (d == otherD) {
  //        continue;
  //      }

  //      float distance = dist(d.pos.x, d.pos.y, otherD.pos.x, otherD.pos.y);
  //      if (distance < lowestDist) {
  //        lowestDist = distance;
  //        closestDisk = otherD;
  //      }
  //    }
      
  //    stroke(0, 0, 100);
  //    line(d.pos.x, d.pos.y, closestDisk.pos.x, closestDisk.pos.y);

  //    break;
  //  }
  //}
}
