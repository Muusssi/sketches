String sana = "ohjelmointikerholainen";
String arvattu = "";
String arvatut_kirjaimet = "";
int sallitut_arvaukset = 10;

void setup() {
  size(800,400);
  textSize(30);
  for (int i=0; i<sana.length(); i++) {
    if (sana.charAt(i) == ' ') {
      arvattu += ' ';
    }
    else {
      arvattu += '_';
    }
  }
  //piirra_sana();
  
}

void draw() {
  background(200);
  piirra_sana();
  piirra_arvatut_kirjaimet();
  piirra_hirsipuu(10-sallitut_arvaukset);
  // Voitto ehto
  if (arvattu.indexOf('_') == -1) {
    text("OIKEIN!", 50, 100);
    noLoop();
  }
  if (sallitut_arvaukset == 0) {
    text("HÄVISIT", 50, 100);
    text(sana, 50, 150);
    noLoop();
  }
}

void keyPressed() {
  arvaa(key);
}

void arvaa(char kirjain) {
  boolean oikein = false;
  String uusi_arvattu = "";
  for (int i=0; i<sana.length(); i++) {
    if (sana.charAt(i) == kirjain) {
      oikein = true;
      uusi_arvattu += kirjain;
    }
    else {
      uusi_arvattu += arvattu.charAt(i);
    }
  }
  if (!oikein) {
    sallitut_arvaukset--;
    arvatut_kirjaimet += kirjain;
  }
  arvattu = uusi_arvattu;
}

void piirra_sana() {
  text(arvattu, 50, 50);
}

void piirra_arvatut_kirjaimet() {
  text("Väärät arvaukset:", 250, 200);
  text(arvatut_kirjaimet, 250, 250);
}

void piirra_hirsipuu(int vaihe) {
  if (vaihe > 0) {
    // pystypuu
    line(50, 400, 50, 200);
  }
  if (vaihe > 1) {
    // oikea tuki
    line(50, 350, 100, 400);
  }
  if (vaihe > 2) {
    //vasen tuki
    line(50, 350, 0, 400);
  }
  if (vaihe > 3) {
    // poikkipuun tuki
    line(50, 250, 100, 200);
  }
  if (vaihe > 4) {
    // poikkipuu
    line(50,200, 200, 200);
  }
  if (vaihe > 5) {
    // köysi
    line(200,200, 200, 250);
  }
  if (vaihe > 6) {
    // silmukka/pää
    fill(200);
    ellipse(200,250, 30, 30);
    fill(255);
  }
  if (vaihe > 7 && vaihe < 10) {
    // lava
    line(175,350, 225, 350);
    line(175,350, 175, 400);
    line(225,400, 225, 350);
  }
  if (vaihe > 8) {
    // ukkeli
    line(200, 265, 200, 300);// vartalo
    line(200, 300, 220, 350);// vasen jalka
    line(200, 300, 180, 350);// oikea jalka
    line(200, 265, 220, 300);// vasen käsi
    line(200, 265, 180, 300);// oikea käsi
  }
  if (vaihe > 9) {
    // kuoli
    ellipse(200, 250+5, 30, 30);// pää
    line(200, 265+5, 200, 300+5);// vartalo
    line(200, 300+5, 220, 350+5);// vasen jalka
    line(200, 300+5, 180, 350+5);// oikea jalka
    line(200, 265+5, 220, 300+5);// vasen käsi
    line(200, 265+5, 180, 300+5);// oikea käsi
  }
  
}