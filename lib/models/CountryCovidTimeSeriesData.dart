import 'package:flutter/foundation.dart';


class SeriesData {
  DateTime date;
  int caseCount;

  SeriesData({@required this.caseCount, @required this.date});

  static void withData(Map<String, dynamic> data){

  }

}

class CountryCovidTimeSeriesData {

  // implement model for CountryCovidTimeSeriesData
  // reference model at https://corona.lmao.ninja/v2/historical/india?lastdays=5

 ///  dataset example
 /// 'timeline'{
 // "country": "India",
 // "province": [],
 // "timeline": {
 // "cases": {
 // "6/18/21": 29823546,
 // "6/19/21": 29881772,
 // "6/20/21": 29935221,
 // "6/21/21": 29977861,
 // "6/22/21": 30028709
 // },
 // "deaths": {
 // "6/18/21": 385137,
 // "6/19/21": 386708,
 // "6/20/21": 388135,
 // "6/21/21": 389302,
 // "6/22/21": 390660
 // },
 // "recovered": {
 // "6/18/21": 28678390,
 // "6/19/21": 28765738,
 // "6/20/21": 28844199,
 // "6/21/21": 28926038,
 // "6/22/21": 28994855
 // }
 // }
 // }

 // data members
  String country;
  Map<String, dynamic> caseSeries;
  Map<String, dynamic> deathSeries;
  Map<String, dynamic> recoverSeries;

  CountryCovidTimeSeriesData({
   @required this.caseSeries,
   @required this.country,
   @required this.deathSeries,
   @required this.recoverSeries
  });

  factory CountryCovidTimeSeriesData.withJsonData(Map<String, dynamic> jsonData) =>
    CountryCovidTimeSeriesData(
    country: jsonData['country'],
    caseSeries: jsonData['timeline']['cases'],
    deathSeries: jsonData['timeline']['deaths'],
    recoverSeries: jsonData['timeline']['recovered']
   );


  // factory generator

 }