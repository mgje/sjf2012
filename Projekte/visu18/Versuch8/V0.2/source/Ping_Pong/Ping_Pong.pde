/*
##############################################################################

Versuch 8: Ping_Pong

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
 frameRate(30);
 colorMode(RGB);
 size(Feldgroesse,Feldgroesse); 
 background(255,255,255);
 noFill();
 smooth();
}

int ping=3;
int pong=4;
int iSpieler=16;
int iSpeed=5;
int iAbstand =50;
int Runde = 1;
int Richtung = 1;
int Verb=10;

boolean generiert = true;
void draw()
{
  if(frameCount % iSpeed == 0)
  {
    generiere();
    zeichne();
  String s1 = "Ping = "+String.valueOf(ping);
  String s2 = "Pong = "+String.valueOf(pong);
  String s3 = "Spieler = "+String.valueOf(iSpieler);
  
  fill(color(0,0,0));
  text(s1,-(0.4*Feldgroesse),-(0.4*Feldgroesse));
  text(s2,-(0.4*Feldgroesse),-(0.4*Feldgroesse+10));
  text(s3,-(0.4*Feldgroesse),-(0.4*Feldgroesse+20));
  noFill();
  }
}

void generiere()
{
  if (generiert) //Checken ob Generiert werden muss
  {
     background(255,255,255);
     translate(Feldgroesse/2,Feldgroesse/2);
     float radius = Feldgroesse/2-(0.1*Feldgroesse);
     float angle= TWO_PI/iSpieler;
     stroke(0,0,0);
     strokeWeight(2);
    beginShape();
      for (int iCounter = 0; iCounter <= iSpieler; iCounter++)
      {
      float x = cos(angle*iCounter)*radius;
      float y= sin(angle*iCounter)*radius;
      vertex(x,y);
      line(x,y,0,0);
      println(x);
      println(y);
      }
    endShape();    
    
    fill(255,255,255);
    ellipse(0,0,iAbstand,iAbstand);
    noFill();
    generiert = false;
  }
}

void zeichne()
{
     float radius = Feldgroesse/2-(0.1*Feldgroesse);
     float angle= TWO_PI/iSpieler;
     stroke(0,0,0);
     strokeWeight(2);
    beginShape();
      for (int iCounter = 0; iCounter <= iSpieler; iCounter++)
      {
      float x = cos(angle*iCounter)*radius;
      float y= sin(angle*iCounter)*radius;
      vertex(x,y,x-Verb,y-Verb);
      println(x);
      println(y);
      }
    endShape();    
    
    fill(255,255,255);
    ellipse(0,0,iAbstand,iAbstand);
    noFill();
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
     }
     break;
   }
   case '2': //Ping Kleiner
    {
      if (ping > 1)
      {
       ping--;
       generiert = true; //Reset
      }
      break;
    }
   case '3': //pong Grösser
    {
      if (pong < 9)
      {
       pong++; 
       generiert = true; //Reset
      }
      break;
    }
   case '4': //pong Kleiner
    {
      if (pong > 1)
      {
       pong--; 
       generiert = true; //Reset
       break;
      }
    }
   case 'r': //Mehr Spieler
    {
      if (iSpieler < 30)
       { 
       iSpieler++;
       generiert = true; //Reset
       }
       break;
     }      
   case 'f': //Weniger Spieler
    {
      if (iSpieler > 3)
      {
       iSpieler--;
       generiert = true; //Reset
      }
      break;
    } 
    case ' ': //Clear
    {
      iSpieler=8;
       generiert = true; 
       break;
    }
  }
}
