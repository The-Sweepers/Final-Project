class Block {   //setup the Block class
  boolean hasMine;    //initialize the boolean has mine
  float x;    //initialize x,y,g,m
  float y;
  float g;
  int m;
  boolean revealed;  //initialize the boolean revealed

  Block(float X, float Y) {  //set up the constuctor 
    hasMine = false;   //set has mine to false when drawn
    x = X;   //set x equal to X and y to Y
    y = Y;
    g =150;   //give the variable g a value
    m = 0;   //set m to 0
    revealed = false;   //set revealed to false when drawn
  }
 
  void display() {   //method display
    fill(g);    //set the fill to variable g or also gray
    rect(x, y, 50, 50);   //draw the rectangle 
  }

  void disappear() { //method disappear
    g=0;   //declare g as 0
    fill(0, 0, 0, 0);   //set the fill
    rect(x, y, 50, 50);   //draw rectangle 
    revealed = true;   //set revealed to true
  }

  //int surroundingMines(){
  //check how many mines around
  //int n;
  //return n;
  //}
}