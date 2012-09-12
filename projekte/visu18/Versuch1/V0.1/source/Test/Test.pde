void setup()
{
 size(500,500, JAVA2D); 
 frameRate(30);
}

void draw()
{
 
 println(frameCount);
 ellipse(250,250, frameCount, frameCount);
}
