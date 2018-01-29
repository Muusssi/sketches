ArrayList<Organism> organisms = new ArrayList<Organism>();
ArrayList<Organism> to_be_removed = new ArrayList<Organism>();


float mutation = 10.0;


public class Organism {
  float r, g, b;
  int x,y;
  float size = 5.0;
  float energy = 5.0;
  boolean alive = true;
  int children = 0;


  public Organism (int x, int y) {
    this.x = x;
    this.y = y;
    r = random(10, 255);
    g = random(10, 255);
    b = random(10, 255);
    organisms.add(this);
  }

  public Organism (int x, int y, float r, float g, float b) {
    this.x = x;
    this.y = y;
    this.r = constrain(r + random(-mutation, mutation), 10, 255);
    this.g = constrain(g + random(-mutation, mutation), 10, 255);
    this.b = constrain(b + random(-mutation, mutation), 10, 255);
    organisms.add(this);
  }
  // public Organism (int x, int y, float r, float g, float b) {
  //   this.x = x;
  //   this.y = y;
  //   this.r = constrain(r + randomGaussian()*mutation, 10, 255);
  //   this.g = constrain(g + randomGaussian()*mutation, 10, 255);
  //   this.b = constrain(b + randomGaussian()*mutation, 10, 255);
  //   organisms.add(this);
  // }

  public void breath() {
    if (nut_grid[x][y] >= b/50.0) {
      nut_grid[x][y] -= b/50.0;
      energy += map(b, 10, 250.5, 1, 0.5)*b/50.0;
    }

  }

  public void metabolize() {
    energy -= 0.05;
    size += 0.045;
    if (energy <= 0) {
      alive = false;
      //println("Dead");
      organisms.remove(this);
      org_grid[x][y] = null;
      nut_grid[x][y] = size;
    }

  }

  public void move() {
    if (energy > r/2+10 && nut_grid[x][y] < energy) {
      int[] d = free_neighbor(false);
      if (d[0] != 0 || d[1] != 0) {
        energy -= 0.5;
        org_grid[x][y] = null;
        x += d[0];
        y += d[1];
        org_grid[x][y] = this;
      }
    }
  }

  public void multiply() {
    if (energy > g/2 + 5) {
      int[] d = free_neighbor(false);
      if (d[0] != 0 || d[1] != 0) {

        Organism child = new Organism(x+d[0], y+d[1], r, g, b);
        child.energy = 3*energy/5;
        child.size = child.energy;
        this.energy = energy/5;
        this.size = this.energy;
        org_grid[x+d[0]][y+d[1]] = child;
        children++;
      }
    }
  }

  public void live() {
    if (alive) {
      breath();
      metabolize();
      move();
      multiply();

    }
  }


  int[] free_neighbor(boolean by_color) {
    float dir;
    if (by_color) {
      dir = r%4;
    }
    else {
      dir = random(4);
    }
    int[] neighbor = new int[2];
    if (dir < 1 && x > 0 && org_grid[x - 1][y] == null) {
      neighbor[0] = -1;
    }
    else if (dir < 2 && x < WORLD_WIDTH - 1 && org_grid[x + 1][y] == null) {
      neighbor[0] = 1;
    }
    else if (dir < 3 && y > 0 && org_grid[x][y - 1] == null) {
      neighbor[1] = -1;
    }
    else if (dir < 4 && y < WORLD_HEIGHT -1 && org_grid[x][y + 1] == null) {
      neighbor[1] = 1;
    }
    return neighbor;
  }

}

