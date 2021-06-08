import processing.sound.*;
SoundFile audio;

PImage b_pawn;
PImage w_pawn;
PImage b_king;
PImage w_king;//should probably not be global, but it makes life easier
PImage b_queen;
PImage w_queen;
PImage b_bishop;
PImage w_bishop;
PImage b_rook;
PImage w_rook;
PImage b_knight;
PImage w_knight;

Board board;
byte mousemoved = 1;
//this mousemoved thingy is for idle performance
//when 0, dont draw. When >0, draw. Subtract one each time draw runs, 
//so it will go to zero, and halt. when the mouse moves, set it to two, so it 
//will render the next several frames, and not cut off final frames of pieces 
//getting placed, etc. Also set to two on other actions

int tileX;
int tileY;//for saving tile sizes based on screen size
byte tileXHalf;
byte tileYHalf;

void setup() {
  audio = new SoundFile(this, "rick.wav");
  audio.play();
  noStroke();
  frameRate(60);
  size(800, 800);//please multiple of 8 for tiling purposes
  smooth(0);
  imageMode(CENTER);
  loadImages();
  board = new Board();
  tileX = width/8;
  tileY = height/8;//used globally to save on doing this math every render
  tileXHalf = byte(width/16);
  tileYHalf = byte(height/16);
}

void draw() {
  if (mousemoved==0) return;//dont do anything if you dont need to
  mousemoved-=1;
  background(0);
  board.render();
}
void mouseMoved() {//render stuff
  mousemoved=2;
}
void mousePressed() {
  mousemoved=2;//render stuff now
  byte row = mouseToXY()[0];//get mouse x and y
  byte col = mouseToXY()[1];
  BasePiece clickedPiece = board.boardArray[row][col];
  if (!board.anySelected) {
    if (clickedPiece.isSelectable()) {//if nothing is selected, and something can be selected, select it
      board.select(clickedPiece);
    }
  } else {//if something is selected
    BasePiece movingPiece = board.boardArray[board.movingPieceRow][board.movingPieceCol];
    if ((movingPiece.selected==true) && (movingPiece.allChecks(row, col))) {
      board.place(row, col, movingPiece);//place the moving piece where the user clicked
    }
  }
}
