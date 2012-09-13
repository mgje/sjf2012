


void setup()
{
 import processing.opengl.*;
 size(500, 500, P3D); 
 colorMode(RGB);
 frameRate(30);
 smooth();
}

void draw()
{
 
 println(frameCount);
 boolean farbe = true;
 int iFarbe=25;
 for (int iCounter= 500; iCounter > 0; iCounter-=20)
 {
 //fill(RGB,mouseX,mouseY,(mouseX+mouseY)/2);


 if (iFarbe % 4 == 0 && iFarbe % 3 == 0)
 {
  fill(0,200,0); 
 }
 else if (iFarbe % 4 == 0)
 {
   fill(0, 0, 200);
 }
 else if (iFarbe % 3 == 0)
 {
   fill(200, 200, 0);
 }
 else
 {
   fill(255,255,255); 
 }
 iFarbe-=1;
 ellipse(250,250,iCounter , iCounter);
 
 }
}
