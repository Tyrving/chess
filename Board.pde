class Board {
  BasePiece[][] boardArray = new BasePiece[8][8];
  boolean anySelected;
  boolean currentColorWhite;
  Board() {
    initialLayout();
    anySelected = false;
    currentColorWhite = true;
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

  void render() {
    checkerBackground();
    renderPieces();
  }

  void renderPieces() {
    for (byte row=0; row<8; row++) {
      for (byte col=0; col<8; col++) {
        boardArray[row][col].render();
      }
    }
  }

  void select(BasePiece piece) {
    board.anySelected = true;
    piece.selected = true;
  }

  void place(byte row, byte col, BasePiece piece) {
    boardArray[piece.row][piece.col] = new noPiece(true, piece.row, piece.col);
    piece.row = row;
    piece.col = col;
    piece.selected = false;
    board.anySelected = false;
    boardArray[row][col] = piece;
    currentColorWhite = !currentColorWhite;
  }

  void checkerBackground() {//generate checkered background based on UI height and width
    int tileX = width/8;
    for (byte col=0; col<8; col++) {
      for (byte row=0; row<8; row++) {
        int tileColor = (((col+row)%2)*100)+155;//make tile color
        stroke(tileColor);
        fill(tileColor);
        rect(row*tileX, col*tileX, tileX, tileX);
      }
    }
  }
}
