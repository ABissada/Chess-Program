class Bishop extends Piece {
  
  Bishop(boolean white) {
    super(white, 3, "Bishop");
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
    //check directions THIS IS NOT THE CLEANEST I SHOULD FIGURE OUT A BETTER WAY TO DO THIS
    for (int j = -1; j <= 1; j+=2) { //this is a nightmare that i don't wish to clarify; have fun future me
      for (int v = -1; v <= 1; v+=2) {
        for (int i = 1; i < 8; i++) {
          int newpos_x = pos_x + (i*v);
          int newpos_y = pos_y + (i*v)*j;
          //actual checking
          if (newpos_x > 7 || newpos_y > 7 || newpos_x < 0 || newpos_y < 0) { //is it going out of the board?
          }
          else if (board.get_piece(newpos_x, newpos_y) != null) { //is there a piece here?
            if (board.get_piece(newpos_x, newpos_y).is_white() == this.is_white()) { //is the piece the same colour as us?
              break;
            }
            else {//you can take it
              possible_moves[newpos_y][newpos_x] = true;
              break;
            }
          }
          else {
            possible_moves[newpos_y][newpos_x] = true;
          }
        }
      }
    }
    return possible_moves;
  }
  
  
  
  
}
