import java.util.Iterator;
//2560 x 1600
//final int WORLD_WIDTH = 1200;
//final int WORLD_HEIGHT = 800;
final int WORLD_WIDTH = 500;
final int WORLD_HEIGHT = 300;

int view = 0;
boolean iterate = true;


float[][] nut_grid;
Organism[][] org_grid;


Organism mother, father;


PGraphics org_layer;
PGraphics nutrion_layer;
PGraphics energy_layer;


int cycle = 0;
int layers_updated = -1;


void setup() {
  //2560 x 1600
  //size(1000, 1000);
  fullScreen(P2D);
  init_world();
  frameRate(100);

}

void draw() {
  if (view == 0) {
    draw_org_grid();
  }
  else if (view == 1) {
    draw_nut_grid();
  }
  else if (view == 2) {
    draw_energy_grid();
  }
  if (iterate) {
    iterate();
  }
  text(frameRate, 50, 50);
  text(organisms.size(), 50, 80);

}

void keyPressed() {
  if (keyCode == 32) {
    iterate = !iterate;
  }
  if (key == 'o') {
    view = 0;
  }
  else if (key == 'n') {
    view = 1;
  }
  else if (key == 'e') {
    view = 2;
  }

}

final int brush_size = 3;
void mousePressed() {
  int x = int(mouseX*(float(WORLD_WIDTH)/float(width)));
  int y = int(mouseY*(float(WORLD_HEIGHT)/float(height)));
  if (x - brush_size > 0 && x + brush_size < WORLD_WIDTH
      && y - brush_size > 0 && y + brush_size < WORLD_HEIGHT) {
    for (int i = -brush_size; i < brush_size; ++i) {
      for (int j = -brush_size; j < brush_size; ++j) {
        nut_grid[x+i][y+j] += 100;
      }
    }
  }
}



void iterate() {

  for (int i = organisms.size() - 1; i >= 0; i--) {
    Organism org = organisms.get(i);
    org.live();
  }
  cycle++;

}


void init_world() {
  org_layer = createGraphics(WORLD_WIDTH, WORLD_HEIGHT);
  org_layer.beginDraw();
  org_layer.background(0, 0);
  org_layer.endDraw();

  nutrion_layer = createGraphics(WORLD_WIDTH, WORLD_HEIGHT);
  nutrion_layer.beginDraw();
  nutrion_layer.background(0, 0);
  nutrion_layer.endDraw();

  energy_layer = createGraphics(WORLD_WIDTH, WORLD_HEIGHT);
  energy_layer.beginDraw();
  energy_layer.background(0, 0);
  energy_layer.endDraw();





  org_grid = new Organism[WORLD_WIDTH][WORLD_HEIGHT];
  nut_grid = new float[WORLD_WIDTH][WORLD_HEIGHT];
  for (int i = 0; i < WORLD_WIDTH; i++) {
    for (int j = 0; j < WORLD_HEIGHT; ++j) {
      if (true || (j%50 > 5 && i%50 > 5)) {
        //nut_grid[i][j] = random(50, 70);
        if (random(1.0) < 0.001 && (true || (j < 200 && j > 100))) {
          //org_grid[i][j] = new Organism(i, j);
          org_grid[i][j] = new Organism(i, j, 100, 100, 100);
          nut_grid[i][j] = 100;
        }

        if (true && (false || i < WORLD_WIDTH/3)) {
          nut_grid[i][j] = random(50, 100);
        }
        else {
          float nut = random(-2, 2);
          nut_grid[i][j] = constrain((nut*nut*nut*nut*nut*nut*nut*nut*nut*nut), 0, 300);
        }
      }

    }
  }

  // nut_grid[200][100] = 200;
  // nut_grid[300][100] = 200;
  // nut_grid[200][200] = 200;
  // nut_grid[300][200] = 200;
  // new Organism(200, 100, 150, 50, 50);
  // new Organism(300, 100, 50, 150, 50);
  // new Organism(300, 200, 50, 50, 150);
  // new Organism(200, 200, 50, 50, 50);

}


void draw_org_grid() {
  if (layers_updated < cycle) {
    org_layer.loadPixels();
    for (int i = 0; i < WORLD_WIDTH; i++) {
      for (int j = 0; j < WORLD_HEIGHT; ++j) {
        Organism organism = org_grid[i][j];
        if (organism != null) {
          org_layer.pixels[j*WORLD_WIDTH+i] = color(organism.r, organism.g, organism.b);
        }
        else {
          org_layer.pixels[j*WORLD_WIDTH+i] = color(0);
        }
      }
    }
    org_layer.updatePixels();
    layers_updated = cycle;
  }
  image(org_layer, 0, 0, width, height);
}

void draw_energy_grid() {
  if (layers_updated < cycle) {
    energy_layer.loadPixels();
    for (int i = 0; i < WORLD_WIDTH; i++) {
      for (int j = 0; j < WORLD_HEIGHT; ++j) {
        Organism organism = org_grid[i][j];
        if (organism != null) {
          energy_layer.pixels[j*WORLD_WIDTH+i] = color(organism.energy, 0, 0);
        }
        else {
          energy_layer.pixels[j*WORLD_WIDTH+i] = color(0);
        }
      }
    }
    energy_layer.updatePixels();
    layers_updated = cycle;
  }
  image(energy_layer, 0, 0, width, height);
}


void draw_nut_grid() {
  if (layers_updated < cycle) {
    nutrion_layer.loadPixels();
    for (int i = 0; i < WORLD_WIDTH; i++) {
      for (int j = 0; j < WORLD_HEIGHT; ++j) {
        nutrion_layer.pixels[j*WORLD_WIDTH+i] = color(nut_grid[i][j], 0, 0);
      }
    }
    nutrion_layer.updatePixels();
    layers_updated = cycle;
  }
  image(nutrion_layer, 0, 0, width, height);
}


