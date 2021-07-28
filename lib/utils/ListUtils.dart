
int maxInList(List<int> nums){
  if (nums.isEmpty) return -1;
  int max = nums[0];
  nums.forEach(
          (int num) => {if(num > max) max = num}
  );
  return max;
}


int minInList(List<int> nums){
  if (nums.isEmpty) return -1;
  int min = nums[0];
  nums.forEach(
          (int num) => {if(num < min) min = num}
  );
  return min;
}

int minInLists(List<List<int>> lists){
  if (lists.isEmpty) return -1;
  List<int> values = <int>[];
  lists.forEach((List<int> list) => {
    values.add(minInList(list))
  });
  return minInList(values);
}

int maxInLists(List<List<int>> lists){
  if (lists.isEmpty) return -1;
  List<int> values = <int>[];
  lists.forEach((List<int> list) => {
    values.add(maxInList(list))
  });
  return maxInList(values);
}