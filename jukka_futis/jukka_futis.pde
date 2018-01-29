int BOARD_WIDTH, BOARD_HEIGHT;
final int BORDER = 50;
final int BALL_RADIUS = 15;
final float MOVING_BOUNDARY = 0.2;
final float SLOWING_COEFFICIENT = 0.995;
final int ITERATIONS = 5;
final int NAIL_RADIUS = 5;

PGraphics pitch;

boolean ball_moving = false;
boolean player1_turn = true;


ArrayList<Nail> nails = new ArrayList<Nail>();



float ball_x, ball_y, ball_vx, ball_vy;

void setup() {
    size(600, 900);
    //fullScreen();
    BOARD_WIDTH = width - 2*BORDER;
    BOARD_HEIGHT = height - 2*BORDER;
    init_pitch(BOARD_WIDTH, BOARD_HEIGHT);
    init_ball();

}

void draw() {
    background(100);
    if (abs(ball_vx)<MOVING_BOUNDARY && abs(ball_vy)<MOVING_BOUNDARY) {
        ball_moving = false;
        ball_vx = 0;
        ball_vy = 0;
    }
    if (ball_moving) {
        ellipse(25, 25, 50, 50);
    }

    if (!ball_moving && abs(mouseY - ball_y) <= BALL_RADIUS && abs(mouseX - ball_x) <= BALL_RADIUS) {
        kick_ball();
    }
    image(pitch, BORDER, BORDER);
    fill(200);
    ellipse(ball_x, ball_y, 30, 30);
    for (int n = 0; n < ITERATIONS; ++n) {
      ball_x += ball_vx/float(ITERATIONS);
      ball_vx = ball_vx*SLOWING_COEFFICIENT;
      ball_y += ball_vy/float(ITERATIONS);
      ball_vy = ball_vy*SLOWING_COEFFICIENT;
      if (ball_y >= height-BALL_RADIUS-BORDER || ball_y <= BALL_RADIUS+BORDER) {
          ball_vy = -ball_vy;
      }
      if (ball_x >= width-BALL_RADIUS-BORDER || ball_x <= BALL_RADIUS+BORDER) {
          ball_vx = -ball_vx;
      }
      for (int i = 0; i < nails.size(); ++i) {
        nails.get(i).hit();
      }
    }

}

void init_pitch(int board_width, int board_height) {
  new Nail(300, 300);
  pitch = createGraphics(board_width+1, board_height+1);
  pitch.beginDraw();
  //pitch.strokeWeight(100);
  pitch.fill(0, 200, 0);
  pitch.rect(0, 0, board_width, board_height);
  pitch.stroke(255);

  pitch.fill(255);
  pitch.ellipse(board_width/2, board_height/2, 10, 10);
  pitch.noFill();
  pitch.strokeWeight(5);
  pitch.line(0, board_height/2, board_width, board_height/2); // Middle line
  pitch.ellipse(board_width/2, board_height/2, board_width/4, board_width/4);

  for (int i = 0; i < nails.size(); ++i) {
    nails.get(i).draw(pitch);
  }

  pitch.endDraw();


}

void init_ball() {
    ball_x = width/2;
    ball_y = height/2;
    ball_vx = 0;
    ball_vy = 0;
}

void kick_ball() {
    if (pmouseX != mouseX || pmouseY != mouseY) {
        ball_moving = true;
        ball_vx = mouseX-pmouseX;
        ball_vy = mouseY-pmouseY;
    }
}

void keyPressed() {
    kick_ball();
}

public class Nail {
    float x, y;

    public Nail (float x, float y) {
        this.x = x;
        this.y = y;
        nails.add(this);
    }

    public void draw(PGraphics pitch) {
      pitch.stroke(0);
      pitch.ellipse(x, y, NAIL_RADIUS*2, NAIL_RADIUS*2);
    }

    public boolean hit() {
        if (distance_to_ball(x, y) < BALL_RADIUS) {
            float ball_speed = sqrt(sq(ball_vx)+sq(ball_vy));
            float x_dir = (x - ball_x)/sqrt(sq(ball_x-x)+sq(ball_y-y));
            float y_dir = (y - ball_y)/sqrt(sq(ball_x-x)+sq(ball_y-y));
            ball_vx = x_dir * ball_speed;
            ball_vy = y_dir * ball_speed;
            return true;
        }
        return false;
    }

}



public float distance_to_ball(float x, float y) {
    return dist(x, y, ball_x, ball_y);
}