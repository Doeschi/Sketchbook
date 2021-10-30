// parameters
float armLength;
float angleIncrease;
float offsetIncrease;
float waveScale;
float pointSpacing;

float angleOffset = 0;

void setup(){
  size(800, 400);
}


void draw(){
  
  armLength = 20;
  
  angleIncrease = 0.100;
  offsetIncrease = 0.100;
  pointSpacing = 5.0;
  waveScale = 50;
  
  background(220);
  strokeWeight(5);
  
  // angle between the mouse and the center of the window
  float directionalAngle = atan2(mouseY - (height / 2), mouseX - (width / 2));
  
  translate(width/2, height/2);
  rotate(directionalAngle);
  
  line(0, 0, armLength, 0);
  translate(armLength, 0);
  
  strokeWeight(1);
  float ang = angleOffset;
  
  for(float x = 0; x < width/2; x += pointSpacing){
     float y = (sin(ang) * waveScale) - (sin(angleOffset) * waveScale);
     ellipse(x, y, 2, 2);
     ang += angleIncrease;
  }
  
  angleOffset += offsetIncrease;
  println(frameRate);
    
}
