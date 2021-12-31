class Move {
  Player player;
  Spot start;
  Spot end;
  Piece piece_moved;
  Piece piece_killed;
  boolean castled = false;
  boolean castled_kingside = false;
  boolean en_passant = false;
  boolean check = false;
  boolean checkmate = false;
  boolean stalemate = false;
  
  Move(Player player, Spot start, Spot end) {
    this.player = player;
    this.start = start;
    this.end = end;
    this.piece_moved = start.get_piece();
  }
  
  Spot get_start() {
    return this.start;
  }
  
  Spot get_end() {
    return this.end;
  }
  
  Player get_player() {
    return this.player;
  }
  
  char file(int x) {
    return (char)(96+x);
  }
  
  String tostring() {
    String move = "";
    String p_name = this.piece_moved.piece_type;
    //castling
    if (this.castled == true) {
      if (this.castled_kingside == true) {
        return "O-O";
      }
      else {
        return "O-O-O";
      }
    }
    //piece name
    if (p_name == "Bishop") {
      move += "B";
    }
    if (p_name == "Knight") {
      move += "N";
    }
    else if (p_name == "King") {
      move += "K";
    }
    else if (p_name == "Rook") {
      move += "R";
    }
    else if (p_name == "Queen") {
      move += "Q";
    }
    //pawn
    if (p_name == "Pawn") { //
      move += this.file(start.get_x()+1);
    }
    //capture
    if (piece_killed != null) {
      move += "x";
      //piece captures, just add file since it'll add row later
      if (p_name == "Pawn") {
        move += this.file(end.get_x()+1);
      }
    }
    //pawn movement
    if (p_name == "Pawn") {
      move += end.get_y()+1;
    }
    //other piece movement
    else {
      move += this.file(end.get_x()+1)+str(end.get_y()+1);
    }
    //check
    if (this.check == true) {
      move += "+";
    }
    //en passant
    if (this.en_passant == true) {
      move += " e.p.";
    }
    //checkmate
    if (this.checkmate == true) {
      move += "#";
    }
    //stalemate
    if (this.stalemate == true) {
      move += "=";
    }
    return move;
  }
  
  boolean is_castling() {
    return this.castled;
  }
  
  boolean is_en_passant() {
    return this.en_passant;
  }
  
  void set_castled() {
    this.castled = true;
  }
  
  void set_en_passant() {
    this.en_passant = true;
  }
  
  void set_killed_piece(Piece p) {
    this.piece_killed = p;
  }
  
}
