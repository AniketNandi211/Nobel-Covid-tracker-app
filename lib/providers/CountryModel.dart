import 'package:covid19_tracker/models/Country.dart';
import 'package:covid19_tracker/services/CountryService.dart';

  /// this class should not ber called from UI code
class CountryModel {

  Map<String, Country> countryMap = Map<String, Country>();

  void initializeMap() async {
    List<Country> _countries = List<Country>();
    try {
      List<dynamic> countries = await CountryService.countriesData;
      countries.forEach((countryJson) => _countries.add(
        Country.withJson(countryJson)
      ));
      _countries.forEach((country) => countryMap.addAll({
        country.slug : country
      }));
      print(countryMap);
    } catch (err) {
        print('error : $err');
    }
  }

}