int currentBubbleIndex = 0;
boolean mixedOrderings = false;
int bubbleIterations = 1;

int bubbleSort(float[] list) {
  float tmp;
  if (currentBubbleIndex == list.length-bubbleIterations) {
    if (mixedOrderings == false) {
      return -1;
    }
    currentBubbleIndex = 0;
    bubbleIterations++;
    mixedOrderings = false;
  }
  if (list[currentBubbleIndex] > list[currentBubbleIndex+1]) {
    tmp = list[currentBubbleIndex];
    list[currentBubbleIndex] = list[currentBubbleIndex+1];
    list[currentBubbleIndex+1] = tmp;
    mixedOrderings = true;
  }
  currentBubbleIndex++;
  return currentBubbleIndex;
}