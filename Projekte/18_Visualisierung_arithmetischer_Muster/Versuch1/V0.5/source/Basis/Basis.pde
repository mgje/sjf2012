 int Feldgroesse = 1000;



void setup()
{
 import processing.opengl.*;
 size(Feldgroesse, Feldgroesse, P3D); 
 colorMode(RGB);
 frameRate(30);
 smooth();
 strokeWeight(2);
}

void draw()
{
 int ping = 5;
 int pong = 7;
 int schritt = 25;
 int iCounter = Feldgroesse;
 int felder = Feldgroesse/schritt;
 
 for (;  iCounter > 0; iCounter-=schritt, felder--)
 {


 if (felder % ping == 0 && felder % pong == 0) //PING - PONG 
 {
  fill(0,200,0);  //Gruen
 }
 else if (felder % ping == 0)
 {
   fill(0, 0, 200); // Blau
 }
 else if (felder % pong == 0)
 {
   fill(200, 200, 0); //Gelb
 }
 else
 {
   fill(255,255,255); //weiss
 }
 ellipse(Feldgroesse/2,Feldgroesse/2,iCounter , iCounter);
 
 }
}
