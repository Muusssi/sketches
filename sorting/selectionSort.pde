int selectionSortIndex = 0;
int selectionSmallestIndex = 0;
int currentSelectionIndex = 0;

int selectionSort(float[] list) {
  if (selectionSortIndex == list.length) {
    return -1;
  }
  if (currentSelectionIndex < list.length) {
    if (list[currentSelectionIndex] < list[selectionSmallestIndex]) {
      selectionSmallestIndex = currentSelectionIndex;
    }
    currentSelectionIndex++;
  }
  else {
    float tmp = list[selectionSmallestIndex];
    list[selectionSmallestIndex] = list[selectionSortIndex];
    list[selectionSortIndex] = tmp;
    selectionSortIndex++;
    currentSelectionIndex = selectionSortIndex;
    selectionSmallestIndex = selectionSortIndex;
  }
  return currentSelectionIndex;
}