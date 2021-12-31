class Knight extends Piece {
  Knight(boolean white) {
    super(white, 3, "Knight");
  }
  
  boolean[][] can_move(Board board, Spot pos) {
    //init array of possible moves
    boolean[][] possible_moves = new boolean[8][8];
    int pos_x = pos.get_x();
    int pos_y = pos.get_y();
    for (int i = -2; i <= 2; i++) {
      if (i == 0) {
        i++;
      }
      for (int j = -1; j <= 1; j+=2) {
        int newpos_x;
        //couldn't find an efficient way to do this cause im dumb
        if (abs(i) == 2) {
          newpos_x = pos_x + j;
        }
        else {
          newpos_x = pos_x + 2*j;
        }
        int newpos_y = pos_y + i;
        if (newpos_x > 7 || newpos_y > 7 || newpos_x < 0 || newpos_y < 0) { //is it going out of the board?
        }
        else if (board.get_piece(newpos_x, newpos_y) != null) { //is there a piece here?
          if (board.get_piece(newpos_x, newpos_y).is_white() == this.is_white()) { //is the piece the same colour as us?
          }
          else {//you can take it
            possible_moves[newpos_y][newpos_x] = true;
          }
        }
        else {
          possible_moves[newpos_y][newpos_x] = true;
        }
      }
    }
    return possible_moves;
    
  }
  
}
