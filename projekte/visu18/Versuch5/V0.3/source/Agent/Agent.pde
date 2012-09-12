void setup()
{
 frameRate(30);
 size(200, 500);
 colorMode(RGB);
 background(255,255,255);

}

int posy = 500;
int posx = 100;
int iZahl = 1;
int iSpeed = 5; 

int ping = 3;
int pong = 4;

void draw()
{
 if(frameCount % iSpeed == 0)
 {
   noStroke();

   int Agent = 10; //Agentgrösse
   int iAbstand = Agent+2; //Abstand zwischen 2 Punkten
 
   if (iZahl % ping == 0 && iZahl % pong == 0) //PingPong
   {
    fill(0,200,0); //Grün
   }
   else if (iZahl % ping == 0) //Ping
   {
    fill(0,0,200); //Blau
    posx = posx-iAbstand; //Nach Links
   }
   else if (iZahl % pong == 0) //Pong
   {
    fill(212,212,0);
    posx = posx+iAbstand; //Nach Rechts
   }
   else
   {
    fill(0,0,0); 
   }
 
   ellipse(posx,posy,Agent,Agent);
   posy = posy-iAbstand;
   iZahl= iZahl+1;
   posx=100;
   println(ping);
   println(pong);
   if (posy < 0) //Spielfeld Reset
   {
    posy=500;
    background(0,0,0);
    background(255,255,255);

    
   }
  }
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
     }
     break;
   }
   
   case '2': //Ping Kleiner
    {
      if (ping > 1)
      {
       ping--; 
      }
      break;
      
    }
  }  
}

