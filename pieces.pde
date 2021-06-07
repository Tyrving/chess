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
    firstMove = true;
  }
  void render() {
    if (!selected) {
      image(myImage, row*(width/8)+(width/16), col*(height/8)+(height/16));
    } else {
      image(myImage, mouseX, mouseY);
    }
  }
  boolean isSelectable() {
    if (this instanceof noPiece) {
      return false;
    } else if (this.white != board.currentColorWhite) {
      return false;
    } else {
      return true;
    }
  }
  boolean wayIsClear(byte row, byte col) {
    byte x1 = this.row;
    byte y1 = this.col;
    byte x2 = row;
    byte y2 = col;
    if ((x1==x2 && y1!=y2)||(x1!=x2 && y1==y2)) {
      if (checkHorizontalPath(x1, y1, x2, y2)) {
        return true;
      }
    }
    if (abs(x2-x1)==abs(y2-y1)) {
      if (checkDiagonalPath(x1, y1, x2, y2)) {
        return true;
      }
    }
    return false;
  }
  boolean checkTarget(byte row, byte col) {
    BasePiece target = board.boardArray[row][col];
    if (target instanceof noPiece) {
      return true;
    }
    if ((this.white==target.white)) {
      return false;
    }
    return true;
  }

  boolean checkPath(byte row, byte col) {
    return false;
  }
  boolean allChecks(byte row, byte col) {
    if (row==this.row && col==this.col) {
      return true;
    }

    if (checkTarget(row, col)) {
      if (checkPath(row, col)) {
        if (wayIsClear(row, col)) {
          return true;
        }
      }
    }
    return false;
  }
}

class Pawn extends BasePiece {
  Pawn(boolean white, byte row, byte col) {
    super(white, row, col);
    if (white==true) {
      myImage = w_pawn;
    } else {
      myImage = b_pawn;
    }
  }
  boolean checkPath(byte row, byte col) {
    byte x1 = this.row;
    byte y1 = this.col;
    byte x2 = row;
    byte y2 = col;
    if (x1==x2) {
      if (firstMove) {
        if (abs(y1-y2)<3) {
          this.firstMove = false;
          return true;
        }
      } else {
        if (abs(y1-y2)<2) {
          return true;
        }
      }
    }

    if (abs(x1-x2)==1 && abs(y1-y2)==1) {//if moving diagonally and target is a piece
      if (!(board.boardArray[row][col] instanceof noPiece)) {
        return true;
      }
    }
    return false;
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

  boolean checkPath(byte row, byte col) {
    byte x1 = this.row;
    byte y1 = this.col;
    byte x2 = row;
    byte y2 = col;
    if ((x1==x2 && y1!=y2)||(x1!=x2 && y1==y2)) {
      return true;
    }

    return false;
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
  boolean checkPath(byte row, byte col) {
    byte x1 = this.row;
    byte y1 = this.col;
    byte x2 = row;
    byte y2 = col;
    if (abs(x2-x1)==abs(y2-y1)) {
      return true;
    }
    return false;
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
  boolean wayIsClear(byte row, byte col){
    return true;
  }

  boolean checkPath(byte row, byte col) {
    byte x1 = this.row;
    byte y1 = this.col;
    byte x2 = row;
    byte y2 = col;
    if ((abs(x2-x1)==1)&&(abs(y2-y1)==2)) {
      return true;
    }
    if ((abs(x2-x1)==2)&&(abs(y2-y1)==1)) {
      return true;
    }
    return false;
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
  boolean checkPath(byte row, byte col) {
    byte x1 = this.row;
    byte y1 = this.col;
    byte x2 = row;
    byte y2 = col;
    if (abs(x2-x1)<2 && abs(y2-y1)<2) {
      return true;
    }
    return false;
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
  boolean checkPath(byte row, byte col) {
    byte x1 = this.row;
    byte y1 = this.col;
    byte x2 = row;
    byte y2 = col;
    if (abs(x2-x1)==abs(y2-y1)) {//bishop
      return true;
    }
    if ((x1==x2 && y1!=y2)||(x1!=x2 && y1==y2)) {//rook
      return true;
    }
    return false;
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
