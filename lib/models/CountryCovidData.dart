import 'package:flutter/foundation.dart';

class CountryCovidData {
  final String countryName;
  final String countryFlagUrl;
  final String totalConfirmed;
  final String totalDeath;
  final String totalRecovery;
  final String dailyConfirmed;
  final String dailyDeath;
  final String dailyRecovery;
  final String activeCases;

  CountryCovidData({
    @required this.dailyConfirmed,
    @required this.dailyDeath,
    @required this.dailyRecovery,
    @required this.totalConfirmed,
    @required this.totalDeath,
    @required this.totalRecovery,
    @required this.activeCases,
    @required this.countryFlagUrl,
    @required this.countryName
  });

  factory CountryCovidData.withJson(Map<String, dynamic> jsonData) {
    return CountryCovidData(
        dailyConfirmed: jsonData['todayCases'] ?? '-',
        dailyDeath: jsonData['todayDeaths'] ?? '-',
        dailyRecovery: jsonData['todayRecovered'] ?? '-',
        totalConfirmed: jsonData['cases'] ?? '-',
        totalDeath: jsonData['deaths'] ?? '-',
        totalRecovery: jsonData['recovered'] ?? '-',
        activeCases: jsonData['active'] ?? '-',
        countryName: jsonData['country'] ?? '-',
        countryFlagUrl: jsonData['countryInfo']['flag'] ?? null
    );
  }

}