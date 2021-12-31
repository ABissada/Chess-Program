//code exists for move notation but the ai bugs it so its disabled, unsure as to why this happens
//only one difficulty (baby mode), code exists for changing difficulty but no ai implemented past the basic one
//no implementation of special rules such as 50-move rule, insufficient material, etc just resign at that point 

//also ui positions made sense for me on my 1920x1080 monitor, if they're off you can manually adjust them via G4P or just drag them around

float sqh, sql; //square height, square length
Game game;

import g4p_controls.*;
boolean startMenu = false;

//position of top left corner
int boardpos_x = 0;
int boardpos_y = 0;

int boardsize_x = 600;
int boardsize_y = 600;

boolean debug = false;

int half_width;
int half_height;

//timing
int tick = 0;

boolean end = false;

void setup() {
  size(600, 600);
  //variables
  sqh = boardsize_x/8;
  sql = boardsize_y/8;
  half_height = height/2;
  half_width = width/2;
  
  //game
  game = new Game();
  game.set_ai_difficulty(0);
  
  //uis
  createGUI();
  winnerWindow.setVisible(false);
  gameWindow.setVisible(false);
  infoWindow.setVisible(false);
}

void update_time_window() { //update the time window itself with the player times
  int white_time = game.get_white_time();
  int black_time = game.get_black_time();
  int white_seconds = white_time % 60;
  int black_seconds = black_time % 60;
  String white_time_display = str(white_time/60) + ":";
  String black_time_display = str(black_time/60) + ":";
  if (white_seconds < 10) {
    white_time_display += "0";
  }
  if (black_seconds < 10) {
    black_time_display += "0";
  }
  white_time_display += white_seconds;
  black_time_display += black_seconds;
  whiteTime.setText("White time: "+white_time_display);
  blackTime.setText("Black time: "+black_time_display);
}

void add_to_move_list(int move_num, Move move) { //add the move to the move list(inside of the time gui, between the players times) BROKEN WITH AI!!!
  String move_string = ""; //when i was little i thought tostring was a reference to toast (???)
  if (move_num > 1) {
    move_string = ", "+str(move_num)+". "+move.tostring();
  }
  else {
    move_string = str(move_num)+". "+move.tostring();
  }
  move_string = moveList.getText() + move_string;
  moveList.setText(move_string);
}

void mousePressed() {
  if (game.game_state == 'g') { // currently in game?
    int[] coord = game.pos_to_coord(mouseX, mouseY); //get x (coord[0]) and y (coord[1]) pos of mouse click
    if (game.two_player == true || game.two_player == false && ((game.white.human == true && game.white_turn == true) || (game.black.human == true && game.white_turn == false))) { //is two player or white is the human and its white turn or black is the human and its black's turn
      if (game.piece_selected() == false) { //no piece selected, select piece
        game.select_coord(coord[0], coord[1]);
      }
      else { //make a move to this place
        game.player_move(coord[0], coord[1]);
      }
    }
  }
  else if (game.game_state == 'p') { //get out of the post-game screen
    end = true;
  }
}

void keyPressed() {
  if (game.game_state == 'p') { //get out of the post-game screen
    end = true;
  }
}

void draw() {
  if (game.game_state == 'm') { //draw nothing
    background(32, 64, 32);
  }
  if (game.game_state == 'g') {
      background(32, 64, 32);
      if (game.winner == 0) { //no one won yet
        game.decrement_current_player_time(); //self-explanatory
        if (game.two_player == false) {//not two player, make ai moves if it's the ai's turn
          if (game.white.human == false && game.white_turn == true) {
            game.white.ai_move(game);
          }
          else if (game.black.human == false && game.white_turn == false) {
            game.black.ai_move(game);
          }
        }
      }
      game.render();
      
      update_time_window();
  }
    
  if (game.game_state == 'p') {
    game.render(); //just render the checkmate/stalemate/whatever
    if (end == true) { //if player pressed key/mouse
      game.game_state = 'm';
      startWindow.setVisible(true);
      winnerWindow.setVisible(false);
      infoWindow.setVisible(false);
      end = false;
      game.new_game(); //reset stuff
    }
  }
  
  tick++;

}
