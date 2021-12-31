class Game {

  Player white, black;
  Board board;

  boolean[][] possible_moves; 
  boolean[][] en_passant_moves; //no way to differentiate between en passants etc. in the possible_moves array so we need seperate ones for those :/ (OR YOU CAN MAKE IT AN INT ARRAY) (THATS SO MUCH WASTED SPACE)
  boolean[][] castles;
  
  ArrayList<Move> moves = new ArrayList<Move>();
  
  boolean white_turn; //true = white's turn, false = black's turn
  boolean flipped_board; //default is yes since you want white on the bottom, but white is rows 1-2 meanwhile black is 7-8
  boolean two_player = true;
  
  int winner; //1 = white, 2 = black, 3 = stalemate, 0 = noone
  int check; //1 = white king in check, 2 = black king in check, 0 = no checks
  int drawoffer;
  char game_state; //m = menu, g = game, p = post-game
  int selected_x; //x and y coords of the selected spot
  int selected_y;
  
  Game() {
    this.white = new Player(true, true);
    this.black = new Player(true, false);
    this.set_player_time(36000); //10mins
    new_game();
  }
  
  void set_state(char state) {
    this.game_state = state;
  }
  
  void render() {
    //render upside-down
    if (this.flipped_board == true) {
      translate(0, 7*sqh);
    }
    if (debug == true) {
      println("\nRoutine draw");
    }
    //draw squares, pieces
    for (int i = 0; i < 8; i++) { //y
      pushMatrix();
      for (int j = 0; j < 8; j++) { //x
        Spot s = this.board.get_spot(j, i);
        //render square
        if (s.is_white() == true) {
          fill(163,112,67);
        }
        else {
          fill(248,224,176);
        }
          
        //is it selected?
        if (this.selected_x == j && this.selected_y == i) {
          fill(192, 255, 192);
        }
             
        rect(0, 0, sql, sqh);
                
        if (s.get_piece() != null) { //if there is a piece on the spot
          Piece p = s.get_piece();
          //is the piece a king and is it in checkmate? if so, RED.
          if (p.piece_type == "King") {
            if ((p.is_white() == true && game.winner == 2) || (p.is_white() == false && game.winner == 1)) {
              fill(255, 64, 64);
              rect(0, 0, sql, sqh);
            }
            //if it's just check then red
            else if ((p.is_white() == true && game.check == 1 || p.is_white() == false && game.check == 2)) {
              fill(255, 128, 128);
              rect(0, 0, sql, sqh);
            }
          }
          image(p.image, sql - 78, sqh - 77, 80, 80); //sets the image to the piece location
        }
        
        //put green circle if this spot is a possible move for the current piece
        if (this.piece_selected() == true && ((this.white_turn == true && this.white.human == true) || (this.white_turn == false && this.black.human == true))) {
          if (this.possible_moves[i][j] == true || this.en_passant_moves[i][j] == true || this.castles[i][j] == true) {
            fill(64, 255, 64);
            circle(sql / 2, sqh / 2, 10);
          }
        }
        //black magic
        translate(sql, 0);
      }
      popMatrix(); //black magic[2]
      if (this.flipped_board == true) {
        translate(0, -sqh); //shift up
      }
      else {
        translate(0, sqh); //shift down
      }
    }
  }
  
  int get_ai_difficulty() {
    if (this.white.human == true) {
      return this.black.difficulty;
    }
    else {
      return this.white.difficulty;
    }
  }
  
  void set_ai_difficulty(int diff) { //sets difficulty of ai
    if (this.white.human == true) {
      this.black.set_difficulty(diff);
    }
    else {
      this.white.set_difficulty(diff);
    }
  }
  
  void set_two_player() { //sets game to 2 player
    this.two_player = true;
  }
  
  void set_one_player() { //sets game to 1 player
    this.two_player = false;
    if (this.white.human == true && this.black.human == true) {
      this.black.human = false;
    }
  }
  
  void set_white_human() { //sets white to human
    if (this.two_player == false) {
      this.black.human = false;
      this.flipped_board = true;
    }
    this.white.human = true;
  }
  
  void set_black_human() { //sets black to human
    if (this.two_player == false) {
      this.white.human = false;
      this.flipped_board = false;
    }
    this.black.human = true;
  }
  
  void set_player_time(int ticks) {
    this.white.set_time(ticks);
    this.black.set_time(ticks);
  }
  
  int get_white_time() {
    return this.white.get_time_seconds();
  }
  
  int get_black_time() {
    return this.black.get_time_seconds();
  }
  
  boolean piece_selected() { //gets whether a piece is selected
    if (this.selected_x == -1) {
      return false;
    }
    else {
      return true;
    }
  }
  
  Spot get_spot(int x, int y) { //gets a spot from pos x, y
    return this.board.get_spot(x, y);
  }
  
  boolean[][] get_special_moves(int type) { //0 = en passant, 1 = castles
    if (debug == true) {
      println("\nSpecial moves");
    }
    boolean[][] moves = new boolean[8][8];
    Spot s = this.get_spot(this.selected_x, this.selected_y);
    Piece p = s.get_piece();
    if (p != null) {
      if (type == 0) {
        int j = 1;
        if (p.is_white() == false) {
          j = -1;
        }
        if (this.selected_y == 3 || this.selected_y == 4 && p.piece_type == "Pawn") {
          for (int i = -1; i <=1; i += 2) {//I JUST REALIZED YOU CAN DO THE i += 2 THING LOL
            if (this.selected_x + i > 7 || this.selected_x + i < 0) { //obligatory 
            }
            else {
              Piece p2 = this.get_spot(this.selected_x + i, this.selected_y).get_piece();
              if (p2 != null) {
                if (p2.piece_type == "Pawn" && p2.moved_two_squares == true && p2.previous_move == this.board.move && p2.is_white() != p.is_white() && this.board.move_will_check(this.white_turn, this.get_spot(selected_x, selected_y), this.get_spot(selected_x + j, selected_x + i)) == false) {
                  moves[this.selected_y+j][this.selected_x + i] = true;
                }
              }
            }
          }
        }
      }
      else if (type == 1) { //castling
        if (debug == true) {
          println("\nSpecial moves");
        }
        if (p.previous_move == 0 && p.piece_type == "King") {
          boolean can_castle_kingside = true;
          boolean can_castle_queenside = true;
          for (int i = 1; i < 3; i++) { //king-side castling
            if (debug == true) {
              println(this.board.move_will_check(this.white_turn, s, this.get_spot(this.selected_x + i, this.selected_y)));
            }
            if (this.get_spot(this.selected_x + i, this.selected_y).get_piece() != null || this.board.move_will_check(this.white_turn, s, this.get_spot(this.selected_x + i, this.selected_y)) == true) {
              can_castle_kingside = false;
            }
          }
          if (can_castle_kingside == true) {
            moves[this.selected_y][this.selected_x + 2] = true;
          }
          for (int i = 1; i < 4; i++) { //king-side castling
            if (debug == true) {
              println(this.board.move_will_check(this.white_turn, s, this.get_spot(this.selected_x - i, this.selected_y)) );
            }
            if (this.get_spot(this.selected_x - i, this.selected_y).get_piece() != null || (this.board.move_will_check(this.white_turn, s, this.get_spot(this.selected_x - i, this.selected_y)) == true && i < 3)) {
              can_castle_queenside = false;
            }
          }
          if (can_castle_queenside == true) {
            moves[this.selected_y][this.selected_x - 2] = true;
          }
        }
      }
    }
    return moves;
  }
  
  int[] pos_to_coord(int x, int y) { //returns int[] table of x, y coord based on screen position
    int[] coord = new int[2];
    coord[0] = (x - boardpos_x) / (int)sql;
    coord[1] = (y - boardpos_y) / (int)sqh;
    if (flipped_board == true) {
      coord[1] = 7 - coord[1];
    }
    return coord;
  }
  
  void select_coord(int x, int y) { //selects coordinate based on x, y pos on board
    if (debug == true) {
      println("\nSelection");
    }
    Spot s = this.get_spot(x, y);
    if (s.get_piece() != null) {
      if (s.get_piece().is_white() == white_turn) {
        this.selected_x = x;
        this.selected_y = y;
        //calculate moves that can be done
        possible_moves = s.get_piece().can_move(this.board, s);
        en_passant_moves = this.get_special_moves(0);
        castles = this.get_special_moves(1);
        
        boolean has_moves = false;
        
        for (int i = 0; i < 8; i++) { //check for moves that put you in check (en-passant and castles are already accounted for) also check if any moves are doable if not deselect
          for (int j = 0; j < 8; j++) {
            if (possible_moves[i][j] == true) {
              if (this.board.move_will_check(this.white_turn, this.get_spot(selected_x, selected_y), this.get_spot(j, i)) == true) {
                possible_moves[i][j] = false;
              }
              else {
                has_moves = true;
              }
            }
            else if (en_passant_moves[i][j] == true) {
              has_moves = true;
            }
            else if (castles[i][j] == true) {
              has_moves = true;
            }
          }
        }
        
        if (has_moves == false) { //deselect if there are no moves
          deselect();
        }
      }
    }
  }
  
  void deselect() { //deselect current piece(just set the values to default)
    this.selected_x = -1;
    this.selected_y = -1;
    possible_moves = new boolean[8][8];
    en_passant_moves = new boolean[8][8];
    castles = new boolean[8][8];
  }
  
  void decrement_current_player_time() { //self explanatory
    if (this.white_turn == true) {
      this.white.decrement_time();
      if (this.white.get_time_ticks() <= 0) {
        game.winner = 2;
        end();
      }
    }
    else {
      this.black.decrement_time();
      if (this.black.get_time_ticks() <= 0) {
        game.winner = 1;
        end();
      }
    }
  }
  
  boolean player_move(int x, int y) { //do the move stuff
    Player player;
    if (this.white_turn == true) {
      player = white;
    }
    else {
      player = black;
    }
    //create move, add move to move table
    Move move = new Move(player, this.board.get_spot(selected_x, selected_y), this.board.get_spot(x, y));
    this.moves.add(move);
    
    return make_move(move);
  }
  
  boolean make_move(Move move) { //returns whether the move was successful or not
    if (debug == true) {
      println("\nMove piece");
    }
    Spot start = move.get_start();
    Piece p = start.get_piece();
    int movetype = 0; //0 = normal, 1 = en passant, 2 = castle;
    //does the piece exist?
    if (p == null) {
      return false;
    }
    
    Spot end = move.get_end();
    //can the piece move there at all?
    
    if (this.possible_moves[end.get_y()][end.get_x()] == false && this.en_passant_moves[end.get_y()][end.get_x()] == false && this.castles[end.get_y()][end.get_x()] == false) {
      deselect();
      return false;
    }
    if (this.en_passant_moves[end.get_y()][end.get_x()] == true) {
      movetype = 1;
    }
    else if (this.castles[end.get_y()][end.get_x()] == true) {
      movetype = 2;
    }
    
    //will the move put the king in check?
    if (this.board.move_will_check(this.white_turn, start, end) == true) {
      deselect();
      return false;
    }
    
    if (movetype == 0) { //is this a normal move?
      //is there a piece on the spot?
      Piece p2 = end.get_piece();
      if (p2 != null) {
        move.set_killed_piece(p2);
      }
      end.set_piece(p);
      start.set_piece(null);
    }
    
    else if (movetype == 1) {//is this an en passant?
      int j = -1;
      if (this.white_turn == false) {
        j = 1;
      }
      Spot s2 = this.get_spot(end.get_x(), end.get_y() + j);
      Piece p2 = s2.get_piece();
      end.set_piece(p);
      start.set_piece(null);
      s2.set_piece(null);
      move.set_killed_piece(p2);
      move.set_en_passant();
    }
    
    else if (movetype == 2) { //castling
      Spot s2;
      Spot s3;
      if (end.get_x() == 2) {
        s3 = this.get_spot(0, end.get_y());
        s2 = this.get_spot(end.get_x()+1, end.get_y());
        move.castled_kingside = false;
      }
      else {
        s3 = this.get_spot(7, end.get_y());
        s2 = this.get_spot(end.get_x()-1, end.get_y());
        move.castled_kingside = false;
      }
      end.set_piece(p);
      start.set_piece(null);
      s2.set_piece(s3.get_piece());
      s3.set_piece(null);
      move.set_castled();
    }
    
    //2-piece moves for pawn also to allow for en passant stuff
    if (p.piece_type == "Pawn") {
      if (abs(end.get_y() - start.get_y()) == 2) {
        p.moved_two_squares = true;
      }
      else if (end.get_y() == 0 && p.is_white() == false) {
        board.promote(end.get_x(), end.get_y());
      }
      else if (end.get_y() == 7 && p.is_white() == true) {
        board.promote(end.get_x(), end.get_y());
      }
    }
    
    //handle end of turn stuff
    
    //is it now checkmate for the enemy?
    if (this.board.any_possible_moves(!white_turn) == true) {
      if (this.board.look_for_check(!white_turn) == true) {
        move.checkmate = true;
        if (this.white_turn == true) {
          this.winner = 1;
        }
        else {
          this.winner = 2;
        }
      }
      else {
        move.stalemate = true;
        this.winner = 3;
      }
      //update move list
      moves.add(move);
      deselect();
      end();
      return true;
    }
    
    else if (this.board.look_for_check(!white_turn) == true) {
      if (this.white_turn == true) {
        this.check = 2;
      }
      else {
        this.check = 1;
      }
    }
    else {
      this.check = 0;
    }
    
    this.white_turn = !this.white_turn;
    
    if (this.two_player == true) {
      this.flipped_board = this.white_turn;
    }
    
    //update move list
    this.board.move++;
    p.previous_move = board.move;
    
    moves.add(move);
    //add_to_move_list(this.board.move, move); //yeah i have no clue why this causes a nullpointerexception but w/e
    deselect();
    
    return true;
  }
  
  void end() {
    String t = "";
    game.game_state = 'p';
    
    winnerWindow.setVisible(true);
    gameWindow.setVisible(false);
    
    if (game.winner == 1) {
      t = "White wins!";
    }
    else if (game.winner == 2) {
      t = "Black wins!";
    }
    else { 
      t = "Stalemate!";
    }
    
    winnerText.setText(t);
    
  }
  
  void new_game() {
    this.board = new Board();
    this.selected_x = -1;
    this.selected_y = -1;
    this.white_turn = true;
    this.flipped_board = true;
    this.winner = 0;
    this.check = 0;
    this.drawoffer = 0;
    this.game_state = 'm';
    this.en_passant_moves = new boolean[8][8];
    this.castles = new boolean[8][8];
    this.set_ai_difficulty(0);
    this.set_two_player();
    this.white.reset_time();
    this.black.reset_time();
  }
  
}
