import 'package:flutter/foundation.dart';

class GlobalCovidData {

  final String totalConfirmed;
  final String totalDeath;
  final String totalRecovery;
  final String dailyConfirmed;
  final String dailyDeath;
  final String dailyRecovery;
  final String activeCases;

  GlobalCovidData({
    @required this.dailyConfirmed,
    @required this.dailyDeath,
    @required this.dailyRecovery,
    @required this.totalConfirmed,
    @required this.totalDeath,
    @required this.totalRecovery,
    @required this.activeCases
  });

  factory GlobalCovidData.withJson(Map<String, dynamic> jsonData) {
    return GlobalCovidData(
      dailyConfirmed: jsonData['todayCases'] ?? '-',
      dailyDeath: jsonData['todayDeaths'] ?? '-',
      dailyRecovery: jsonData['todayRecovered'] ?? '-',
      totalConfirmed: jsonData['cases'] ?? '-',
      totalDeath: jsonData['deaths'] ?? '-',
      totalRecovery: jsonData['recovered'] ?? '-',
      activeCases: jsonData['active'] ?? '-'
    );
  }

}