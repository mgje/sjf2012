// Author: Davud Evren
//Formen aus Agenten

int groesseX = screen.width-100;
int groesseY = screen.height-100;
int speed;

void ausgabe()
{
  String s1 = "";
  
  fill(color(255,255,255));
  noStroke();
  rect(0,0,100,100);
  
  fill(color(0,0,0));
  text(s1, 10, 20);
}

void setup()
{
  size(groesseX,groesseY);
  speed = 31;
  background(color(255,255,255));
}

void draw()
{
  //ausgabe();
  if (frameCount%speed==0)
  {
    if(mouseX != 0 || mouseY != 0)
    {
      centerX += (mouseX-centerX) * 0.01;
      centerY += (mouseY-centerY) * 0.01;
    }
    
  }
}

void keyPressed()
{
  switch(key)
  {
    case 'w':speed--; break;
    case 's':speed++; break;   
  }  
  
  //speed = constrain(speed, 1, 80);
}


