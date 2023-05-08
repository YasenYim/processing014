import ddf.minim.*;

Minim minim;
AudioPlayer player;

int num=256;
Point[]ps;

float threshold;

void setup() {
  size(600, 600);
  colorMode(HSB);

  minim = new Minim(this);

  player = minim.loadFile("赵雷 - 画.mp3");
  player.loop();

  ps=new Point[num];
  for (int i=0; i<num; i++) {
    ps[i]=new Point();
  }
}


void draw() {
  noStroke();
  fill(150, 200, 60, 40);
  rect(0, 0, width, height);

  float level=player.mix.level();
  threshold=level*200;
  
  float hue=map(level, 0, 1, 150, 0);
  float bright=map(level, 0, 1, 150, 255);
  float alpha=map(level, 0, 1, 255, 150);
  stroke(hue, 200, bright, alpha);

  for (int i=0; i<num; i++) {
    ps[i].move();
    ps[i].display();
  }

  for (int i=0; i<num; i++) {
    for (int j=0; j<i; j++) {
      ps[i].connect(ps[j]);
    }
  }
}


class Point {
  float xpos;
  float ypos;
  float xspd;
  float yspd;
  float spdRange=1;


  Point() {
    xpos=random(width);
    ypos=random(height);
    xspd=random(-spdRange, spdRange);
    yspd=random(-spdRange, spdRange);
  }


  void move() {
    xpos+=xspd;
    if (xpos<0 || xpos>=width) {
      xspd*=-1;
    }

    ypos+=yspd;
    if (ypos<0 || ypos>=height) {
      yspd*=-1;
    }
  }

  void display() {

    strokeWeight(3);
    point(xpos, ypos);
  }

  void connect(Point other) {
    if (dist(xpos, ypos, other.xpos, other.ypos)<threshold) {
      strokeWeight(1);

      line(xpos, ypos, other.xpos, other.ypos);
    }
  }
}
