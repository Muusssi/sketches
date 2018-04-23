final int TILE_SIZE = 25;

int grid_width = 30;
int grid_height = 30;
int mines_total = 100;

int unmarked_mines = 0;

Tile[][] grid;

void setup() {
  size(1000, 900, P2D);
  textSize(20);

  new_grid();
  update();
}

void draw() {}

void update() {
  background(200);
  draw_grid();
}

void new_grid() {
  unmarked_mines = mines_total;
  init_empty_grid();
  set_mines();
  set_neighbor_counts();
}

void mousePressed() {
  int x = int(mouseX)/TILE_SIZE;
  int y = int(mouseY)/TILE_SIZE;
  if (valid_tile_coordinate(x, y)) {
    if (mouseButton == LEFT && !grid[x][y].marked) {
      grid[x][y].reveal();
    }
    else if (mouseButton == RIGHT) {
      grid[x][y].mark();
    }
  }

  update();
}

void keyPressed() {
  new_grid();
  update();
}