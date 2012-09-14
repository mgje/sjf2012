//ini wird benutzt um animationen herzustellen (Final_Frame bestimmt die Anzahl der Bilder)                                                      
                                                           
#include "colors.inc"
#include "textures.inc"
//bearbeitbare Variablen
#declare YFaktor = 0.1;
#declare zielx = 0.1;
#declare ziely = 0.1;
#declare zielz = -0.2;
#declare drehungen = 1.2; //fuer anflug
#declare hohenabstand = 0.4;
#declare schlussabstand = 0.1;
#declare perspektive = 2; //(1: anflug, 2: direkt anflug, 3: vogel)
#declare startposcamx = 0.8; //funktioniert nicht mit anflug (direkt anflug schon)
#declare startposcamy = 0.8;
#declare startposcamz = 0.8;
#declare rotation = 180; //soll im moment konstant bleiben
#declare farbe = 6;
//1: weiss;gelb;rot
//2: weiss;gelb;rot;unterteilt
//3: weiss;hellblau;blau
//4: weiss;hellgruen;dunkelgruen
//5: weiss;grau;schwarz
//6: gelb;rot;schwarz
//7: hellblau;blau;schwarz
//8: hellgruen;gruen;schwarz
//9: schwarz;grau;weiss
//10: regenbogen mit streifen
//11: regenbogen mit streifen;umgekehrt
//12: regenbogen
//13: regenbogen;umgekehrt
//14: regenbogen mit schwarz
//15: regenbogen mit schwarz;umgekehrt


#declare tinus = drehungen*2*pi*clock;
#declare ziel = <zielx,ziely,zielz>;
#declare startposcam = <startposcamx,startposcamy,startposcamz>;

//verschiedene perspektiven
#switch (perspektive)
        #case (1)
        #declare r = sqrt(((zielx-startposcamx)*(zielx-startposcamx))+((zielz-startposcamz)*(zielz-startposcamz)));
        
        //problemcode
        #declare camx = zielx + ((0.8-(clock*0.8)) * startposcamx +schlussabstand)*cos(tinus+startposcamx-zielx);
        
        #if (clock*1.5<1) 
        #declare camy = startposcamy - ((startposcamy-hohenabstand-YFaktor) * clock);
        #else
        #declare camy = YFaktor + hohenabstand;
        #end
                                           
        #declare camz = zielz + ((0.8-(clock*0.8)) * startposcamz +schlussabstand)*sin(tinus+startposcamz-zielz);
        
        
        
        //Blick der Kamera
        #if (clock<0.5)
        #declare anschauen = <(zielx*clock*2),(ziely*clock*2),(zielz*clock*2)>;
        #else
        #declare anschauen = ziel;
        #end
#break

#case (2)
        #declare camx= startposcamx - ((startposcamx-zielx-schlussabstand) * clock);
        #declare camy= startposcamy - ((startposcamy-ziely-hohenabstand-YFaktor) * clock);
        #declare camz= startposcamz - ((startposcamz-zielz-schlussabstand) * clock);
        //Blick der Kamera
        #if (clock<0.5)
        #declare anschauen = <(zielx*clock*2),(ziely*clock*2),(zielz*clock*2)>;
        #else
        #declare anschauen = ziel;
        #end
#break

#case (3)
        #declare camx = 0 - (-zielx * clock);
        #declare camy = 1.35-((1.35-hohenabstand-YFaktor) * clock);
        #declare camz = 0 - (-zielz * clock);
        //Blick der Kamera
        #if (clock<0.5)
        #declare anschauen = <(zielx*clock*2),(ziely*clock*2),(zielz*clock*2)>;
        #else
        #declare anschauen = ziel;
        #end
        
        // Text
        text {
            ttf "timrom.ttf" "0.5x ; 0.5z" 0.1, 0
            pigment { color rgb <1,1,0> }
            translate <11,11,0>
            rotate 90*x
            scale 0.05}
        
        text {
            ttf "timrom.ttf" "-0.5x ; 0.5z" 0.1, 0
            pigment { color rgb <1,1,0> }
            translate <-15,11,0>
            rotate 90*x
            scale 0.05}
        
        text {
            ttf "timrom.ttf" "-0.5x ; -0.5z" 0.1, 0
            pigment { color rgb <1,1,0> }
            translate <-15,-12,0>
            rotate 90*x
            scale 0.05}
        
        text {
            ttf "timrom.ttf" "0.5x ; -0.5z" 0.1, 0
            pigment { color rgb <1,1,0> }
            translate <11,-12,0>
            rotate 90*x
            scale 0.05}
            
        // Achsen
        #declare A = 0.005;
        box{
            <-A,0,1>, <A,0,-1> // x = 0
            pigment { color rgb <1,0,0>}}
        
        box{
            <1,0,-A>, <-1,0,A> // y = 0
            pigment { color rgb <1,0,0>}}
        
#break
#end


//Lichtquelle
light_source {
        <0.5,0.8,0.5>
        color White}

//Kamera
camera{
        location <camx,camy,camz>
        look_at anschauen}

//Oberflaeche
height_field{ jpeg "C:\Users\gast\Documents\SJF Dateien\SJF\NanoWebVis\nano_measurements\DMP_Ag100\dmp_ag100_detail.jpg" smooth
        translate <-0.5,0,-0.5>  
        scale <1,YFaktor,1>
        rotate <0,rotation,0>
        texture{
                pigment {
                        gradient y
                        color_map {
                                #switch (farbe)
                                #case (1)
                                        [0.0*YFaktor*10 color rgb<1,1,1>]
                                        [0.05*YFaktor*10 color rgb<1,0.65,0>]
                                        [0.1*YFaktor*10 color rgb<1,0,0>]}
                                #break
                                #case (2)
                                        [-0.01*YFaktor*10 color rgb <0,0,0>]
                                        [-0.005*YFaktor*10 color rgb <1,1,1>]
                                        [0.0*YFaktor*10 color rgb <0,0,0>]
                                        [0.005*YFaktor*10 color rgb <1,1,0>]
                                        [0.01*YFaktor*10 color rgb <0,0,0>]
                                        [0.015*YFaktor*10 color rgb <1,0.9,0>]
                                        [0.02*YFaktor*10 color rgb <0,0,0>]
                                        [0.025*YFaktor*10 color rgb <1,0.8,0>]
                                        [0.03*YFaktor*10 color rgb <0,0,0>]
                                        [0.035*YFaktor*10 color rgb <1,0.7,0>]
                                        [0.04*YFaktor*10 color rgb <0,0,0>]
                                        [0.045*YFaktor*10 color rgb <1,0.6,0>]
                                        [0.05*YFaktor*10 color rgb <0,0,0>]
                                        [0.055*YFaktor*10 color rgb <1,0.5,0>] 
                                        [0.06*YFaktor*10 color rgb <0,0,0>]
                                        [0.065*YFaktor*10 color rgb <1,0.4,0>]
                                        [0.07*YFaktor*10 color rgb <0,0,0>]
                                        [0.075*YFaktor*10 color rgb <1,0.3,0>]
                                        [0.08*YFaktor*10 color rgb <0,0,0>]
                                        [0.085*YFaktor*10 color rgb <1,0.2,0>]
                                        [0.09*YFaktor*10 color rgb <0,0,0>]
                                        [0.095*YFaktor*10 color rgb <1,0.1,0>]
                                        [0.1*YFaktor*10 color rgb <0,0,0>]
                                        [0.11*YFaktor*10 color rgb <1,0,0>]}
                                #break  
                                #case (3)
                                        [0.0*YFaktor*10 color rgb<1,1,1>]
                                        [0.05*YFaktor*10 color rgb<0,0.8,1>]
                                        [0.1*YFaktor*10 color rgb<0,0.2,1>]}
                                #break       
                                #case (4)
                                        [0.0*YFaktor*10 color rgb<1,1,1>]
                                        [0.05*YFaktor*10 color rgb<0.4,1,0.4>]
                                        [0.1*YFaktor*10 color rgb<0,0.5,0>]}  
                                #break
                                #case (5)
                                        [0.0*YFaktor*10 color rgb<1,1,1>]
                                        [0.05*YFaktor*10 color rgb<0.5,0.5,0.5>]
                                        [0.1*YFaktor*10 color rgb<0,0,0>]}  
                                #break
                                #case (6)
                                        [0.0*YFaktor*10 color rgb<0,0,0>]
                                        [0.05*YFaktor*10 color rgb<1,0.2,0.2>]
                                        [0.1*YFaktor*10 color rgb<1,1,0>]}  
                                #break
                                #case (7)
                                        [0.0*YFaktor*10 color rgb<0,0,0.2>]
                                        [0.05*YFaktor*10 color rgb<0,0.7,1>]
                                        [0.1*YFaktor*10 color rgb<0,1,1>]}  
                                #break
                                #case (8)
                                        [0.0*YFaktor*10 color rgb<0,0.2,0>]
                                        [0.05*YFaktor*10 color rgb<0.2,1,0.2>]
                                        [0.1*YFaktor*10 color rgb<0.7,1,0.7>]}  
                                #break
                                #case (9)
                                        [0.0*YFaktor*10 color rgb<0,0,0>]
                                        [0.05*YFaktor*10 color rgb<0.5,0.5,0.5>]
                                        [0.1*YFaktor*10 color rgb<1,1,1>]}  
                                #break
                                #case(10) 
                                        [-0.005*YFaktor*10 color rgb <1,1,1>]
                                        [0.0*YFaktor*10 color rgb <0,0,0>]
                                        [0.005*YFaktor*10 color rgb <1,1,0>]
                                        [0.01*YFaktor*10 color rgb <0,0,0>]
                                        [0.015*YFaktor*10 color rgb <1,0.5,0>]
                                        [0.02*YFaktor*10 color rgb <0,0,0>]
                                        [0.025*YFaktor*10 color rgb <1,0,0>]
                                        [0.03*YFaktor*10 color rgb <0,0,0>]
                                        [0.035*YFaktor*10 color rgb <1,0,0.5>]
                                        [0.04*YFaktor*10 color rgb <0,0,0>]
                                        [0.045*YFaktor*10 color rgb <1,0,1>]
                                        [0.05*YFaktor*10 color rgb <0,0,0>]
                                        [0.055*YFaktor*10 color rgb <0,0,1>] 
                                        [0.06*YFaktor*10 color rgb <0,0,0>]
                                        [0.065*YFaktor*10 color rgb <0,0.5,1>]
                                        [0.07*YFaktor*10 color rgb <0,0,0>]
                                        [0.075*YFaktor*10 color rgb <0,1,1>]
                                        [0.08*YFaktor*10 color rgb <0,0,0>]
                                        [0.085*YFaktor*10 color rgb <0,1,0.5>]
                                        [0.09*YFaktor*10 color rgb <0,0,0>]
                                        [0.095*YFaktor*10 color rgb <0,1,0>]}
                                #break
                                #case(11) 
                                        [-0.005*YFaktor*10 color rgb <0,1,0>]
                                        [0.0*YFaktor*10 color rgb <0,0,0>]
                                        [0.005*YFaktor*10 color rgb <0,1,0.5>]
                                        [0.01*YFaktor*10 color rgb <0,0,0>]
                                        [0.015*YFaktor*10 color rgb <0,1,1>]
                                        [0.02*YFaktor*10 color rgb <0,0,0>]
                                        [0.025*YFaktor*10 color rgb <0,0.5,1>]
                                        [0.03*YFaktor*10 color rgb <0,0,0>]
                                        [0.035*YFaktor*10 color rgb <0,0,1>]
                                        [0.04*YFaktor*10 color rgb <0,0,0>]
                                        [0.045*YFaktor*10 color rgb <1,0,1>]
                                        [0.05*YFaktor*10 color rgb <0,0,0>]
                                        [0.055*YFaktor*10 color rgb <1,0,0.5>] 
                                        [0.06*YFaktor*10 color rgb <0,0,0>]
                                        [0.065*YFaktor*10 color rgb <1,0,0>]
                                        [0.07*YFaktor*10 color rgb <0,0,0>]
                                        [0.075*YFaktor*10 color rgb <1,0.5,0>]
                                        [0.08*YFaktor*10 color rgb <0,0,0>]
                                        [0.085*YFaktor*10 color rgb <1,1,0>]
                                        [0.09*YFaktor*10 color rgb <0,0,0>]
                                        [0.095*YFaktor*10 color rgb <1,1,1>]}
                                #break  
                                #case(12) 
                                        [-0.005*YFaktor*10 color rgb <1,1,1>]
                                        [0.005*YFaktor*10 color rgb <1,1,0>]
                                        [0.015*YFaktor*10 color rgb <1,0.5,0>]
                                        [0.025*YFaktor*10 color rgb <1,0,0>]
                                        [0.035*YFaktor*10 color rgb <1,0,0.5>]
                                        [0.045*YFaktor*10 color rgb <1,0,1>]
                                        [0.055*YFaktor*10 color rgb <0,0,1>] 
                                        [0.065*YFaktor*10 color rgb <0,0.5,1>]
                                        [0.075*YFaktor*10 color rgb <0,1,1>]
                                        [0.085*YFaktor*10 color rgb <0,1,0.5>]
                                        [0.095*YFaktor*10 color rgb <0,1,0>]}
                                #break
                                #case(13) 
                                        [-0.005*YFaktor*10 color rgb <0,1,0>]
                                        [0.005*YFaktor*10 color rgb <0,1,0.5>]
                                        [0.015*YFaktor*10 color rgb <0,1,1>]
                                        [0.025*YFaktor*10 color rgb <0,0.5,1>]
                                        [0.035*YFaktor*10 color rgb <0,0,1>]
                                        [0.045*YFaktor*10 color rgb <1,0,1>]
                                        [0.055*YFaktor*10 color rgb <1,0,0.5>] 
                                        [0.065*YFaktor*10 color rgb <1,0,0>]
                                        [0.075*YFaktor*10 color rgb <1,0.5,0>]
                                        [0.085*YFaktor*10 color rgb <1,1,0>]
                                        [0.095*YFaktor*10 color rgb <1,1,1>]}
                                #break
                                #case(14)
                                        [-0.005*YFaktor*10 color rgb <1,1,1>]
                                        [0.005*YFaktor*10 color rgb <1,1,0>]
                                        [0.015*YFaktor*10 color rgb <1,0.5,0>]
                                        [0.025*YFaktor*10 color rgb <1,0,0>]
                                        [0.035*YFaktor*10 color rgb <1,0,1>]
                                        [0.045*YFaktor*10 color rgb <0,0,1>]
                                        [0.055*YFaktor*10 color rgb <0,1,1>] 
                                       [0.065*YFaktor*10 color rgb <0.25,1,0>]
                                        [0.075*YFaktor*10 color rgb <0,1,0>]
                                        [0.085*YFaktor*10 color rgb <0.5,0.5,0.5>]
                                        [0.095*YFaktor*10 color rgb <0,0,0>]}
                                #break
                                #case(15)
                                        [-0.005*YFaktor*10 color rgb <0,0,0>]
                                        [0.005*YFaktor*10 color rgb <0.5,0.5,0.5>]
                                        [0.015*YFaktor*10 color rgb <0,1,0>]
                                        [0.025*YFaktor*10 color rgb <0.25,1,0>]
                                        [0.035*YFaktor*10 color rgb <0,1,1>]
                                        [0.045*YFaktor*10 color rgb <0,0,1>]
                                        [0.055*YFaktor*10 color rgb <1,0,1>] 
                                       [0.065*YFaktor*10 color rgb <1,0,0>]
                                        [0.075*YFaktor*10 color rgb <1,0.5,0>]
                                        [0.085*YFaktor*10 color rgb <1,1,0>]
                                        [0.095*YFaktor*10 color rgb <1,1,1>]}
                                #break
                                #end
                        }
                finish{ phong 0.5
                        ambient White*0.5}
        }
}
