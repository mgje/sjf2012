/*
##############################################################################

Versuch 6: Tabelle

Diese Tabelle kann eine beliebige Anzahl Spieler haben. 
Ping: Blau
Pong: Gelb
Ping-Pong: Grün

Steuerung:
r: Mehr Spieler
f: Weniger Spieler
+: Geschwindigkeit erhöhen.
-: Geschwindigkeit drosseln.
1: Ping vergrössern.
2: Ping verkleinern.
3: Pong vergrössern.
4: Pong verkleinern.

Leer: Reset

############################################################################
*/


int Feldgroesse = 1000;

void setup()
{
 size(Feldgroesse, Feldgroesse, P3D); 
 colorMode(RGB);
 frameRate(30);
 smooth();
 strokeWeight(2);
 background(0,0,0); //Hintergrund Schwarz initialisieren
}

int iSpieler = 8; //Startanzahl für Spieler
int iZahl = 1; //Zähler
int ping = 5; //Startanzahl für Ping
int pong = 7; //Startanzahö für Pong
int iNummer = 1; //Welcher Spieler ist drann
int iRichtung = 1; //Richtung: 1 = Rechts 2 = Links 
int xpos=0; //Startposition für Spielerfelder
int ypos=0; //Startposition für Spielerfelder
int iSpeed = 5; //Startwert für geschwindigkeit

void draw()
{
 if (frameCount % iSpeed == 0) //Geschwindigkeitskontrolle
 {
   int schritt = 25;
   int iCounter = Feldgroesse;
   generierefeld();
   fillup();
 
 }
}

boolean generiert = true; //Boolean Wert der für die Generierung benötigt wird
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
  String s1 = "Ping = "+String.valueOf(ping);
  String s2 = "Pong = "+String.valueOf(pong);
  String s3 = "Spieler = "+String.valueOf(iSpieler);
  //String s4 = "Speed = "+String.valueOf(iSpeed);
  
  fill(color(0,0,160));
  text(s1,900,500);
  //fill(color(0,160,0));
  text(s2,900,510);
  //fill(0);
  text(s3,900,520);
  
  //text(s4,900,530);
}

void fillup()
{

  int Feld=Feldgroesse/iSpieler; //Spielfelder ausrechnen
  int Feldb = 10; //Feldhöhe für Ping-Pong
  
  if (iZahl % ping == 0 && iZahl % pong == 0) //Ping-Pong
  {
   fill(0,255,0);  //Grün
   ypos = ypos+Feldb; 
   
  }
  else if (iZahl % ping == 0) //Ping
  {
   fill(0,0,255); //Blau
   iRichtung = iRichtung *-1; 
   ypos = ypos+Feldb;
  }
  else if (iZahl % pong == 0) //Pong
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
  
  
  rect(xpos+(Feld*iNummer)-Feld,ypos, Feld,Feldb); //Füllfelder
  iZahl++;
  iNummer=iNummer+iRichtung;
  println(iSpieler); //Consolenausgabe Anzabl Spieler
  
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
     if (iSpeed < 30)
     {
     iSpeed++;
     }
     break;
   }
   case '1': //Ping Grösser
   {
    if (ping < 9) //Check grösser als 9
     {
      ping++;
      generiert = true; 
      ypos=0;
      iNummer=1;
      iZahl=1;
      iRichtung = 1;
     }
     break;
   }
   case '2': //Ping Kleiner
    {
      if (ping > 1)
      {
       ping--;
       generiert = true; //Reset
       ypos=0; 
       iNummer=1;
       iZahl=1;
       iRichtung = 1;
      }
      break;
    }
   case '3': //pong Grösser
    {
      if (pong < 9)
      {
       pong++; 
       generiert = true; //Reset
       ypos=0;
       iNummer=1;
       iZahl=1;
       iRichtung = 1;
      }
      break;
    }
   case '4': //pong Kleiner
    {
      if (pong > 1)
      {
       pong--; 
       generiert = true; //Reset
       ypos=0;
       iNummer=1;
       iZahl=1;
       iRichtung = 1;
       break;
      }
    }
   case 'r': //Mehr Spieler
    {
       iSpieler++;
       generiert = true; //Reset
       ypos=0;
       iNummer=1;
       iZahl=1;
       iRichtung = 1;
       break;
     }      
   case 'f': //Weniger Spieler
    {
      if (iSpieler > 1)
      {
       iSpieler--;
       generiert = true; //Reset
       ypos=0;
       iNummer=1;
       iZahl=1;
       iRichtung = 1;
      }
      break;
    } 
    case ' ': //Clear
    {
       generiert = true; 
       ypos=0;
       iNummer=1;
       iZahl=1;
       iRichtung = 1;
       break;
    }
  }
}
