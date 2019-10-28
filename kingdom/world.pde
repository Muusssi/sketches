


Tile[][] world_grid = new Tile[WORLD_WIDTH][WORLD_HEIGHT];
PGraphics map_layer, dominion_layer;

void init_world() {
  for (int i = 0; i < WORLD_WIDTH; ++i) {
    for (int j = 0; j < WORLD_HEIGHT; ++j) {
      float rand = random(1);
      if (rand > 0.25 || (i == 10 && j == 10)) {
        world_grid[i][j] = new LandTile(i, j);
      }
      else if (rand > 0.12) {
        world_grid[i][j] = new WaterTile(i, j);
      }
      else {
        world_grid[i][j] = new MountainTile(i, j);
      }
    }
  }
}

void init_map_layer() {
  map_layer = createGraphics(TILE_SIZE*WORLD_WIDTH, TILE_SIZE*WORLD_WIDTH);
  map_layer.beginDraw();
  for (int i = 0; i < WORLD_WIDTH; ++i) {
    for (int j = 0; j < WORLD_HEIGHT; ++j) {
      world_grid[i][j].draw();
    }
  }
  map_layer.endDraw();
}


void draw_map() {
  image(map_layer, 0, 0);
}


public abstract class Tile {

  int x, y;
  float fertility = 0;
  float movement_cost = 1;
  boolean units_can_cross = false;

  Building building = null;
  Unit unit = null;


  int red = 255;
  int green = 255;
  int blue = 255;



  public Tile (int x, int y) {
    this.x = x;
    this.y = y;
  }

  void draw() {
    map_layer.fill(red, green, blue);
    map_layer.rect(x*TILE_SIZE, y*TILE_SIZE, TILE_SIZE, TILE_SIZE);
  }

}

public class LandTile extends Tile {

  public LandTile (int x, int y) {
    super(x, y);
    red = 0;
    green = 255;
    blue = 0;
    units_can_cross = true;
  }

}


public class WaterTile extends Tile {

  public WaterTile (int x, int y) {
    super(x, y);
    red = 0;
    green = 0;
    blue = 255;
  }

}

public class MountainTile extends Tile {



  public MountainTile (int x, int y) {
    super(x, y);
    red = 51;
    green = 17;
    blue = 0;
  }

}



public class Building {

  public Building () {

  }

}

void draw_units() {
  for (int i = 0; i < units.size(); ++i) {
    Unit unit = units.get(i);
    unit.draw();
  }
}


public class PathPoint {
  Tile tile;
  PathPoint previous_point;
  float movement_cost;

  public PathPoint (Tile tile, float movement_cost, PathPoint previous_point) {
    // this.destination = destination;
    // this.movement_cost = movement_cost;
    // this.previous_point = previous_point;
  }

}


int[] x_directions = {-1, 0, 1, -1, 1, -1, 0, 1};
int[] y_directions = {-1, -1, -1, 0, 0, 1, 1, 1};

public class Unit {

  int x = 10;
  int y = 10;
  Tile tile;

  float initial_movement_points = 5;
  float movement_points = 0;
  LinkedList<PathPoint> reachable_points = new LinkedList<PathPoint>();

  public Unit () {
    units.add(this);
    world_grid[x][y].unit = this;
  }

  void draw() {
    if (active_unit == this) {
      fill(255, 0, 0);
    }
    else {
      fill(255);
    }
    ellipse((x+0.5)*TILE_SIZE, (y+0.5)*TILE_SIZE, 2*TILE_SIZE/3, 2*TILE_SIZE/3);
  }

  // void find_reachable_paths() {

  //   LinkedList<PathPoint> reachable = new LinkedList<PathPoint>();

  //   LinkedList<PathPoint> queue = new LinkedList<PathPoint>();
  //   queue.add(new PathPoint(this.tile, 0));
  //   int x, y;
  //   Tile tile;
  //   while (queue.size() > 0) {
  //     PathPoint current = queue.removeFirst();
  //     x = current.x;
  //     y = current.y;
  //     for (int i = 0; i < 8; ++i) {
  //       int next_x = x - x_directions[i];
  //       int next_y = y - y_directions[i];
  //       if (are_coordinates_inside(next_x, next_y)) {
  //         tile = world_grid[next_x][next_y];
  //       }
  //     }


  //   }
  // }

}

boolean are_coordinates_inside(int x, int y) {
  if (x < 0 || x >= WORLD_WIDTH) {
    return false;
  }
  if (y < 0 || y >= WORLD_HEIGHT) {
    return false;
  }
  return true;
}
















