int X = 0;  //initialize x,y, and n
int Y = 0;
Block[][] a = new Block[9][9]; //create a 2D array of the block class with the dimensions of 9X9
int n;
PImage mine; //initialize varables
boolean lose;
PImage flag;
int score;
PFont font;
PImage loss;
int u;
boolean win;
PImage winpic;

int actualSecs; //actual seconds elapsed since start
int actualMins; //actual minutes elapsed since startint startSec = 0; 
int startMin = 0; //starting minute value
int startSec = 0; //starting second value
int scrnSecs=0; //seconds displayed on screen 
int scrnMins=0; //minutes displayed on screen (will be infinite)
int restartSecs=0; //number of seconds elapsed at 60 sec interval
int restartMins=0; //number of seconds ellapsed at most recent minute
int displaySec; //displaying time 
boolean timeExists = true;  //boolean to stop timer


void setup() {
  size(650, 650);     //set the size of the canvas
  for (int X = 0; X < 9; X++) {    //create a for loop too draw the grid for the x and y locations
    for (int Y = 0; Y < 9; Y ++) {
      a[X][Y] = new Block(X*50 + 100, Y*50 + 100);   //using the block class give the values of the array
    }
  }
  mine = loadImage("maher-mine.png"); //load image from data folder
  lose = false; //set lose to false
  flag = loadImage("ACAD-logo.png"); //load image from data folder
  n = 0;   //declare the value for n
  score = 10; //start the score at 10
  loss = loadImage("maher-mine-inverted.png"); //load image from data folder
  font = createFont("Courier New", 50); //load font
  textFont(font); //set font
  u = 0; //set u o 0
  win = false; //set win to false
  winpic = loadImage("maher-mine-sunglasses.png"); //load image from data folder
}

void draw() {

  actualSecs = millis()/1000; //convert milliseconds to seconds
  actualMins = millis() /1000 / 60; //convert milliseconds to minutes
  scrnSecs = actualSecs - restartSecs; //seconds to be shown on screen
  scrnMins = actualMins - restartMins; //minutes to be shown on screen


  if (actualSecs % 60 == 0) { //after 60 secs, restart second timer 
    restartSecs = actualSecs;   //placeholder for this second in time
    displaySec = startSec; //reset to zero
  }

  textSize(25); //set text size to 25
  if (timeExists) {
    displaySec = scrnSecs;  //display seconds
  } 

  background(#fae9e1);   //set the background to black

  textAlign(CENTER, CENTER);  //text align
  textSize(25); //set text size to 25
  fill(255, 0, 0);  //fill color
  text(displaySec, (width/2)+110, 50);  //placement
  text(":", (width/2)+90, 50);  //placement
  text(scrnMins, (width/2)+70, 50);  //placement

  for (int X = 0; X < 9; X++) {   //for loop to draw the grid for the x and y values
    for (int Y = 0; Y < 9; Y++) {
      a[X][Y].display();     //using the display method draw the blocks
      if (a[X][Y].hasMine == true && a[X][Y].revealed == true && win == false) { //if a block with a mine is clicked
        fill(#676e4f); //change the color of the block
        rect(a[X][Y].x, a[X][Y].y, 50, 50);
        imageMode(CORNER); 
        image(mine, a[X][Y].x, a[X][Y].y); //display an image from the corner
        lose = true; //the game has been lost
      }
      if (a[X][Y].revealed == true && a[X][Y].m > 0) { //if revealed is true
        fill(#676e4f);  //set the fill to white
        textSize(25); //set text size
        textAlign( CENTER, CENTER);  //text align to center
        text(a[X][Y].m, a[X][Y].x + 25, a[X][Y].y + 25);  //draw the variable m also know as the mine surrounding it in the box
      }
      if ( lose == true && a[X][Y].hasMine == true && a[X][Y].flagged == false) { //if the game has been lost
        a[X][Y].revealed = true; //reveal all unflagged mines
      }
      if ( a[X][Y].flagged == true) { //if a block has been flagged
        imageMode(CORNER); 
        image(flag, a[X][Y].x, a[X][Y].y); //display the flag image
      }
    }
  }
  while (n<10) {    //while loop to draw the mines while the value is less than 10
    a[round(random(0, 8))][round(random(0, 8))].hasMine = true;   //set the value for the boxes that have mines to truw for the boolean hasmine
    n++;   //increase the value of n until it reaches 10
  }
  textSize(25);
  textAlign(CENTER, CENTER);
  fill(#2f3325);
  text(score, width/2-50, 50); //display the score
  if (lose) { //if the game has been lost 
    textAlign(CENTER, CENTER);
    textSize(100);
    text("YOU LOSE!", width/2, height/2); //on top of board (or bg)
    fill(#eda691);
    imageMode(CENTER);
    rect(width/2 - 25, 25, 50, 50);
    image(loss, width/2, 50); //change the maher at the top
    timeExists = false;
  }
  if (lose == false && win == false) { //if the game is still being played
    fill(#676e4f);
    imageMode(CENTER);
    rect(width/2 - 25, 25, 50, 50);
    image(mine, width/2, 50); //show maher
  }

  if (u == 71 && lose == false) { //if 71 non-mine blocks have been uncovered
    win = true; //you have won
  }

  if (win) { //if you win
    textAlign(CENTER, CENTER);
    textSize(100);
    text("YOU WIN!", width/2, height/2); //display win text
    fill(#676e4f);
    imageMode(CENTER);
    rect(width/2 - 25, 25, 50, 50);
    image(winpic, width/2, 50); //display win maher
    timeExists = false; //stop time
  }

  if (mousePressed) { //if the mouse is presses
    if (mouseX > width/2 - 25 && mouseX < width/2 + 25 && mouseY > 25 && mouseY < 75) { //if the mouse is at the restart button
      n = 0;
      lose = false;
      win = false;
      u = 0; //reset variables
      timeExists= true;
      restartSecs = actualSecs; //restart timer
      restartMins = actualMins;
      score = 10; //reset score
      for (int X = 0; X < 9; X++) {   //while in the grid
        for (int Y = 0; Y < 9; Y++) {
          a[X][Y].flagged = false;
          a[X][Y].revealed = false;
          a[X][Y].hasMine = false;
          a[X][Y].m = 0; //reset mines
        }
      }
    }
  }
}

void mouseClicked() {  //mouse clicked 
  for (int X = 0; X < 9; X++) {   //while in the grid
    for (int Y = 0; Y < 9; Y++) {
      if (mouseX > a[X][Y].x && mouseX < a[X][Y].x + 50 && mouseY > a[X][Y].y && mouseY < a[X][Y].y +50) {  //if the mouse is clicked within a certain box
        if (mouseButton == LEFT && a[X][Y].revealed == false && a[X][Y].flagged == false) {
          a[X][Y].disappear();   //use the method to cause the block to dissapear
          u++;
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
        if (mouseButton == RIGHT) { //if right clicked
          if (a[X][Y].flagged == true && a[X][Y].revealed == false ) { //if flagged
            a[X][Y].flagged = false; //unflag
            score = score + 1; //increase score
          } else if (a[X][Y].flagged == false && a[X][Y].revealed == false ) { //if unflagged
            a[X][Y].flagged = true; //flag
            score = score - 1; //decrease score
          }
        }
      }
    }
  }
}