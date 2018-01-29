DragTargetti t, p;

void setup() {
    size(400, 400);
    t = new DragTargetti(50, 50, 50);
    p = new DragTargetti(100, 50, 30);
}

void draw() {
  background(100);
  moveTarget();
  t.draw();p.draw();
}

void mousePressed() {
  selectTarget();
}

void mouseReleased() {
  releaseTarget();
}

DragTargetti selectedTarget = null;

ArrayList<DragTargetti> targets = new ArrayList<DragTargetti>();

class DragTargetti {
    float radius, x, y;
    float vy = 0;


    public DragTargetti(int x, int y, int radius) {
        this.x = x;
        this.y = y;
        this.radius = radius;
        targets.add(this);
    }

    void draw() {
      if (selectedTarget != this && y < height-radius) {
        vy += 0.1;
        y += vy;
      }
      else {
        vy = 0;
      }
        rect(x, y, radius, radius);
        //ellipse(x, y, radius*2, radius*2);

    }

    boolean pick() {
      if (mouseX>x && mouseX<x+radius && mouseY>y && mouseY<y+radius) {
        selectedTarget = this;
      }
        return false;
    }

}


void selectTarget() {
  for (int i=0; i<targets.size(); i++) {
     if (targets.get(i).pick()) {
       selectedTarget = targets.get(i);
       return;
     }
  }
}

void moveTarget() {
  if (selectedTarget != null) {
    selectedTarget.x += (mouseX - pmouseX);
    selectedTarget.y += (mouseY - pmouseY);
  }
}

void releaseTarget() {
  if (selectedTarget != null) {
    selectedTarget = null;
  }
}