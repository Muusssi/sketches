public class Rocket {

  boolean corked = true;

  float diameter = 30;
  float length = 100;

  float pressure = 3.0;
  float water = 70.0;

  float x, y;
  float vx = 0;
  float vy = 0;

  Suihke stream;

  public Rocket(int x, int y) {
    this.x = x;
    this.y = y;
    this.stream = new Suihke(0, length/2, 0, 1);
  }

  void move() {
    stream.x = this.x;
    stream.y = this.y + length/2;
    if (!this.corked && this.water > 0) {
      water -= 1;
      vy -= 0.1*pressure;
    }

    if (this.y + length/2 <= height) {
      this.x += vx;
      this.y += vy;
      vy += GRAVITATION;
    }
    else {
      vy = 0;
      y = height - length/2;
    }
  }

  void draw() {
    move();
    pushStyle();
    pushMatrix();
    {
      translate(this.x, this.y);
      rectMode(CENTER);
      fill(200);
      rect(0, 0, diameter, length);
      rectMode(CORNER);
      fill(0, 0, 200);
      rect(-diameter/2, length/2 - length/100.0*water,
          diameter, length/100.0*water);
    }
    popMatrix();
    popStyle();
    if (!this.corked && this.water > 0) {
      stream.piirra(true);
    }
    else {
      stream.piirra(false);
    }


  }

}
