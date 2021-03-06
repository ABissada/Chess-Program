/* =========================================================
 * ====                   WARNING                        ===
 * =========================================================
 * The code in this tab has been generated from the GUI form
 * designer and care should be taken when editing this file.
 * Only add/edit code inside the event handlers i.e. only
 * use lines between the matching comment tags. e.g.

 void myBtnEvents(GButton button) { //_CODE_:button1:12356:
     // It is safe to enter your event code here  
 } //_CODE_:button1:12356:
 
 * Do not rename this tab!
 * =========================================================
 */

synchronized public void win_draw2(PApplet appc, GWinData data) { //_CODE_:startWindow:748592:
    appc.background(230);
  } //_CODE_:startWindow:748592:

public void button1_click5(GButton source, GEvent event) { //_CODE_:onePlayer:553250:
  game.set_one_player();
} //_CODE_:onePlayer:553250:

public void button1_click6(GButton source, GEvent event) { //_CODE_:twoPlayers:249130:
  game.set_two_player();
} //_CODE_:twoPlayers:249130:

public void button1_click7(GButton source, GEvent event) { //_CODE_:white:377657:
  game.set_white_human();
} //_CODE_:white:377657:

public void button1_click8(GButton source, GEvent event) { //_CODE_:black:473183:
  game.set_black_human();
} //_CODE_:black:473183:

public void slider1_change1(GSlider source, GEvent event) { //_CODE_:timeSlider:322675:
  int min = timeSlider.getValueI();
  game.set_player_time(min*60*60); //60 seconds in a minute, 60 ticks in a second (60fps)
} //_CODE_:timeSlider:322675:

public void button1_click9(GButton source, GEvent event) { //_CODE_:start:827188:
  game.set_state('g');
  startWindow.setVisible(false);
  gameWindow.setVisible(true);
  infoWindow.setVisible(true);
} //_CODE_:start:827188:

synchronized public void win_draw3(PApplet appc, GWinData data) { //_CODE_:gameWindow:234090:
  appc.background(230);
} //_CODE_:gameWindow:234090:

public void button1_click1(GButton source, GEvent event) { //_CODE_:resignButton:918641:
  if (game.game_state == 'g') {
    if (game.white_turn == true) {
      game.winner = 2;
    }
    else {
      game.winner = 1;
    }
    game.game_state = 'p';
  }
  game.end();
} //_CODE_:resignButton:918641:

synchronized public void win_draw1(PApplet appc, GWinData data) { //_CODE_:winnerWindow:977485:
  appc.background(230);
} //_CODE_:winnerWindow:977485:

synchronized public void win_draw4(PApplet appc, GWinData data) { //_CODE_:infoWindow:709271:
  appc.background(230);
  
} //_CODE_:infoWindow:709271:



// Create all the GUI controls. 
// autogenerated do not edit
public void createGUI(){
  G4P.messagesEnabled(false);
  G4P.setGlobalColorScheme(GCScheme.BLUE_SCHEME);
  G4P.setMouseOverEnabled(false);
  surface.setTitle("Sketch Window");
  startWindow = GWindow.getWindow(this, "Start Window", 400, 100, 450, 300, JAVA2D);
  startWindow.noLoop();
  startWindow.setActionOnClose(G4P.KEEP_OPEN);
  startWindow.addDrawHandler(this, "win_draw2");
  onePlayer = new GButton(startWindow, 20, 100, 80, 30);
  onePlayer.setText("One Player");
  onePlayer.setLocalColorScheme(GCScheme.CYAN_SCHEME);
  onePlayer.addEventHandler(this, "button1_click5");
  twoPlayers = new GButton(startWindow, 20, 170, 80, 30);
  twoPlayers.setText("Two Players");
  twoPlayers.setLocalColorScheme(GCScheme.RED_SCHEME);
  twoPlayers.addEventHandler(this, "button1_click6");
  white = new GButton(startWindow, 130, 100, 80, 30);
  white.setText("White");
  white.setLocalColorScheme(GCScheme.ORANGE_SCHEME);
  white.addEventHandler(this, "button1_click7");
  black = new GButton(startWindow, 130, 170, 80, 30);
  black.setText("Black");
  black.addEventHandler(this, "button1_click8");
  timeLimit = new GLabel(startWindow, 350, 100, 80, 20);
  timeLimit.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  timeLimit.setText("Time Limit");
  timeLimit.setLocalColorScheme(GCScheme.PURPLE_SCHEME);
  timeLimit.setOpaque(false);
  timeSlider = new GSlider(startWindow, 342, 140, 100, 40, 10.0);
  timeSlider.setShowValue(true);
  timeSlider.setLimits(10, 1, 60);
  timeSlider.setNumberFormat(G4P.INTEGER, 0);
  timeSlider.setLocalColorScheme(GCScheme.PURPLE_SCHEME);
  timeSlider.setOpaque(false);
  timeSlider.addEventHandler(this, "slider1_change1");
  start = new GButton(startWindow, 165, 240, 120, 40);
  start.setText("Start");
  start.setLocalColorScheme(GCScheme.GREEN_SCHEME);
  start.addEventHandler(this, "button1_click9");
  startLabel = new GLabel(startWindow, 75, 15, 300, 55);
  startLabel.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  startLabel.setText("Start Menu");
  startLabel.setLocalColorScheme(GCScheme.RED_SCHEME);
  startLabel.setOpaque(true);
  gameWindow = GWindow.getWindow(this, "Game Options", 1300, 300, 400, 200, JAVA2D);
  gameWindow.noLoop();
  gameWindow.setActionOnClose(G4P.KEEP_OPEN);
  gameWindow.addDrawHandler(this, "win_draw3");
  gameSettings = new GLabel(gameWindow, 100, 10, 200, 30);
  gameSettings.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  gameSettings.setText("Game Settings");
  gameSettings.setLocalColorScheme(GCScheme.RED_SCHEME);
  gameSettings.setOpaque(true);
  resignButton = new GButton(gameWindow, 50, 70, 300, 100);
  resignButton.setText("Resign");
  resignButton.setLocalColorScheme(GCScheme.RED_SCHEME);
  resignButton.addEventHandler(this, "button1_click1");
  winnerWindow = GWindow.getWindow(this, "Winner", 300, 400, 240, 120, JAVA2D);
  winnerWindow.noLoop();
  winnerWindow.setActionOnClose(G4P.KEEP_OPEN);
  winnerWindow.addDrawHandler(this, "win_draw1");
  winnerText = new GLabel(winnerWindow, 40, 30, 160, 60);
  winnerText.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  winnerText.setText("Black Wins!");
  winnerText.setOpaque(false);
  infoWindow = GWindow.getWindow(this, "Window title", 300, 200, 240, 480, JAVA2D);
  infoWindow.noLoop();
  infoWindow.setActionOnClose(G4P.KEEP_OPEN);
  infoWindow.addDrawHandler(this, "win_draw4");
  blackTime = new GLabel(infoWindow, 0, 400, 240, 80);
  blackTime.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  blackTime.setText("Black time:");
  blackTime.setLocalColorScheme(GCScheme.ORANGE_SCHEME);
  blackTime.setOpaque(true);
  whiteTime = new GLabel(infoWindow, 0, 0, 240, 80);
  whiteTime.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  whiteTime.setText("White time:");
  whiteTime.setLocalColorScheme(GCScheme.YELLOW_SCHEME);
  whiteTime.setOpaque(true);
  moveList = new GLabel(infoWindow, 0, 120, 240, 240);
  moveList.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  moveList.setOpaque(false);
  startWindow.loop();
  gameWindow.loop();
  winnerWindow.loop();
  infoWindow.loop();
}

// Variable declarations 
// autogenerated do not edit
GWindow startWindow;
GButton onePlayer; 
GButton twoPlayers; 
GButton white; 
GButton black; 
GLabel timeLimit; 
GSlider timeSlider; 
GButton start; 
GLabel startLabel; 
GWindow gameWindow;
GLabel gameSettings; 
GButton resignButton; 
GWindow winnerWindow;
GLabel winnerText; 
GWindow infoWindow;
GLabel blackTime; 
GLabel whiteTime; 
GLabel moveList; 
