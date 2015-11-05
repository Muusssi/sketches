PImage img;
int cellWidth = 3;
int cellHeight = 5;
int charLimit = 200;
int maxColumns = 120;

void setup() {
    noLoop();
    img = loadImage("troll.png");
    reformatText("text.txt");
}

void draw() {}

boolean hasCharacter(int cellx, int celly) {
    float sum = 0;
    for (int i=0; i<cellWidth; i++) {
        for (int j=0; j<cellHeight; j++) {
            int pixel = img.get(cellx*cellWidth+i, celly*cellHeight+j);
            sum += max(red(pixel), green(pixel), blue(pixel));
        }
    }
    if (sum / (cellWidth*cellHeight) < charLimit) {
        return true;
    }
    else {
        return false;
    }
}

void reformatText(String filename) {
    String[] lines = loadStrings(filename);
    String text = "";
    for (int n=0; n < lines.length; n++) {
        text += trim(lines[n]);
    }
    int charIdx = 0;
    String[] newLines = new String[img.height/cellHeight];
    newLines[0] = "";
    for (int j=0; j<img.height/cellHeight; j++) {
      newLines[j] = "";
      for (int i=0; i<min(img.width/cellWidth, maxColumns); i++) {
            if (!hasCharacter(i, j)) {
              if (charIdx >= text.length()) {
                  charIdx = 0;
              }
              if (text.charAt(charIdx) == ' ') {
                newLines[j] += '_';
              }
              else {
                newLines[j] += text.charAt(charIdx);
              }
              charIdx++;
            }
            else {
                newLines[j] += ' ';
            }
        }
    }
    saveStrings("troll"+filename, newLines);
    println("Done");
}