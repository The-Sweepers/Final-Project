class Block {   //setup the Block class
  boolean hasMine;    //initialize the boolean has mine
  float x;    //initialize x,y,m
  float y;
  int m;
  boolean flagged;
  boolean revealed;  //initialize the boolean revealed

  Block(float X, float Y) {  //set up the constuctor 
    hasMine = false;   //set has mine to false when drawn
    x = X;   //set x equal to X and y to Y
    y = Y;
    flagged = false;
    m = 0;   //set m to 0
    revealed = false;   //set revealed to false when drawn
  }

  void display() {   //method display
    if (revealed==false) {
      fill(#eda691);
      stroke(#fae9e1);
      rect(x, y, 50, 50);   //draw the rectangle
    }
  }

  void disappear() { //method disappear
    fill(0, 0, 0, 0);   //set the fill  
    rect(x, y, 50, 50);   //draw rectangle 
    revealed = true;   //set revealed to true
  }
}