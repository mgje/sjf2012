int Max =500; //Spielfeldgroesse
int bg = 30 ;//Groesse des Punktes

int Posx = Max/2;
int Posy = Max/2;

void setup()
{
size(Max,Max);
colorMode(RGB);
frameRate(100);
}

void draw()
{
int r;
int g;
int b;
 
for (int iCounter=0; iCounter < 100; iCounter ++)
{
 
 Posx = Posx + ((int)random(0,3)) -1;
 Posy = Posy + ((int)random(0,3)) -1;
 
 //#######################################
 
 if (Posx > Max)
 {
  Posx = 0;
 }
 
 if (Posy > Max)
 {
  Posy = 0;
 }
 
 //######################################
 
 
 if (Posx < 0)
 {
  Posx = Max; 
 }
 
 if (Posy < 0)
 {
  Posy = Max; 
 }
 //########################################

r=(int)random(0,256);
g=(int)random(0,256);
b=(int)random(0,256);
 
 stroke(r,g,b);
 fill (r,g,b);
 ellipse(Posx, Posy, bg, bg);
} 
  
  
}
