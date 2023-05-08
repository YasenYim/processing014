import ddf.minim.*;

Minim minim;
AudioPlayer player;

Particle[]pts;

PVector[]vertices;

void setup() {
  size(800, 800);
  background(255);

  minim = new Minim(this);

  player = minim.loadFile("song.mp3", 1024);
  println(player.bufferSize());
  player.loop();

  pts=new Particle[2048];
  color b=#89A9FF;
  color c=#FF8989;
  for (int i=0; i<pts.length/2; i++) {
    pts[i]=new Particle(i, c);
  }

  for (int i=pts.length/2; i<pts.length; i++) {
    pts[i]=new Particle(i-1024, b);
  }

  vertices=new PVector[1024];
  for (int i=0; i<vertices.length; i++) {
    vertices[i]=new PVector(map(i, 0, vertices.length, 0, width), height/2);
  }
}

void draw() {
  noStroke();
  fill(255, 20);
  rect(0, 0, width, height);
  updateVertices();

  float amp;
  for (int i=0; i<pts.length/2; i++) {
    amp=abs(player.left.get(i));
    pts[i].update(amp);
    pts[i].display(amp);
  }

  for (int i=pts.length/2; i<pts.length; i++) {
    amp=abs(player.right.get(i-1024));
    pts[i].update(amp);
    pts[i].display(amp);
  }

  jumpingLine();
}


void updateVertices(){
  for(int i=0;i<vertices.length;i++){
    vertices[i].y+=(height/2+player.mix.get(i)*100-vertices[i].y)*0.2;
  }
}

void jumpingLine(){
  pushStyle();
  stroke(#1D837C);
  strokeWeight(4);
  noFill();
  beginShape();
  for(int i=0;i<player.bufferSize();i+=4){
    vertex(vertices[i].x,vertices[i].y);    
  }
  endShape();
}
