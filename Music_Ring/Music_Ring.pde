import ddf.minim.*;

Minim minim;
AudioPlayer song;


void setup() {
  size(800,800);
  background(0);
  minim = new Minim(this);    //永远别忘了先先先先先先初始化 minim 对象
  
  song=minim.loadFile("赵雷 - 画.mp3",1024);    //把 buffer size 设置成 1024
  song.loop();    //播放音乐
  
  colorMode(HSB);    //HSB颜色模式
  noStroke();
}

void draw() {

  //半透明方块，营造尾迹效果
  fill(0, 40); 
  rect(0, 0, width, height);
  

  float max=-10;      //找出1024个数据里的最大值
  float centerColorHue=0;    //最大值对应的色相存在这里
  
  for (int i=0; i<1024; i++) {    //1024个点均匀排布在圆周上

    // 每个点所在的角度
    float theta=map(i, 0, 1024, 0, TWO_PI);

    float value=song.mix.get(i);    //声音数据
    
    
    float r=map(value, -1, 1, 100, 360);    //映射成和圆心的距离
    float x=cos(theta) * r;        
    float y=sin(theta) * r;

    float ellipseRadius= map(value, -1, 1, 1, 15);    //映射成圆点的尺寸
    
    float hueValue=map(i,0,1024,0,255);    //每个圆点的色相不同
    fill(hueValue,255,255);
    ellipse(x+width/2, y+height/2, ellipseRadius, ellipseRadius);  
    
    if(abs(value)>max){    //找到最大值对应的色相
      max=abs(value);
      centerColorHue=hueValue;
    }
  }
  
  float diam=map(max,-1,1,5,50);    //中心圆的尺寸
  fill(centerColorHue,255,255);
  ellipse(width/2,height/2,diam,diam);
}
