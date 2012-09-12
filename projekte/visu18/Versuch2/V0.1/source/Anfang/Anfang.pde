int Max =200; //Spielfeldgroesse
int b = 2 ;//Groesse des Punktes

void setup()
{
size(Max,Max);
colorMode(RGB);
}

void draw()
{
 int Posx = Max/2;
 int Posy = Max/2;
 
 for (int iCounter=0; iCounter < 100; iCounter ==)
{
 
 Posx = Posx + ((int)random(0,3)) -1;
 Posy = Posy + ((int)random(0,3)) -1;
 
 //#######################################
 /*
 if (Posx == Max)
 {
  Posx = Posx * -1;
 }
 
 if (Posy == Max)
 {
  Posy = Posy * -1;
 }
 
 //######################################
 
 
 if (Posx == (Max*-1))
 {
  Posx = Posx * -1; 
 }
 
 if (Posy == (Max*-1))
 {
  Posy = Posy * -1; 
 }
 */
 //########################################
 
 fill(0,0,0);
 ellipse(Posx, Posy, b, b);
} 
  
  
}
