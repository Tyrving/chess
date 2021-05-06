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
BasePiece selectedPiece = new noPiece(true);
int selectedRow;
int selectedCol;

BasePiece[][] boardArray = new BasePiece[8][8];

void setup() {
  size(800, 800);//please multiple of 8 for tiling purposes
  imageMode(CENTER);
  loadImages();
  checkerBackground();
  startPiecesArrangement();
  renderPieces();
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
  if(!movingAnyPiece && (boardArray[col][row].white != whiteTurn)){
    return;
  }
  if(boardArray[col][row] instanceof noPiece && !movingAnyPiece){
    return;
  }
  if(!movingAnyPiece){
    selectedRow = mouseToXY()[0];
    selectedCol = mouseToXY()[1];
    selectedPiece = boardArray[col][row];
    selectedPiece.moving=true;
    movingAnyPiece=true;
  }else if(selectedPiece.checkMove(row, col, selectedRow, selectedCol)){
    boardArray[selectedCol][selectedRow] = new noPiece(true);
    boardArray[col][row] = selectedPiece;
    selectedPiece.moving=false;
    movingAnyPiece=false;
    whiteTurn = !whiteTurn;
  }
  
}

void renderPieces(){
  for(int col=0; col<boardArray.length; col++){
    BasePiece[] collumnArray = boardArray[col];
    for(int row=0; row<collumnArray.length; row++){
      BasePiece piece = collumnArray[row];
      if(piece.moving==false){
        piece.render(row*100+50, col*100+50);
      }else{
        piece.render(mouseX, mouseY);
      }
    }
  }
}
boolean somethingInTheWay(int x, int y, int targetX, int targetY){
  if(x==targetX){
    int range = y-targetY;
    for(int i=y; i==targetY; i+=range/abs(range)){
      println(i);
    }
    
  }
  if(y==targetY){
    int range = x-targetX;
    for(int i=x; i==targetX; i+=range/abs(range)){
      println(i);
    }
  }
  return false;
}
