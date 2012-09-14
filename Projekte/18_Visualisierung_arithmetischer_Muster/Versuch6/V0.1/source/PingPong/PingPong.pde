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

int iSpieler = 8;

void draw()
{
 int ping = 5;
 int pong = 7;
 int schritt = 25;
 int iCounter = Feldgroesse;
 int felder = Feldgroesse/schritt;
 generierefeld();
 fillup();
  
}


void generierefeld()
{
 int Feld=800/iSpieler;
 int xpos=100;
 int ypos=0;
 println(Feld);
 
 for (int iCounter =0; iCounter < iSpieler; iCounter++)
 {
 fill(255,255,255);
 rect(xpos,ypos,Feld,1000);
 xpos=xpos+Feld;
 }

}

void fillup()
{
  
}

