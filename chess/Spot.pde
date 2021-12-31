class Spot {
  
  Piece piece;
  
  boolean white;
  
  int x;
  int y;
  
  Spot(Piece p, int x, int y, boolean white) {
    set_piece(p);
    set_x(x);
    set_y(y);
    this.white = white;
  }
  
  Piece get_piece() {
    return this.piece;
  }
  
  int get_x() {
    return this.x;
  }
  
  int get_y() {
    return this.y;
  }
  
  boolean is_white() {
    return this.white;
  }
  
  void set_piece(Piece p) {
    this.piece = p;
  }
  
  void set_x(int x) {
    this.x = x;
  }
  
  void set_y(int y) {
    this.y = y;
  }
  
  void set_white() {
    this.white = true;
  }
  
  void set_black() {
    this.white = false;
  }
  
}
