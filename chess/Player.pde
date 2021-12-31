class Player {
  
  boolean white = false;
  
  int score = 0;
  int wins = 0;
  IntList pieces = new IntList();
  
  boolean human;
  int difficulty; //0 = baby, 1 = normal, 2 = hard
  int time_left;
  int max_time;
  
  Player(boolean human, boolean white) {
    this.human = human;
    this.white = white;
  }
  
  void set_white() {
    this.white = true;
  }
  
  void set_black() {
    this.white = false;
  }
  
  void set_difficulty(int diff) {
    this.difficulty = diff;
  }
  
  void set_time(int ticks) {
    this.time_left = ticks;
    this.max_time = ticks;
  }
  
  void reset_time() {
    this.time_left = max_time;
  }
  
  boolean is_white() {
    return this.white;
  }
  
  boolean is_black() {
    return !this.white;
  }
  
  int get_time_ticks() {
    return this.time_left;
  }
  
  int get_time_seconds() {
    return this.time_left/60;
  }
  
  void decrement_time() {
    this.time_left--;
  }
  
  void ai_move(Game game) {
    //baby
    if (this.difficulty == 0) {
      Spot[] moves = new Spot[2];
      boolean move_found = false;
      while (move_found == false) {
        int x = (int)random(0, 8);
        int y = (int)random(0, 8);
        Spot s = game.get_spot(x, y);
        if (s.get_piece() != null) {
          game.select_coord(x, y);
            boolean selected_pos = false;
            int attempts = 0;
            while (selected_pos == false && attempts < 64) {
              attempts++;
              int i = (int)random(0, 8);
              int j = (int)random(0, 8);
              if (game.possible_moves != null) {
                if (game.possible_moves[i][j] == true) {
                  moves[0] = s;
                  moves[1] = game.get_spot(j, i);
                  move_found = true;
                  selected_pos = true;
                }
              }
            }
          }
        }
      game.player_move(moves[1].get_x(), moves[1].get_y());
    }
  }
}
