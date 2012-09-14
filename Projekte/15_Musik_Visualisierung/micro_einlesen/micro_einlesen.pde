import ddf.minim.*;
import ddf.minim.signals.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;

Minim minim;
AudioInput in;
FFT fft;
int w;
PImage fade;

float rWidth, rHeight;

void setup()
{
 size(680,  680, P3D);
 
 minim=new Minim(this);
 in = minim.getLineIn(Minim.STEREO, 512);
 fft = new FFT(in.bufferSize(), in.sampleRate());
 fft.logAverages(60, 7);
 stroke(0,255,0);
 w = width/fft.avgSize();
 strokeWeight(w);
 strokeCap(SQUARE);
 background(0);
 fade = get(0,0, width, height);
 
 rWidth = width *0.99;
 rHeight = height * 0.99;
}

void draw()
{
  
  background(0);
 fft.forward(in.mix);
 
 tint(255,255,255, 254);
 image(fade, (width - rWidth) / 2 , (height - rHeight) / 2 , rWidth, rHeight);
 noTint();
 for(int i = 0; i < fft.avgSize();i++)
 {
   line((i*w)+(w/2),height, (i*w)+(w/2), height - fft.getBand(i) * 4);
 }
 
  fade = get(0,0, width, height);
  
}
