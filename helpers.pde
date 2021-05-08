
void loadImages() {
  String dir = "resources/";
  b_pawn = loadImage(dir+"b_pawn.png");
  w_pawn = loadImage(dir+"w_pawn.png");
  b_king = loadImage(dir+"b_king.png");
  w_king = loadImage(dir+"w_king.png");
  b_queen = loadImage(dir+"b_queen.png");
  w_queen = loadImage(dir+"w_queen.png");
  b_bishop = loadImage(dir+"b_bishop.png");
  w_bishop = loadImage(dir+"w_bishop.png");
  b_rook = loadImage(dir+"b_rook.png");
  w_rook = loadImage(dir+"w_rook.png");
  b_knight = loadImage(dir+"b_knight.png");
  w_knight = loadImage(dir+"w_knight.png");
}


void startPiecesArrangement(){
  for(int row=0; row<8; row++){
    for(int col=0; col<8; col++){
      boardArray[row][col] = new noPiece(true);//true/false is arbitrary, but satisfies my base class thing
    }
  }
  for(int i=0; i<8; i++){
    boardArray[1][i] = new Pawn(true);
    boardArray[6][i] = new Pawn(false);
  }
  for(int i=0; i<2; i++){
  boardArray[i*7][0] = new Rook(i*2==0);
  boardArray[i*7][1] = new Knight(i*2==0);
  boardArray[i*7][2] = new Bishop(i*2==0);
  if(i==0){
  boardArray[i*7][3] = new King(i*2==0);
  boardArray[i*7][4] = new Queen(i*2==0);
  }else{
  boardArray[i*7][3] = new Queen(i*2==0);
  boardArray[i*7][4] = new King(i*2==0);
  }
  boardArray[i*7][5] = new Bishop(i*2==0);
  boardArray[i*7][6] = new Knight(i*2==0);
  boardArray[i*7][7] = new Rook(i*2==0);
  }
}


int[] mouseToXY(){
  int row = mouseX/(width/8);
  int col = mouseY/(height/8);
  int[] out = new int[2];
  out[0] = row;
  out[1] = col;
  return out;
}
void checkerBackground() {//generate checkered background based on UI height and width
  int tileX = width/8;
  int tileY = tileX;//asssuming UI is a square
  for (int col=0; col<8; col++) {
    for (int row=0; row<8; row++) {
      int tileColor = (((col+row)%2)*100)+155;//make tile color
      stroke(tileColor);
      fill(tileColor);
      int xLoc = row*tileX;
      int yLoc = col*tileX;
      rect(xLoc, yLoc, tileX, tileY);
    }
  }
}

PImage getImage(byte row, byte col){
  Piece piece = pieceArray[row][col];
  boolean side = colorArray[row][col];
  switch piece{
    
  }
  return 
  
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
