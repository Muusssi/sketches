float kameran_x_siirto = 0;
float kameran_y_siirto = 0;
float skaalaus = 1;
float kierto = 0;
boolean kamera_alustettu = false;

final int ruutu = 15;
final int kaupungin_halkaisija = 200;
Rakennus[][] ruudukko = new Rakennus[kaupungin_halkaisija][kaupungin_halkaisija];
ArrayList<Rakennus> rakennukset = new ArrayList<Rakennus>();


public class Rakennus {
    int x, y;
    int leveys, pituus;
    color vari = color(200, 250, 100);

    public Rakennus(int x, int y, int leveys, int pituus) {
        this.x = x;
        this.y = y;
        this.leveys = leveys;
        this.pituus = pituus;
        rakennukset.add(this);
    }

    void piirra() {
        fill(vari);
        rect(x*ruutu, y*ruutu, leveys*ruutu, pituus*ruutu);
    }

}

public void pirra_rakennukset() {
    for (int i=0; i<rakennukset.size(); i++) {
        rakennukset.get(i).piirra();
    }
}


public void rakenna(int x, int y, int tyyppi) {
    if (tyyppi == 1) {
        new Rakennus(x, y, 3, 4);
    }

}

public void piirra_ruudukko() {
    for (int i=0; i<kaupungin_halkaisija; i++) {
        for (int j=0; j<kaupungin_halkaisija; j++) {
            //stroke(100, 100, 100);
            line(0, j*ruutu, kaupungin_halkaisija*ruutu, j*ruutu);
            line(i*ruutu, 0, i*ruutu, kaupungin_halkaisija*ruutu);
        }   
    }
}

public void piirra_pohja() {
    fill(100,255,100);
    stroke(250);
    rect(0, 0, kaupungin_halkaisija*ruutu, kaupungin_halkaisija*ruutu);
}

void alusta_kamera() {
    pushMatrix();
    scale(1,1);
    kamera_alustettu = true;
}

void ohjaa_kameraa() {
    if (!kamera_alustettu) {
        alusta_kamera();
    }
    if (w_painettu) {
        kameran_y_siirto = constrain(
            kameran_y_siirto+ruutu*1.5,
            -kaupungin_halkaisija*ruutu,
            kaupungin_halkaisija*ruutu);
    }
    else if (s_painettu) {
        kameran_y_siirto -= ruutu*1.5;
    }
    if (a_painettu) {
        kameran_x_siirto += ruutu*1.5;
    }
    else if (d_painettu) {
        kameran_x_siirto -= ruutu*1.5;
    }
    if (q_painettu) {
        kierto = constrain(kierto+0.05, -PI, PI);
    }
    else if (e_painettu) {
        kierto = constrain(kierto-0.05, -PI, PI);
    }

    translate(width/2,height/2);
    rotate(kierto);
    scale(skaalaus, skaalaus);
    translate(-width/2,-height/2);
    translate(kameran_x_siirto, kameran_y_siirto);

}




