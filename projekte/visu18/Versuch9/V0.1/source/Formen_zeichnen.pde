// Davud Evren
// 11/09/12

void setup()
{
  size(1200,800);  
  background(color(255,255,255));
  noFill();
  smooth();
}

void draw()
{
 
  //background(color(255,255,255));
  if(mousePressed)
  {
    pushMatrix();
    translate(width/2,height/2);
    
    int circleResolution = (int) map(mouseY+100, 0,height, 2,10);
    float radius = mouseX-width/2 + 0.5;
    float angle = TWO_PI/circleResolution;
    
    strokeWeight(2);
    stroke(0, 25);
    
    beginShape();
    for (int i = 0 ; i <= circleResolution ; i++ )
   {
     float x = cos(angle*i) * radius;
     float y = sin(angle*i) * radius;
     //line(0,0, x,y);
     
     vertex(x,y);
   }
    endShape();
   popMatrix(); 
  }

}

void keyPressed()
{
  switch(key)
  {
    case ' ': background(color(255,255,255));
    
  }
}
