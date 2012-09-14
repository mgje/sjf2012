


void setup()
{
 import processing.opengl.*;
 size(255,255, P3D); 
 frameRate(2);
 smooth();
}

void draw()
{
 
 println(frameCount);
 
 for (int iCounter= 255; iCounter > 0; iCounter-=10)
 {
 fill(RGB,mouseX,mouseY,(mouseX+mouseY)/2);
 ellipse(127,127,iCounter , iCounter);
 
  for (int iCounter= 255; iCounter > 0; iCounter-=10)
 
 }
}
