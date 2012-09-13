


void setup()
{
 import processing.opengl.*;
 size(500,500, P3D); 
 frameRate(30);
}

void draw()
{
 
 println(frameCount);
 
 for (int iCounter= 500; iCounter > 0; iCounter-=20)
 {
 fill(frameCount);
 ellipse(250,250,iCounter , iCounter);
 }
}
