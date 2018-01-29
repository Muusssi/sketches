import java.util.LinkedList;
import java.util.HashMap;
import java.lang.Math.*;

final int NUMBER_OF_PARTICLES = 5000;

final double UNIVERSE_RADIUS = 100;
final double GRIS_SIZE = UNIVERSE_RADIUS/10;
final double MAX_SPEED = 30;


HashMap<Integer,HashMap<Integer,Cell>> grid = new HashMap<Integer,HashMap<Integer,Cell>>();



LinkedList<Particle> all_particles = new LinkedList<Particle>();


Cell get_cell(int x, int y) {
  if (grid.containsKey(x)) {
    HashMap<Integer,Cell> row = grid.get(x);
    if (row.containsKey(y)) {
      return row.get(y);
    }
  }
  return new Cell(x, y);

}


public class Cell {
  int x, y;
  double mass = 0;
  double mid_x = 0;
  double mid_y = 0;
  HashMap<Integer,Cell> own_row = null;

  ArrayList<Particle> particles = new ArrayList<Particle>();

  public Cell(int x, int y) {
    this.x = x;
    this.y = y;
    if (grid.containsKey(x)) {
      this.own_row = grid.get(x);
      grid.get(x).put(y, this);
    }
    else {
      this.own_row = new HashMap<Integer,Cell>();
      grid.put(x, this.own_row);
      this.own_row.put(y, this);
    }
  }

  void add(Particle p) {
    this.particles.add(p);
    update();
  }

  void remove(Particle p) {
    this.particles.remove(p);
    update();
  }

  void update() {
    this.mass = 0;
    this.mid_x = 0;
    this.mid_y = 0;
    for (Particle p : this.particles) {
      this.mass += p.mass;
      this.mid_x += p.x*p.mass;
      this.mid_y += p.y*p.mass;
    }
    this.mid_x /= this.mass;
    this.mid_y /= this.mass;
  }

}


void generate_particles() {
  for (int i = 0; i < NUMBER_OF_PARTICLES; ++i) {
    new Particle(random(-(float)UNIVERSE_RADIUS, (float)UNIVERSE_RADIUS), random(-(float)UNIVERSE_RADIUS, (float)UNIVERSE_RADIUS), random(1, 10));
  }
  //new Particle(0, 0, 10000);
}

void circular_start() {
  double speed = 1;
  for (int i = all_particles.size() - 1; i >= 0; i--) {
    Particle p = all_particles.get(i);
    double dist = Math.sqrt(p.x*p.x + p.y*p.y);
    speed = Math.sqrt(300/dist);//random(000, 100);
    p.vx = speed*p.y/dist;
    p.vy = -speed*p.x/dist;
    if (Double.isNaN(p.vx)) {
      p.vx = 0;
    }
    if (Double.isNaN(p.vy)) {
      p.vy = 0;
    }
  }
}


void draw_particles() {
  for (int i = all_particles.size() - 1; i >= 0; i--) {
    Particle p = all_particles.get(i);
    if (p.move()) {
      all_particles.remove(i);
      p.cell.remove(p);
    }
    else {

    }
    p.draw();
  }
}


public class Particle {
  double x, y, mass;
  double vx = 0;
  double vy = 0;
  double ax = 0;
  double ay = 0;
  double r = 0.1;
  int grid_x, grid_y;
  Cell cell;


  public Particle (double x, double y, double mass) {
    this.x = x;
    this.y = y;
    this.mass = mass;
    this.grid_x = (int)(x/GRIS_SIZE);
    this.grid_y = (int)(y/GRIS_SIZE);
    this.cell = get_cell(grid_x, grid_y);
    this.cell.add(this);
    update_radius();
    all_particles.add(this);
  }

  void update_radius() {
    this.r = Math.cbrt(this.mass);
  }

  void update_grid_status() {
    int new_grid_x = (int)(x/GRIS_SIZE);
    int new_grid_y = (int)(y/GRIS_SIZE);
    if (new_grid_x != grid_x || new_grid_y != new_grid_y) {
      this.cell.remove(this);
      this.cell = get_cell(new_grid_x, new_grid_y);
      this.cell.add(this);
      grid_x = new_grid_x;
      grid_y = new_grid_y;
    }

  }

  void draw() {
    ellipse((float)(x/UNIVERSE_RADIUS)*width/2, (float)(y/UNIVERSE_RADIUS)*width/2, (float)r*2+1, (float)r*2+1);
  }

  boolean move() {
    ax = 0;
    ay = 0;
    for (HashMap<Integer,Cell> row : grid.values()) {
      for (Cell cur_cell : row.values()) {
        if (cur_cell.x - grid_x > 1 || cur_cell.y - grid_y > 1) {
          if (!cur_cell.particles.isEmpty()) {
            double x_diff = cur_cell.mid_x - this.x;
            double y_diff = cur_cell.mid_y - this.y;
            double dist = Math.sqrt(x_diff*x_diff + y_diff*y_diff);
            if (dist < 0.001) {
              dist = 0.001;
            }
            double acc = cur_cell.mass/(dist*dist);
            ax += x_diff/dist * acc;
            ay += y_diff/dist * acc;
          }
        }
        else {
          for (Particle other : cur_cell.particles) {
            if (this != other) {
              double x_diff = other.x - this.x;
              double y_diff = other.y - this.y;
              double dist = Math.sqrt(x_diff*x_diff + y_diff*y_diff);
              if (dist < 0.001) {
                dist = 0.001;
              }
              if (dist*(double)width*0.5/UNIVERSE_RADIUS < other.r + this.r) {
                // Collision
                // println("Collision");
                double mass_total = this.mass + other.mass;
                other.vx = (vx*mass + other.vx*other.mass)/mass_total;
                other.vy = (vy*mass + other.vy*other.mass)/mass_total;
                other.x = (x*mass + other.x*other.mass)/mass_total;
                other.y = (y*mass + other.y*other.mass)/mass_total;
                other.mass = mass_total;
                other.update_radius();
                return true;
              }
              double acc = other.mass/(dist*dist);
              ax += x_diff/dist * acc;
              ay += y_diff/dist * acc;

            }

          }
        }



      }
    }

    vx += ax*h;
    if (vx > MAX_SPEED) {
      vx = MAX_SPEED;
    }
    else if (vx < -MAX_SPEED) {
      vx = -MAX_SPEED;
    }
    vy += ay*h;
    if (vy > MAX_SPEED) {
      vy = MAX_SPEED;
    }
    else if (vy < -MAX_SPEED) {
      vy = -MAX_SPEED;
    }
    x += h*vx + 0.5*ax*h*h;
    y += h*vy + 0.5*ay*h*h;
    update_grid_status();

    return false;

  }




  // v = v0 + h*a
  // x = x0 + v*h + 0.5*a*h*h


}