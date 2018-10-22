import tui.*;

int score = 0;
float player_x = 0;
float player_y = 0;

final static int player_size = 30;

void setup() {
  size(1200, 800);
  background(0);
  textSize(20);

  player_x = width/2;
  player_y = height/2;
  new Alien();
  TUI.aloita(this);
}

void draw() {
  background(0);
  text(score, 30, 30);
  move_player();
  draw_player();
  iterateProjectiles();
  iterateAliens();
  score++;
  if (frameCount % 100 == 0) {
    new Alien();
    if (frameCount % 500 == 0) new RectAlien();
  }
  if (mousePressed) {
    shoot();
  }
}


void keyPressed() {
  TUI.huomaa_painallus();
  if (keyCode == 32) {
    shoot();
  }
}

void keyReleased() {
  TUI.huomaa_vapautus();
}

void move_player() {
  if (TUI.nappain_painettu('W')) player_y -= 5;
  if (TUI.nappain_painettu('A')) player_x -= 5;
  if (TUI.nappain_painettu('S')) player_y += 5;
  if (TUI.nappain_painettu('D')) player_x += 5;
}

void draw_player() {
  pushStyle();
  fill(100);
  ellipse(player_x, player_y, player_size, player_size);
  popStyle();
}