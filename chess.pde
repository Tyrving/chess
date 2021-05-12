PImage b_pawn;
PImage w_pawn;
PImage b_king;
PImage w_king;
PImage b_queen;
PImage w_queen;
PImage b_bishop;
PImage w_bishop;
PImage b_rook;
PImage w_rook;
PImage b_knight;
PImage w_knight;
Board board;
enum Turn{
  Black, White, Moving
}

void setup() {
  frameRate(60);
  size(800, 800);//please multiple of 8 for tiling purposes
  imageMode(CENTER);
  loadImages();
  board = new Board();
}

void draw() {
  background(0);
  board.render();
  stroke(0);
  fill(0);
  text(mouseX + " - " + mouseY, 5, 15);
  text(mouseToXY()[0] + " - " + mouseToXY()[1], 5, 35);
}

void mousePressed() {
  byte row = mouseToXY()[0];
  byte col = mouseToXY()[1];
  BasePiece piece = board.boardArray[row][col];
  if (!board.anySelected) {
    if (piece.isSelectable()) {
      board.select(piece);
    }
  } else {
    if(piece.checkTarget(row, col)){
      board.place(row, col, piece);
    }
  }
}
