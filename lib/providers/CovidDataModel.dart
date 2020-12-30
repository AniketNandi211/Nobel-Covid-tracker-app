import 'package:covid19_tracker/models/CountryCovidData.dart';
import 'package:covid19_tracker/models/Fails.dart';
import 'package:covid19_tracker/models/GlobalCovidData.dart';
import 'package:covid19_tracker/services/CovidService.dart';
import 'package:flutter/foundation.dart';

/// keeps track of Countries' covid data state
enum CountriesCovidDataState {
  working, ready
}
/// keeps track of Global covid data state
enum GlobalCovidDataState {
  working, ready
}
/// keeps track of an individual Country covid data state
enum CountryCovidDataState {
  working, ready
}

class CovidDataModel extends ChangeNotifier {

      /// for debugging purposes
  bool _debug = true;

      // for maintaining state
  CountriesCovidDataState _countriesCovidDataState = CountriesCovidDataState.working;
  GlobalCovidDataState _globalCovidDataState = GlobalCovidDataState.working;
  CountryCovidDataState _countryCovidDataState = CountryCovidDataState.working;
      // data(s)
  GlobalCovidData _globalCovidData;
  List<CountryCovidData> _countriesCovidDataList;
  CountryCovidData _countryCovidData;
  Fails _fails;

  // getters
      // for maintaining state
  bool get isCountriesCovidDataReady =>
      _countriesCovidDataState == CountriesCovidDataState.ready;
  bool get isGlobalCovidDataReady =>
      _globalCovidDataState == GlobalCovidDataState.ready;
  bool get isCountryCovidDataReady =>
      _countryCovidDataState == CountryCovidDataState.ready;
      // data(s)
  GlobalCovidData get globalCovidData => _globalCovidData;
  CountryCovidData get countryCovidData => _countryCovidData;
  List<CountryCovidData> get countriesCovidDataList => _countriesCovidDataList;
  Fails get fail => _fails;


  // setters
  void _setCountriesCovidDataState(CountriesCovidDataState currentState) {
    _countriesCovidDataState = currentState;
    notifyListeners();
  }

  void _setGlobalCovidDataState(GlobalCovidDataState currentState) {
    _globalCovidDataState = currentState;
    notifyListeners();
  }

  void _setCountryCovidDataState(CountryCovidDataState currentState) {
    _countryCovidDataState = currentState;
    notifyListeners();
  }


  void _setGlobalCovidData(GlobalCovidData globalCovidData) {
    _globalCovidData = globalCovidData;
    notifyListeners();
  }

  void _setCountriesCovidData(List<CountryCovidData> countriesCovidData) {
    _countriesCovidDataList = countriesCovidData;
  }

  void _setCountryCovidData(CountryCovidData countryCovidData) {
    _countryCovidData = countryCovidData;
  }

  void _setFails(Fails fails) {
    _fails = fails;
    notifyListeners();
  }

  // data getters through CovidService

  // ignore: missing_return
  Future<GlobalCovidData> _globalData() async {
    _fails = null;
    try {
      //_setGlobalCovidDataState(GlobalCovidDataState.working);
      Map<String, dynamic> globalData = await CovidService.globalCovidData;
      return GlobalCovidData.withJson(globalData);
    } on Fails catch(fail) {
      _setFails(fail);
      if(_debug) print('From GlobalCovidDataModel Fails : ${fail.codeName} $fail');
    } catch (e) {
      _setFails(Fails.generateFail(FailsType.Unknown)..info = e.toString());
      if(_debug) print('From GlobalCovidDataModel error : $e');
    }
  }

  Future<void> fetchGlobalData() async {
    _setGlobalCovidData(await _globalData());
    _setGlobalCovidDataState(GlobalCovidDataState.ready);
  }

  Future<void> refreshGlobalData() async {
    _setGlobalCovidDataState(GlobalCovidDataState.working);
    _setGlobalCovidData(await _globalData());
    _setGlobalCovidDataState(GlobalCovidDataState.ready);
  }


  // ignore: missing_return
  Future<List<CountryCovidData>> _countriesData() async {
    List<CountryCovidData> countriesCovidDataList = <CountryCovidData>[];
    _fails = null;
    try {
      List<dynamic> countriesJsonList = await CovidService.countriesCovidData;
      countriesJsonList.forEach((countryCovidJson) {
        countriesCovidDataList.add(CountryCovidData.withJson(countryCovidJson));
      });
      return countriesCovidDataList;
    } on Fails catch(fail) {
      _setFails(fail);
      if(_debug) print('From CovidDataModel Fails : ${fail.codeName} $fail');
    } catch (e) {
      _setFails(Fails.generateFail(FailsType.Unknown)..info = e.toString());
      if(_debug) print('From CovidDataModel error : $e');
    }
  }

  Future<void> fetchCountriesData() async {
    _setCountriesCovidData(await _countriesData());
    _setCountriesCovidDataState(CountriesCovidDataState.ready);
  }

  Future<void> refreshCountriesData() async {
    _setCountriesCovidDataState(CountriesCovidDataState.working);
    _setCountriesCovidData(await _countriesData());
    _setCountriesCovidDataState(CountriesCovidDataState.ready);
  }

  // ignore: missing_return
  Future<CountryCovidData> _countryData() async {
    _fails = null;
    try {
      Map<String, dynamic> countryCovidData = await CovidService.getCountryCovidData('india');
      return CountryCovidData.withJson(countryCovidData);
    } on Fails catch(fail) {
      _setFails(fail);
      if(_debug) print('From CovidDataModel Fails : ${fail.codeName} $fail');
    } catch (e) {
      _setFails(Fails.generateFail(FailsType.Unknown)..info = e.toString());
      if(_debug) print('From CovidDataModel error : $e');
    }
  }

  Future<void> fetchCountryData() async {
    _setCountryCovidData(await _countryData());
    _setCountryCovidDataState(CountryCovidDataState.ready);
  }

  Future<void> refreshCountryData() async {
    _setCountryCovidDataState(CountryCovidDataState.working);
    _setCountryCovidData(await _countryData());
    _setCountryCovidDataState(CountryCovidDataState.ready);
  }

}
