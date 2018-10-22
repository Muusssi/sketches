ArrayList<Projectile> projectiles = new ArrayList<Projectile>();
IntList projectilesToRemove = new IntList();
int previousShot = 0;
float projectileSpeed = 7;

void shoot() {
  new Projectile(player_x, player_y, mouseX, mouseY);
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
    this.x = x;
    this.y = y;
    float normalizer = dist(x, y, xDirection, yDirection);
    this.xSpeed = projectileSpeed*(xDirection - x)/normalizer;
    this.ySpeed = projectileSpeed*(yDirection - y)/normalizer;
    projectiles.add(this);
  }

  boolean iterate() {
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