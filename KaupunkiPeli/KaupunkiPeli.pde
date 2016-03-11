int valittu_rakennus_tyyppi = 0;

boolean w_painettu = false;
boolean a_painettu = false;
boolean s_painettu = false;
boolean d_painettu = false;
boolean q_painettu = false;
boolean e_painettu = false;
final int kompassin_sade = 15;
final int kompassi_x = 50;
final int kompassi_y = 50;


PVector kursori = new PVector();

// Tilat
final int NORMAALI_TILA = 0;
final int RAKENNUS_TILA = 1;
int tila = NORMAALI_TILA;

void setup() {
    fullScreen(P2D);
    //size(1000, 800, P2D);
    alusta_kartta();
    paivita_kartta();
}

void draw() {
    strokeWeight(2);
    background(200);
    pushMatrix();
    ohjaa_kameraa();
    ratkaise_kursori();
    piirra_kartta();

    popMatrix();

    if (tila == RAKENNUS_TILA) {
        //piirra_ruudukko();
        juuri_katalogi.piirra();
    }

    kompassi();
}


void ratkaise_kursori() {
    kursori = new PVector(mouseX, mouseY);
    kursori.add(new PVector(-kameran_x_siirto, -kameran_y_siirto));
    kursori.add(new PVector(-width/2, -height/2));
    kursori.rotate(-kierto);
    kursori.div(skaalaus);
    kursori.add((new PVector(width/2, height/2)));
}


void keyPressed() {
    // Rakennus tila
    if (key == 'r') {
        if (tila == RAKENNUS_TILA) {
            tila = NORMAALI_TILA;
        }
        else {
            tila = RAKENNUS_TILA;
        }

    }

    // Ohjaus
    else if (key == 'w') {
        w_painettu = true;
    }
    else if (key == 'a') {
        a_painettu = true;
    }
    else if (key == 's') {
        s_painettu = true;
    }
    else if (key == 'd') {
        d_painettu = true;
    }
    else if (key == 'q') {
        q_painettu = true;
    }
    else if (key == 'e') {
        e_painettu = true;
    }

}

void keyReleased() {
    // Ohjaus
    if (key == 'w') {
        w_painettu = false;
    }
    else if (key == 'a') {
        a_painettu = false;
    }
    else if (key == 's') {
        s_painettu = false;
    }
    else if (key == 'd') {
        d_painettu = false;
    }
    else if (key == 'q') {
        q_painettu = false;
    }
    else if (key == 'e') {
        e_painettu = false;
    }
}

void mouseClicked() {
    if (kompassia_klikattu()) {
        kierto = 0;
    }
    else if (tila == RAKENNUS_TILA) {
        if (juuri_katalogi.klikkaus()) {
            valittu_rakennus_tyyppi = juuri_katalogi.aktiivinen_painike.rakennus_tyyppi;
        }
        else {
            rakenna(int(kursori.x/ruutu), int(kursori.y/ruutu), valittu_rakennus_tyyppi);
        }
    }
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  if (e<0) {
    skaalaus = constrain(skaalaus*0.95, 0.1, 5);
  }
  else if (e>0) {
    skaalaus = constrain(skaalaus*1.05, 0.1, 5);
  }
}

boolean kompassia_klikattu() {
    if (dist(mouseX,mouseY,kompassi_x,kompassi_y)<kompassin_sade) {
        return true;
    }
    else {
        return false;
    }
}

void kompassi() {

    translate(kompassi_x,kompassi_y);
    rotate(kierto);
    fill(250);
    stroke(250,100,100);
    ellipse(0, 0, 2*kompassin_sade, 2*kompassin_sade);
    line(0, 0, 0, -kompassin_sade);
}
