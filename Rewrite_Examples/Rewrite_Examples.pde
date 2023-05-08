import ddf.minim.*;

Minim minim;
AudioPlayer player;

void setup() {
  size(512, 200);
  minim = new Minim(this);
  player = minim.loadFile("groove.mp3",512);
  player.loop();
}

void draw(){
  background(0);
  stroke(255);
  noFill();
  
  beginShape();
  for(int i = 0; i < player.bufferSize(); i++){
    vertex(i,abs(player.left.get(i))*80+50);
  }
  endShape();
  
  beginShape();
  for(int i = 0; i < player.bufferSize(); i++){
    vertex(i,player.mix.get(i)*80+150);
  }
  endShape();  
}
