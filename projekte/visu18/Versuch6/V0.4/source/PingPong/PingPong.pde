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
int iZahl = 1;
int ping = 5;
int pong = 7;
int iNummer = 1;
int iRichtung = 1;  
int xpos=0;
int ypos=0;
int iSpeed = 1;

void draw()
{
 if (frameCount % iSpeed == 0)
 {
   int schritt = 25;
   int iCounter = Feldgroesse;
   generierefeld();
   fillup();
 
 }
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

  int Feld=Feldgroesse/iSpieler;
  int Feldb = 10;
  
  if (iZahl % ping == 0 && iZahl % pong == 0)
  {
   fill(0,255,0);  //Grün
   ypos = ypos+Feldb; 
   
  }
  else if (iZahl % ping == 0)
  {
   fill(0,0,255); //Blau
   iRichtung = iRichtung *-1; 
   ypos = ypos+Feldb;
  }
  else if (iZahl % pong == 0)
  {
   fill(212,212,0);  //Gelb
   iRichtung = iRichtung *-1; 
   ypos = ypos+Feldb;   
  }
  else
  {
   fill(127,127,127);
   
  }  
  
  if (iNummer == 0)
  {
   iNummer = 8; 
  }
  
  if (iNummer == 9)
  {
   iNummer = 1; 
  }
  
  
  rect(xpos+(Feld*iNummer)-Feld,ypos, Feld,Feldb);
  iZahl++;
  iNummer=iNummer+iRichtung;
  
  
}

void keyPressed()
{
   switch(key)
  {
   case 
  } 
}
