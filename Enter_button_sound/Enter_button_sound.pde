import ddf.minim.*;

Minim minim;
AudioSample sound;

Button[]bts;

void setup(){
  size(800,600);
  
  minim = new Minim(this);
  sound = minim.loadSample( "PopUp.mp3");
  
  bts=new Button[3];
  bts[0]=new Button(200,300);  //小括号里是按钮位置
  bts[1]=new Button(400,300);
  bts[2]=new Button(600,300);
}

void draw(){
  background(0);
  
  for(int i=0;i<bts.length;i++){
    bts[i].update();
    bts[i].display();
  }
}
  


class Button {
  float xpos;
  float ypos;
  float diam;

  float normalDiam=100;  //普通尺寸
  float bigDiam=120;    //鼠标悬浮时的大尺寸

  float targetDiam=normalDiam;
  boolean locked=false;

  Button(float input_x, float input_y) {

    xpos=input_x;
    ypos=input_y;

    diam=normalDiam;
  }

  boolean mouseOn() {  //判断鼠标是否在按钮内
    if (dist(mouseX, mouseY, xpos, ypos)<normalDiam/2) {
      if(locked==false){
        locked=true;
        sound.trigger();
      }
      return true;
    } else {
      locked=false;
      return false;
    }
  }


  void update() {
    if (mouseOn()) {    //根据鼠标是否在按钮内来设定目标尺寸
      targetDiam=bigDiam;
    } else {
      targetDiam=normalDiam;
    }

    float diamSpeed=(targetDiam-diam)*0.2;  //当前尺寸向目标尺寸缓动
    diam+=diamSpeed;
  }

  void display() {
    if (mouseOn()) {  //鼠标位置是否在按钮内决定了按钮外观

      noStroke();
      fill(120, 190, 240);
      ellipse(xpos, ypos, diam, diam);
    } else {
      noStroke();
      fill(120, 190, 240,127);
      ellipse(xpos, ypos, diam, diam);
    }
  }
}
