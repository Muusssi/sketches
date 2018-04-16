final float GRAVITATION = 0.1;
Rocket rocket;


void setup() {
  fullScreen(P2D);
  rocket = new Rocket(width/2, height - 50);
  //rocket.draw();
}

void draw() {
  background(200);
  // rocket.x = mouseX;
  // rocket.y = mouseY;
  rocket.draw();
  text(rocket.vy, 100, 100);
}

void mousePressed() {
  rocket.corked = false;
}

void keyPressed() {
  rocket.water = 50;
  rocket.corked = true;
}

