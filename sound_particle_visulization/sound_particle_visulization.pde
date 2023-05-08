
import ddf.minim.*;

Minim minim;
AudioPlayer song;

float bgHue;
float avg;
float ballBaseHue;

float diameter;

float ballX;
float ballY;

float ballHue;
float ballSat;
float ballBright;
float ballAlpha;

void setup() {
  size(960,720);

  colorMode(HSB);

  minim = new Minim(this);

  song =minim.loadFile("赵谬 - 新世界.mp3");
  song.loop();
}

void draw() {


  noStroke();
  fill(255, 20);

  rect(0, 0, width, height);

  stroke(bgHue, 200, 255, 50);
  strokeWeight(4);
  noFill();

  float xpos;
  float ypos;

  avg=0;
  beginShape();

  for (int i = 0; i < song.bufferSize(); i++) {
    xpos=map(i, 0, song.bufferSize(), 0, width);
    ypos=height/2+100*song.mix.get(i);

    vertex(xpos, ypos);

    avg+=abs(song.mix.get(i));
  }
  endShape();

  avg/=song.bufferSize();

  ballBaseHue=map(avg, 0, 0.6, 170, 0);  //HSB模式下，170是蓝色，0是红色，正好体现"冷和热"

  noStroke();

  for (int i = 0; i < song.bufferSize(); i++) {
    if (random(1)<abs(song.mix.get(i))) {
      diameter=map(song.mix.get(i), 0, 0.5, 6, 20);
      diameter*=random(0.7, 1.3);

      ballX=randomGaussian()*100+width/2;
      ballY=randomGaussian()*100+height/2;

      ballHue=ballBaseHue+random(-10, 10);
      ballSat=random(200, 255);
      ballBright=random(200, 255);
      ballAlpha=random(80, 160);

      if (diameter>50) {
        ballAlpha=random(50, 120);
      }

      fill(ballHue, ballSat, ballBright, ballAlpha);
      ellipse(ballX, ballY, diameter, diameter);
    }
  }
}
