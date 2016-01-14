class Block {
  boolean hasMine;
  float x;
  float y;
  float g;
  float m;

  Block(float X, float Y) {
    hasMine = false;
    x = X;
    y = Y;
    g =150;
    m = 0;
  }

  void display() {
    fill(g);
    rect(x, y, 50, 50);
  }

  void disappear() {
    g=0;
    fill(0, 0, 0, 0);
    rect(x, y, 50, 50);
  }

  //int surroundingMines(){
  //check how many mines around
  //int n;
  //return n;
  //}
}