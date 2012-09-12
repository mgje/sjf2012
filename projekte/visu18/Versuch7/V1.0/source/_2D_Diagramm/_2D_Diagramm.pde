int ping;
int pong;
int speed;
int i = 0; // zaehler;
int stepX, posX;
int stepY, posY;
int groesseX = 1800;
int groesseY = 800;
int punktS = 10; //PunktSize


void drawPoint()
{
  ellipse(posX, posY, punktS, punktS);    
}

void setup()
{
  size(groesseX,groesseY);
  ping = 3;
  pong = 4;
  speed = 30;
  stepX = punktS+2;
  stepY = -punktS-2;
  posX = 0;
  posY = groesseY/2;
  background(color(255,255,255));
}

void draw()
{
  noStroke();
  smooth();
   if (frameCount%speed==0)
   {
     if(posX >= groesseX)
     {
       posX -= groesseX;
       background(color(255,255,255));
     }
     
     if(posY >= groesseY)
     {
       posY -= groesseY;
       background(color(255,255,255));
     }
     
     if(posY < 0)
     {
       posY += groesseY;
       background(color(255,255,255));
     }
       fill(color(127,127,127));
       
       if((i % ping)+(i % pong) == 0)
       {
         fill(color(0,255,0));
       }
       else if(i % ping == 0)
       {
         fill(color(0,0,255));
         stepY *= (-1);
       }
       else if(i % pong == 0)
       {
         fill(color(255,255,0));
         stepY *= (-1);
       }
       
       drawPoint();
       posX += stepX;
       posY += stepY;
       i++;       
   }
}

void keyPressed()
{
  switch(key)
  {
    case 'w':speed--; break;
    case 's':speed++; break;
    case 'r':
    {
      if(stepY < 0 && stepY > -25)
      {
        stepY--;
      }
      else if(stepY > 0 && stepY <  25)
      {
        stepY++;
      }
      break;
    }
    case 'f':
    {
      if(stepY < -5)
      {
        stepY++;
      }
      else if(stepY > 5)
      {
        stepY--;
      }
      break;      
    }
    case 'd':stepX--; break;
    case 'g':stepX++; break;
    case '1': ping++; break;
    case '2': ping--; break;
    case '3': pong++; break;
    case '4': pong--; break;
    case '5': punktS++; break;
    case '6': punktS--; break;
    
  }  
  
  speed = constrain(speed, 1, 250);
  ping = constrain(ping, 1, 100);
  pong = constrain(pong, 1, 100);
}
