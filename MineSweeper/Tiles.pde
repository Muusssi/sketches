
void init_empty_grid() {
  tiles = new ArrayList<Tile>();
  grid = new Tile[grid_width][grid_height];
  for (int i = 0; i < grid_width; ++i) {
    for (int j = 0; j < grid_height; ++j) {
      grid[i][j] = new Tile(i, j);
    }
  }
}


void set_mines() {
  if (grid != null) {
    int mines_to_add = mines_total;
    while (mines_to_add > 0) {
      int x = int(random(0, grid_width));
      int y = int(random(0, grid_height));
      if (!grid[x][y].mine) {
        mines_to_add--;
        grid[x][y].mine = true;
      }
    }
  }
}

void draw_grid() {
  if (grid != null) {
    for (int i = 0; i < grid_width; ++i) {
      for (int j = 0; j < grid_height; ++j) {
        Tile tile = grid[i][j];
        tile.draw();
      }
    }
  }
  text(unmarked_mines + "/" + mines_total + "", 10, (grid_height + 1)*TILE_SIZE);
}

void set_neighbor_counts() {
  if (grid != null) {
    for (int i = 0; i < grid_width; ++i) {
      for (int j = 0; j < grid_height; ++j) {
        Tile tile = grid[i][j];
        tile.count_neighbors();
      }
    }
  }
}

void reveal_all() {
  for (Tile tile : tiles) {
    tile.reveal();
  }
}

ArrayList<Tile> tiles = new ArrayList<Tile>();

public class Tile {

  int x;
  int y;
  boolean mine = false;
  boolean revealed = false;
  boolean marked = false;
  boolean exploded = false;
  int neighbors = 0;

  public Tile (int x, int y) {
    this.x = x;
    this.y = y;
    tiles.add(this);
  }

  void reveal() {
    if (!revealed) {
      revealed = true;
      if (mine) {
        exploded = true;
        reveal_all();
      }
      else {
        if (neighbors == 0) {
          for (int i = -1; i <= 1; ++i) {
            for (int j = -1; j <= 1; ++j) {
              int xx = x + i;
              int yy = y + j;
              if (valid_tile_coordinate(xx, yy) && !grid[xx][yy].revealed) {
                grid[xx][yy].reveal();
              }
            }
          }
        }
      }
    }
  }

  void mark() {
    if (marked) {
      marked = false;
      unmarked_mines++;
    }
    else {
      marked = true;
      unmarked_mines--;
    }

  }

  void draw() {
    pushStyle();
    if (revealed) {
      if (this.mine) {
        if (this.exploded) {
          fill(200, 0, 0);
          if (marked) {
            stroke(0, 0, 200);
          }
        }
        else {
          fill(0);
        }

      }
      else {
        fill(200);
      }
    }
    else {
      if (marked) {
        fill(0, 0, 200);
      }
      else {
        fill(100);
      }
    }
    rect(x*TILE_SIZE, y*TILE_SIZE, TILE_SIZE, TILE_SIZE);
    // Number
    if (revealed && !mine && neighbors > 0) {
      fill(0);
      if (neighbors == 1) fill(50, 50, 250);
      if (neighbors == 2) fill(0, 200, 0);
      if (neighbors == 3) fill(250, 0, 0);
      if (neighbors == 4) fill(0, 0, 150);
      if (neighbors == 5) fill(150, 50, 0);
      if (neighbors == 6) fill(50, 200, 200);

      text(neighbors, x*TILE_SIZE, (y + 1)*TILE_SIZE);
    }
    popStyle();
  }

  void count_neighbors() {
    for (int i = -1; i <= 1; ++i) {
      for (int j = -1; j <= 1; ++j) {
        int xx = x + i;
        int yy = y + j;
        if (valid_tile_coordinate(xx, yy) && grid[xx][yy].mine) {
          neighbors++;
        }
      }
    }
  }

}


boolean valid_tile_coordinate(int x, int y) {
  if (x >= 0 && x < grid_width && y >= 0 && y < grid_height) {
    return true;
  }
  return false;
}