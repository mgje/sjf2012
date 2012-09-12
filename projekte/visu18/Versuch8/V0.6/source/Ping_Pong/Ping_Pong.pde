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
int iCounter = 0;
int Runde = 1;
int Richtung = 1;
int iZahl=0;
int Verb=10;
int iNummer=1;

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
  text(s1,-(0.4*Feldgroesse),-(0.4*Feldgroesse)); //Textplatzierung im Verhältnis zum Spielfeld.
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
     pushMatrix();
     translate(Feldgroesse/2,Feldgroesse/2);
     stroke(255,0,0);
     strokeWeight(Verb);
//#############################################################

  if (iZahl % ping == 0 && iZahl % pong == 0) //Ping-Pong
  {
   stroke(0,255,0);  //Grün
   
  }
  else if (iZahl % ping == 0) //Ping
  {
   stroke(0,0,255); //Blau
  }
  else if (iZahl % pong == 0) //Pong
  {
   stroke(212,212,0);  //Gelb
  }
  else
  {
   stroke(127,127,127);
  }  
  
  if (iCounter == 0)
  {
   iCounter = iSpieler; 
  }
  
  if (iCounter == iSpieler+1)
  {
   iCounter = 1; 
  }
//#############################################################
     float radius =2*Verb+(Verb*Runde);
     float angle= TWO_PI/iSpieler;
   
    beginShape();

      float x = cos(angle*iCounter)*radius;
      float y= sin(angle*iCounter)*radius;
      vertex(x,y);
      x = cos(angle*(iCounter+Richtung))*radius;
      y = sin(angle*(iCounter+Richtung))*radius;
      vertex(x,y);
      println(x);
      println(y);
    endShape();    
    popMatrix();
  if (iZahl % ping == 0 && iZahl % pong == 0) //Ping-Pong
  {
   iCounter=iCounter+Richtung;
  }
  else if (iZahl % ping == 0) //Ping
  {
   Richtung *= (-1);
   Runde++;
  }
  else if (iZahl % pong == 0) //Pong
  {
   Richtung *= (-1);
   Runde++;
  }
  else
  {
    iCounter=iCounter+Richtung;
  }
    iZahl++;
    iCounter=iCounter+Richtung;
    println(iCounter);
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
      Runde= 1;
       iZahl= 1;
     }
     break;
   }
   case '2': //Ping Kleiner
    {
      if (ping > 1)
      {
       ping--;
       generiert = true; //Reset
       Runde= 1;
       iZahl= 1;
      }
      break;
    }
   case '3': //pong Grösser
    {
      if (pong < 9)
      {
       pong++; 
       generiert = true; //Reset
       Runde= 1;
       iZahl= 1;
      }
      break;
    }
   case '4': //pong Kleiner
    {
      if (pong > 1)
      {
       pong--; 
       generiert = true; //Reset
       Runde= 1;
       iZahl= 1;
       break;
      }
    }
   case 'r': //Mehr Spieler
    {
      if (iSpieler < 30)
       { 
       iSpieler++;
       generiert = true; //Reset
       Runde= 1;
       iZahl= 1;
       }
       break;
     }      
   case 'f': //Weniger Spieler
    {
      if (iSpieler > 3)
      {
       iSpieler--;
       generiert = true; //Reset
       Runde= 1;
       iZahl= 1;
      }
      break;
    } 
    case ' ': //Clear
    {
      iSpieler=8;
       generiert = true; 
       Runde= 1;
       iZahl= 1;
       break;
    }
  }
}
