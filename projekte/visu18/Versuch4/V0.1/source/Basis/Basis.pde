int Feldgroesse = 1000;
int ping = 5;
int pong = 7;
int anzKinder = 6;
int groesseKind = 100;
float kreisradius = 300;

float posX;
float posY;
float Kinderabstand = 2*cos(radians((180 - (360/anzKinder))/2))*kreisradius; // um den Abstand zwischen den Kinder zu berechnen 

void setup()
{
 
 size(Feldgroesse, Feldgroesse, P3D); 
 colorMode(RGB);
 frameRate(1);
 smooth();
 strokeWeight(4);
 
}

void draw()
{
 posX = Feldgroesse/2;
 posY = Feldgroesse/2-kreisradius;
 
 pushMatrix();
 for (int iCounter = 1;  iCounter <= anzKinder; iCounter++)
 {

   
   ellipse(0, 0, groesseKind, groesseKind);
   rotate(TWO_PI/anzKinder);
   translate(Kinderabstand,0);
 }
 
 translate(posX, posY); // Wieso macht er diesen translate nicht ?
 popMatrix();
 
 

/* if (felder % ping == 0 && felder % pong == 0) //PING - PONG 
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
 }*/
 
 
 
}
