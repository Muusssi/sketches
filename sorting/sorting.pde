boolean sorted = false;
int listSize = 100;
int bubbleIdx, selectIdx;
float[] originalList = new float[listSize];
float[] bubbleList = new float[listSize];
float[] selectionList = new float[listSize];

void setup() {
  size(600,600);
  originalList = new float[listSize];
  for (int i=0; i<originalList.length; i++) {
    originalList[i] = random(100);
  }
  arrayCopy(originalList, bubbleList);
  arrayCopy(originalList, selectionList);
}

void draw() {
  background(200);
  bubbleIdx = bubbleSort(bubbleList);
  selectIdx = selectionSort(selectionList);
  drawList(bubbleList, 1, bubbleIdx);
  drawList(selectionList, 2, selectIdx);
}


void drawList(float[] list, int position, int idx) {
  for (int i=0; i<list.length; i++) {
    if (idx>0 && i == idx) {
      stroke(200,0,0);
    }
    line(2*i+30, position*100-list[i], 2*i+30, position*100);
    stroke(0);
  }
}