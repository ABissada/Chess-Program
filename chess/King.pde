class King extends Piece {  
  King(boolean white) {
    super(white, 100, "King");
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
    for (int i = -1; i <= 1; i++) {
      for (int j = -1; j <= 1; j++) {
        int newpos_x = pos_x + i;
        int newpos_y = pos_y + j;
        //no need to check if i&j == 0 since that's covered later with colour checking
        if (newpos_x > 7 || newpos_y > 7 || newpos_x < 0 || newpos_y < 0) { //is it going out of the board?
        }
        else if (board.get_piece(newpos_x, newpos_y) != null) { //is there a piece here?
          if (board.get_piece(newpos_x, newpos_y).is_white() == this.is_white()) { //is it the same colour as us?
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
