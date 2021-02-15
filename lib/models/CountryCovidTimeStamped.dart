import 'package:flutter/foundation.dart';

class CountryCovidTimeStamped {

  final String country;
  final String confirmed;
  final String death;
  final String recovered;
  final String activeCases;
  final DateTime date;

  CountryCovidTimeStamped({
    @required this.activeCases,
    @required this.country,
    @required this.confirmed,
    @required this.death,
    @required this.recovered,
    @required this.date
  });

    // data{s} will be fetched from
    //  https://api.covid19api.com/$country?from=$from&to=$to endpoint
  factory CountryCovidTimeStamped.withJson(Map<String, dynamic> jsonData) {
    return CountryCovidTimeStamped(
      activeCases: jsonData['Active'].toString() ?? '-',
      confirmed: jsonData['Confirmed'].toString() ?? '-',
      country: jsonData['Country'].toString() ?? '-',
      date: jsonData['Date'] ?? null,
      death: jsonData['Deaths'].toString() ?? '-',
      recovered: jsonData['Recovered'].toString() ?? '-'
    );
  }

 }