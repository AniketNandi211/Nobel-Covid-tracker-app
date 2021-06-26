import 'package:flutter/foundation.dart';

enum SeriesType {
  infection, dead, recovered
}

class SeriesData {
  SeriesType type;
  DateTime date;
  int caseCount;

  SeriesData({@required this.caseCount, @required this.date, @required this.type});

  static List<SeriesData> generateSeriesData(Map<String, dynamic> dataset, SeriesType type) {

    List<SeriesData> seriesData = <SeriesData>[];

    // API data arrives in mm/dd/yy format
    // have to convert it into yyyy/mm/dd format in order to
    //  work with Series Data (casting to DateTime object)
    dataset.forEach((key, value) {
      List<String> dateKey = key.split('/');
      // int.parse('dateKey[2]')  ->> 0021 year so,
      // int.parse('20${dateKey[2]}') ->> 2021 year
      DateTime date = DateTime(int.parse('20${dateKey[2]}'), int.parse(dateKey[0]),
          int.parse(dateKey[1]));
      seriesData.add(
        SeriesData(caseCount: value, date: date, type: type)
      );
    });
    return seriesData;
  }

  // factory SeriesData.buildSeriesObjectFromJson(Map<String, dynamic> data){
  //
  // }

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
  List<SeriesData> infectionSeries;
  List<SeriesData> deathSeries;
  List<SeriesData> recoverSeries;

  CountryCovidTimeSeriesData({
   @required this.infectionSeries,
   @required this.country,
   @required this.deathSeries,
   @required this.recoverSeries
  });

  factory CountryCovidTimeSeriesData.withJsonData(Map<String, dynamic> jsonData) =>
    CountryCovidTimeSeriesData(
    country: jsonData['country'],
    infectionSeries: SeriesData.generateSeriesData(jsonData['timeline']['cases'], SeriesType.infection),
    deathSeries: SeriesData.generateSeriesData(jsonData['timeline']['deaths'], SeriesType.dead),
    recoverSeries: SeriesData.generateSeriesData(jsonData['timeline']['recovered'], SeriesType.recovered)
   );

 }