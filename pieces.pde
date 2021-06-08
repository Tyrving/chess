class BasePiece { // base chess piece which is extended by all others
  boolean white;
  boolean selected;//for rendering, if selected render at mouse position
  boolean firstMove; // for pawns
  PImage myImage;//store image locally for easy of rendering, sorry memory consumption
  byte row;// x y grid coords, should always be the same as coords within boardArray
  byte col;
  BasePiece(boolean white, byte row, byte col) {
    this.white = white;
    this.row = row;//constructor stuff
    this.col = col;
    selected = false;
    firstMove = true;
  }
  void render() {//render image at x y grid coords, 
  //unless its selected, then render at mouse for drag-and-drop effect
    if (!selected) {
      image(myImage, row*(width/8)+(width/16), col*(height/8)+(height/16));
      //the screen/8 is for the cell dimentions, /16 is for centering it within the cell
    } else {
      image(myImage, mouseX, mouseY);
    }
  }
  boolean isSelectable() {//is this piece of the right color to 
  //select, based on who's turn it is?
    if (this instanceof noPiece) {
      return false;
    } else if (this.white != board.currentColorWhite) {
      return false;
    } else {
      return true;
    }
  }
  boolean wayIsClear(byte row, byte col) {//is the path the piece will take clear?
    byte x1 = this.row;
    byte y1 = this.col;
    byte x2 = row;
    byte y2 = col;
    if ((x1==x2 && y1!=y2)||(x1!=x2 && y1==y2)) {
      if (checkLinearPath(x1, y1, x2, y2)) {//checkLinear and Diagonal are in helpers.pde
        return true;
      }
    }
    if (abs(x2-x1)==abs(y2-y1)) {
      if (checkDiagonalPath(x1, y1, x2, y2)) {//these see if there is a piece in the way
        return true;
      }
    }
    return false;
  }
  boolean checkTarget(byte row, byte col) {//is this a valid target to claim?
    BasePiece target = board.boardArray[row][col];
    if (target instanceof noPiece) {//claim any nopiece object
      return true;
    }
    if ((this.white==target.white)) {//if the piece is the same color, stop
      return false;
    }
    return true;
  }

  boolean checkPath(byte row, byte col) {//extended throughout the other pieces
    return false;
  }
  boolean allChecks(byte row, byte col) {//nice wrapper for all my piece checking stuff
    if (row==this.row && col==this.col) {//allow a piece to go back into 
    //its original cell at any time
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
    byte deltay = byte(y2-y1);
    byte deltax = byte(x2-x1);
    if (x1==x2) {
      if (white) {
        if (firstMove) {
          if (deltay<3 && deltay>-1) {
            this.firstMove = false;
            return true;
          }
        } else {
          if (deltay<2 && deltay>-1) {
            return true;
          }
        }
      } else {
        if (firstMove) {
          if (deltay>-3 && deltay<1) {
            this.firstMove = false;
            return true;
          }
        } else {
          if (deltay>-2 && deltay<1) {
            return true;
          }
        }
      }
    }
    if (white) {
      if (deltay==1 && abs(deltax)==1) {
        if (!(board.boardArray[row][col] instanceof noPiece)) {
          return true;
        }
      }
    } else {
      if (deltay==-1 && abs(deltax)==1) {
        if (!(board.boardArray[row][col] instanceof noPiece)) {
          return true;
        }
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
  boolean wayIsClear(byte row, byte col) {
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
    if (abs(x2-x1)==abs(y2-y1)) {//bishop valid or
      return true;
    }
    if ((x1==x2 && y1!=y2)||(x1!=x2 && y1==y2)) {//rook valid
      return true;
    }
    return false;
  }
}

// class to fill boardArray positions, but will not render or do anything
class noPiece extends BasePiece { // class to fill boardArray positions, but will not render or do anything
  noPiece(boolean white, byte row, byte col) {
    super(white, row, col);
  }
  void render() {
    return; // dont render anything
  }
}
