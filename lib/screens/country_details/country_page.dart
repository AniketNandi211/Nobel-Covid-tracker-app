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

  @override
  void initState() {
    super.initState();
    Provider.of<CovidDataModel>(context, listen: false)..fetchTimeSeriesData('India', 90)
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


  @override
  Widget build(BuildContext context) {
    CovidDataModel model = Provider.of<CovidDataModel>(context, listen: false);
    ChartSeriesDataProvider chartsData = Provider.of<ChartSeriesDataProvider>(context, listen: false);
    // List<String> countries = model.
    return Column(
      children: [
        SizedBox(height: 8),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(width: 12,),
            Text(
                'Overview',
              style: TextStyle(
                fontSize: 26
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
                        model.refreshTimeSeriesData(country, 90);
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
                    style: TextStyle(color: Colors.white),
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
                    style: TextStyle(color: Colors.white),
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
                'At a glace',
              style: TextStyle(
                fontSize: 22,
              ),
            )
        ),
        // clips row widget
      ],
    );
  }
}