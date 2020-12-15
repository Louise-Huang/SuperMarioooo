import processing.sound.*;
SoundFile sound;
int [][]map={{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
             {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
             {0,0,0,0,0,0,0,0,0,0,0,0,0,1,1},
             {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
             {0,0,0,0,0,1,1,2,1,0,0,0,0,0,0},
             {1,1,0,0,0,0,0,0,0,0,0,0,1,1,1},
             {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
             {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
             {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
             {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1}};
int interval=45,time;
PImage imgTurtle2R,imgTurtle2L,imgTurtleR,imgTurtleL,imgCoin,imgBrick,imgQuestion,imgMarioR,imgMarioL,imgMarioJumpR,imgMarioJumpL;
void setup(){
  size(600,400);
  imgCoin=loadImage("Coin.png");
  imgBrick=loadImage("brick.png");
  imgQuestion=loadImage("question.jpg");
  imgMarioR=loadImage("Mario.png");
  imgMarioL=loadImage("MarioL.png");
  imgMarioJumpL=loadImage("MarioJumpL.png");
  imgMarioJumpR=loadImage("MarioJumpR.png");
  imgTurtleR=loadImage("TurtleR.png");
  imgTurtleL=loadImage("TurtleL.png");
  imgTurtle2R=loadImage("Turtle2R.png");
  imgTurtle2L=loadImage("Turtle2L.png");
  //imgMarioJumpR=loadImage("MarioJumpR.png");
  //imgMarioJumpL=loadImage("MarioJumpL.png");
  sound = new SoundFile(this,"marioMusic.mp3");
  sound.play();
  sound.loop();
}
boolean marioJumping=false,marioR=true,marioL=false;//marioL=false,marioRJ=false,marioLJ=false;
int marioX=100,marioY=300;
float marioVX=0,marioVY=0;
boolean GameStart=false,dead=false;
void Initail(){
  interval=45;
  time=0;
  Score=0;
  TurtleX=500;TurtleY=280;Turtle2X=400;Turtle2Y=280;
  marioX=100;marioY=300;
}

void draw(){
  
  
  if(GameStart){
  time=interval-int(millis()/1000);
  DrawMap();
  MarioConrol();
  testMarioOnFloor();
  OnCollision();
  drawCoin();
  DrawTurtle();
  DrawTurtle2();}
  else{
    if(dead){
      DrawDeadMenu();
    }
    else DrawMenu();
  }
}


  //print("MarioR="+marioR+" MarioL="+marioL+"\n");


void OnFloorDetect(){
  int i=int(marioY/40),j=int(marioX/40);
  if(i>=8||j>=15)return;
  if(map[i+1][j]!=0){marioJumping=false;marioY=i*40;marioVY=0;}
  else marioJumping=true;
}
void testMarioOnFloor(){

  int i=int(marioY/40),j=int(marioX/40);
  //print("Y:"+i+" X:"+j+"\n");
  if(i>=8||j>=15||j<0||i<0)return;
  //print(map[i+1][j]);
  if(map[i+1][j]!=0||map[i+1][j+1]!=0){
  marioJumping=false;marioY=i*40;marioVY=0;}
  else marioJumping=true;
}
void keyPressed(){
  if(keyCode=='P'||keyCode=='p'){Initail();GameStart=true;dead=false;interval=interval+int(millis()/1000);}
  if(keyCode==RIGHT) {marioR=true; marioVX=4;}
  if(keyCode==LEFT) {marioR=false;marioVX=-4;}
  if(key==' ' ||keyCode==UP) {marioVY=-12; marioJumping=true;} 
}
void keyReleased(){
    if(keyCode==RIGHT||keyCode==LEFT){
    marioVX=0;}
}

boolean Coin=false,Coin2=false;
void OnCollision(){
  if(marioX>(imgQ_PosX-20)&&marioX<(imgQ_PosX+20)&&marioY==(imgQ_PosY+40)){
     Coin=true;
  } 
  /*if(marioX>(imgQ2_PosX-20)&&marioX<(imgQ2_PosX+20)&&marioY==(imgQ2_PosY+40)){
     Coin2=true;
  }*/
  if(marioX>(TurtleX-20)&&marioX<(TurtleX+20)&&marioY<(TurtleY+20)&&marioY>TurtleY-20){
    DrawDeadMenu();
    dead=true;
    print("Dead");
  }
  if(marioX>(Turtle2X-20)&&marioX<(Turtle2X+20)&&marioY<(Turtle2Y+20)&&marioY>Turtle2Y-20){
    DrawDeadMenu();
    dead=true;
    print("Dead");
  }
}

void drawCoin(){
   if(Coin){
     image(imgCoin,280,120,40,40);
     //print("X:"+marioX+"Y:"+marioY+"\n");
     if(marioX>260&&marioX<300&&marioY>=80&&marioY<=120){
       Score+=10;
       Coin=false;
     }
   }
   /*if(Coin2){
     image(imgCoin,280,120,40,40);
     //print("X:"+marioX+"Y:"+marioY+"\n");
     if(marioX>480&&marioX<560&&marioY>=80&&marioY<=160){
       Score+=10;
       Coin=false;
     }
   }*/
}


int Score=0;
int TurtleX=500,TurtleY=280,Turtle2X=400,Turtle2Y=280;
int TurtleV=0;
boolean TurtleTurn=false,Turtle2Turn=true;
void TurtleControl(){
  if(TurtleTurn==false){
    TurtleX-=3;
  }
  else TurtleX+=3;
  
  if(TurtleX<0)TurtleTurn=true;
  if(TurtleX>560)TurtleTurn=false;
}
void Turtle2Control(){
  if(Turtle2Turn==false){
    Turtle2X-=2;
  }
  else Turtle2X+=2;
  
  if(Turtle2X<0)Turtle2Turn=true;
  if(Turtle2X>560)Turtle2Turn=false;
}

void DrawTurtle2(){
  Turtle2Control();
  if(Turtle2Turn){
  image(imgTurtle2R,Turtle2X,TurtleY,40,40);}
  else image(imgTurtle2L,Turtle2X,TurtleY,40,40);
}

void DrawTurtle(){
  TurtleControl();
  if(TurtleTurn){
  image(imgTurtleR,TurtleX,TurtleY,40,40);}
  else image(imgTurtleL,TurtleX,TurtleY,40,40);
}

int imgQ_PosX=0,imgQ_PosY=0,imgQ2_PosX=0,imgQ2_PosY=0;

void DrawMenu(){
  background(#9CD8FC);
  fill(255,0 ,0 );
  textSize(25);
  text("Press 'P' to play Game", 180, 200);
}

void DrawDeadMenu(){
  GameStart=false;
  background(#9CD8FC);
  fill(255,0 ,0 );
  textSize(100);
  text("GAME OVER", 15, 160);
  textSize(50);
  text("Your Score:"+Score, 140, 230);
  fill(0,0 ,0 );
  textSize(25);
  text("Press 'p' to Restart",190,340);
  
}

void DrawMap(){
  background(#9CD8FC);
  fill(255,0 ,0 );
  textSize(25);
  text("Score:"+Score, 10, 30);
  text("Time:"+time,450,30);
  for(int i=0;i<10;i++){
    for(int j=0;j<15;j++){
      if(map[i][j]==1) {image(imgBrick,j*40,i*40,40,40);}
      if(map[i][j]==2){
      image(imgQuestion,j*40,i*40,40,40);
      imgQ_PosX=j*40;imgQ_PosY=i*40;
      //print("X:"+imgQ_PosX+" Y:"+imgQ_PosY);
      }
    }
  }
  if(time<0){
    DrawDeadMenu();
    dead=true;
    //print("Dead");
  }
}


void MarioConrol(){
  
  if(marioR==true&&marioJumping==false){
    image(imgMarioR,marioX,marioY,40,40);
  }
  if(marioR==false&&marioJumping==false) {
    image(imgMarioL,marioX,marioY,40,40);
  }

  marioX+=marioVX;marioY+=marioVY;
  if(marioJumping) {
  marioVY+=0.98;
  if(marioR){
    image(imgMarioJumpR,marioX,marioY,40,40);
  }
  else {
    image(imgMarioJumpL,marioX,marioY,40,40);
  }
  }
}