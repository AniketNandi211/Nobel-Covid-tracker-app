import 'package:flutter/foundation.dart';



class ChartSeriesDataProvider extends ChangeNotifier {


  int _index = 0;

  void updateDataIndex(int index) {
    _index = index;
    notifyListeners();
  }

  int get index => _index;

}
