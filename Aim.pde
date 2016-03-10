class Aim{
  int ballX;
  int ballY;
  int reverse = 5;
  float t = 1,ballwalk;
  Aim () {
    
    
  }
  
  void display(int x, int y){
    strokeWeight(6);
    noFill();
    pushMatrix();
    translate(15,170);
    ellipse(x,y,50,50);
    line(x-50,y,x+50,y);
    line(x,y-50,x,y+50);
    ballX = x;
    ballY = y;
    popMatrix();
  }
  
  void ball(){
    ballwalk = map(t,0,180,0,PI);
    ellipse(ballX +80*cos(ballwalk),ballY +80*sin(ballwalk),20,20);
    t+=reverse;
    if(t>180||t<0)
      reverse*=-1;
  }
}