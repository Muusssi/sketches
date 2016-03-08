float kameran_x_siirto = 0;
float kameran_y_siirto = 0;
float skaalaus = 1;
float kierto = 0;
boolean kamera_alustettu = false;

final int ruutu = 15;
final int kaupungin_halkaisija = 200;
Rakennus[][] ruudukko = new Rakennus[kaupungin_halkaisija][kaupungin_halkaisija];
ArrayList<Rakennus> rakennukset = new ArrayList<Rakennus>();

final int painike_korkeus = 30;
final int painike_leveys = 70;
final int painike_rako = 10;
RakennusKatalogi juuri_katalogi = alusta_katalogi();


public class KatalogiPainike {
    boolean aktiivinen = false;
    RakennusKatalogi alikatalogi;
    int rakennus_tyyppi = 0;
    int x, y;
    String teksti;

    public KatalogiPainike(int x, int y, String teksti, RakennusKatalogi alikatalogi) {
        this.x = x;
        this.y = y;
        this.teksti = teksti;
    }

    public KatalogiPainike(int x, int y, String teksti, int rakennus) {
        this.x = x;
        this.y = y;
        this.rakennus_tyyppi = rakennus;
        this.teksti = teksti;
    }

    void piirra() {
        if (this.aktiivinen) {
            stroke(100,200,100);
        }
        else {
            stroke(0);
        }
        fill(250);
        rect(x, y, painike_leveys, painike_korkeus);
        fill(0);
        stroke(0);
        text(teksti, x+15, y+15);
    }

    void klikkaus() {
        if (alikatalogi == null) {
            valittu_rakennus_tyyppi = rakennus_tyyppi;
        }
        else {
            alikatalogi.piirra();
        }
    }

}

public class RakennusKatalogi {
    RakennusKatalogi aktiivinen_katalogi = this;
    KatalogiPainike aktiivinen_painike = null;

    ArrayList<KatalogiPainike> katalogi = new ArrayList<KatalogiPainike>();
    int x, y;

    public RakennusKatalogi(int x, int y) {
        this.x = y;
        this.y = y;
    }

    void piirra() {
        for (int i=0; i<katalogi.size(); i++) {
            KatalogiPainike kp = katalogi.get(i);
            kp.piirra();
        }
    }

    boolean klikkaus() {
        if (mouseX < aktiivinen_katalogi.x || mouseX > aktiivinen_katalogi.x+painike_leveys) {
            return false;
        }
        KatalogiPainike painike;
        for (int i=0; i<aktiivinen_katalogi.katalogi.size(); i++) {
            painike = aktiivinen_katalogi.katalogi.get(i);
            if (mouseY < painike.y) {
                continue;
            }
            else if (mouseY < painike.y+painike_korkeus) {
                if (aktiivinen_painike != null) {
                    aktiivinen_painike.aktiivinen = false;
                }
                aktiivinen_painike = painike;
                aktiivinen_painike.aktiivinen = true;
                return true;
            }
        }
        return false;
    }

    void lisaa_katalogiin(int tyyppi, String nimi) {
        katalogi.add(new KatalogiPainike(x, y+(katalogi.size()-1)*(painike_rako+painike_korkeus), nimi, tyyppi));
    }

    void lisaa_alikatalogi(String name) {
        // TODO
    }

}

RakennusKatalogi alusta_katalogi() {
    // Tässä funktiossa määritellään mitä rakennuksia katalogissa on
    RakennusKatalogi katalogi = new RakennusKatalogi(15, 100);
    katalogi.lisaa_katalogiin(1, "Koulu");
    katalogi.lisaa_katalogiin(2, "Sairaala");
    katalogi.lisaa_katalogiin(2, "Sairaala");
    return katalogi;
}

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


// public class RakennusMalli {

//     public RakennusMalli (int leveys, int korkeus, int hinta) {
        
//     }

// }


public void rakenna(int x, int y, int tyyppi) {
    if (x<0 || x>kaupungin_halkaisija || y<0 || y>kaupungin_halkaisija) {
        return;
    }
    println(tyyppi+": "+x+", "+y);
    if (tyyppi == 1) {
        new Rakennus(x, y, 3, 4);
    }
    else if (tyyppi == 2) {
        new Rakennus(x, y, 6, 5);
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
        kameran_y_siirto = constrain(kameran_y_siirto+ruutu*1.5,-kaupungin_halkaisija*ruutu,
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

    translate(kameran_x_siirto, kameran_y_siirto);
    translate(width/2,height/2);
    rotate(kierto);
    scale(skaalaus, skaalaus);
    translate(-width/2,-height/2);
    
}




