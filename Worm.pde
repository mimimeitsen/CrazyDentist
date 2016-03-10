class Worm {
  PImage[] worms = new PImage[6];
  PImage[] collect = new PImage[7];
  int i,which=1,life =5;
  int pace = 0;
  int reverse = 5;
  float t = 1,ballwalk,flag = 0.05;
  int ballX = 400;
  int ballY = 200;
  float the = 0;
  float a, b =1, c = 1,e =1 ,x,y,clock = -90,count,slope;
  Boolean noShoot;
  int number = 0;


  Worm () {
    for(i=1;i<=5;i++){
      worms[i] = loadImage("pic/worm"+i+".png");
      noShoot = true;
    }

  }
  
  void display(){
   if(noShoot==true){
     //println(clock);
    pushMatrix();
    translate (width/2+15, height/2+170);
    rotate (the);
    image(worms[which],25,0);
    x = width/2+15 + 25*cos(the);
    y = height/2+170 + 25*sin(the);
    popMatrix();
      if (the < -0.3 || the > PI-0.1){
      flag *= -1;}
      the += flag;
      pace++;
      if (pace%3==0)
      which++;
      if(which==6)
      which=1;
      a = (height/2+170-y)/( width/2+15-x);
      slope = map(abs(a),0,44,3,0.0000001);
      
      if(the>HALF_PI){
      b=2.5;
      c = 2.5;
    }
    else{
      b = -2.5;
      c = -2.5;
    }
    if(key==' '){
      noShoot = false;
      shootAWorm.rewind(); shootAWorm.play();
      clock = -90;
     // println(the);
      beingHit.rewind();
    }
   }
     
   if(noShoot != true){
     if (y < -30||x<-10||x>660||y>480){
      noShoot = true;
      key = 'a';
      life--;     
    }
    
    pushMatrix();

    translate (width/2+15+b, height/2+170+b*a*slope);
    rotate (the);
    imageMode(CORNER);
    
    image(worms[which],25,0);
    if(the>0.75 && the<2.25 ){
    b+=c*(abs(the-1.5)+0.5)*0.6;
    }else{
    b+=c*2;}
    e++;
    popMatrix();
    
    x =  width/2+15 + 25*cos(the)+b;
    y = height/2+170 + 25*sin(the)+b*a*slope;
    for(i=1;i<=6;i++){
      if(width/2+15 + 25*cos(the)+b>130+i*50 && width/2+15 + 25*cos(the)+b<130+(i+1)*50 && height/2+170 + 25*sin(the)+b*a*slope>35 && height/2+170 + 25*sin(the)+b*a*slope<168){
        
        if(teeth[i]!=null){
          number++;
          beingHit.play();
        teeth[i] = null;
      
        break;
        }
      }
    }
   }
  }
  
  
  void score(){
    
    for(i=1;i<=life;i++){
      image(worms[1],550,-30+i*90);
    }
    //image(collect[number],20,20);
    count = map(clock,0,360,0,TWO_PI);
    fill(255,111,181);
    ellipse(80,90,100,100);
    fill(255,255,255);
    arc(80, 90, 100, 100, -HALF_PI, count, PIE);
    //ellipse(80,90,100,100);
    line(80,90,80+50*cos(count),90+50*sin(count));
    if(noShoot==true){
    clock += 3;
    }
    
    if(clock>=270){
      life--;
      clock = -90;
    }

    if(number==6 && noShoot == true){
      number = 0;
      life = 5;
      gameState = GAME_WIN1;
    }
    if(life==-1){
      life = 5;
      number = 0;
      gameState = GAME_LOSE1;
    }
  }
}