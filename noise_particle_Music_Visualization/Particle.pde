class Particle{
  
  PVector loc;
  PVector spd;
  PVector acc;
  color c;
  int index;
  float life=random(255);
  
  Particle(int _index,color _c){
    loc=new PVector(random(width),random(height));
    spd=new PVector(0,0);
    acc=new PVector(0,0);
    c=_c;
    
    index=_index;
  }
  
  void update(float amp){
    float len=amp*20*noise(loc.x*0.01,loc.y*0.01,frameCount*0.01);
    float angle=TWO_PI*2*noise(loc.x*0.01+2000,loc.y*0.01+2000,frameCount*0.01+2000);
    spd.set(len*cos(angle),len*sin(angle));
    loc.add(spd);
    life--;
    
    if(loc.x>width || loc.x<0 || loc.y>height || loc.y<0 || life<0){
      loc.set(vertices[index].x,vertices[index].y);
      //loc=new PVector(random(width),random(height));
      spd.set(0,(vertices[index].y-height/2)*0.1);
      life=255;
    }
  }
  
  void display(float amp){
    stroke(c, (amp)*life);
    strokeWeight((amp)*6);
    //strokeWeight(life*0.01);
    point(loc.x,loc.y);
  }
}