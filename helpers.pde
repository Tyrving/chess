
void loadImages() {//clean up main file
  b_pawn = loadImage("b_pawn.png");
  w_pawn = loadImage("w_pawn.png");
  b_king = loadImage("b_king.png");
  w_king = loadImage("w_king.png");
  b_queen = loadImage("b_queen.png");
  w_queen = loadImage("w_queen.png");
  b_bishop = loadImage("b_bishop.png");
  w_bishop = loadImage("w_bishop.png");
  b_rook = loadImage("b_rook.png");
  w_rook = loadImage("w_rook.png");
  b_knight = loadImage("b_knight.png");
  w_knight = loadImage("w_knight.png");
}

byte[] mouseToXY() {//Get mouse x and y in terms of chess tile coordinates, 0-7
  byte[] out = new byte[2];
  out[0] = byte(mouseX/(width/8));
  out[1] = byte(mouseY/(height/8));
  return out;
}

boolean checkDiagonalPath(byte x1, byte y1, byte x2, byte y2) {
  byte pathLength = byte(abs(x2 - x1));
  byte xDir = 1;
  byte yDir = 1;
  if (x2-x1>0) {//set x and y directions for following loop based 
    xDir = 1; // on pos/neg movement in each axis
  }
  if (x2-x1<0) {
    xDir = -1;
  }
  if (y2-y1>0) {
    yDir = 1;
  }
  if (y2-y1<0) {
    yDir = -1;
  }
  for (byte i = 1; i < pathLength; i++) {//for each cell in the path,
    byte x = byte(x1 + (i*xDir));// add or subtract based on direction of movement to get the cell to check
    byte y = byte(y1 + (i*yDir));
    if (board.boardArray[x][y] instanceof noPiece) continue; // nothing in the way
    else return false; // something in the way, uh oh, spaghetti-o *aneurism intensifies*
  }

  return true;
}

boolean checkLinearPath(byte x1, byte y1, byte x2, byte y2) {//basically above, just for straight lines
  byte pathLength = byte(abs((x2 - x1) + (y2 - y1)));
  byte xDir = 1;
  byte yDir = 1;
  if (x2-x1>0) {//same as above, but x/ydir can be zero, in case the piece does not move in that direction
    xDir = 1;
  } else if (x2-x1<0) {
    xDir = -1;
  } else xDir = 0;
  if (y2-y1>0) {
    yDir = 1;
  } else if (y2-y1<0) {
    yDir = -1;
  } else {
    yDir = 0;
  }
  for (byte i = 1; i < pathLength; i++) {
    byte x = byte(x1 + (i*xDir));
    byte y = byte(y1 + (i*yDir));
    if (board.boardArray[x][y] instanceof noPiece) { 
      continue;
    } else { 
      return false;
    }
  }
  return true;
}
