import processing.core.*; 
import processing.data.*; 
import processing.opengl.*; 

import java.applet.*; 
import java.awt.Dimension; 
import java.awt.Frame; 
import java.awt.event.MouseEvent; 
import java.awt.event.KeyEvent; 
import java.awt.event.FocusEvent; 
import java.awt.Image; 
import java.io.*; 
import java.net.*; 
import java.text.*; 
import java.util.*; 
import java.util.zip.*; 
import java.util.regex.*; 

public class Ping_Pong extends PApplet {

/*
##############################################################################

Versuch 8: Ping_Pong

Ping: Blau
Pong: Gelb
Ping-Pong: Gr\u00fcn

Steuerung:
r: Mehr Spieler
f: Weniger Spieler
+: Geschwindigkeit erh\u00f6hen.
-: Geschwindigkeit drosseln.
1: Ping vergr\u00f6ssern.
2: Ping verkleinern.
3: Pong vergr\u00f6ssern.
4: Pong verkleinern.

Leer: Reset

############################################################################
*/

int Feldgroesse = 1000;
public void setup()
{
 frameRate(30);
 colorMode(RGB);
 size(Feldgroesse,Feldgroesse); 
 background(255,255,255);
 noFill();
 smooth();
}

int ping=7;
int pong=4;
int iSpieler=16;
int iSpeed=5;
int iAbstand =100;
int iCounter = 0;
int Runde = 1;
int Richtung = 1;
int iZahl=0;
int Verb=10;

boolean generiert = true;
public void draw()
{
  if(frameCount % iSpeed == 0)
  {
    generiere();
    zeichne();
  String s1 = "Ping = "+String.valueOf(ping);
  String s2 = "Pong = "+String.valueOf(pong);
  String s3 = "Spieler = "+String.valueOf(iSpieler);
  fill(color(0,0,0));
  text(s1,-(0.4f*Feldgroesse),-(0.4f*Feldgroesse)); //Textplatzierung im Verh\u00e4ltnis zum Spielfeld.
  text(s2,-(0.4f*Feldgroesse),-(0.4f*Feldgroesse+10));
  text(s3,-(0.4f*Feldgroesse),-(0.4f*Feldgroesse+20));
  noFill();
  }
}

public void generiere()
{
  if (generiert) //Checken ob Generiert werden muss
  {
     background(255,255,255);
     translate(Feldgroesse/2,Feldgroesse/2);
     float radius = Feldgroesse/2-(0.1f*Feldgroesse);
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

public void zeichne()
{
     pushMatrix();
     translate(Feldgroesse/2,Feldgroesse/2);
     strokeWeight(Verb/2);
     
//#############################################################

  if (iZahl % ping == 0 && iZahl % pong == 0) //Ping-Pong
  {
   stroke(0,255,0);  //Gr\u00fcn
   
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
     float radius =iAbstand*0.4f+(Verb*0.8f*Runde);
     float angle= TWO_PI/iSpieler;
   if (radius < (Feldgroesse/2-(0.1f*Feldgroesse)))
   {
   
   
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

  if (iZahl % ping == 0 && iZahl % pong == 0) //Ping-Pong
  {
   iCounter=iCounter+Richtung;
   Runde++;
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
    println(iCounter);
  }
 popMatrix();
}

public void keyPressed()
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
   case '1': //Ping Gr\u00f6sser
   {
    if (ping < iSpieler) //Check gr\u00f6sser als 9
     {
      ping++;
      generiert = true; 
      Runde= 1;
       iZahl= 0;
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
       iZahl= 0;
      }
      break;
    }
   case '3': //pong Gr\u00f6sser
    {
      if (pong < iSpieler)
      {
       pong++; 
       generiert = true; //Reset
       Runde= 1;
       iZahl= 0;
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
       iZahl= 0;

      }
      break;
    }
   case 'r': //Mehr Spieler
    {
      if (iSpieler < 30)
       { 
       iSpieler++;
       generiert = true; //Reset
       Runde= 1;
       iZahl= 0;
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
       iZahl= 0;
      }
      break;
    } 
    case ' ': //Clear
    {
       generiert = true; 
       Runde= 1;
       iZahl= 0;
       break;
    }
  }
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "--full-screen", "--bgcolor=#666666", "--stop-color=#cccccc", "Ping_Pong" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
