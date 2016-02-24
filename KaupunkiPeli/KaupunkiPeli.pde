int tila = 0;
boolean w_painettu = false;
boolean a_painettu = false;
boolean s_painettu = false;
boolean d_painettu = false;
boolean q_painettu = false;
boolean e_painettu = false;

void setup() {
    size(1000, 800, P2D);
    rakenna(20,10,1);
    rakenna(30,100,1);
}

void draw() {
    strokeWeight(2);
    background(200);
    pushMatrix();
    
    ohjaa_kameraa();
    piirra_pohja();
    pirra_rakennukset();

    if (tila == 1) {
        //piirra_ruudukko();
        kursori();
    }
    popMatrix();
    kompassi();
}


// translate(width/2,height/2);
//     rotate(kierto);
//     scale(skaalaus, skaalaus);
//     translate(-width/2,-height/2);
//     translate(kameran_x_siirto, kameran_y_siirto);

void kursori() {
    PVector kursori = new PVector(mouseX, mouseY);
    kursori.add(new PVector(-kameran_x_siirto, -kameran_y_siirto));
    kursori.add(new PVector(width/2, height/2));
    kursori.div(skaalaus);
    kursori.rotate(-kierto);
    kursori.add(new PVector(-width/2, -height/2));
    println(kursori.div(ruutu));
    //ellipse(kursori.x/ruutu, kursori.y, 10, 10);
}


void keyPressed() {
    // Rakennus tila
    if (key == 'r') {
        tila = 1;
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
    if (dist(mouseX,mouseY,50,50)<15) {
        kierto = 0;
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

void kompassi() {
    translate(50,50);
    rotate(kierto);
    fill(250);
    stroke(250,100,100);
    ellipse(0, 0, 30, 30);
    line(0, 0, 0, -15);
}
