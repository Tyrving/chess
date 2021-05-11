class BasePiece {
  boolean white;
  boolean selected;
  boolean firstMove; // for pawns
  PImage myImage;
  byte row;
  byte col;
  BasePiece(boolean white, byte row, byte col) {
    this.white = white;
    this.row = row;
    this.col = col;
    selected = false;
    firstMove = false;
  }
  void render() {
    image(myImage, row*(width/8)+(width/16), col*(height/8)+(height/16));
  }

}

class Pawn extends BasePiece {
  Pawn(boolean white, byte row, byte col) {
    super(white, row, col);
    if (white) {
      myImage = w_pawn;
    } else {
      myImage = b_pawn;
    }
  }
}

class Rook extends BasePiece {
  Rook(boolean white, byte row, byte col) {
    super(white, row, col);
    if (white) {
      myImage = w_rook;
    } else {
      myImage = b_rook;
    }
  }
  
}

class Bishop extends BasePiece {
  Bishop(boolean white, byte row, byte col) {
    super(white, row, col);
    if (white) {
      myImage = w_bishop;
    } else {
      myImage = b_bishop;
    }
  }
  
}

class Knight extends BasePiece {
  Knight(boolean white, byte row, byte col) {
    super(white, row, col);
    if (white) {
      myImage = w_knight;
    } else {
      myImage = b_knight;
    }
  }
  
}

class King extends BasePiece {
  King(boolean white, byte row, byte col) {
    super(white, row, col);
    if (white) {
      myImage = w_king;
    } else {
      myImage = b_king;
    }
  }
  
}

class Queen extends BasePiece {
  Queen(boolean white, byte row, byte col) {
    super(white, row, col);
    if (white) {
      myImage = w_queen;
    } else {
      myImage = b_queen;
    }
  }
  
}

class noPiece extends BasePiece {
  noPiece(boolean white, byte row, byte col) {
    super(white, row, col);
  }
  void render() {
    return; // dont render anything
  }
}
