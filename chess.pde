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
boolean movingAnyPiece = false;
boolean whiteTurn = true;
int selectedRow;
int selectedCol;

enum Piece{
  Rook, Knight, Bishop, King, Queen, Pawn
}

Piece[][] pieceArray = new Piece[8][8];
boolean[][] colorArray= new boolean[8][8];

void setup() {
  size(800, 800);//please multiple of 8 for tiling purposes
  imageMode(CENTER);
  loadImages();
  startPiecesArrangement();
}

void draw() {
  background(0);
  checkerBackground();
  renderPieces();
  stroke(0);
  fill(0);
  text(mouseX + " - " + mouseY, 5, 15);
  text(mouseToXY()[0] + " - " + mouseToXY()[1], 5, 35);
}

void mousePressed() {
  int row = mouseToXY()[0];
  int col = mouseToXY()[1];

  if (isSelectAble(row, col)) {
    return;
  }

  if (!movingAnyPiece) {
    selectedRow = mouseToXY()[0];
    selectedCol = mouseToXY()[1];
    selectedPiece = boardArray[col][row];
    selectedPiece.moving=true;
    movingAnyPiece=true;
  } else if (selectedPiece.checkMove(row, col, selectedRow, selectedCol)) {
    boardArray[selectedCol][selectedRow] = new noPiece(true);
    boardArray[col][row] = selectedPiece;
    selectedPiece.moving=false;
    movingAnyPiece=false;
    whiteTurn = !whiteTurn;
  }
}
boolean isSelectAble(int row, int col) {
  if (!movingAnyPiece) {
    if ((boardArray[col][row].white != whiteTurn)) {
      return false;
    }
    if (boardArray[col][row] instanceof noPiece) {
      return false;
    }
  }
  return true;
}

boolean isPieceInWay(byte x, byte y, byte targetX, byte targetY){
  return false;
}
boolean targetColor(byte row, byte col){
  return false;
}
