class Pawn extends Piece {  
    
  Pawn(boolean white) {
    super(white, 1, "Pawn");
  }
  
  boolean[][] can_move(Board board, Spot pos) {
    //init array of possible moves
    boolean[][] possible_moves = new boolean[8][8];
    int pos_x = pos.get_x();
    int pos_y = pos.get_y();
    for (int i = 0; i < 8; i++) {
      for (int j = 0; j < 8; j++) {
        possible_moves[j][i] = false;
      }
    }
    int v = 1; 
    int j = 1;
    if (this.white == false) { //if false then go down, else go up
      v = -1;
    }
    if (this.previous_move == 0) { //if not moved also add 2 pieces up/down as an option
      j = 2;
    }
    
    //moving up
    for (int i = 1; i <= j; i++) {
      int newpos_y = pos_y + i*v;
      if (newpos_y > 7 || newpos_y < 0) { //is it going out of the board?
      }
      else if (board.get_piece(pos_x, newpos_y) != null) { //is there a piece here?
        break;
      }
      else {
        possible_moves[pos_y + v*i][pos_x] = true;
      }
    }
    
    //captures
    for (int i = -1; i <= 1; i+=2) {
      int newpos_x = pos_x + i;
      int newpos_y = pos_y + v;
      if (newpos_x > 7 || newpos_y > 7 || newpos_x < 0 || newpos_y < 0) { //is it going out of the board?
        //L
      }
      else {
        if (board.get_piece(newpos_x, newpos_y) != null) {
          if (board.get_piece(newpos_x, newpos_y).is_white() != this.is_white()) {
            possible_moves[newpos_y][newpos_x] = true;
          }
        }
      }
    }
    return possible_moves;
  }
  
}
