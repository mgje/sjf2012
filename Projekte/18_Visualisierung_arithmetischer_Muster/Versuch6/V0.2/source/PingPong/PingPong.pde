int Feldgroesse = 1000;

void setup()
{
 import processing.opengl.*;
 size(Feldgroesse, Feldgroesse, P3D); 
 colorMode(RGB);
 frameRate(30);
 smooth();
 strokeWeight(2);
 background(0,0,0);
}

int iSpieler = 8;
int iNummer = 1;
int iRichtung = 1;
int Feldb = 10;
int iZahl = 1;
int ping = 5;
int pong = 7;

void draw()
{

 int schritt = 25;
 int iCounter = Feldgroesse;
 generierefeld();
 fillup();
 
 
}

boolean generiert = true;
void generierefeld()
{

 if (generiert)
 {
 int xpos=0;
 int ypos=0;
 int Feld=Feldgroesse/iSpieler;
 generiert = false;

 for (int iCounter =0; iCounter < iSpieler; iCounter++)
 {
   
   
 fill(255,255,255);
 rect(xpos,ypos,Feld,1000);

 xpos=xpos+Feld;
 }
 }
}

void fillup()
{
  
  
  /*
  if (iZahl % ping == 0 && iZahl % pong == 0)
  {
   fill(0,255,0);  //Grün
   iNummer= iNummer+iRichtung;
   
  }
  else if (iZahl % ping == 0)
  {
   fill(0,0,255); //Blau
   iRichtung = iRichtung *-1; 
   iNummer= iNummer+iRichtung;
   ypos = ypos+Feldb;
  }
  else if (iZahl % pong == 0)
  {
   fill(212,212,0);  //Gelb
   iRichtung = iRichtung *-1; 
   iNummer= iNummer+iRichtung;
   ypos = ypos+Feldb;   
   
  }
  else
  {
   fill(255,255,255);
   iNummer= iNummer+iRichtung;
  }  
  if (iNummer == 0)
  {
   iNummer = 8; 
  }
  
  if (iNummer == 9)
  {
   iNummer = 1;
  }
  int Feld=800/iSpieler;
  rect(xpos+(Feld*iNummer*iRichtung),ypos, Feld, Feldb);
  
  */
  
  
  
}

