// Davud Evren
// 11/09/12

int raster = 20;
boolean mach = true;

int actRandomSeed = 0;

void setup()
{
  size(1200,800);  
  background(color(255,255,255));
  noFill();
  smooth();
}

void draw()
{
  strokeCap(ROUND);

  background(color(255,255,255));
  noFill();
  smooth();
  
  
  randomSeed(actRandomSeed);
    
  for(int gridY = 0 ; gridY < raster ; gridY++){
    for(int gridX = 0 ; gridX < raster ;gridX++){
      int posX = width/raster*gridX;
      int posY = height/raster*gridY;
      int toggle = (int) random(0,2);
      if(toggle == 0)
      {
        strokeWeight(mouseX/30);
        line(posX, posY, posX+width/raster, posY+height/raster);
      }
      if(toggle == 1)
      {
        strokeWeight(mouseY/30);
        line(posX+width/raster, posY, posX, posY+height/raster);
      }
    }
  }
}

void mousePressed() {
  actRandomSeed = (int) random(100000);
}

void keyPressed()
{
  switch(key)
  {
    case ' ': background(color(255,255,255));break;
    
  }
}
