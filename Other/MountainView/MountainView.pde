/** inspiration:
 - https://t4.ftcdn.net/jpg/02/74/66/23/400_F_274662346_bBUKsDQ7g1erp5m5fttSh2HoqcWufA67.jpg
 - https://cdn5.vectorstock.com/i/1000x1000/19/19/blue-mountain-landscape-mountains-misty-vector-26211919.jpg
 - https://www.google.com/search?q=blue+mountains+morning
 - https://assets.vogue.com/photos/595410f9b0480b0ec94bc147/master/w_2560%2Cc_limit/00-lede-moganshan-vacation-from-shanghai-china.jpg
 **/

// variables
int number_of_mountain_vertecies;
color peakColor = color(0, 0, 255);
color bottomColor = 0xFFFFFFFF;

ArrayList<MountainRange> mountains;

// parameters meant to be changed in draw

void setup() {
  size(1200, 800, P2D);
  number_of_mountain_vertecies = width/2;
  smooth(4);
  noLoop();
}



void mousePressed() {
  redraw();
}


void draw() {
  background(255);
  
  // TODO: 
  // a mountain should have a depth 
  // -> color should vary between depths
  // -> bottom color should be based of the peak color 
  //    -> the closer the mountain, the lower the diffrence between the peak and bottom color
  initMountains();
  
  // translates (0,0) to the bottem left corner and (widht,height) to the top right corner
  translate(0, height);
  scale(1, -1);
  
  // draw the mountains
  for (MountainRange m : mountains) {
    m.show();
  }
}

void initMountains() {
  mountains = new ArrayList();
  
  MountainRange m = new MountainRange(500, random(150, 250), random(0.005, 0.015));
  MountainRange m2 = new MountainRange(400, random(150, 250), random(0.005, 0.015));
  
  mountains.add(m);
  mountains.add(m2);
}
