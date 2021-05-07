class BasePiece {
  boolean white;//true = white, false= black
  boolean moving = false;
  boolean firstMove = true;
  PImage myImage;
  BasePiece(boolean white) {
    this.white = white;
  }
  void render(int x, int y) {
    image(myImage, x, y);
  }
  boolean checkMove(int targetX, int targetY, int x, int y) {
    return true;
  }
}

class Pawn extends BasePiece {
  Pawn(boolean white) {
    super(white);
    if (white) {
      myImage = w_pawn;
    } else {
      myImage = b_pawn;
    }
  }
  boolean checkMove(int targetX, int targetY, int x, int y) {//white on top
  if (globalChecks(x, y , targetX, targetY, white)){
    return false;
  }
    if(targetY==y && targetX==x){
      return true;
    }
    if ((white == boardArray[targetY][targetX].white) && !(boardArray[targetY][targetX] instanceof noPiece)) {
      return false;
    }
    if (targetX == x && targetY == y) {
      return true;
    }
    if (x==targetX) {
      if (firstMove) {
        if (white) {//first move for white
          if (targetY-y>0 && targetY-y<3) {
            firstMove = false;
            return true;
          }
        } else {//first move for black
          if (y-targetY>0 && y-targetY<3) {
            firstMove = false;
            return true;
          }
        }
      } else {//second move
        if (white) {//second move for white
          if (targetY-y==1) {
            return true;
          }
        } else {//second move for black
          if (y-targetY==1) {
            return true;
          }
        }
      }
    }
    return false;
  }
}

class Rook extends BasePiece {
  Rook(boolean white) {
    super(white);
    if (white) {
      myImage = w_rook;
    } else {
      myImage = b_rook;
    }
  }
  boolean checkMove(int targetX, int targetY, int x, int y) {
    if(targetY==y && targetX==x){
      return true;
    }
    if ((white == boardArray[targetY][targetX].white) && !(boardArray[targetY][targetX] instanceof noPiece)) {
      return false;
    }
    if (x - targetX == 0 || y - targetY == 0) {
      return true;
    }
    return false;
  }
}

class Bishop extends BasePiece {
  Bishop(boolean white) {
    super(white);
    if (white) {
      myImage = w_bishop;
    } else {
      myImage = b_bishop;
    }
  }
  boolean checkMove(int targetX, int targetY, int x, int y) {
    if(targetY==y && targetX==x){
      return true;
    }
    if ((white == boardArray[targetY][targetX].white) && !(boardArray[targetY][targetX] instanceof noPiece)) {
      return false;
    }
    if (abs(x - targetX)==abs(y - targetY)) {
      return true;
    }
    return false;
  }
}

class Knight extends BasePiece {
  Knight(boolean white) {
    super(white);
    if (white) {
      myImage = w_knight;
    } else {
      myImage = b_knight;
    }
  }
  boolean checkMove(int targetX, int targetY, int x, int y) {
    if(targetY==y && targetX==x){
      return true;
    }
    if ((white == boardArray[targetY][targetX].white) && !(boardArray[targetY][targetX] instanceof noPiece)) {
      return false;
    }

    return false;
  }
}

class King extends BasePiece {
  King(boolean white) {
    super(white);
    if (white) {
      myImage = w_king;
    } else {
      myImage = b_king;
    }
  }
  boolean checkMove(int targetX, int targetY, int x, int y) {
    if(targetY==y && targetX==x){
      return true;
    }
    if ((white == boardArray[targetY][targetX].white) && !(boardArray[targetY][targetX] instanceof noPiece)) {
      return false;
    }
    if ((Math.abs(targetX-x))<2 && (Math.abs(targetY-y))<2) {
      return true;
    }
    return false;
  }
}

class Queen extends BasePiece {
  Queen(boolean white) {
    super(white);
    if (white) {
      myImage = w_queen;
    } else {
      myImage = b_queen;
    }
  }
  boolean checkMove(int targetX, int targetY, int x, int y) {
    if(targetY==y && targetX==x){
      return true;
    }
    if ((white == boardArray[targetY][targetX].white) && !(boardArray[targetY][targetX] instanceof noPiece)) {
      return false;
    }
    if (abs(x - targetX)==abs(y - targetY)) {
      return true;
    }
    if (x - targetX == 0 || y - targetY == 0) {
      return true;
    }
    return false;
  }
}

class noPiece extends BasePiece {
  noPiece(boolean white) {
    super(white);
  }
  void render(int x, int y) {
    return;
  }
}
