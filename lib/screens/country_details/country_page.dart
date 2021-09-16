import 'dart:math';
import 'package:covid19_tracker/models/CountryCovidData.dart';
import 'package:covid19_tracker/providers/ChartSeriesDataProvider.dart';
import 'package:covid19_tracker/providers/CovidDataModel.dart';
import 'package:covid19_tracker/widgets/LocationDropDownButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:intl/intl.dart';
import 'package:covid19_tracker/models/CountryCovidTimeSeriesData.dart';
import 'package:provider/provider.dart';


class CountryPage extends StatefulWidget {
  @override
  _CountryPageState createState() => _CountryPageState();
}

class _CountryPageState extends State<CountryPage> {

  String countryName = 'India'; // initial name of country
  int days; // time series data in days

  @override
  void initState() {
    super.initState();
    countryName = 'India';
    days = 180;
    Provider.of<CovidDataModel>(context, listen: false)..fetchTimeSeriesData('India', days)
                                                       ..fetchCountriesData();
  }

  List<charts.Series<SeriesData, DateTime>> buildSeriesList(CovidDataModel chartsData, int index) {
    List<SeriesData> series = [];
    charts.Color chartLineColor;
    if(index == 0) {
      series = chartsData.countryTimeSeriesData.infectionSeries;
      chartLineColor = charts.ColorUtil.fromDartColor(Colors.orange);
    }
    else if (index == 1) {
      series = chartsData.countryTimeSeriesData.deathSeries;
      chartLineColor = charts.ColorUtil.fromDartColor(Colors.redAccent);
    }
    else {
      series = chartsData.countryTimeSeriesData.recoverSeries;
      chartLineColor = charts.ColorUtil.fromDartColor(Colors.green);
    }
    return [
      charts.Series<SeriesData, DateTime>(
      id: 'subs growth',
      data: series,
      domainFn: (SeriesData series, __) => series.date,
      measureFn: (SeriesData series, __) => series.caseCount,
      seriesColor: chartLineColor,
      displayName: 'Growth',
    ),
    ];
  }

  // widget for displaying individual data analytics
  Widget analyticsInfo({int data, String textInfo = 'dummy text', Color color = Colors.teal}) {
    TextStyle textStyle = Theme.of(context).primaryTextTheme.bodyText2;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Row(
        children: [
          // circle pointer
          Container(
            height: 12,
            width: 12,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(6)
            ),
          ),
          SizedBox(width: 12,),
          Text(
              '$data$textInfo ${(days/30).toStringAsFixed(0)} months',
            style: textStyle,
          ),
        ],
      ),
    );
  }

  /// calculates the percentage increase or decrease between
  /// starting and final value
  double percentageHike({int initialValue, int finalValue}) {
    return ((finalValue - initialValue)/initialValue) * 100;
  }

  @override
  Widget build(BuildContext context) {
    CovidDataModel model = Provider.of<CovidDataModel>(context, listen: false);
    ChartSeriesDataProvider chartsData = Provider.of<ChartSeriesDataProvider>(context, listen: false);
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          SizedBox(height: 8),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(width: 12,),
              Text(
                  'Overview',
                style: Theme.of(context).primaryTextTheme.headline4.copyWith(
                  fontSize: 28
                ),
              ),
              Spacer(),
              Consumer<CovidDataModel>(
                builder: (context, _, __) {
                  if(model.isCountriesCovidDataReady){
                    return LocationDropDownButton(
                      countryFlagUris: model.countriesCovidDataList.map(
                              (CountryCovidData data) => data.countryFlagUrl).toList(),
                      countryNames: model.countriesCovidDataList.map(
                              (dataset) => dataset.countryName).toList(),
                        onSelected: (String country) {
                          model.refreshTimeSeriesData(country, days);
                          countryName = country;
                        }
                    );
                  } else {
                    return DummyDropdown(
                      hint: 'Getting data',
                    );
                  }
                }
              ),
              SizedBox(width: 12,),
            ],
          ),
          SizedBox(height: 8,),
          Consumer<CovidDataModel>(
            builder: (BuildContext context, _, __){
              if(model.isTimeSeriesDataReady) {
                // countryIndex = model.countriesCovidDataList.indexWhere(
                //         (country) => country.countryName == 'india');
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey.shade800,
                        borderRadius: BorderRadius.circular(18)
                    ),
                    margin: const EdgeInsets.all(4),
                    padding: const EdgeInsets.all(4),
                    width: double.infinity,
                    height: 250,
                    child: Consumer<ChartSeriesDataProvider>(
                      builder: (context, _, __) {
                        return charts.TimeSeriesChart(
                          buildSeriesList(model, chartsData.index),
                          dateTimeFactory: const charts.LocalDateTimeFactory(),
                          selectionModels: [
                            charts.SelectionModelConfig(
                                changedListener: (charts.SelectionModel model) {
                                  if(model.hasDatumSelection)
                                    print(model.selectedSeries[0].measureFn(model.selectedDatum[0].index));
                                }
                            )
                          ], // make it reactive
                          primaryMeasureAxis: charts.NumericAxisSpec(
                              tickFormatterSpec: charts.BasicNumericTickFormatterSpec.fromNumberFormat(
                                  NumberFormat.compact()
                              ),
                              // viewport: chartsNumberScaleExtent(model),
                              renderSpec: charts.GridlineRendererSpec(
                                  lineStyle: charts.LineStyleSpec(
                                      color: charts.MaterialPalette.blue.shadeDefault,
                                      dashPattern: [4, 2]
                                  ),
                                  labelStyle: charts.TextStyleSpec(
                                      color: charts.MaterialPalette.white
                                  )
                              )
                          ),
                          domainAxis: charts.DateTimeAxisSpec(
                              renderSpec: charts.GridlineRendererSpec(
                                  labelStyle: charts.TextStyleSpec(
                                      color: charts.MaterialPalette.white
                                  )
                              )
                          ),
                        );
                      },
                      // child: ,
                    ),
                  ),
                );
              } else {
                return Container(
                  height: 250,
                  child: Center(child: CircularProgressIndicator(),),
                );
              }
            }
          ),
          SizedBox(height: 2,),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Consumer<ChartSeriesDataProvider>(
                builder: (context, _, __){
                  return ChoiceChip(
                    selected: chartsData.index == 0,
                    selectedColor: Colors.deepOrange,
                    label: Text(
                      'Infection',
                      style: Theme.of(context).primaryTextTheme.caption,
                    ),
                    onSelected: (bool selected){
                      chartsData.updateDataIndex(0);
                    },
                  );
                },
              ),
              SizedBox(width: 12,),
              Consumer<ChartSeriesDataProvider>(
                builder: (context, _, __){
                  return ChoiceChip(
                    selected: chartsData.index == 1,
                    selectedColor: Colors.redAccent,
                    label: Text(
                      'Deaths',
                      style: Theme.of(context).primaryTextTheme.caption,
                    ),
                    onSelected: (bool selected){
                      chartsData.updateDataIndex(1);
                    },
                  );
                },
              ),
              SizedBox(width: 12,),
              // Consumer<ChartSeriesDataProvider>(
              //   builder: (context, _, __){
              //     return ChoiceChip(
              //       selected: chartsData.index == 2,
              //       selectedColor: Colors.green,
              //       label: Text(
              //         'Recovery',
              //         style: TextStyle(color: Colors.white),
              //       ),
              //       onSelected: (bool selected){
              //         chartsData.updateDataIndex(2);
              //       },
              //     );
              //   },
              // ),
            ],
          ),
          SizedBox(height: 8,),
          Align(
            alignment: Alignment(-0.92, 0),
              child: Text(
                  'Summary',
                style: Theme.of(context).primaryTextTheme.headline4,
              )
          ),
          Consumer<CovidDataModel>(
              builder: (context, _, __) {
                TextStyle basicTextStyle = Theme.of(context).primaryTextTheme.bodyText2;
                int countryIndex = model.countriesCovidDataList.indexWhere(
                        (country) => country.countryName == countryName);
                if(model.isTimeSeriesDataReady){
                  List<int> deathSeries = model.countryTimeSeriesData.deathSeries.map(
                          (SeriesData data) => data.caseCount).toList();
                  List<int> infectionSeries = model.countryTimeSeriesData.infectionSeries.map(
                          (SeriesData data) => data.caseCount).toList();
                  // percentage +/-
                  double deathPercent = percentageHike(
                    initialValue: deathSeries.reduce(min),
                    finalValue: deathSeries.reduce(max)
                  );
                  double infectionPercent = percentageHike(
                    initialValue: infectionSeries.reduce(min),
                    finalValue: infectionSeries.reduce(max)
                  );
                  return Column(
                    children: [
                      SizedBox(height: 12,),
                      Row(
                        children: [
                          SizedBox(width: 18,),
                          ClipRRect(
                            child: Image.network(
                              model.countriesCovidDataList[countryIndex].countryFlagUrl,
                              fit: BoxFit.cover,
                              height: 65,
                              width: 95,
                            ),
                            borderRadius: BorderRadius.circular(26),
                          ),
                          SizedBox(width: 30,),
                          Text(
                            '${model.countryTimeSeriesData.country}',
                            style: Theme.of(context).primaryTextTheme.headline2,
                          ),
                        ],
                      ),
                      SizedBox(height: 18,),
                      Container(
                        child: RichText(
                          text: TextSpan(
                            style: basicTextStyle,
                            children: <TextSpan>[
                              TextSpan(
                                text: '${NumberFormat.compactLong().format(infectionSeries[infectionSeries.length-1])}'
                                    ' infections',
                                style: basicTextStyle.copyWith(
                                  color: Colors.greenAccent,
                                  fontWeight: FontWeight.bold
                                )
                              ),
                              TextSpan(
                                text: ' nation-wide with a total of ',
                                style: basicTextStyle
                              ),
                              TextSpan(
                                text: '${NumberFormat.compactLong().format(deathSeries[deathSeries.length-1])}'
                                    ' deaths.',
                                style: basicTextStyle.copyWith(
                                  color: Colors.redAccent,
                                  fontWeight: FontWeight.bold
                                )
                              )
                            ]
                          ),
                        ),
                        padding:  const EdgeInsets.symmetric(horizontal: 8),
                      ),
                      SizedBox(height: 16,),
                      analyticsInfo(
                        color: Colors.deepOrange,
                        textInfo: '% death hike over the past ',
                        data: int.parse(deathPercent.toStringAsFixed(0))
                      ),
                      SizedBox(height: 8,),
                      analyticsInfo(
                          color: Colors.teal,
                          textInfo: '% rise in infection for past ',
                          data: int.parse(infectionPercent.toStringAsFixed(0))
                      ),
                    ],
                  );
                }
                return Container(
                  height: 250,
                  child: Center(child: CircularProgressIndicator(),),
                );
              }
          )
        ],
      ),
    );
  }
}