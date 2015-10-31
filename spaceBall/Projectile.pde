ArrayList<Projectile> projectiles = new ArrayList<Projectile>();
IntList projectilesToRemove = new IntList();
int previousShot = 0;
float projectileSpeed = 7;

void shoot() {
  
  if (frameCount > previousShot) {
    println("wtf");
    if (score>0 && (mouseX != pmouseX || mouseY != pmouseY)) {
      new Projectile(mouseX, mouseY, pmouseX, pmouseY);
      previousShot = frameCount;
      score--;
    }
  }
}

void iterateProjectiles() {
  boolean toRemove;
  for (int i=0; i<projectiles.size(); i++) {
    toRemove = projectiles.get(i).iterate();
    if (toRemove) {
      projectilesToRemove.append(i);
    }
  }
  if (projectilesToRemove.size() > 0) {
    projectiles.remove(projectilesToRemove.get(0));
  }
  projectilesToRemove.clear();
}

class Projectile {
  float x, y, xSpeed, ySpeed;
  
  Projectile(float x, float y, float xDirection, float yDirection) {
    println("new projectile");
    this.x = x;
    this.y = y;
    float normalizer = dist(x, y, xDirection, yDirection);
    this.xSpeed = projectileSpeed*(x-xDirection)/normalizer;
    this.ySpeed = projectileSpeed*(y-yDirection)/normalizer;
    projectiles.add(this);
  }
  
  void remove() {
  }
  
  boolean iterate() {
    println("iterate");
    x += xSpeed;
    y += ySpeed;
    if (x > width || x < 0 || y > height || y < 0) {
      return true;
    }
    else if (isAlienHit(x, y)) {
      return true;
    }
    else {
      fill(255);
      ellipse(x, y, 5, 5);
    }
    return false;
  }
}