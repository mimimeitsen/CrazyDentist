//background
int gameState ;
final int GAME_START=1, GAME_STORY1=2, GAME_RULE1=3, GAME_MISSION1=4, GAME_LOSE1=5, GAME_WIN1=6, GAME_STORY2=7, GAME_RULE2=8,GAME_MISSION2=9, GAME_LOSE2=10, GAME_WIN2=11, GAME_ENDING=12;
PImage start, story1, rule1, mission1bg, story2, rule2, mission2bg, lose, win, ending;

//mission1
Aim aim;
Worm worm;
PImage[] teeth = new PImage[7];
int i;

//mission2
PImage imgLife, imgReceiver, imgReceiver1;
int nbrLife , xReceiver , yReceiver , currentFakeTeeth , nbrTeethCollected;
final int receiverSpeed =5 ;
int q=0 ;
boolean leftPressed = false , rightPressed = false, enter = false ;
PImage[] tooth = new PImage[5];
float toothAX , toothAY , toothBX , toothBY , dentureAX , dentureAY , dentureBX , dentureBY , dentureCX , dentureCY;
int tA , tB , toothAFallingSpeed , toothBFallingSpeed;
PImage[] nbrCollectedPic = new PImage[10];

//denture
int currentDenture, dA , dB ,dC , dentureAFallingSpeed , dentureBFallingSpeed , dentureCFallingSpeed ;
final int nbrDenture = 120 ;
PImage[] imagesDenture = new PImage[nbrDenture];

//audio
import ddf.minim.*;
Minim minim;
AudioPlayer soundTrack;
AudioPlayer soundLose;
AudioPlayer soundWin1;
AudioPlayer soundWin2;
AudioPlayer soundEnding;
AudioPlayer shootAWorm;
AudioPlayer beingHit;
AudioPlayer toothCollectd;

void setup () {
  size(640,480) ; 

  aim = new Aim();
  worm = new Worm();

  for(i=1;i<=6;i++){
      teeth[i] = loadImage("pic/original teeth.png");
    }
  minim = new Minim(this);
  soundTrack = minim.loadFile("soundTrack.mp3");
  soundTrack.play();
  soundLose = minim.loadFile("lose.mp3");
  soundWin1 = minim.loadFile("win1.mp3");
  soundWin2 = minim.loadFile("win2.mp3");
  soundEnding = minim.loadFile("ending.mp3");
  toothCollectd = minim.loadFile("toothcollected.mp3");
  beingHit = minim.loadFile("beingHit.mp3");
  shootAWorm = minim.loadFile("shootAWorm.mp3");
  
  start = loadImage("pic/start.png") ;
  ending = loadImage("pic/ending.png") ;
  rule1 = loadImage("pic/rule1.png") ;
  rule2 = loadImage("pic/rule2.png") ;
  story1 = loadImage("pic/story1.png") ;
  story2 = loadImage("pic/story2.png") ;
  win = loadImage("pic/win.png") ;
  lose = loadImage("pic/lose.png") ;

  
  mission1bg = loadImage("pic/mission1background.png") ;
  mission2bg = loadImage("pic/mission2background.png") ;
  
  imgReceiver = loadImage("pic/receiver.png") ;
  imgReceiver1 = loadImage("pic/receiver1.png") ;
  
  imgLife = loadImage("pic/life.png") ;
  nbrLife = 3;

  for(int i=0;i<5;i++){tooth[i]=loadImage("pic/tooth"+(i+1)+".png");}
  for(int i=0;i<10;i++){nbrCollectedPic[i]=loadImage("pic/collected"+"0"+i+".png");}

  xReceiver = width/2-imgReceiver.width/2 ;  
  yReceiver = 280 ;

//denture
  currentDenture =0;
  for (int i=0;i<nbrDenture;i++){imagesDenture[i]=loadImage("pic/faketeeth"+(i%5+1)+".png");}
  frameRate(60);

  gameState = GAME_START;

  tA =int(random(5)) ;
  toothAX = random(width-tooth[tA].width);
  toothAY = -100 ;
  toothAFallingSpeed = 3 ;
  tB =int(random(5)) ;
  toothBX = random(width-tooth[tB].width);
  toothBY = -180 ;
  toothBFallingSpeed = 5 ;

  dentureAX = random(imagesDenture[dA].width/2,width-imagesDenture[dA].width/2);
  dentureAY = -100 ;
  dentureAFallingSpeed = 6 ;
  dentureBX = random(imagesDenture[dB].width/2,width-imagesDenture[dB].width/2);
  dentureBY = -150 ;
  dentureBFallingSpeed = 7 ;
  dentureCX = random(imagesDenture[dC].width/2,width-imagesDenture[dC].width/2);
  dentureCY = -180 ;
  dentureCFallingSpeed = 8 ;

  nbrTeethCollected=0;

}

void draw() {
    
  switch (gameState){
    
    case GAME_START:   
    if (enter==true){
      background(225);
      gameState = GAME_STORY1 ;
      enter = false;
      }else{
      image(start,0,0) ;}
      break ;   

    case GAME_STORY1 :
    if (enter==true){
      background(225);
       gameState = GAME_RULE1 ;
       enter = false;
      }else{image(story1,0,0);}      
      break ;
        
    case GAME_RULE1 :
    if (enter==true){
      background(225);
       gameState = GAME_MISSION1 ;
       enter = false;
      }else{image(rule1,0,0);}      
      break ;

     case GAME_MISSION1 :
    
          background(255);
          for(i=1;i<=6;i++){
          if(teeth[i]!=null){
          image(teeth[i],130+i*50,22);
          }
          image(mission1bg,0,0);
        }
        
        aim.display(width/2,height/2);
        worm.score();
        worm.display();             
      break ;

    case GAME_LOSE1 :
    if (enter==true){
      for(i=1;i<=6;i++){
      teeth[i] = loadImage("pic/original teeth.png");
      }
      gameState = GAME_MISSION1 ;
       enter = false;
       soundLose.rewind();
       soundLose.pause();
      }else{soundLose.play(); image(lose,0,0);}      
      break ;

    case GAME_WIN1 :
    if (enter==true){
      for(i=1;i<=6;i++){
      teeth[i] = loadImage("pic/original teeth.png");
      }
      background(225);
       gameState = GAME_STORY2 ;
       enter = false;
       soundWin1.pause();
      }else{soundWin1.play(); image(win,0,0);}
      break ;

    case GAME_STORY2 :
    if (enter==true){
      background(225);
       gameState = GAME_RULE2 ;
       enter = false;
      }else{image(story2,0,0);}      
      break ;
      
    case GAME_RULE2 :
    if (enter==true){
       gameState = GAME_MISSION2 ;
       enter = false;
      }else{image(rule2,0,0);}      
      break ;

    case GAME_MISSION2 :
      image(mission2bg,0,0);
      
      if(nbrTeethCollected==10){gameState=GAME_WIN2;nbrLife=3;nbrTeethCollected=0;}else{
      image(nbrCollectedPic[nbrTeethCollected],600-nbrCollectedPic[nbrTeethCollected].width,80);        
      //receiver
      if(q>120){q=0; }
      if(q==0){image(imgReceiver,xReceiver,yReceiver); beingHit.rewind();
      }else{image(imgReceiver1,xReceiver,yReceiver);q++; }
      if(leftPressed){
        xReceiver -= receiverSpeed;
        if(xReceiver<0)xReceiver = 0;
      }
      if(rightPressed){
        xReceiver += receiverSpeed;
        if(xReceiver>width-imgReceiver.width)xReceiver= width-imgReceiver.width;
      }
      
      //teeth
      if(toothAY < height-tooth[tA].height-10){
      image(tooth[tA],toothAX,toothAY);
      toothAY+= toothAFallingSpeed;
        if(toothAY+tooth[tA].height-yReceiver>=0 && toothAY+tooth[tA].height-yReceiver <= 8 && toothAX >= xReceiver-tooth[tA].width && toothAX <= xReceiver+imgReceiver.width){
        toothCollectd.play(); toothCollectd.rewind(); 
        nbrTeethCollected ++ ; toothAX = random(width-tooth[tA].width); toothAY=-100; tA=int(random(5)) ; toothAFallingSpeed = int(random(3,8)) ;}      
      }else{toothAX = random(width-tooth[tA].width); toothAY=-100; tA=int(random(5)) ; toothAFallingSpeed = int(random(3,8)) ; }     
      if(toothBY < height-tooth[tB].height-10){
      image(tooth[tB],toothBX,toothBY);
      toothBY+= toothBFallingSpeed;
        if(toothBY+tooth[tB].height-yReceiver>=0 && toothBY+tooth[tB].height-yReceiver<=8 && toothBX >= xReceiver-tooth[tB].width && toothBX <= xReceiver+imgReceiver.width){
        toothCollectd.play(); toothCollectd.rewind(); 
        nbrTeethCollected ++ ; toothBX = random(width-tooth[tB].width); toothBY=-100; tB=int(random(5)) ; toothBFallingSpeed = int(random(3,8)) ;}   
      }else{toothBX = random(width-tooth[tB].width); toothBY=-100; tB=int(random(5)) ; toothBFallingSpeed = int(random(3,8)) ; }
      
      //denture
      if(dentureAY < height-100){
      int i = (currentDenture++)%nbrDenture;
      imageMode(CENTER);
      pushMatrix();
      translate(dentureAX , dentureAY);
      if(xReceiver+imgReceiver.width/2>=dentureAX){
        rotate(-PI/2);
        rotate(atan2(yReceiver+imgReceiver.height/2-dentureAY,30));
      }else{
        rotate(PI/2);
        rotate(atan2(-(yReceiver+imgReceiver.height/2)+dentureAY,30));
      }
      image(imagesDenture[i],0,0);
      popMatrix();
      dentureAY += dentureAFallingSpeed;
      if(dentureAY>=yReceiver && dentureAX>=xReceiver-imagesDenture[i].width/2 && dentureAX<=xReceiver+imagesDenture[i].width/2){
        nbrLife--;dentureAX = random(imagesDenture[dA].width/2,width-imagesDenture[dA].width/2); dentureAY=-100; dentureAFallingSpeed = int(random(5,9)) ;
        q=1; 
        image(imgReceiver1,xReceiver+imgReceiver1.width/2,yReceiver+imgReceiver1.height/2);
        beingHit.play();
        beingHit.rewind();
      }}else{dentureAX = random(imagesDenture[dA].width/2,width-imagesDenture[dA].width/2); dentureAY=-100; dentureAFallingSpeed = int(random(5,9)) ;}

      if(dentureBY < height-100){
      int i = (currentDenture++)%nbrDenture;
      imageMode(CENTER);
      pushMatrix();
      translate(dentureBX , dentureBY);
      if(xReceiver+imgReceiver.width/2>=dentureBX){
        rotate(-PI/2);
        rotate(atan2(yReceiver+imgReceiver.height/2-dentureBY,30));
      }else{
        rotate(PI/2);
        rotate(atan2(-(yReceiver+imgReceiver.height/2)+dentureBY,30));
      }
      image(imagesDenture[i],0,0);
      popMatrix();
      dentureBY += dentureBFallingSpeed;
      if(dentureBY>=yReceiver && dentureBX>=xReceiver-imagesDenture[i].width/2 && dentureBX<=xReceiver+imagesDenture[i].width/2){
        nbrLife--;dentureBX = random(imagesDenture[dB].width/2,width-imagesDenture[dB].width/2); dentureBY=-100; dentureBFallingSpeed = int(random(5,9)) ;
        q=1; 
        image(imgReceiver1,xReceiver+imgReceiver1.width/2,yReceiver+imgReceiver1.height/2);
        beingHit.play();
        beingHit.rewind();
      }}else{dentureBX = random(imagesDenture[dB].width/2,width-imagesDenture[dB].width/2); dentureBY=-100; dentureBFallingSpeed = int(random(5,9)) ;}
 
      if(dentureCY < height-100){
      int i = (currentDenture++)%nbrDenture;
      imageMode(CENTER);
      pushMatrix();
      translate(dentureCX , dentureCY);
      if(xReceiver+imgReceiver.width/2>=dentureCX){
        rotate(-PI/2);
        rotate(atan2(yReceiver+imgReceiver.height/2-dentureCY,30));
      }else{
        rotate(PI/2);
        rotate(atan2(-(yReceiver+imgReceiver.height/2)+dentureCY,30));
      }
      image(imagesDenture[i],0,0);
      popMatrix();
      dentureCY += dentureCFallingSpeed;
      if(dentureCY>=yReceiver && dentureCX>=xReceiver-imagesDenture[i].width/2 && dentureCX<=xReceiver+imagesDenture[i].width/2){
        nbrLife--;dentureCX = random(imagesDenture[dC].width/2,width-imagesDenture[dC].width/2); dentureCY=-100; dentureCFallingSpeed = int(random(5,9)) ;
        q=1; 
        image(imgReceiver1,xReceiver+imgReceiver1.width/2,yReceiver+imgReceiver1.height/2);
        beingHit.play();
        beingHit.rewind();
      }}else{dentureCX = random(imagesDenture[dC].width/2,width-imagesDenture[dC].width/2); dentureCY=-100; dentureCFallingSpeed = int(random(5,9)) ;}

      imageMode(CORNER);
            
      for(int i=0;i<nbrLife;i++){image(imgLife,445+i*50,30);}
      if (nbrLife==0){gameState=GAME_LOSE2; nbrLife=3;nbrTeethCollected=0;beingHit.rewind(); beingHit.play();}      
      }
      break ;

   case GAME_LOSE2 :
    if (enter==true){
       gameState = GAME_MISSION2 ;
       enter=false;
       soundLose.rewind();
       soundLose.pause();
      }else{soundLose.play(); image(lose,0,0);}      
      break ;

    case GAME_WIN2 :
    if (enter==true){
       gameState = GAME_ENDING ;
       enter=false;
       soundWin2.pause();
       }else{soundWin2.play(); image(win,0,0);}      
    break ;
    
       case GAME_ENDING :
    if (enter==true){
       gameState = GAME_START ;
       enter=false;
       soundTrack.play(); soundEnding.pause();
      }else{soundTrack.pause(); soundEnding.play(); image(ending,0,0);}      
      break ;

  }
}

    void keyPressed() {
      if(key == CODED){
        switch(keyCode){
          case LEFT :   leftPressed = true ;   break ;
          case RIGHT :   rightPressed = true ;   break ;
        }
      }
      if(key==ENTER){
        enter = true;
      }
    }

    void keyReleased(){
      if(key == CODED) {
        switch(keyCode){
          case LEFT :   leftPressed = false ;   break ;
          case RIGHT :   rightPressed = false ;   break ;
        }
      }
    }