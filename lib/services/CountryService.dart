import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:covid19_tracker/models/Fails.dart';
import 'package:http/http.dart' as http;

class CountryService {

  static final String _baseUrl = 'https://api.covid19api.com/countries';

      // Private constructor to prohibit making of an instance of this class
  CountryService._();

  static Future<List<dynamic>> get countriesData async {
    try{
      http.Response response = await http.get(_baseUrl);
      dynamic jsonData = json.decode(response.body);
      return jsonData;
    } on SocketException {
      throw Fails.generateFail(FailsType.NoNetwork);
    } on HttpException {
      throw Fails.generateFail(FailsType.BadRequest);
    } catch (_) {
      // rethrow;
      throw Fails.generateFail(FailsType.Unknown).info = _.toString();
    }
  }

}