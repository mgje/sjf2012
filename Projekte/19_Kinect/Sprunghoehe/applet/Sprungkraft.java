import processing.core.*; 
import processing.xml.*; 

import SimpleOpenNI.*; 
import java.awt.Frame; 
import java.awt.Container; 
import javax.swing.*; 
import java.awt.Graphics; 
import java.awt.Button; 
import java.awt.event.*; 
import java.awt.Component; 
import java.lang.Throwable; 
import java.lang.System; 
import java.util.Map; 

import java.applet.*; 
import java.awt.Dimension; 
import java.awt.Frame; 
import java.awt.event.MouseEvent; 
import java.awt.event.KeyEvent; 
import java.awt.event.FocusEvent; 
import java.awt.Image; 
import java.io.*; 
import java.net.*; 
import java.text.*; 
import java.util.*; 
import java.util.zip.*; 
import java.util.regex.*; 

public class Sprungkraft extends PApplet {

/*

Sprungkraft messen mit Kinect
Schweizer Jugend forscht, Studienwoche Informatik
Universit\u00e4t Basel, DMI

Flurin Schwerzmann 
& Simon Furrer


*/















SimpleOpenNI context;
float        zoomF =0.5f;
float        rotX = radians(180);  // by default rotate the hole scene 180deg around the x-axis, 
                                   // the data from openni comes upside down
float        rotY = radians(0);
boolean      autoCalib=true;

PVector      bodyCenter = new PVector();
PVector      bodyDir = new PVector();
List<Float>  heightsStore;
List<Long>   timeStore;
Long         startTime;
Float        max, min, temp;
Map<Long, Float> storage;
Map<Integer, Float> maxStorage;
Map<Integer, Float> minStorage;
Map<Integer, Float> difStorage;
int          cycle, run;
boolean      aufzeichnen, geloescht;
float        sprunghoehe;
JFrame       f;
public JTextArea    textOut;
JScrollPane  scrollPane;
JTextField   weightEntry;



public void setup()
{
  size(640,480,P3D);  // strange, get drawing error in the cameraFrustum if i use P3D, in opengl there is no problem
  
  context = new SimpleOpenNI(this, SimpleOpenNI.RUN_MODE_MULTI_THREADED);
  
  heightsStore = new ArrayList<Float>();
  cycle = 0;
  run = 1;
  
  max = 1.0f;
  min = 0.0f; 
  temp = 0.0f;
  aufzeichnen = false;
  sprunghoehe = 0;
  storage = new HashMap<Long, Float>();
   
  // disable mirror
  context.setMirror(false);

  //set up the GUI
  makeGUI();

  // enable depthMap generation 
  if(context.enableDepth() == false)
  {
     println("Can't open the depthMap, maybe the camera is not connected!"); 
     exit();
     return;
  }

  // enable skeleton generation for all joints
  context.enableUser(SimpleOpenNI.SKEL_TORSO);
  context.enableUser(SimpleOpenNI.SKEL_NECK);

  stroke(255,255,255);
  smooth();  
  
  perspective(radians(45),
              PApplet.parseFloat(width)/PApplet.parseFloat(height),
              10,150000);
 }

public void makeGUI(){
  JFrame f = new JFrame("Sprungkraft");
  Container c = f.getContentPane();
  BoxLayout bl = new BoxLayout(c, BoxLayout.Y_AXIS);
  f.setLayout(bl);
  f.setDefaultCloseOperation(JFrame.HIDE_ON_CLOSE);
  f.setSize(500, 600);
  f.setVisible(true); 
         
  Listeners l = new Listeners();
  
  Button start = new Button("Start");
  //start.setMaximumSize(new Dimension(5, 2));
  start.addActionListener(l);
  start.setMaximumSize(new Dimension(350,75));
  c.add(start);
  
  Button stop = new Button("Stop");
  stop.addActionListener(l);
  stop.setMaximumSize(new Dimension(350,75));
  c.add(stop);
  
  Button berechnen = new Button("Berechnen");
  berechnen.addActionListener(l);
  berechnen.setMaximumSize(new Dimension(350,75));
  c.add(berechnen);
  
  Button loeschen = new Button("L\u00f6schen");
  loeschen.addActionListener(l);
  loeschen.setMaximumSize(new Dimension(350,75));
  c.add(loeschen);
  
  /*
  Button neueMessung = new Button("Neue Messung");
  neueMessung.addActionListener(l);
  neueMessung.setMaximumSize(new Dimension(350,75));
  c.add(neueMessung);
  
  Button zeigeWerte = new Button("Werte anzeigen");
  zeigeWerte.addActionListener(l);
  zeigeWerte.setMaximumSize(new Dimension(350,75));
  c.add(zeigeWerte); */
  
  Button byebye = new Button("Bye Bye");
  //byebye.setMaximumSize(new Dimension(5,2));
  byebye.addActionListener(l);
  byebye.setMaximumSize(new Dimension(350,100));
  c.add(byebye);
  
  textOut = new JTextArea();
  scrollPane = new JScrollPane(textOut);
  textOut.setEditable(false);
  textOut.setLineWrap(true);
  textOut.setWrapStyleWord(true);
  textOut.setSize(new Dimension(500,300));
  textOut.append("Stehen sie vor das Kinect. Sobald sie auf dem Bildschirm einen roten Strich sehen, klicken sie links auf Start!");
  c.add(scrollPane);
  
  weightEntry = new JTextField("Ihr Gewicht: ");
  weightEntry.addActionListener(l);
  weightEntry.setEditable(true);
  weightEntry.setVisible(true);
  weightEntry.setMaximumSize(new Dimension(150,50));
  c.add(weightEntry);
  
  f.show();
}

public void makeText(String s){
  try{
    textOut.append("\n" + s);
  }
  catch(Exception e){println(e.toString());}
}


public void draw()
{
  // update the cam
  context.update();

  background(0,0,0);
  
  // set the scene pos
  translate(width/2, height/2, 0);
  rotateX(rotX);
  rotateY(rotY);
  scale(zoomF);
  
  int[]   depthMap = context.depthMap();
  int     steps   = 5;  // to speed up the drawing, draw every third point
  int     index;
  PVector realWorldPoint;
 
  translate(0,0,-1000);  // set the rotation center of the scene 1000 infront of the camera

  stroke(100); 
  for(int y=0;y < context.depthHeight();y+=steps)
  {
    for(int x=0;x < context.depthWidth();x+=steps)
    {
      index = x + y * context.depthWidth();
      if(depthMap[index] > 0)
      { 
        // draw the projected point
        realWorldPoint = context.depthMapRealWorld()[index];
        point(realWorldPoint.x,realWorldPoint.y,realWorldPoint.z);
      }
    } 
  } 
  
  // draw the skeleton if it's available
  int[] userList = context.getUsers();
  for(int i=0;i<userList.length;i++)
  {
    if(context.isTrackingSkeleton(userList[i]))
      drawSkeleton(userList[i]);
  }    
 
  // draw the kinect cam
  // context.drawCamFrustum();
}

// draw the skeleton with the selected joints
public void drawSkeleton(int userId)
{
  strokeWeight(3);
  
  drawLimb(userId, SimpleOpenNI.SKEL_NECK, SimpleOpenNI.SKEL_TORSO);
  
/*
  // to get the 3d joint data
  drawLimb(userId, SimpleOpenNI.SKEL_HEAD, SimpleOpenNI.SKEL_NECK);

  drawLimb(userId, SimpleOpenNI.SKEL_NECK, SimpleOpenNI.SKEL_LEFT_SHOULDER);
  drawLimb(userId, SimpleOpenNI.SKEL_LEFT_SHOULDER, SimpleOpenNI.SKEL_LEFT_ELBOW);
  drawLimb(userId, SimpleOpenNI.SKEL_LEFT_ELBOW, SimpleOpenNI.SKEL_LEFT_HAND);

  drawLimb(userId, SimpleOpenNI.SKEL_NECK, SimpleOpenNI.SKEL_RIGHT_SHOULDER);
  drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_SHOULDER, SimpleOpenNI.SKEL_RIGHT_ELBOW);
  drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_ELBOW, SimpleOpenNI.SKEL_RIGHT_HAND);

  drawLimb(userId, SimpleOpenNI.SKEL_LEFT_SHOULDER, SimpleOpenNI.SKEL_TORSO);
  drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_SHOULDER, SimpleOpenNI.SKEL_TORSO);

  drawLimb(userId, SimpleOpenNI.SKEL_TORSO, SimpleOpenNI.SKEL_LEFT_HIP);
  drawLimb(userId, SimpleOpenNI.SKEL_LEFT_HIP, SimpleOpenNI.SKEL_LEFT_KNEE);
  drawLimb(userId, SimpleOpenNI.SKEL_LEFT_KNEE, SimpleOpenNI.SKEL_LEFT_FOOT);

  drawLimb(userId, SimpleOpenNI.SKEL_TORSO, SimpleOpenNI.SKEL_RIGHT_HIP);
  drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_HIP, SimpleOpenNI.SKEL_RIGHT_KNEE);
  drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_KNEE, SimpleOpenNI.SKEL_RIGHT_FOOT);  
 
  // draw body direction
  getBodyDirection(userId,bodyCenter,bodyDir);
  
  bodyDir.mult(200);  // 200mm length
  bodyDir.add(bodyCenter);
  
  stroke(255,200,200);
  line(bodyCenter.x,bodyCenter.y,bodyCenter.z,
       bodyDir.x ,bodyDir.y,bodyDir.z);

  strokeWeight(1); */
 
}

public void storeInArray(PVector position){ 
  
    heightsStore.add(position.z);
    //timeStore.add(currentTimeMillis());
    
    storage.put(System.currentTimeMillis(), position.z);
    
    println(String.valueOf(position.z)); 
}

//Werte in long-term Speicher verschieben
public void saveValues(){
  
  minStorage.put(run, min);
  maxStorage.put(run, max);
  difStorage.put(run, max-min);
  
  makeText("Werte gespeichert");
}

//zeige long-term Werte
public void showValues(){
  StringBuffer sb = new StringBuffer();
  
  for( int i : minStorage.keySet()){
  sb.append(
  "Gespeicherte Werte: " + "\n" )
  .append(
  "min: " + minStorage.get(i) + " \n")
  .append(
  "max: " + maxStorage.get(i) + " \n")
  .append(
  "Differenz: " + difStorage.get(i));
   }
   
  makeText(sb.toString());

}


//den tempor\u00e4ren Speicher l\u00f6schen

public void clearStorage(){    
  storage.clear();
  
  max = 0.0f;
  min = 0.0f;
  geloescht = true;
  
  makeText("Speicher gel\u00f6scht");
}


//orginale H\u00f6henberechnung
public void berechneHoehe(){
  long maxTime = 0;
  
  for( Long l : storage.keySet() ){
    temp = storage.get(l);
    
    if(temp > max) {
      max = temp;
      maxTime = l;
      }
    min = max;
    }
  
  for( Long l : storage.keySet() ){
    temp = storage.get(l);
    
    if (l == maxTime) break;
    
    if(temp < min) min = temp;
  }
    
  
  if(max != 1 && geloescht == false){
  makeText("H\u00f6chster Z-Wert: " + max);
  makeText("Minimaler Z-Wert: " + min);
  makeText("Differenz: " + (max - min));
  //saveValues();
    } 
  else{
  makeText("Kein Berechnen ohne Messung!");
    }
    
}

/* modifizierte H\u00f6henberechnung
void berechneHoehe(){
  float max = 1, min = 0, temp = 0;
  int i = 0;
  
  //h\u00f6chster Z-Wert suchen
  for( Iterator<Float> iter = heightsStore.iterator(); iter.hasNext(); ){
    temp = iter.next();
   i++;
    
    if(temp > max){
      max = temp;
      index = i;
    }
  }
  
  i = 0;
  min = max;
  
  
  //tiefster Z-Wert vor dem h\u00f6chsten suchen
  for( Iterator<Float> iter = heightsStore.iterator(); iter.hasNext() && i < index; i++ ){
    temp = iter.next();
    
      if(temp < min) {
        min = temp;
      }
    
  }
  
  println("Maximaler Z-Wert: " + max);
  println("Minimaler Z-Wert: " + min);
  println("Differenz: " + (max - min));
} */

//Linie von einem Gelenk zu einem zweiten
public void drawLimb(int userId,int jointType1,int jointType2)
{
  PVector jointPos1 = new PVector();
  PVector jointPos2 = new PVector();
  float  confidence;
  
  // draw the joint position
  confidence = context.getJointPositionSkeleton(userId,jointType1,jointPos1);
  confidence = context.getJointPositionSkeleton(userId,jointType2,jointPos2);

  stroke(255,0,0,confidence * 200 + 55);
  line(jointPos1.x,jointPos1.y,jointPos1.z,
       jointPos2.x,jointPos2.y,jointPos2.z);
  
  //drawJointOrientation(userId,jointType1,jointPos1,50);
  
  if (aufzeichnen == true) storeInArray(jointPos2);
}

public void drawJointOrientation(int userId,int jointType,PVector pos,float length)
{
  // draw the joint orientation  
  PMatrix3D  orientation = new PMatrix3D();
  float confidence = context.getJointOrientationSkeleton(userId,jointType,orientation);
  if(confidence < 0.001f) 
    // nothing to draw, orientation data is useless
    return;
    
  pushMatrix();
    translate(pos.x,pos.y,pos.z);
    
    // set the local coordsys
    applyMatrix(orientation);
    
    // coordsys lines are 100mm long
    // x - r
    stroke(255,0,0,confidence * 200 + 55);
    line(0,0,0,
         length,0,0);
    // y - g
    stroke(0,255,0,confidence * 200 + 55);
    line(0,0,0,
         0,length,0);
    // z - b    
    stroke(0,0,255,confidence * 200 + 55);
    line(0,0,0,
         0,0,length);
  popMatrix();
}

// -----------------------------------------------------------------
// SimpleOpenNI user events
// Interface
public void onNewUser(int userId)
{
  println("onNewUser - userId: " + userId);
  println("  start pose detection");
  
  if(autoCalib)
    context.requestCalibrationSkeleton(userId,true);
  else    
    context.startPoseDetection("Psi",userId);
}

public void onLostUser(int userId)
{
  println("onLostUser - userId: " + userId);
}

public void onExitUser(int userId)
{
  println("onExitUser - userId: " + userId);
}

public void onReEnterUser(int userId)
{
  println("onReEnterUser - userId: " + userId);
}


public void onStartCalibration(int userId)
{
  println("onStartCalibration - userId: " + userId);
}

public void onEndCalibration(int userId, boolean successfull)
{
  println("onEndCalibration - userId: " + userId + ", successfull: " + successfull);
  
  if (successfull) 
  { 
    println("  User calibrated !!!");
    context.startTrackingSkeleton(userId); 
  } 
  else 
  { 
    println("  Failed to calibrate user !!!");
    println("  Start pose detection");
    context.startPoseDetection("Psi",userId);
  }
}

public void onStartPose(String pose,int userId)
{
  println("onStartdPose - userId: " + userId + ", pose: " + pose);
  println(" stop pose detection");
  
  context.stopPoseDetection(userId); 
  context.requestCalibrationSkeleton(userId, true);
 
}

public void onEndPose(String pose,int userId)
{
  println("onEndPose - userId: " + userId + ", pose: " + pose);
}

// -----------------------------------------------------------------
// Keyboard events

public void keyPressed()
{
  switch(key)
  {
  case ' ':
    context.setMirror(!context.mirror());
    break;
  }
    
  switch(keyCode)
  {
    case 'S':
      aufzeichnen = true;
      break;
    case 'B':
      aufzeichnen = false;
      berechneHoehe();
      break;
    case LEFT:
      rotY += 0.1f;
      break;
    case RIGHT:
      // zoom out
      rotY -= 0.1f;
      break;
    case UP:
      if(keyEvent.isShiftDown())
        zoomF += 0.01f;
      else
        rotX += 0.1f;
      break;
    case DOWN:
      if(keyEvent.isShiftDown())
      {
        zoomF -= 0.01f;
        if(zoomF < 0.01f)
          zoomF = 0.01f;
      }
      else
        rotX -= 0.1f;
      break;
  }
}

/*
public class Fenster extends JPanel{
    @Override
       protected void paintComponent(Graphics g){
         super.paintComponent(g);
         g.drawString("", 400, 300);
         g.drawRect(390,285,100,25);
       }
} */

public class Listeners implements ActionListener
{
  public void actionPerformed( ActionEvent e){
    
    if (e.getActionCommand() == "Start") {
      aufzeichnen = true; 
      geloescht = false;
      startTime = System.currentTimeMillis();
      makeText("Aufzeichnung gestartet");
      }
    if (e.getActionCommand() == "Stop"){
      aufzeichnen = false;
      makeText("Aufzeichnung beendet");
      }
    if (e.getActionCommand() == "L\u00f6schen") clearStorage();
    if (e.getActionCommand() == "Berechnen") berechneHoehe();
    if (e.getActionCommand() == "Werte anzeigen") //To-Do
    if (e.getActionCommand() == "Neue Messung") clearStorage();
    if (e.getActionCommand() == "Bye Bye") context.delete();
    
  }
  
}



/*
void getBodyDirection(int userId,PVector centerPoint,PVector dir)
{
  PVector jointL = new PVector();
  PVector jointH = new PVector();
  PVector jointR = new PVector();
  float  confidence;
  
  // draw the joint position
  confidence = context.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_LEFT_SHOULDER,jointL);
  confidence = context.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_HEAD,jointH);
  confidence = context.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_RIGHT_SHOULDER,jointR);
  
  // take the neck as the center point
  confidence = context.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_NECK,centerPoint);
  
  /*  // manually calc the centerPoint
  PVector shoulderDist = PVector.sub(jointL,jointR);
  centerPoint.set(PVector.mult(shoulderDist,.5));
  centerPoint.add(jointR);
  
  
  PVector up = new PVector();
  PVector left = new PVector();
  
  up.set(PVector.sub(jointH,centerPoint));
  left.set(PVector.sub(jointR,centerPoint));
  
  dir.set(up.cross(left));
  dir.normalize();
} 

public class SpeechRecognition{
  
        static bool pwrequest;
        static string zugangscode;
        static bool session;
        static string inputtext;

  void main(){
    // Obtain a KinectSensor if any are available
         KinectSensor sensor = (from sensorToCheck in KinectSensor.KinectSensors where sensorToCheck.Status == KinectStatus.Connected select sensorToCheck).FirstOrDefault();
         
         pwrequest = false;
         session = false;
         zugangscode =  "    ";
         inputtext = "";
    
         sensor.Start(); 

      // Obtain the KinectAudioSource to do audio capture
         KinectAudioSource source = sensor.AudioSource;
         source.EchoCancellationMode = EchoCancellationMode.None; // No AEC for this sample
         source.AutomaticGainControlEnabled = false; // Important to turn this off for speech recognition

         RecognizerInfo ri = GetKinectRecognizer();
          
      // NOTE: Need to wait 4 seconds for device to be ready right after initialization
         int wait = 4;
         while (wait > 0){
          println("Device will be ready for speech recognition in {0} second(s).\r", wait--);
          Thread.Sleep(1000);
          }
          
         */

  static public void main(String args[]) {
    PApplet.main(new String[] { "--bgcolor=#F0F0F0", "Sprungkraft" });
  }
}
