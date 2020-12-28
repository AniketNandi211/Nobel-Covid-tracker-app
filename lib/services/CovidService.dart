import 'package:http/http.dart' as http;
import 'dart:convert';

/// Data(s) are fetched from NovelCOVID API (github.com/NovelCOVID/API)

class CovidService {

  static final String _baseGlobalDataUrl = 'https://corona.lmao.ninja/v2/all';
  static final String _baseAllCountryDataUrl = 'https://corona.lmao.ninja/v2/countries?sort=country';
  static final String _baseDataByCountry = 'https://corona.lmao.ninja/v2/countries/';

  CovidService._privateConstructor();

  static Future<Map<String, dynamic>> get globalCovidData async {
    http.Response data = await http.get(_baseGlobalDataUrl);
    Map<String, dynamic> jsonData =  json.decode(data.body);
    return jsonData;
  }

  static Future<List<dynamic>> get countriesCovidData async {
    http.Response data = await http.get(_baseAllCountryDataUrl);
    List<dynamic> jsonData = json.decode(data.body);
    return jsonData;
  }

  static Future<Map<String, dynamic>> getCountryCovidData(String country) async {
    http.Response data = await http.get('$_baseDataByCountry$country');
    Map<String, dynamic> jsonData =  json.decode(data.body);
    return jsonData;
  }

}