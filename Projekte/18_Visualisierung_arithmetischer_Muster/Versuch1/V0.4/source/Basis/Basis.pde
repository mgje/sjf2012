


void setup()
{
 import processing.opengl.*;
 size(255,255, P3D); 
 frameRate(30);
 smooth();
}

void draw()
{
 
 println(frameCount);
 
 for (int iCounter= 255; iCounter > 0; iCounter-=1)
 {
 //fill(RGB,mouseX,mouseY,(mouseX+mouseY)/2);
 if (iCounter % 4 == 0 & iCounter % 3 == 0)
 {
  fill(RGB, 0,0,200); 
 }
 
 
 ellipse(127,127,iCounter-10 , iCounter-10);
 
 }
}
