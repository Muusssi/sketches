import java.util.LinkedList;
float speed_of_sound = 10;
float period = 5;

LinkedList<Float> centers_x = new LinkedList<Float>();
LinkedList<Float> centers_y = new LinkedList<Float>();
LinkedList<Float> radii = new LinkedList<Float>();

float screen_diameter;
float theta = 0.0;
float rotation_diameter = 400;

boolean cursor = false;

void setup() {
  //size(800, 600);
  fullScreen(P2D);
  noFill();
  screen_diameter = dist(0, 0, width, height);

}

void draw() {
  background(200);

  if (frameCount % period == 0) {
    new_wave();
  }
  if (!cursor) {
    ellipse(width/2, height/2, rotation_diameter*2, rotation_diameter*2);
  }
  iterate_waves();
}

void new_wave() {
  if (cursor) {
    centers_x.addFirst((float)mouseX);
    centers_y.addFirst((float)mouseY);
  }
  else {
    theta += 0.1;
    centers_x.addFirst(width/2 + cos(theta)*rotation_diameter);
    centers_y.addFirst(height/2 + sin(theta)*rotation_diameter);
  }

  radii.addFirst(1.0);
}

void iterate_waves() {
  if (radii.size() > 0) {
    for (int i = radii.size() - 1; i >= 0 ; i--) {
      float new_radius = radii.get(i) + speed_of_sound;
      radii.set(i, new_radius);
      ellipse(centers_x.get(i), centers_y.get(i), new_radius, new_radius);
    }
    if (radii.getLast() >= 2*screen_diameter) {
      radii.removeLast();
      centers_x.removeLast();
      centers_y.removeLast();
    }
  }
}

void mousePressed() {
  if (cursor) {
    cursor = false;
  }
  else {
    cursor = true;
  }
}

void keyPressed() {
  if (key == 'c') {
    speed_of_sound = speed_of_sound*1.1;
  }
  else if (key == 'v') {
    speed_of_sound = speed_of_sound*0.9;
  }
  else if (key == 'm') {
    period += 1;
  }
  else if (key == 'n') {
    period -= 1;
  }
}