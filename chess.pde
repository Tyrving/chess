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
  text(mouseToXY()[0] + " - " + mouseToXY()[1], 5, 15);
  text(frameRate, 5, 30);
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
    for (BasePiece[] movingPieceRow : board.boardArray) {
      for (BasePiece movingPiece : movingPieceRow) {
        if (movingPiece.selected==true) {
          if (movingPiece.allChecks(row, col)) {
            board.place(row, col, movingPiece);
            return;
          }
        }
      }
    }
  }
}


void keyPressed() {
  if (key=='q') {
    byte row = mouseToXY()[0];
    byte col = mouseToXY()[1];
    BasePiece piece = board.boardArray[row][col];
    println(piece);
  }
}
