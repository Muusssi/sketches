final double h = 0.005;



void setup() {
  fullScreen(P2D);
  generate_particles();
  circular_start();
  frameRate(30);
}

void draw() {
  translate(width/2, height/2);

  background(0);
  text(frameRate, 50, 0);
  draw_particles();
  //text((float)((double)(mouseX - width/2)/(double)width*UNIVERSE_RADIUS), 100, 100);

}


void keyPressed() {
  redraw();
}