
float lengthReduction = 0.75;
float strokeReudction = 0.85;
int max = 11;


void setup(){
  size(600, 800);
  stroke(100, 50, 0, 200);
}
void draw(){
  background(220);
  translate(width / 2, height - 110);
  strokeWeight(5);
  line(0,0, 0, 100);
  drawBranch(-100, max, 5* 0.9);
}

void drawBranch(float len, int maxBranches, float strokeW){
  float angle = 0.35;
  
  if(abs(len) < 1 || maxBranches == 0){
    return;
  }
  
  // left branch
  rotate(angle);
  strokeWeight(strokeW);
  line(0, 0, 0, len);
  translate(0, len);
  drawBranch(len * lengthReduction, maxBranches - 1, strokeW * strokeReudction);
  translate(0, -len);
  rotate(-angle);
  
  // right branch
  rotate(-angle);
  strokeWeight(strokeW);
  line(0, 0, 0, len);
  translate(0, len);
  drawBranch(len * lengthReduction, maxBranches - 1, strokeW * strokeReudction);
  translate(0, -len);
  rotate(angle);
}
