void setup()
{
 frameRate(5);
 size(200, 500);
 colorMode(RGB);
 
}

int posy = 500;
int posx = 100;

void draw()
{
 
 int ping = 3;
 int pong = 4;
 int Agent = 10;
 int iZahl = 1;
 
 
 if (iZahl % 3 == 0 && iZahl % 4 == 0)
 {
  fill(0,200,0) //Grün
 }
 else if (iZahl % 3 == 0);
 {
  fill(0,0,200); //Blau
 }
 else if (iZahl % 4 == 0)
 {
  fill(212,212,0);
 }
 else
 {
  fill(0,0,0); 
 }
 
 ellipse(posx,posy,Agent,Agent);
 posy = posy+15
 
  
}

