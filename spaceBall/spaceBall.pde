int score = 0;


void setup() {
  size(1200, 800);
  background(0);
  textSize(20); 
  new Alien();
}

void draw() {
  background(0);
  text(score, 30, 30); 
  fill(100);
  ellipse(mouseX, mouseY, 30, 30);
  iterateProjectiles();
  iterateAliens();
  score++;
  if (frameCount % 100 == 0) {
    new Alien();
  }
}


void keyPressed() {
  if (keyCode == 32) {
    shoot();
  }
}