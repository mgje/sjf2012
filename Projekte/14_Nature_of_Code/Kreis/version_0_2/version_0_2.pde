//Authors: Simon Vogel und Beat Käfer
//
//The Ring Project
//Studienwoche SJF Basel



person[] persons;
int n;
int last_moved;
int tol;
float fac;

void setup() {
  size(800,800);
  n = 8;
  tol = 3;
  
  last_moved = n + 1;
  persons = new person[n];
  start_circle(400,400,150,n);
}


void start_circle(int x_pos,int y_pos, int radius, int number_of_points){
  float angle = TWO_PI / (float)number_of_points;
  for(int i=0; i<n; i++){
    persons[i] = new person((int)(x_pos + sin((float)i*angle)*(float)radius), (int)(y_pos + cos((float)i*angle)*(float)radius));
  } 
  for(int i=0; i<n; i++){
    persons[i].choose_persons(i);
  }
}

int draw_counter = 0;
void draw() {
  int j = (int)random(n);
  frameRate(60);
  background(100);
  move_points();
  for(int i=j; i<j+n; i++){
    if(draw_counter > 0){
      if(i%n != last_moved){
        persons[i%n].observe();
     }
     if(mouse == 0){
       draw_counter--;
     }
    }
    persons[i%n].draw_person(i%n);
  }
}


float distance(int x_pos1, int y_pos1,int x_pos2, int y_pos2){
  float result;
  result = sqrt(pow((float)x_pos1-(float)x_pos2,2.0) + pow((float)y_pos1-(float)y_pos2,2.0));
  return result;
}

//Move Point functions
int mouse = 0;

void move_points(){
  if(mouse == 1){
    draw_counter = 60;
    for(int i = 0; i < n; i++){
      if(pmouseX < persons[i].x_pos + 10 && pmouseX > persons[i].x_pos - 10){
        if(pmouseY < persons[i].y_pos + 10 && pmouseY > persons[i].y_pos - 10){
          persons[i].set_pos(mouseX, mouseY);
          last_moved = i;
        }
      }
    }
  }
  if(mouse == 2){
    
    mouse = 0;
  }
}



void mousePressed(){
  mouse = 1;
}

void mouseReleased(){
  mouse = 2;
}

class person{
   int x_pos, y_pos;
   float angle_must;
   int pers1, pers2;
   int wait = 0;
   float distance1;
   int old_x_1, old_x_2, old_y_1, old_y_2;   
   person(int set_x, int set_y){
     x_pos = set_x;
     y_pos = set_y;
   }
   
   float calc_angle(int x_pers1,int y_pers1,int x_pers2,int y_pers2)
   {
     float angle1;
     float a = distance(x_pers1, y_pers1, x_pos, y_pos);
     float b = distance(x_pers1, y_pers1, x_pers2, y_pers2);
     angle1 = acos((2*a*a - b*b)/ (4 * a * a));
     System.out.println("angle: " + angle1);
     return angle1;
   }
   void choose_persons(int index)
   {
     int offset = (int)random(1,n/2-1);
     pers1 = index + offset;
     if(pers1 >= n){
       pers1 -= n;
     }     
     pers2 = index - offset;
     if(pers2 < 0){
       pers2 += n;
     }
     old_x_1 = persons[pers1].x_pos;
     old_x_2 = persons[pers2].x_pos;
     old_y_1 = persons[pers1].y_pos;
     old_y_2 = persons[pers2].y_pos;
     distance1 = distance(x_pos, y_pos,  persons[pers1].x_pos, persons[pers1].y_pos);
     angle_must = calc_angle(persons[pers1].x_pos, persons[pers1].y_pos, persons[pers2].x_pos, persons[pers2].y_pos);
   }
   
   void calc_new(){
     float b = distance(persons[pers1].x_pos, persons[pers1].y_pos, persons[pers2].x_pos, persons[pers2].y_pos);
     float c = (distance1 - ((b/2) / cos(angle_must / 2.0)))/distance1;
     float a = (b/2) / tan(angle_must / 2);
     a = a + a * c * 0.3;
     if(a<400){
       float steigung_b = ((float)(persons[pers1].y_pos - persons[pers2].y_pos))/(float)(persons[pers1].x_pos - persons[pers2].x_pos);
       float offset_b = ((float)persons[pers2].y_pos - (float)persons[pers2].x_pos * steigung_b);
       float steigung_a = -1.0 / steigung_b;
       if(steigung_a < 100000000.0 && steigung_a != 0){
         float schnitt_x = persons[pers1].x_pos + (persons[pers2].x_pos - persons[pers1].x_pos) / 2;
         float schnitt_y = persons[pers1].y_pos + (persons[pers2].y_pos - persons[pers1].y_pos) / 2;
         float offset_a = schnitt_y - schnitt_x * steigung_a;
         float final_x;
         if(persons[pers1].y_pos < persons[pers2].y_pos){ 
           final_x = schnitt_x + a * cos(atan(steigung_a));
         }
         else{
           final_x = schnitt_x - a * cos(atan(steigung_a));
         }
         
         float final_y = final_x * steigung_a + offset_a;
         
         
         x_pos = (int)final_x;
         y_pos = (int)final_y;
       }
     }
     
   }
   
   void set_pos(int set_x, int set_y){
     x_pos = set_x;
     y_pos = set_y;
   }
   
   
    void observe(){
     if(abs(old_x_1 - persons[pers1].x_pos) >tol|| abs(old_x_2 - persons[pers2].x_pos) > tol || abs(old_y_1 - persons[pers1].y_pos) > tol || abs(old_y_2 - persons[pers2].y_pos)>tol ){
       calc_new();
       old_x_1 = persons[pers1].x_pos;
       old_x_2 = persons[pers2].x_pos;
       old_y_1 = persons[pers1].y_pos;
       old_y_1 = persons[pers2].y_pos;
     }
   }
   

   void draw_person(int index){
     stroke(color(255,0,0));
     line(x_pos, y_pos, persons[pers1].x_pos, persons[pers1].y_pos);
     line(x_pos, y_pos, persons[pers2].x_pos, persons[pers2].y_pos);
     stroke(color(0,0,0));
     fill(color(255,255,255));
     ellipse(x_pos,y_pos,20,20);
     fill(color(0,0,0));
     text(index, x_pos - 5, y_pos + 5);
   }
 }

