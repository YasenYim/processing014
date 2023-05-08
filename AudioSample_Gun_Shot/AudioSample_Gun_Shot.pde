import ddf.minim.*;

Minim minim;
AudioSample fire;

float diam=60;

void setup(){
  size(400,400);
  minim = new Minim(this);
  fire = minim.loadSample( "ak47-1.wav");
}

void draw(){
  background(0);  
  fill(0,150,255);  
  diam+=(60-diam)*0.1;  
  ellipse(width/2,height/2,diam,diam);
}

void mousePressed(){
  fire.trigger();
  diam=120;
}
