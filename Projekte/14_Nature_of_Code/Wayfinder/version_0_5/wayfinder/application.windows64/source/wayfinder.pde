//***********************************************************************************************************//
//  Title:                   Wayfinder                                                                       //
//  Version:                 0.4                                                                             //
//  Authors:                 Simon Vogel und Beat Käfer                                                      //
//  Date of last change:     14.09.2012                                                                      //
//  Description:             eine kleine Software die im Rahmen der Studienwoche von Schweizer Jugend Forscht//
//                           an der Universität Basel erstellt wurde. Die Software versucht das TSP          //
//                           darzustellen. Das heisst,den kürzesten Rundweg zwischen einer vorgegebenen      //
//                           Anzahl Punkten zu finden                                                        //
//                                                                                                           //
//***********************************************************************************************************//

kunde[] kunden;
kunde lieferant;
int delay_counter;
way[] ways;
way[] ways2;
int[] shuffle;
int mouse = 0;
int temp_key = 0;
int mode = 0;
int selected1 = 11;
int selected2 = 11;
int active;
int todraw;
int numb_ways = 10;
float cross_tol = 0.01;

PImage img;



void setup() {
  delay_counter = 1;
  img = loadImage("schweiz.png");
  ways = new way[numb_ways];
  ways2 = new way[numb_ways];
  size(1120,600);
  frameRate(120);
  kunden = new kunde[0];
  lieferant = new kunde(545,255,20);
  active = 0;
}


//************** Draw Functions          ******************************************

void draw() {
  int mouse_pos = 0;
  int[] temp_int;
  fill(color(255,255,255)); 
  stroke(color(255,255,255));
  //rect(0,0,1200,800);
  image(img, 200,0);
  int best;
  render_environment();
  for(int i=0; i<kunden.length; i++){
    kunden[i].render();
  }
  lieferant.render();
  
  strokeWeight(2);

  if(active == 1){
    delay_counter = 1;
    best = fitness();
    int badest=11;
     float bad_value = 0;
     for(int i= 0; i<numb_ways; i++){
       if(bad_value < ways[i].way_distance){
         badest = i;
         bad_value = ways[i].way_distance;
       }
     }
     ways[badest] = new way(ways[best].order,0);
     ways[badest] = reduce_crossover(ways[badest]);
     ways[badest].way_distance = calc_way(ways[badest].order);
     fitness();
     for(int i = 0; i<numb_ways; i++){
       temp_int = recombine();
       ways2[i] = new way(temp_int,0.0);
     }
     mutate();
     for(int i = 0; i<numb_ways; i++){
       ways2[i].way_distance = calc_way(ways2[i].order);
     }
     badest=11;
     bad_value = 0;
     for(int i= 0; i<numb_ways; i++){
       if(bad_value < ways2[i].way_distance){
         badest = i;
         bad_value = ways2[i].way_distance;
       }
     }
     ways2[badest] = new way(ways[best].order, ways[best].way_distance);
    way temp_way = new way(ways[best].order, ways[best].way_distance);
    
    for(int k = 0; k< (int)random(0,3); k++){
      temp_way = reduce_crossover(temp_way);
    }
    if(calc_way(temp_way.order)<ways2[badest].way_distance){
      ways2[badest] = new way(temp_way.order, calc_way(temp_way.order));
    }
     arrayCopy(ways2, ways);
     ways2 = new way[numb_ways];
     todraw = fitness();  
  }
  if(ways[todraw] != null){
    stroke(color(0,0,0));
  ways[todraw].render();
  }
  check_keyboard();
}


void render_environment(){
  stroke(color(80,80,80));
  strokeWeight(2);
  line(200,0,200,600);
  fill(color(80,80,80));
  rect(0,0,220,600);
  fill(color(255,255,255));
  stroke(color(255,255,255));
  textSize(28);
  text("Wayfinder",5,25);
  textSize(15);
  switch(mode){
    case 0:
    
    text("Click on the map \nto add Waypoints",10,50);
    text("If you're ready to start\npress 'd' on your keyboard",10,110);
    break;
    case 1:
    if(active == 1){
      text("algorithm is working",10,50);
    }
    else
    {
      text("algorithm is waiting",10,50);
    }
    
    text("distance: "+ways[todraw].way_distance*(386.0/920.0) + " km", 10, 100);
    break;
    
  }
  textSize(10);
  text("Beat Käfer, Simon Vogel - 2012",1,582);
  text("Version 0.4",1,595);
}

//************** Draw Functions     -End  ******************************************




//************** Input/Output      *************************************************

void mousePressed(){
  kunde temp_kunde;
  kunde[] temp_array = new kunde[1];
  if(mouse == 0 && mode==0){
    mouse = 1;
    temp_kunde = new kunde(mouseX, mouseY, kunden.length);
    kunden = (kunde[]) expand(kunden, kunden.length+1);
    kunden[kunden.length - 1] = temp_kunde;
  }
}

void mouseReleased(){
  mouse = 0;
}


void check_keyboard(){
 if(keyPressed){
   if(key == 'd'&& temp_key== 0){
     mode = 1;
     temp_key = 2;
     for(int j=0; j<numb_ways; j++){
       shuffle = random_order(kunden.length);
       ways[j] = new way(shuffle, calc_way(shuffle));
     }
     active = 1;
   }
   
   if(key == 'a' && temp_key==0){
     temp_key = 2;
     if(active == 1){
       active = 0;
     }
     else{
       active = 1;
     }
   }
   
   if(key == 'f' && temp_key==0){
      temp_key = 2;
      ways[todraw] = reduce_crossover(ways[todraw]);
   }
   if(key == 'l'){
      for(int i = 0; i<ways[todraw].order.length; i++){
        text(ways[todraw].order[i], 10, 150 + i * 20);
      } 
   }
 }
}

void keyReleased(){
  temp_key = 0;
}
//************** Input/Output     - End *************************************************


//**************diverse Funktionen               ****************************************************************


float distance(int x_pos1, int y_pos1,int x_pos2, int y_pos2){
  float result;
  result = sqrt(pow((float)x_pos1-(float)x_pos2,2.0) + pow((float)y_pos1-(float)y_pos2,2.0));
  return result;
}





float calc_way(int[] reihenfolge)
{
  int index_max = reihenfolge.length - 1;
  float distance_ges = 0;
  distance_ges += distance(lieferant.x_pos, lieferant.y_pos, kunden[reihenfolge[0]].x_pos, kunden[reihenfolge[0]].y_pos);
  for(int i = 0; i < index_max; i++){
    distance_ges += distance(kunden[reihenfolge[i]].x_pos, kunden[reihenfolge[i]].y_pos, kunden[reihenfolge[i+1]].x_pos, kunden[reihenfolge[i+1]].y_pos);
  }
  distance_ges += distance(kunden[reihenfolge[index_max]].x_pos, kunden[reihenfolge[index_max]].y_pos, lieferant.x_pos, lieferant.y_pos);
  return distance_ges;
}  

 //**** Funktion int fitness() ***********************************************
  // Diese Funktion bewertet die fitness / erstellt das Ranking, aller Wege, welche im Array "ways" enthalten
  // sind. Der Rückgabewert ist der Index des kürzesten Weges
  //
  //
  int[] random_order(int nr_of_objects){
    int[] temp_int = new int[nr_of_objects];
    for(int j= 0; j<nr_of_objects; j++){
      temp_int[j] = nr_of_objects+1;
    }
    int found = 0;
    int value = 0;
    int h;
    temp_int[0] = (int)random(nr_of_objects);
    temp_int[0] = temp_int[0]%nr_of_objects;
    for(int i=1; i<nr_of_objects; i++){
      do{
        value = (int)random(nr_of_objects);
        value = value%nr_of_objects;
        found = 0;
        for(h=0; h<nr_of_objects; h++){
          if(temp_int[h] == value){
            found = 1;
          }
        }
      }while(found != 0);
      temp_int[i] = value;
    }
    return temp_int;
  }


 //**************diverse Funktionen        - End      ****************************************************************


 //**************reduce_crossover               ****************************************************************
 // der nachfolgende Algorithmus versucht Überkreuzungen von Wegen zu reduzieren
 
 
  float[] steigungen;
  float[] offsets;
 
  //**** Funktion way reduce_crossover(way temp_way) ***********************************************
  // Diese Funktion wird aufgerufen um Überkreuzungen der Wege zu reduzieren. Man gibt das Objekt als Parameter mit
  // und erhält die optimierte Version mit dem Returnwert zurück
  //  
  way reduce_crossover(way temp_way){
    int array_length = temp_way.order.length-1;
    float cross_x;
    int found = 0;
    int rand;
    int temp_pos;
    int[] temp;
    int success = 0;
    float steigung_first, steigung_last;
    float offset_first, offset_last;
    int[] order = new int[array_length+1];
    arrayCopy(temp_way.order, order);
    steigungen = new float[array_length];
    offsets = new float[array_length];
  
    calc_steigung(array_length, order);
    
    steigung_first = ((((float)kunden[order[0]].y_pos)-255.0))/(((float)kunden[order[0]].x_pos)-545.0);
    offset_first = (float)kunden[order[0]].y_pos - steigung_first*(float)kunden[order[0]].x_pos;
    
    steigung_last = ((((float)kunden[order[array_length]].y_pos)-255.0))/(((float)kunden[order[array_length]].x_pos)-545.0);
    offset_last = (float)kunden[order[array_length]].y_pos - steigung_last*(float)kunden[order[array_length]].x_pos;
    
    
    // start check crossover of other ways with the way (origin to first point)
    for(int i = 0; i<array_length; i++){
        cross_x = (offsets[i]-offset_first)/(steigung_first- steigungen[i]);
        if(kunden[order[i]].x_pos > kunden[order[i+1]].x_pos){
          if(545 > kunden[order[0]].x_pos){
            if((float)kunden[order[i]].x_pos-cross_tol >= cross_x && (float)kunden[order[i+1]].x_pos+cross_tol <= cross_x){
              if(545.0-cross_tol >= cross_x && (float)kunden[order[0]].x_pos+cross_tol <= cross_x){
              found = 1;
              }
            }
          }
          else{
            if((float)kunden[order[i]].x_pos-cross_tol >= cross_x && (float)kunden[order[i+1]].x_pos+cross_tol <= cross_x){
              if(545.0+cross_tol <= cross_x && (float)kunden[order[0]].x_pos-cross_tol >= cross_x){
              found = 1;
              }
            }
          }
        }
        else{
          if(545 > kunden[order[0]].x_pos){
            if((float)kunden[order[i]].x_pos+cross_tol <= cross_x && (float)kunden[order[i+1]].x_pos-cross_tol >= cross_x){
              if(545.0-cross_tol >= cross_x && (float)kunden[order[0]].x_pos+cross_tol<= cross_x){
              found = 1;
              }
            }
          }
          else{
            if((float)kunden[order[i]].x_pos+cross_tol <= cross_x && (float)kunden[order[i+1]].x_pos-cross_tol >= cross_x){
              if(545.0+cross_tol <= cross_x && (float)kunden[order[0]].x_pos-cross_tol >= cross_x){
              found = 1;
              }
            }
          }
          if(found == 1){
          rand = (int)random(0,2);
          if(i>0){
            rand -= 1;
          }
            temp_pos = order[i+rand];
            order[i+rand] = order[0];
            order[0] = temp_pos;
            calc_steigung(array_length, order);
          found = 0;
          }
        }
        }
        // end check crossover of other ways with the way (origin to first point)
        
        
        // start check crossover of other ways with the way (origin to last point)
        found = 0;
        for(int i = 0; i<array_length; i++){
        cross_x = (offsets[i]-offset_last)/(steigung_last- steigungen[i]);
        if(kunden[order[i]].x_pos > kunden[order[i+1]].x_pos){
          if(545 > kunden[order[array_length]].x_pos){
            if((float)kunden[order[i]].x_pos-cross_tol >= cross_x && (float)kunden[order[i+1]].x_pos+cross_tol <= cross_x){
              if(545.0-cross_tol >= cross_x && (float)kunden[order[array_length]].x_pos+cross_tol <= cross_x){
              found = 1;
              }
            }
          }
          else{
            if((float)kunden[order[i]].x_pos-cross_tol >= cross_x && (float)kunden[order[i+1]].x_pos+cross_tol <= cross_x){
              if(545.0+cross_tol <= cross_x && (float)kunden[order[array_length]].x_pos-cross_tol >= cross_x){
              found = 1;
              }
            }
          }
        }
        else{
          if(545 > kunden[order[0]].x_pos){
            if((float)kunden[order[i]].x_pos+cross_tol <= cross_x && (float)kunden[order[i+1]].x_pos-cross_tol >= cross_x){
              if(545.0-cross_tol >= cross_x && (float)kunden[order[array_length]].x_pos+cross_tol<= cross_x){
              found = 1;
              }
            }
          }
          else{
            if((float)kunden[order[i]].x_pos+cross_tol <= cross_x && (float)kunden[order[i+1]].x_pos-cross_tol >= cross_x){
              if(545.0+cross_tol <= cross_x && (float)kunden[order[array_length]].x_pos-cross_tol >= cross_x){
              found = 1;
              }
            }
          }  
        }
        if(found == 1){
          
          rand = (int)random(0,2);
          if(i>1){
            rand -= 1;
          }
          else{
            rand = (int)random(0,1);
          }
          temp_pos = order[i+rand];
          order[i+rand] = order[array_length];
          order[array_length] = temp_pos;
          calc_steigung(array_length, order);
  
          found = 0;
          }
    }
    // end check crossover of other ways with the way (origin to last point)
    
    // start checking crossover of all other ways
    int start_val = (int)random(0,array_length);
    for(int m = 0; m<2; m++){
      if(m==1){
        start_val = 0;
      }
      for(int i = start_val; i<array_length; i++){
        for(int j = 0; j<array_length; j++){
          if(j != i){
          cross_x = (offsets[j]-offsets[i])/(steigungen[i]- steigungen[j]);
          if(kunden[order[i]].x_pos > kunden[order[i+1]].x_pos){
            if(kunden[order[j]].x_pos > kunden[order[j+1]].x_pos){
              if((float)kunden[order[i]].x_pos-cross_tol >= cross_x && (float)kunden[order[i+1]].x_pos+cross_tol <= cross_x){
                if((float)kunden[order[j]].x_pos-cross_tol >= cross_x && (float)kunden[order[j+1]].x_pos+cross_tol <= cross_x){
                found = 1;
                }
              }
            }
            else{
              if((float)kunden[order[i]].x_pos-cross_tol >= cross_x && (float)kunden[order[i+1]].x_pos+cross_tol <= cross_x){
                if((float)kunden[order[j]].x_pos+cross_tol <= cross_x && (float)kunden[order[j+1]].x_pos-cross_tol >= cross_x){
                found = 1;
                }
              }
            }
          }
          else{
            if(kunden[order[j]].x_pos > kunden[order[j+1]].x_pos){
              if((float)kunden[order[i]].x_pos+cross_tol <= cross_x && (float)kunden[order[i+1]].x_pos-cross_tol >= cross_x){
                if((float)kunden[order[j]].x_pos-cross_tol >= cross_x && (float)kunden[order[j+1]].x_pos+cross_tol<= cross_x){
                found = 1;
                }
              }
            }
            else{
              if((float)kunden[order[i]].x_pos+cross_tol <= cross_x && (float)kunden[order[i+1]].x_pos-cross_tol >= cross_x){
                if((float)kunden[order[j]].x_pos+cross_tol <= cross_x && (float)kunden[order[j+1]].x_pos-cross_tol >= cross_x){
                found = 1;
                }
              }
            }
          }
          if(found == 1){        
            //println("found" + i);
            float min_distance = temp_way.way_distance;
            float temp_distance;
            int eins = 0;
            int zwei = 0;
            int pos = 1000;
            int rand2 = (int)random(0,1);
            rand = (int)random(0,1);
            temp = new int[order.length];
            arrayCopy(order, temp);
            if(i-j==2){
              temp_pos = order[i+1];
              order[i+1] = order[j];
              order[j] = temp_pos;
            }
            else if(i-j==-2){
              temp_pos = order[i];
              order[i] = order[j+1];
              order[j+1] = temp_pos;
            }
            else {
              arrayCopy(order, temp);
              for(int k = 1; k < j+1-i; k++){
                temp[(k+i)%order.length] = order[(j+1-k)%order.length];
              }
              arrayCopy(temp, order);  
            }
            found = 0;
            arrayCopy(order, temp_way.order);
            return temp_way;
            //break;
          }
        }
      }
      }
    }
    arrayCopy(order, temp_way.order);
    return temp_way;
  }
  
  
  int check_cross(int[] order, int set_i, int array_length){
  float cross_x; 
  int i = set_i;
  int found = 0;
    for(int j = 0; j<array_length; j++){
      if(j != i){
      cross_x = (offsets[j]-offsets[i])/(steigungen[i]- steigungen[j]);
      if(kunden[order[i]].x_pos > kunden[order[i+1]].x_pos){
        if(kunden[order[j]].x_pos > kunden[order[j+1]].x_pos){
          if((float)kunden[order[i]].x_pos-cross_tol >= cross_x && (float)kunden[order[i+1]].x_pos+cross_tol <= cross_x){
            if((float)kunden[order[j]].x_pos-cross_tol >= cross_x && (float)kunden[order[j+1]].x_pos+cross_tol <= cross_x){
            found = 1;
            }
          }
        }
        else{
          if((float)kunden[order[i]].x_pos-cross_tol >= cross_x && (float)kunden[order[i+1]].x_pos+cross_tol <= cross_x){
            if((float)kunden[order[j]].x_pos+cross_tol <= cross_x && (float)kunden[order[j+1]].x_pos-cross_tol >= cross_x){
            found = 1;
            }
          }
        }
      }
      else{
        if(kunden[order[j]].x_pos > kunden[order[j+1]].x_pos){
          if((float)kunden[order[i]].x_pos+cross_tol <= cross_x && (float)kunden[order[i+1]].x_pos-cross_tol >= cross_x){
            if((float)kunden[order[j]].x_pos-cross_tol >= cross_x && (float)kunden[order[j+1]].x_pos+cross_tol<= cross_x){
            found = 1;
            }
          }
        }
        else{
          if((float)kunden[order[i]].x_pos+cross_tol <= cross_x && (float)kunden[order[i+1]].x_pos-cross_tol >= cross_x){
            if((float)kunden[order[j]].x_pos+cross_tol <= cross_x && (float)kunden[order[j+1]].x_pos-cross_tol >= cross_x){
            found = 1;
            }
          }
        }
      }
    }
  }
  return found;
  }
  
  
  //**** Funktion void calc_steigung(int arr_length, int[] order) ***********************************************
  // Diese Funktion berechnet alle Steigungen und Offsets der einzelnen Teilfunktionen zwischen den einzelnen Punkten
  //  
  void calc_steigung(int arr_length, int[] order){
    for(int i = 0; i<arr_length; i++){
      steigungen[i] = (((float)kunden[order[i]].y_pos)-((float)kunden[order[i+1]].y_pos))/(((float)kunden[order[i]].x_pos)-((float)kunden[order[i+1]].x_pos));
      offsets[i] = (float)kunden[order[i]].y_pos - steigungen[i]*(float)kunden[order[i]].x_pos;
    }
  }
  
  
 //**************reduce_crossover     - End  ****************************************************************



 
 //**************evolution***********************************************************************************
 // Hier folgen die Funktionen, welche für den evolutionären Alogrithmus zuständig sind

  //**** Funktion int fitness() ***********************************************
  // Diese Funktion bewertet die fitness / erstellt das Ranking, aller Wege, welche im Array "ways" enthalten
  // sind. Der Rückgabewert ist der Index des kürzesten Weges
  //
  //
  int fitness()
  {
    int fitest = 0;
    int i_max = ways.length;
    
    for(int i = 0; i < i_max; i++){
      if(ways[fitest].way_distance > ways[i].way_distance)
      {
        fitest = i;  
      }
    }
    ways[fitest].quality = 100;
    
    for(int i = 0; i < i_max; i++){
      ways[i].quality = (int)((100*ways[fitest].way_distance)/(ways[i].way_distance));
    }
    return fitest;
  }
  
  //*** End of int fitness()
  
  
  
  //**** Funktion void mutate() ***********************************************
  // Diese Funktion mutiert alle Wege, welche im Array "ways2" enthalten sind. Die Stärke der Mutation ist
  // abhängig von der Länge des Weges. 
  //
  //
  void mutate()
  {
    int order_length = ways[0].order.length;
    int change;
    int[] buf = new int[order_length];
    int temp;
    int i_max = ways.length;
    int numb_change;
    int revers = 0;
    
    
    for(int j = 0; j<random(0,order_length/5); j++){
      for(int i = 0; i < i_max; i++){
        revers = (int)random(0, 2);
        numb_change = (int)random(1, order_length/5);
        change = (int)random(0,order_length-1);
        
        for(int k = 0; k < numb_change; k++){
          buf[k] = ways2[i].order[(change+k)%order_length];
        }
        temp = (change+numb_change+(int)random(0,(order_length-(2*numb_change))))%order_length;
        for(int k = 0; k < numb_change; k++){
          if(revers == 1){
            ways2[i].order[(change+k)%order_length] = ways2[i].order[(temp+k)%order_length];
            ways2[i].order[(temp+k)%order_length] = buf[numb_change-1-k];
          }
          else if(revers == 2){
            for(int m = 0; m < abs(temp - change + numb_change); m++){
            ways2[i].order[(change+m)%order_length] = ways2[i].order[(change+m+1)%order_length];
            }
            ways2[i].order[(temp+numb_change)%order_length] = buf[k];
          }
          else{
            ways2[i].order[(change+k)%order_length] = ways2[i].order[(temp+k)%order_length];
            ways2[i].order[(temp+k)%order_length] = buf[k];
          }
        }
      }
    }
  }

  //** End of void mutate() 


  //**** Funktion int[] recombine() ***********************************************
  // Diese Funktion rekombiniert zwei Wege aus dem Array "ways" abhängig von der Fitness/Ranking der Wege
  // Hat ein Weg eine höhere Fitness ist es auch wahrscheinlicher, dass er für die Rekombination ausgewählt 
  // wird. Die Rekombination nimmt eine zufällige Anzahl von Punkten aus Weg1 an einer zufälligen Position 
  // und kombiniert diese mit Weg2. Am Schluss wird der neu kreierte Weg als []int zurück gegeben.
  //
  //
  int[] recombine()
  {
    int order_length = ways[0].order.length;
    int i_max = ways.length;
    int selection1 = 0; 
    int selection2 = 0;
    int zufall;
    int zufall_max = 0;
    int zufall_max_save;
    int buffer = -1;
    int buffer2 = 1000;
    int buffer3 = 0;
    int i_save=0;
    int l = 2;
    int[] arr = new int[order_length];
    int[] arr2 = new int[order_length];
   
   
   //selection
    for(int i = 0; i < i_max; i++)
    {
     zufall_max += pow((ways[i].quality/10),2);
    } 
    zufall_max_save = zufall_max;
    
    for(int k = 0; k < l; k++)
    {
      zufall_max = zufall_max_save;
      zufall = (int)random(0,zufall_max);
      buffer2 = 1000;
      for(int j = 0; j < i_max; j++)
      {
        buffer = 0;
        
        for(int i = 0; i < i_max; i++)
        {
         if((buffer < ways[i].quality)&&((buffer2 > ways[i].quality)||((i_save != i)&&(buffer2 == ways[i].quality))))
         {
          buffer = ways[i].quality;
          buffer3 = i; 
         } 
        }
        i_save = buffer3;
        buffer2 = buffer;
        
        zufall_max -= pow((buffer/10),2);
        if(k == 0)
        {
          if(zufall_max < zufall){
            selection1 = i_save;
             break;
          }
        }
        else if(k >= 1){
          if((zufall_max < zufall)&&(i_save != selection1)){
            selection2 = i_save;
            break;
          }
          else if((zufall_max < zufall)&&(i_save == selection1)){
            l ++;
            break;
          }
        }
      }
    }
   //end selection
   
   buffer = (int)random(2, (order_length-1));
   int start_value = (int)random(0,order_length-1);
   arrayCopy(ways[selection2].order, arr2);
   for(int  i = 0; i<order_length; i++){
     arr[i] = order_length+1;
   }
   for(int k = start_value; k < start_value+buffer; k++){
     arr[k%order_length] = ways[selection1].order[k%order_length];
     for(int i = 0; i < order_length; i++)
     {
       if(arr2[i] == arr[k%order_length]){
         for(int j = i; j < (order_length - 1); j++){
           arr2[j] = arr2[j+1];
         }
         arr2[order_length-1] = 0;
       }
     }
   }
   int k = 0;
   for(int i = 0; i < order_length; i++){
     if(arr[i] == order_length + 1){
       arr[i] = arr2[k];
       k++;
     }
   }
   
   return arr;
  }
  //** end of int[] recombine

//**************evolution end*******************************************************************************


 //************** Class way  *******************************************************************************
 // Way ist ein Objekt, welches einen Weg repräsentiert, welcher alle Punkte(Kunden) in einer bestimmten
 // Reihenfolge anfährt
 //
 // Reihenfolge:  int[] order     - Der Array enthält die Indexe der Punkte(Kunden) in der Reihenfolge, wie
 //                                 sie angefahren werden sollen
 // Länge des Weges:  way_distance
 // Bewertung:    quality         - Enthält einen Wert von 0 bis 100 und entspricht dem Ranking des Weges
 //                                 im Vergleich mit allen andern. Dieser Wert wird von der Funktion fitness()
 //                                 gesetzt, welche nicht teil dieser Klasse ist!
 
 class way{
   int[] order;
   float way_distance;
   int quality;
   
   way(int[] temp_order, float temp_distance){
     order = new int[temp_order.length];
     arrayCopy(temp_order, order);
     //order = temp_order;
     way_distance = temp_distance;
     quality = 50;
   }
   void render(){
  if(order != null){
    int index_max = order.length - 1;
    if(index_max > 0){
      line(lieferant.x_pos, lieferant.y_pos, kunden[order[0]].x_pos, kunden[order[0]].y_pos);
      for(int i = 0; i < index_max; i++){
        line(kunden[order[i]].x_pos,kunden[order[i]].y_pos, kunden[order[i+1]].x_pos, kunden[order[i+1]].y_pos);
      }
      line(kunden[order[index_max]].x_pos, kunden[order[index_max]].y_pos, lieferant.x_pos, lieferant.y_pos);
    }
  }
}
 }
 
 
 //************** Class kunde  *******************************************************************************
 // Kunde ist ein Objekt, welches einen Standort auf der Karte repräsentiert, wo der Weg hindurch führen muss
 // 
 // Koordinaten: x_pos, y_pos
 // Nummer der Person: index
 
 
 class kunde{
  int x_pos, y_pos;
  int index;
  
  kunde(int set_x, int set_y, int set_i){
    x_pos = set_x;
    y_pos = set_y;
    index = set_i;
  }
  
  void render(){
     fill(color(255,255,255));
     stroke(color(0,0,0));
     ellipse(x_pos,y_pos,20,20);
     fill(color(0,0,0));
     text(index, x_pos - 5, y_pos + 5);
   }
 }

 //************** Class kunde  - End*****************************************************************************
 

