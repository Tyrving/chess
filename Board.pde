class Board {
  BasePiece[][] boardArray = new BasePiece[8][8];
  boolean anySelected;
  boolean currentColorWhite;
  byte movingPieceRow;
  byte movingPieceCol;
  Board() {
    initialLayout();
    anySelected = false;
    currentColorWhite = true;
  }

  private void initialLayout() {//my obscenely convoluted method of laying out start pieces
    for (byte row=0; row<8; row++) {
      for (byte col=0; col<8; col++) {
        boardArray[row][col] = new noPiece(true, row, col);//true/false is arbitrary for noPiece,
        //but satisfies my base class constructor, and this is only run once, so performance is not super rellevant
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

  public void select(BasePiece piece) {
    board.anySelected = true;
    piece.selected = true;
    movingPieceRow = piece.row;
    movingPieceCol = piece.col;
  }

  public void place(byte row, byte col, BasePiece piece) {
    boardArray[piece.row][piece.col] = new noPiece(true, piece.row, piece.col);
    piece.row = row;
    piece.col = col;
    piece.selected = false;
    board.anySelected = false;
    boardArray[row][col] = piece;
    currentColorWhite = !currentColorWhite;
    movingPieceRow = -1; // should INTENTIONALLY error if called like this
    movingPieceCol = -1;// now i know if it goofs up
  }

  public void render() {//wrap it up into one function
    checkerBackground();
    renderPieces();
  }

  private void renderPieces() {//just call the render methods for every piece
    for (byte row=0; row<8; row++) {
      for (byte col=0; col<8; col++) {
        boardArray[row][col].render();
      }
    }
  }


  private void checkerBackground() {//generate checkered background based on UI height and width
    fill(255);
    rect(0, 0, width, height);
    fill(155);
    for (byte col=0; col<8; col++) {
      for (byte row=0; row<8; row++) {
        if ((col+row)%2==0) {
          rect(row*tileX, col*tileY, tileX, tileY);
        }
      }
    }
  }
}
