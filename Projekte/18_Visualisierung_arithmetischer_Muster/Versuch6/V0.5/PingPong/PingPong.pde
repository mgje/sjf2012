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
 background(0,0,0);
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
   iNummer = iSpieler; 
  }
  
  if (iNummer == iSpieler+1)
  {
   iNummer = 1; 
  }
  
  
  rect(xpos+(Feld*iNummer)-Feld,ypos, Feld,Feldb);
  iZahl++;
  iNummer=iNummer+iRichtung;
  println(iSpieler);
  
}

void keyPressed()
{
   switch(key)
  {
       case '+': //Speed Up
   {
    if (iSpeed > 1)
     {
      iSpeed--;
     } 
      break;      
   }
   case '-': //Speed down
   {
     iSpeed++;
     break;
   }
   case '1': //Ping Grösser
   {
    if (ping < 9) //Check grösse als 9
     {
      ping++;
      generiert = true; 
      ypos=0;
      iNummer=1;
      iZahl=1;
     }
     break;
   }
   case '2': //Ping Kleiner
    {
      if (ping > 1)
      {
       ping--;
       generiert = true;
       ypos=0; 
       iNummer=1;
       iZahl=1;
      }
      break;
    }
   case '3': //pong Grösser
    {
      if (pong < 9)
      {
       pong++; 
       generiert = true; 
       ypos=0;
       iNummer=1;
       iZahl=1;
      }
      break;
    }
   case '4': //pong Kleiner
    {
      if (pong > 1)
      {
       pong--; 
       generiert = true; 
       ypos=0;
       iNummer=1;
       iZahl=1;
      }
    }
   case 'r': //Mehr Spieler
    {
       iSpieler=iSpieler+1;
       generiert = true; 
       ypos=0;
       iNummer=1;
       iZahl=1;
     }      
   case 'f': //Weniger Spieler
    {
      if (iSpieler > 1)
      {
       iSpieler--;
       generiert = true; 
       ypos=0;
       iNummer=1;
       iZahl=1;
      }
      
      break;
  } 
    }
  }
