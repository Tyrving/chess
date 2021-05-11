
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

int[] mouseToXY(){
  int row = mouseX/(width/8);
  int col = mouseY/(height/8);
  int[] out = new int[2];
  out[0] = row;
  out[1] = col;
  return out;
}
