
void setup(){
  size(800, 600);  
  noSmooth();
}

void draw(){
  background(220);
  
  float randomSpace = 2.0;
  float gridSpacing = 10.0;
  
  for(int x = 0; x < width; x += gridSpacing){
    for(int y = 0; y < height; y += gridSpacing){
      
      float xPos = x + random(-randomSpace, randomSpace);
      float yPos = y + random(-randomSpace, randomSpace);
      
      point(xPos, yPos);
    
    }
  
  }

}
