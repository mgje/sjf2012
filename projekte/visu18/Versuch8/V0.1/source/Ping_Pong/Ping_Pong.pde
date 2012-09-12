void setup()
{
 frameRate(30);
 colorMode(RGB);
 size(500,500); 
 background(255,255,255);
}
int ping=3;
int pong=4;
int Spieler=4;
int iSpeed=5;

boolean generiert = true;
void draw()
{
  if(frameCount % iSpeed == 0)
  {
    generiere();
 
 
 
  
 
  }
}

void generiere()
{
  if (generiert)
  {
    
    generiert = false;
  }
}
