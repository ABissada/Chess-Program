abstract class Piece {
  PImage image;
  
  boolean alive = true;
  boolean white = true;
  boolean moved_two_squares = false; //bit of a waste to put it in here since only pawns care
  int previous_move = 0; //also waste but at least kings also care
  String piece_type; //instanceof would work but i feel like it'd be nice just to have this here
  int points;
  
  Piece(boolean white, int points, String type) {
    this.white = white;
    this.points = points;
    this.piece_type = type;
    
    if (this.white == true && type == "King") {
      this.image = loadImage("WKing.png");
    }
    
    else if (this.white == false && type == "King"){
      this.image = loadImage("BKing.png");
    }
    
    else if (this.white == true && type == "Queen") {
      this.image = loadImage("WQueen.png");
    }
    
    else if (this.white == false && type == "Queen"){
      this.image = loadImage("BQueen.png");
    }
    
    else if (this.white == true && type == "Rook") {
      this.image = loadImage("WRook.png");
    }
    
    else if (this.white == false && type == "Rook") {
      this.image = loadImage("BRook.png");
    }
    
    else if (this.white == true && type == "Bishop") {
      this.image = loadImage("WBishop.png");
    }
    
    else if (this.white == false && type == "Bishop") {
      this.image = loadImage("BBishop.png");
    }
    
    else if (this.white == true && type == "Knight") {
      this.image = loadImage("WKnight.png");
    }
    
    else if (this.white == false && type == "Knight") {
      this.image = loadImage("BKnight.png");
    }
    
    else if (this.white == true && type == "Pawn") {
      this.image = loadImage("WPawn.png");
    }
    
    else {
      this.image = loadImage("BPawn.png");
    }

  }
  
  boolean is_white() {
    return this.white;
  }
  
  boolean is_alive() {
    return this.alive;
  }
  
  abstract boolean[][] can_move(Board board, Spot pos);
    
}
