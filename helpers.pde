
void loadImages() {
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

byte[] mouseToXY() {
  byte[] out = new byte[2];
  out[0] = byte(mouseX/(width/8));
  out[1] = byte(mouseY/(height/8));
  return out;
}

boolean checkDiagonalPath(byte x1, byte y1, byte x2, byte y2) {
  int pathLength = abs(x2 - x1);
  int xDir = 1;
  int yDir = 1;
  if (x2-x1>0) {
    xDir = 1;
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
  for (int i = 1; i < pathLength; i++) {
    int x = x1 + (i*xDir);
    int y = y1 + (i*yDir);
    println(x, y);
    if (board.boardArray[x][y] instanceof noPiece) continue; // No obstacles here: keep going
    else return false; // Obstacle found before reaching target: the move is invalid
  }

  return true;
}

boolean checkLinearPath(byte x1, byte y1, byte x2, byte y2) {//TODO
  println("linpath");
  int pathLength = abs((x2 - x1) + (y2 - y1));
  println(pathLength);
  boolean horizontal = x1==x2 ? true : false; // horizontal or vertical

  int xDir = 1;
  int yDir = 1;
  if (x2-x1>0) {
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
  for (int i = 1; i < pathLength; i++) {
    int x = x1 + (i*xDir);
    int y = y1 + (i*yDir);
    println(x, y);
    if (board.boardArray[x][y] instanceof noPiece) { 
      continue; // No obstacles here: keep going
    } else { 
      return false; // Obstacle found before reaching target: the move is invalid
    }
  }
  return true;
}
