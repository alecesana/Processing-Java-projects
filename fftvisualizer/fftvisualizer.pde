

/////WRITTEN AND DEBUGGED BY ALESSANDRO CESANA//////
/*import processing.serial.*;
Serial myPort;
/**/
import ddf.minim.analysis.*;
import ddf.minim.*;
Minim minim;
FFT fft;
AudioInput in;

float angle1 = PI/2;
float angle2 = PI/2;
float angle3 = PI;
float[]  x1,x2,x3,x4,y1,y2,y3,y4, angle;



//////shapes origin xs and ys/// 
boolean TF=true;
float ax;
float ay;
float bx;
float by;
float cx;
float cy;
float dx;
float dy;




////
int w;
int h;
int timer1;
int timer2;
int timer3;
int timer4;

float r1;
float g1;
float b1;

float r2;
float g2;
float b2;

float r3;
float g3;
float b3;

float r4;
float g4;
float b4;

 PImage img;


float redvalue;
float greenvalue;
float bluevalue;
void setup()
{
  fullScreen(P3D,1);
  w = 720;
  h= 360;
  


  
  smooth();
  
    frameRate(200);

  
 
  ax = displayWidth/3;
  ay = displayHeight/2;
 
  bx =  displayWidth/2;
  by =  displayHeight/5;
 
  cx =  2*displayWidth/3;
  cy = displayHeight/2;
 
  dx = displayWidth/2;
  dy = 4*displayHeight/5;
  
  
  minim = new Minim(this);
  in = minim.getLineIn(Minim.MONO, 1024, 44100.0);
  fft = new FFT(in.bufferSize(), in.sampleRate());
  
  
  y1 = new float[fft.specSize()];
  x1= new float[fft.specSize()];
   y2 = new float[fft.specSize()];
  x2= new float[fft.specSize()];
   y3 = new float[fft.specSize()];
  x3= new float[fft.specSize()];
   y4 = new float[fft.specSize()];
  x4= new float[fft.specSize()];
  
  frameRate(240);
}
 


 
 
  

void draw()
{
  smooth();

  noCursor();
  background(0);

  
  fft.forward(in.mix);
  
  pushMatrix();  

  translate(mouseX,mouseY);


  holo();
  popMatrix();
  
  pushMatrix();

  translate(mouseX,mouseY);
  rotate(PI/2);
  holo();
  popMatrix();
  
  pushMatrix();

  translate(mouseX,mouseY);
  rotate(PI);
  holo();
  popMatrix();
  
  
  pushMatrix();
  translate(mouseX,mouseY);
  rotate(PI*3/2);
  holo();
  popMatrix();
  
}
 
void holo() {

  noStroke();
  pushMatrix();
  
  for (int i = 0; i <  512 ; i++) {
    y1[i] = y1[i] + fft.getBand(i)/20;
    x1[i] = x1[i] + random(-5,5);

    
    //////////////YELLOW/ORANGE///////////////
    fill(r1,g1,0,180);
     if (millis() - timer1 >= 100) {
    r1 = random(100, 270);
    g1 = random(230,255);
    b1 = random(200,255);
    timer1 = millis();
    
      }
      
    pushMatrix();
    rotate(3*i);
    translate((x1[i]+i)%displayWidth/3, (y1[i] + i)%displayHeight/2);
    //box(((0.5+fft.getBand(i))/(0.3+fft.getFreq(i)))/3);
    box(random(1,fft.getBand(i)/10));
    popMatrix();/**/
  }
  popMatrix();
  
  
  ////////////////VIOLET//////////////
  pushMatrix();
  //translate(w/2,h/2);
  for (int i = 0; i < 50 ; i++) {
    y2[i] = y2[i] + random(-2,2);
    x2[i] = x2[i] + fft.getBand(i)/15;
     
    
 ///////COLOUR//////   
    fill(r2,0,b2,255);
      if (millis() - timer2 >= 200) {
    r2 = random(160, 240);
    g2 = random(7,255);
    b2 = random(170,255);
    timer2 = millis();
      }
    
    pushMatrix();
    rotate((-3*i));
    translate( (x2[i])+i, ((y2[i])+i));
    box((0.5+fft.getBand(i))/(0.3+fft.getFreq(i))/3);
    popMatrix(); /**/
  }
  popMatrix();
  
  
  //////////ORANGE//////////
  /pushMatrix();  
  for (int j = 200; j < 400 ; j++) {
    y3[j] = y3[j] + fft.getBand(j);
    x3[j] = x3[j] + random(-2,2);

    fill(r3,g3,0,255);  
    
      if (millis() - timer3 >= 200) {
    r3 = random(230, 255);
    g3 = random(100,135);
    timer3 = millis();
      }
    pushMatrix();
    rotate((j*2));

    translate( (x3[j]+random(-2,2)), (y3[j])+random(-2,2));

    box(((0.4+2*fft.getBand(j))));
    popMatrix(); /**/
  }
  popMatrix();
  ///////WHITE//////////
  pushMatrix();
  for (int i = 0; i <  fft.specSize() ; i++) {
    y4[i] = y4[i] + random(-2,2);
    x4[i] = x4[i] + random(-2,2);
    
    rotateX(sin(2*angle1/5));
    rotateY(cos(3*angle1/2));
    
    fill(255, 200);
    if (millis() - timer4 >= 200) {
    r4 = random(190, 255);
    g4 = random(100,140);
    b4 = random(247,255);
    timer4 = millis();
    }
    pushMatrix();
   
    rotate(4*i);
    translate((x4[i]/3), (y4[i]/3));

    box((0.6+fft.getBand(i)/(0.3+fft.getFreq(i))/8));
    popMatrix();
  }
  popMatrix();
}


void stop()
{
  // always close Minim audio classes when you finish with them
  minim.stop();
 
  super.stop();
}