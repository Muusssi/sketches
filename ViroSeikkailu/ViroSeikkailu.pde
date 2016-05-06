boolean vasen_painettu = false;
boolean oikea_painettu = false;
boolean ylos_painettu = false;
boolean alas_painettu = false;



final int SHIP = 1;
Tasohyppelyhahmo emma, customs;

final int BUFFET = 2;
final int TOWER = 3;
final int WASH = 4;
final int LADYBIRD = 5;
final int PRISON = 6;
final int CLIMB = 7;
final int MEGAZONE = 8;
float megax, megay;

int stage = MEGAZONE;

void setup() {
  size(1200, 800, P2D);
  // fullScreen(P2D);

  // for Ship
  maailman_leveys = 10000;
  maailman_korkeus = 1200;
  make_ship();

  emma = new Tasohyppelyhahmo(loadImage("kuvat/kana.png"));
  //emma.aseta(40, 100);
  emma.aseta(900, 400);

  customs = new Tasohyppelyhahmo(loadImage("kuvat/ninja.png"));
  customs.aseta(750, 100);

  // for megazone
  megax = width/2;
  megay = height-50;
}

void draw() {
  switch (stage) {
    case SHIP:
      background(200);
      emma.seuraa_kameralla();

      emma.piirra();
      customs.piirra();
      customs.liiku_itsestaan(100, 750);
      if (customs.koskee(emma)) {
        customs.tyonna(emma);
      }

      piirra_tasot();
      piirra_seinat();
      check_water();

      if (vasen_painettu) {
        emma.liiku_vasemmalle();
      }
      else if (oikea_painettu) {
        emma.liiku_oikealle();
      }
      println(mouse_x(), mouse_y());

    case MEGAZONE:
      background(10);
      ellipse(megax, megay, 30, 30);
      if (vasen_painettu) {
        println("vasen");
        megax -= 3;
      }
      if (oikea_painettu) {
        println("oikea");
        megax += 3;
      }
      if (ylos_painettu) {
        println("ylos");
        megay -= 3;
      }
      if (alas_painettu) {
        megay += 3;
      }

  }
}

void keyPressed() {
  // general controls
  switch (key) {
    case 'w':
      ylos_painettu = true;
    case 'a':
      vasen_painettu = true;
    case 's':
      alas_painettu = true;
    case 'd':
      oikea_painettu = true;
  }
  // stage specific controls
  switch (stage) {
    case SHIP: {
      if (key == 'w') {
        emma.hyppy();
      }
    }
  }

}

void keyReleased() {
  // general controls
  switch (key) {
    case 'w':
      ylos_painettu = false;
    case 'a':
      vasen_painettu = false;
    case 's':
      alas_painettu = false;
    case 'd':
      oikea_painettu = false;
  }
  // stage specific controls
  switch (stage) {


  }

}

void check_water() {
  if (emma.x >= 800 && emma.x+emma.kuva.width/2 <= 1200 && emma.y < 10) {
    noLoop();
  }
}

ArrayList<Taso> ship_levels = new ArrayList<Taso>();
ArrayList<Seina> ship_walls = new ArrayList<Seina>();
void make_ship() {
  ship_levels.add(new Taso(0, 100, 800));//laituri
  ship_walls.add(new Seina(800, 0, 100));
  //vesi
  Taso water = new Taso(800, 5, 400);
  water.vari = color(0, 0, 200);
  ship_levels.add(water);

  ship_levels.add(new Taso(400, 150, 100));
  ship_levels.add(new Taso(500, 200, 100));
  ship_levels.add(new Taso(600, 250, 100));
  ship_levels.add(new Taso(700, 300, 100));
  ship_levels.add(new Taso(800, 350, 400));//Silta
  ship_walls.add(new Seina(1200, 0, 350));

  ship_levels.add(new Taso(1200, 100, 1000));//kansi 1
  ship_levels.add(new Taso(1300, 200, 1000));//kansi 2
  ship_levels.add(new Taso(1200, 300, 1000));//kansi 3

}





