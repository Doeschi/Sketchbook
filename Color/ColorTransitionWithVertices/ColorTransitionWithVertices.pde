void setup(){
  size(600,300,P2D);
  
  color fromCol = color(0,0,255);
  color toCol = color(0,255,0);
  
  beginShape(QUADS);
  
  fill(fromCol);
  vertex(0,0);
  vertex(0,height);
  
  fill(toCol);
  vertex(width, height);
  vertex(width, 0);
  
  endShape();
}
