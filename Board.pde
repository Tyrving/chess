class Board {
  BasePiece[][] boardArray = new BasePiece[8][8];
  boolean anySelected;
  boolean whiteTurn;
  Board() {
    initialLayout();
    anySelected = false;
    whiteTurn = true;
  }
  
  void initialLayout() {
    for (byte row=0; row<8; row++) {
      for (byte col=0; col<8; col++) {
        boardArray[row][col] = new noPiece(true, row, col);//true/false is arbitrary, but satisfies my base class thing
      }
    }
    for (byte i=0; i<8; i++) {
      boardArray[i][1] = new Pawn(true, i, (byte)1);
      boardArray[i][6] = new Pawn(false, i, (byte)6);
    }
    for (byte i=0; i<2; i++) {
      byte col = byte(i*7);
      boardArray[0][col] = new Rook(i*2==0, (byte)0, col);
      boardArray[1][col] = new Knight(i*2==0, (byte)1, col);
      boardArray[2][col] = new Bishop(i*2==0, (byte)2, col);
      if (i==0) {
        boardArray[3][col] = new King(i*2==0, (byte)3, col);
        boardArray[4][col] = new Queen(i*2==0, (byte)4, col);
      } else {
        boardArray[3][col] = new Queen(i*2==0, (byte)3, col);
        boardArray[4][col] = new King(i*2==0, (byte)4, col);
      }
      boardArray[5][col] = new Bishop(i*2==0, (byte)5, col);
      boardArray[6][col] = new Knight(i*2==0, (byte)6, col);
      boardArray[7][col] = new Rook(i*2==0, (byte)7, col);
    }
  }
  
  void render(){
    checkerBackground();
    renderPieces();
  }
  
  void renderPieces() {
    byte movingPieceX = 0;
    byte movingPieceY = 0;
    boolean movingPiece = false;
    for (byte row=0; row<8; row++) {
      for (byte col=0; col<8; col++) {
        BasePiece piece = boardArray[row][col];
        if(piece.selected){
          movingPieceX = row;
          movingPieceY = col;
          movingPiece = true;
        }else{
          piece.render();
        }
      }
    }
    if(movingPiece){
      image(board.boardArray[movingPieceX][movingPieceY].myImage, mouseX, mouseY);
    }
  }

  void checkerBackground() {//generate checkered background based on UI height and width
    int tileX = width/8;
    int tileY = tileX;//asssuming UI is a square
    for (byte col=0; col<8; col++) {
      for (byte row=0; row<8; row++) {
        int tileColor = (((col+row)%2)*100)+155;//make tile color
        stroke(tileColor);
        fill(tileColor);
        int xLoc = row*tileX;
        int yLoc = col*tileX;
        rect(xLoc, yLoc, tileX, tileY);
      }
    }
  }
}
