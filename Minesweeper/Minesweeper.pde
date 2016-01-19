int X = 0;  //initialize X,Y, and n
int Y = 0;
Block[][] a = new Block[9][9]; //create a 2D array of the block class with the dimensions of 9X9
int n;

void setup() {
  size(650, 650);     //set the size of the canvas
  for (int X = 0; X < 9; X++) {    //create a for loop to draw the grid for the x and y locations
    for (int Y = 0; Y < 9; Y ++) {
      a[X][Y] = new Block(X*50 + 100, Y*50 + 100);   //using the block class give the values of the array
    }
  }
  n = 0;   //declare the value for n
}

void draw() {
  background(0);   //set the background to black
  for (int X = 0; X < 9; X++) {   //for loop to draw the grid for the x and y values, 
    for (int Y = 0; Y < 9; Y++) {
      a[X][Y].display();     //using the display method draw the blocks
      if (mouseX > a[X][Y].x && mouseX < a[X][Y].x + 50 && mouseY > a[X][Y].y && mouseY < a[X][Y].y +50) {   
        if (a[X][Y].hasMine) { 
          fill(255);
          rect(a[X][Y].x, a[X][Y].y, 10, 10);
        }
      }
      a[5][5].hasMine = true;
      if (a[X][Y].revealed == true && a[X][Y].m > 0) { //if revealed is true
        fill(255);  //set the fill to white
        textSize(25); //set text size
        textAlign( CENTER, CENTER);  //text align to center
        text(a[X][Y].m, a[X][Y].x + 25, a[X][Y].y + 25);  //draw the variable m also know as the mine surrounding it in the box
      }
    }
  }
  while (n<10) {    //while loop to draw the mines while the value is less than 10
    a[round(random(0, 8))][round(random(0, 8))].hasMine = true;   //set the value for the boxes that have mines to truw for the boolean hasmine
    n++;   //increase the value of n until it reaches 10
  }
}

void mouseClicked() {  //mouse clicked 
  for (int X = 0; X < 9; X++) {   //while in the grid
    for (int Y = 0; Y < 9; Y++) {
      if (mouseX > a[X][Y].x && mouseX < a[X][Y].x + 50 && mouseY > a[X][Y].y && mouseY < a[X][Y].y +50) {  //if the mouse is clicked within a certain box
        a[X][Y].disappear();   //use the method to cause the block to dissapear
        if (a[X][Y].hasMine == false) {  //if the box is not a mine
          if (X<8) {    
            if (a[X+1][Y].hasMine) {   //is there a mine to the right if so increase m
              a[X][Y].m++;
            }
          }
          if (X>0) {   
            if (a[X-1][Y].hasMine) {   //is there a mine to the left if so increase m
              a[X][Y].m++;
            }
          }
          if (X<8 && Y<8) {   //is there a mine diagonally down to the right if so increase m
            if (a[X+1][Y+1].hasMine) { 
              a[X][Y].m++;
            }
          }
          if (X<8 && Y>0) {
            if (a[X+1][Y-1].hasMine) {   //is there a mine diagonally up to the right if so increase m
              a[X][Y].m++;
            }
          }
          if (X>0 && Y<8) {
            if (a[X-1][Y+1].hasMine) {  //is there a mine diagonally down to the left if so increase m
              a[X][Y].m++;
            }
          }
          if (X>0 && Y>0) {
            if (a[X-1][Y-1].hasMine) { //is there a mine diagonally to the right if so increase m 
              a[X][Y].m++;
            }
          }
          if (Y<8) {
            if (a[X][Y+1].hasMine) {   //is there a mine below if so increase m
              a[X][Y].m++;
            }
          }
          if (Y>0) {
            if (a[X][Y-1].hasMine) {   //is there a mine above if so increase m 
              a[X][Y].m++;
            }
          }
        }
      }
    }
  }
}