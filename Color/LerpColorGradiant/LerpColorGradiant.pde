void setup(){
  size(600, 300);
  strokeWeight(1);
  
  color fromCol = color(0,0,255);
  color toCol = color(0,255,0);
  
  float normWidth;

  for(int i = 0; i < width; i++){
      normWidth = norm(i, 0, width);
      color col = lerpColor(fromCol, toCol, normWidth);
      stroke(col);
      line(i, 0, i, height);
  }
}
