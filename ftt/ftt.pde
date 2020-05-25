

int peak_timer = 0;

void setup() {
  size(512, 512, P2D);
  frameRate(100);

  init_ftt();
}

void draw() {
  background(0);
  analyze();

  draw_timespectrum();
  draw_spectrum(spectrum, 0);
  //draw_spectrum(peak_spectrum, 1);
}


void keyPressed() {
  if (keyCode == ' ') {
    saveFrame();
    // println("----------------");
    // compare_to_all_samples();
  }
  else if (keyCode == ENTER) {
    timeline_on = !timeline_on;
  }
  else if (keyCode == 'R') {
    reverse = !reverse;
  }
  else if (keyCode == 'F') {
    flip = !flip;
  }
  else {
    // record_sample("" + key);
  }
}
