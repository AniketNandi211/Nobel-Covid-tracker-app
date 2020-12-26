import 'package:covid19_tracker/models/CountryCovidData.dart';
import 'package:covid19_tracker/models/Fails.dart';
import 'package:covid19_tracker/models/GlobalCovidData.dart';
import 'package:covid19_tracker/services/CovidService.dart';
import 'package:flutter/foundation.dart';

enum CovidDataModelState {
  working, ready
}

class CovidDataModel extends ChangeNotifier {

  CovidDataModelState _state = CovidDataModelState.working;
  GlobalCovidData _globalCovidData;
  List<CountryCovidData> _countriesCovidDataList;
  Fails _fails;

  // getters
  CovidDataModelState get covidDataModelState => _state;
  GlobalCovidData get globalCovidData => _globalCovidData;
  List<CountryCovidData> get countriesCovidDataList => _countriesCovidDataList;
  Fails get fail => _fails;


  // setters
  void _setState(CovidDataModelState state) {
    _state = state;
    notifyListeners();
  }

  void _setGlobalData(GlobalCovidData globalCovidData) {
    _globalCovidData = globalCovidData;
    // notifyListeners();
  }

  void _setFails(Fails fails) {
    _fails = fails;
    notifyListeners();
  }

  Future<void> get globalData async {
    _setState(CovidDataModelState.working);
    _fails = null;
    try {
      Map<String, dynamic> globalData = await CovidService.globalCovidData;
      _setGlobalData(GlobalCovidData.withJson(globalData));
      _setState(CovidDataModelState.ready);
    } on Fails catch(fail) {
      _setFails(fail);
    } catch (e) {
      _setFails(Fails.generateFail(FailsType.Unknown)..info = e.toString());
    }
  }

}
