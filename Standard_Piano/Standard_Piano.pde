import ddf.minim.*;

Minim minim;

PianoKey[]whiteKey;
PianoKey[]blackKey;

AudioSample temp;

void setup() {
  size(800, 400);
  minim = new Minim(this);

  whiteKey=new PianoKey[16];
  whiteKey[0]=new PianoKey("21-F.mp3",1, 1, 66, 388);  // 括号里参数 (声音文件名称，琴键横坐标，纵坐标，琴键宽，高）
  whiteKey[1]=new PianoKey("23-G.mp3",50, 1, 66, 388);
  whiteKey[2]=new PianoKey("25-A.mp3",100, 1, 66, 388); 
  whiteKey[3]=new PianoKey("27-B.mp3",150, 1, 66, 388);   
  whiteKey[4]=new PianoKey("28-C.mp3",200, 1, 66, 388);
  whiteKey[5]=new PianoKey("30-D.mp3",250, 1, 66, 388); 
  whiteKey[6]=new PianoKey("32-E.mp3",300, 1, 66, 388); 
  whiteKey[7]=new PianoKey("33-F.mp3",350, 1, 66, 388);
  whiteKey[8]=new PianoKey("35-G.mp3",400, 1, 66, 388);
  whiteKey[9]=new PianoKey("37-A.mp3",450, 1, 66, 388);   
  whiteKey[10]=new PianoKey("39-B.mp3",500, 1, 66, 388);  
  whiteKey[11]=new PianoKey("40-C.mp3",550, 1, 66, 388); 
  whiteKey[12]=new PianoKey("42-D.mp3",600, 1, 66, 388);  
  whiteKey[13]=new PianoKey("44-E.mp3",650, 1, 66, 388); 
  whiteKey[14]=new PianoKey("45-F.mp3",700, 1, 66, 388); 
  whiteKey[15]=new PianoKey("47-G.mp3",750, 1, 66, 388);   

  blackKey=new PianoKey[11];
  blackKey[0]=new PianoKey("22-F#.mp3",30, 1, 40, 188);   
  blackKey[1]=new PianoKey("24-G#.mp3",80, 1, 40, 188);  
  blackKey[2]=new PianoKey("26-A#.mp3",130, 1, 40, 188);     
  blackKey[3]=new PianoKey("29-C#.mp3",235, 1, 40, 188);  
  blackKey[4]=new PianoKey("31-D#.mp3",285, 1, 40, 188);      
  blackKey[5]=new PianoKey("34-F#.mp3",385, 1, 40, 188);
  blackKey[6]=new PianoKey("36-G#.mp3",435, 1, 40, 188);
  blackKey[7]=new PianoKey("38-A#.mp3",485, 1, 40, 188);    
  blackKey[8]=new PianoKey("41-C#.mp3",585, 1, 40, 188);
  blackKey[9]=new PianoKey("46-F#.mp3",635, 1, 40, 188);  
  blackKey[10]=new PianoKey("48-G#.mp3",735, 1, 40, 188);
}

void draw() {
  background(255);
  for (int i=0; i<whiteKey.length; i++) {
    whiteKey[i].update();
    whiteKey[i].display();
  }

  for (int i=0; i<blackKey.length; i++) {
    blackKey[i].update();
    blackKey[i].display();
  }
}

void mousePressed() {
  for (int i=0; i<blackKey.length; i++) {
    if (blackKey[i].isHover()) {
      blackKey[i].hitKey();
    }
  }

  if (mouseOnBlack()==false) {  //先看一下黑键是否被触发，没有的话再触发白键
    for (int i=0; i<whiteKey.length; i++) {
      if (whiteKey[i].isHover()) {
        whiteKey[i].hitKey();
      }
    }
  }
}

boolean mouseOnBlack() {    
  for (int i=0; i<blackKey.length; i++) {
    if (blackKey[i].isHover()) {
      return true;
    }
  }
  return false;
}

class PianoKey {
  int xpos;
  int ypos;
  int wd;
  int ht;
  color bgCl;  //琴键默认色
  color hitCl;  //按键时变成这个颜色
  float alfa;  //颜色分两层，下层默认色，上层半透明的 hitCl，这里是上层色的透明度

  AudioSample sample;

  PianoKey(String sampleName, int _xpos, int _ypos, int _wd, int _ht) {  //String是字符串的数据类型，文件名就是一个字符串

    sample=minim.loadSample(sampleName);
    xpos=_xpos;
    ypos=_ypos;
    wd=_wd;
    ht=_ht;

    if (ht>200) {  //白键在靠下的位置
      bgCl=color(255);
      hitCl=color(255, 0, 0);
    } else {      //黑键在靠上的位置
      bgCl=color(0);
      hitCl=color(255);
    }
    alfa=0;
  }

  boolean isHover() {  //鼠标位置是否在琴键方块里
    if (mouseX>xpos && mouseX<xpos+wd &&
      mouseY>ypos && mouseY<ypos+ht) {
      return true;
    } else {
      return false;
    }
  }

  void hitKey() {
    alfa=180;
    sample.trigger();
  }

  void update() {    //缓动
    alfa+=(0-alfa)*0.1;
  }

  void display() {  
    fill(bgCl);
    rect(xpos, ypos, wd, ht);
    fill(hitCl, alfa);
    rect(xpos, ypos, wd, ht);
  }
}
