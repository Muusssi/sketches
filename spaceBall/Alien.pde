ArrayList<Alien> aliens = new ArrayList<Alien>();
IntList aliensToRemove = new IntList();
float alienMaxSpeed = 4;
float alienSideBounce = 10;

void iterateAliens() {
  boolean toRemove;
  for (int i=0; i<aliens.size(); i++) {
    toRemove = aliens.get(i).iterate();
    if (toRemove) {
      aliensToRemove.append(i);
    }
  }
  if (aliensToRemove.size() > 0) {
    aliens.remove(aliensToRemove.get(0));
  }
  aliensToRemove.clear();
}

void gameOver() {
  fill(200,0,0);
  text(score, 30, 30);
  textSize(50);
  text("Game Over!", width/2, height/2);
  noLoop();
}

boolean isAlienHit(float x, float y) {
  Alien currentAlien;
  for (int i=0; i<aliens.size(); i++) {
    currentAlien = aliens.get(i);
    if (dist(x,y,currentAlien.x,currentAlien.y) < currentAlien.size/2) {
      currentAlien.health--;
      return true;
    }
  }
  return false;
}

class Alien {
  float x, y;
  float xSpeed = 3;
  float ySpeed = 3;
  float size = 50;
  int health = 3;

  Alien() {
    float side = random(4);
    if (side < 1) {
      x = 0;
      y = random(height);
    }
    else if (side < 2) {
      x = width;
      y = random(height);
    }
    else if (side < 3) {
      x = random(width);
      y = 0;
    }
    else {
      x = random(width);
      y = height;
    }
    aliens.add(this);
  }

  boolean iterate() {
    if (health < 1) {
      return true;
    }
    xSpeed = constrain(xSpeed+random(-1,1), -alienMaxSpeed, alienMaxSpeed);
    ySpeed = constrain(ySpeed+random(-1,1), -alienMaxSpeed, alienMaxSpeed);
    x = constrain(x+xSpeed, 0, width);
    y = constrain(y+ySpeed, 0, height);
    if (x < alienSideBounce) {
      xSpeed += 1;
    }
    else if (x > width-alienSideBounce) {
      xSpeed -= 1;
    }
    if (y < alienSideBounce) {
      ySpeed += 1;
    }
    else if (y > height-alienSideBounce) {
      ySpeed -= 1;
    }
    this.draw();
    if (touches_player()) {
      gameOver();
    }
    return false;
  }

  void draw() {
    pushStyle();
    fill(50,map(health, 0, 3, 50, 250),50);
    ellipse(x, y, size, size);
    popStyle();
  }

  boolean touches_player() {
    return dist(player_x, player_y, x, y) < (size/2 + player_size/2);
  }

}

public class RectAlien extends Alien {

  public RectAlien () {
    super();
    this.health = 10;
  }

  void draw() {
    pushStyle();
    fill(map(health, 0, 3, 50, 250),50,50);
    rect(x - size/2, y - size/2, size, size);
  }

}
