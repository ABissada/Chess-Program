class Board {
  Spot[][] board; //8x8 array of spots
  int move;
  
  Board() {
    this.board = new Spot[8][8]; //initialize the spots
    for (int i = 0; i < 8; i++) { //colouring stuff(chess grids are black & white after all)
      for (int j = 0; j < 8; j++) {
        if ((i + j) % 2 == 0) {
          this.board[i][j] = new Spot(null, j, i, true);
        }
        else {
          this.board[i][j] = new Spot(null, j, i, false);
        }
      }
    }
    ////piece setup
    //pawns
    for (int i = 0; i < 8; i++) {
      this.board[1][i].piece = new Pawn(true);
      this.board[6][i].piece = new Pawn(false);
    }
    //other pieces
    for (int i = 0; i < 2; i++) {
      int v = 7 * i;
      boolean col = true;
      if (i == 1) {
        col = false;
      }
      this.board[v][0].set_piece(new Rook(col));
      this.board[v][7].set_piece(new Rook(col));
      this.board[v][1].set_piece(new Knight(col));
      this.board[v][6].set_piece(new Knight(col));
      this.board[v][2].set_piece(new Bishop(col));
      this.board[v][5].set_piece(new Bishop(col));
      this.board[v][3].set_piece(new Queen(col));
      this.board[v][4].set_piece(new King(col));
    }
    this.move = 0;
  }
  
  Spot get_spot(int x, int y){
    if (debug == true) {
      print(x, y);
    }
    return this.board[y][x];
  }
  
  Piece get_piece(int x, int y) {
    Spot s = this.board[y][x];
    if (s.get_piece() == null) {
      return null;
    }
    else {
      return s.get_piece();
    }
  }
  
  boolean any_possible_moves(boolean check_for_white) {
    if (debug == true) {
      println("\nFind checkmate");
    }
    Spot king_spot = null;
    for (int i = 0; i < 8; i++) { //find the king spot
      for (int j = 0; j < 8; j++) {
        Spot s = this.get_spot(j, i);
        Piece p = s.get_piece();
        if (p != null) {
          if (p.piece_type == "King" && p.is_white() == check_for_white) {
            king_spot = s; 
          }
        }
      }
    }
    if (king_spot == null) { //waaaaaaaaaa how would this even happen
      return false;
    }
    //Nightmare.
    else { //IF THE KING EXISTS!!! WOOO
      for (int i = 0; i < 8; i++) { //y; this is for each individual piece
        for (int j = 0; j < 8; j++) { //x
          Spot s = this.get_spot(j, i); 
          Piece p = s.get_piece();
          if (p != null) { //is there a piece
            if (p.is_white() == check_for_white) {
              boolean[][] possible_moves = p.can_move(this, s); //get array of possible moves for that piece
              for (int k = 0; k < 8; k++) { //y; this is for each individual move
                for (int l = 0; l < 8; l++) { //x
                  //dude this is a quadruple nested for loop is there really no better way to do this
                  if (possible_moves[k][l] == true) {
                    Spot s2 = this.get_spot(l, k); 
                    if (this.move_will_check(check_for_white, s, s2) == false) {
                      return false;
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
    return true;
  }
  
  boolean look_for_check(boolean check_for_white) { //iterate through the board, check if any pieces attack that colour's king king
    Spot king_spot = null;
    for (int i = 0; i < 8; i++) { //find the king spot
      for (int j = 0; j < 8; j++) {
        Spot s = this.get_spot(j, i);
        Piece p = s.get_piece();
        if (p != null) {
          if (p.piece_type == "King" && p.is_white() == check_for_white) {
            king_spot = s; 
          }
        }
      }
    }
    if (king_spot == null) { //waaaaaaaaaa how would this even happen
      return false;
    }
    else { //IF THE KING EXISTS!!! WOOO
      for (int i = 0; i < 8; i++) { //y
        for (int j = 0; j < 8; j++) { //x
          Spot s = this.get_spot(j, i);
          Piece p = s.get_piece();
          if (p != null) { //is there a piece
            if (p != king_spot.get_piece() && p.is_white() != check_for_white) { //is the piece NOT the king we're looking for checks?
              boolean[][] possible_moves = p.can_move(this, s); //get array of possible moves for that piece
              if (possible_moves[king_spot.get_y()][king_spot.get_x()] == true) { //is the position of the king inside of possible_moves equal to true
                return true; //return so that the loop stops running (no need to check if we know something is attacking it)
              }
            }
          }
        }
      }
    }
    return false;
  }
  
  boolean move_will_check(boolean check_for_white, Spot start, Spot end) { //will the move put you in check?
    //move the piece to that spot
    Piece p1 = start.get_piece();
    Piece p2 = end.get_piece();
    start.set_piece(null);
    end.set_piece(p1);
    if (debug == true) {
      println("\nFind check");
    }
    //does this end up in check?
    boolean result = this.look_for_check(check_for_white);
    
    //move pieces back
    start.set_piece(p1);
    end.set_piece(p2);
    if (result == true) {
      return true;
    }
    else {
      return false;
    }
  }
  
  void promote(int x, int y) { //promotion stuff, for now just set it to be queen, todo gui that pops up to select
    Spot spot = this.get_spot(x, y);
    boolean white = spot.get_piece().is_white();
    String option = "Queen";
    if (option == "Queen") {
      spot.set_piece(new Queen(white));
    }
    else if (option == "Rook") {
      spot.set_piece(new Rook(white));
    }
    else if (option == "Bishop") {
      spot.set_piece(new Bishop(white));
    }
    else if (option == "Knight") {
      spot.set_piece(new Knight(white));
    }
  }
  
}
