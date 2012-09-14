/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author Jaime
 */
import java.awt.TextField;
import java.awt.event.KeyAdapter;
import java.awt.event.KeyEvent;
import javax.sound.midi.*;

int north = 0;
int east = 1;
int south = 2;
int west = 4;

int stepSize = 4;
int diameter = 4;

int anzKreise =0;
int radius = 0;
int abstand = 0;

float posY ;
float posX ; 
int direction;


  // Variable um die Werte aus dem Array zu holen
  int a1 = 0;         
  public void setup(){
    size(800,600, P3D);
    background(255);
    noStroke();
    smooth();
    posX = width/2;
    posY = height/2;
    fill(100,255,0);
  }
  
  void draw()
  {   
  }  

  private void play()
    throws Exception {
    // Daten in das Array füllen
    final int DATA[][] = {
      {60, 1, 1}, // c
      {61, 1, 1}, // cis
      {62, 1, 1}, // d
      {63, 1, 1}, // dis
      {64, 1, 1}, // e
      {65, 1, 1}, // f
      {66, 1, 1}, // fis
      {67, 1, 1}, // g
      {68, 1, 1}, // gis
      {69, 1, 1}, // a
      {70, 1, 1}, // ais
      {71, 1, 1}, // h
      {72, 1, 1}  // c'
    };
      
    // Synthesizer des Systems holen
    Synthesizer synth = MidiSystem.getSynthesizer();
    // Receiver initialisieren und Synthesizer öffnen
    Receiver rcvr = synth.getReceiver();
    synth.open();
    // Message mit Daten aus dem Array füllen, danach senden
    ShortMessage msg = new ShortMessage();
    msg.setMessage(ShortMessage.NOTE_ON, 0, DATA[a1][0], 100);
    rcvr.send(msg, -1);
    
    } //Schluss der playMethode
    
      // Bei dieser Methode werden die Tasten den Tönen zugewiesen
      void keyPressed(){
        if(key == 'a'){
          println("Ton: c");
          a1 = 0;     
        } 
            
       if(key == 'w'){
        println("Ton: cis");
        a1 = 1;                                    
       }
       
       if(key == 's'){
        println("Ton: d");
        a1 = 2;                                        
       }
       
       if(key == 'e'){
        println("Ton: dis");
        a1 = 3;                           
       }
       
       if(key == 'd'){
        println("Ton: e");
        a1 = 4;                         
       }
       
       if(key == 'f'){
        println("Ton: f");
        a1 = 5;                              
       }
       
       if(key == 't'){
        println("Ton: fis");
        a1 = 6;                        
       }
       
       if(key == 'g'){
        println("Ton: g");
        a1 = 7;                       
       }
       
       if(key == 'z'){
        println("Ton: gis");
        a1 = 8;                           
       }
       
       if(key == 'h'){
        println("Ton: a");
        a1 = 9;                       
       }     
      
       if(key == 'u'){
        println("Ton: ais");
        a1 = 10;                      
       }     
       
       if(key == 'j'){
        println("Ton: h");
        a1 = 11;                        
       }       
       
       if(key == 'k'){
        println("Ton: c'");
        a1 = 12;                       
       }
       
       //allgemeiner Code für alle Tasten, die zugewiesen wurden
       key = ' ';        
            //realdraw();
        
            anzKreise = (int) random(1,25);
            radius = (int) random(5,300);
            abstand = (int) random(2,30);
            drawVertex();         
            //fill(color(random(256), random (256), random(256)));
            //rect(random(800), random(600), random(40), random(40));
            
            
          try {
            play();          
          } catch (Exception e) {
              e.printStackTrace();
          }                
     } //close keypressed
     
     
     /*Grafikfunction*******************************/
     
     
     void realdraw()
     {
      if(key == ' ')
    {
     fill(random(256),random(256),random(256));
   }
    
    
    for(int i = 0; i < mouseX; i++) {
 direction =  (int) random(0, 8);
 
 if(direction == north)
 {
  posY -= stepSize; 
 }

 else if(direction == east)
 {
  posX += stepSize; 
 }

 else if(direction == south)
 {
  posY += stepSize; 
  }
  else if(direction == west)
 {
  posX -= stepSize; 
 }
 
 
 if(posX > width) posX = 0;
 if(posX < 0) posX = width;
 if(posY < 0) posY = height;
 if(posY > height) posY= 0;


ellipse(posX+stepSize/2, posY+stepSize/2, diameter, diameter);
 
 }    
     }
 
  void drawVertex(){
   new Thread() {
   public void run(){ 
    beginShape();
    noFill();
    
    int x1 = (int) random(800);
    int y1 = (int) random(600);
    int x2 = (int) random(800);
    int y2 = (int) random(600);
    int x3 = (int) random(800);
    int y3 = (int) random(600);
    int x4 = (int) random(800);
    int y4 = (int) random(600);
    int farbeR = (int) random (255);
    int farbeG = (int) random (255);
    int farbeB = (int) random (255);
    
    for (anzKreise = anzKreise; anzKreise > 1; anzKreise -= 1){
        farbeR = (int) random(farbeR-30,farbeR+30);
        farbeB = (int) random(farbeB-30,farbeB+30);
        farbeG = (int) random(farbeG-30, farbeG+30);
        println("r" + farbeR + "b" + farbeB + "g" + farbeG);
        //farbeR = (int) random(farbeR-10, farbeR+10);
        stroke(farbeR, farbeG,farbeB );
        quad(x1, y1, x2, y2, x3, y3, x4, y4);
        x1 = x1-5;
        y1 = y1-5;
        x2 = x2-5;
        y2 = y2+5;
        x3 = x3+5;
        y3 = y3+5;
        x4 = x4+5;
        y4 = y4-5;
        /*x1 =  (int) random(x1-abstand,x1+abstand);
        y1 =  (int) random(y1-abstand,y1+abstand);
        x2 =  (int) random(x2-abstand,x2+abstand);
        y2 =  (int) random(y2-abstand,y2+abstand);
        x3 =  (int) random(x3-abstand,x3+abstand);
        y3 =  (int) random(y3-abstand,y3+abstand);
        x4 =  (int) random(x4-abstand,x4+abstand);
        y4 =  (int) random(y4-abstand,y4+abstand);*/
    
     try {
      Thread.sleep(50); 
      repaint();
     } catch(Exception e){
       e.printStackTrace();
     }
    }
    /*int x1Old = x1;
    int y1Old = y1;
    int x2Old = x2;
    int y2Old = y2;
    int x3Old = x3;
    int y3Old = y3;
    int x4Old = x4;
    int y4Old = y4;
    //quad(x1Old, y1Old, x2Old, y2Old, x3Old, y3Old, x4Old, y4Old);*/
   }
   }.start();
  } 
  
  void drawEllipse(){
    float koordinateX = random(800);
    float koordinateY = random(600);
    float farbeR = random (255);
    float farbeG = random (255);
    float farbeB = random (255);
    
    println("Anzahl Kreise: " + anzKreise + " Radius: " + radius + " Abstand: " + abstand);
     
    for (anzKreise = anzKreise; anzKreise > 1; anzKreise -= 1) { 
      noFill();
      stroke(farbeR, farbeG, farbeB);
      ellipse(koordinateX,koordinateY,radius,radius);  
      radius = radius - abstand;
      /*try {
      Thread.sleep(100);
      } catch (Exception e){}*/
  }
  }
