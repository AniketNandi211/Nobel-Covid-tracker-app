import 'package:covid19_tracker/providers/ChartSeriesDataProvider.dart';
import 'package:covid19_tracker/providers/CovidDataModel.dart';
// import 'package:covid19_tracker/utils/ListUtils.dart';
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

  // int chartSeriesMinScale, chartSeriesMaxScale;
  bool _selected = false;

  @override
  void initState() {
    super.initState();
    Provider.of<CovidDataModel>(context, listen: false).fetchTimeSeriesData('india', 50);
  }

  List<charts.Series<SeriesData, DateTime>> buildSeriesList(CovidDataModel chartsData, int index) {
    List<SeriesData> series = [];
    charts.Color chartLineColor;
    if(index == 0) {
      series = chartsData.countryTimeSeriesData.infectionSeries;
      chartLineColor = charts.ColorUtil.fromDartColor(Colors.deepOrange);
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

  // List<int> _buildListFromSeries(List<SeriesData> series){
  //   List<int> list = [];
  //   series.forEach(
  //           (seriesData) {
  //             list.add(seriesData.caseCount);
  //           });
  //   return list;
  // }

  // charts.NumericExtents chartsNumberScaleExtent(CovidDataModel model) {
  //   int min = minInLists(
  //     [buildListFromSeries(model.countryTimeSeriesData.deathSeries),
  //      buildListFromSeries(model.countryTimeSeriesData.recoverSeries),
  //      buildListFromSeries(model.countryTimeSeriesData.infectionSeries)]
  //   );
  //   int max = maxInLists(
  //       [buildListFromSeries(model.countryTimeSeriesData.deathSeries),
  //         buildListFromSeries(model.countryTimeSeriesData.recoverSeries),
  //         buildListFromSeries(model.countryTimeSeriesData.infectionSeries)]
  //   );
  //   print('$min, $max');
  //   return charts.NumericExtents(min, max);
  // }

  @override
  Widget build(BuildContext context) {
    CovidDataModel model = Provider.of<CovidDataModel>(context, listen: false);
    ChartSeriesDataProvider chartsData = Provider.of<ChartSeriesDataProvider>(context, listen: false);
    return Column(
      children: [
        Consumer<CovidDataModel>(
          builder: (BuildContext context, _, __){
            if(model.isTimeSeriesDataReady) {
              return Container(
                padding: const EdgeInsets.all(12),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey.shade800,
                      borderRadius: BorderRadius.circular(18)
                  ),
                  margin: const EdgeInsets.all(8),
                  padding: const EdgeInsets.all(12),
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
                  selectedColor: Colors.orange,
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
            Consumer<ChartSeriesDataProvider>(
              builder: (context, _, __){
                return ChoiceChip(
                  selected: chartsData.index == 2,
                  selectedColor: Colors.green,
                  label: Text(
                    'Recovery',
                    style: TextStyle(color: Colors.white),
                  ),
                  onSelected: (bool selected){
                    chartsData.updateDataIndex(2);
                  },
                );
              },
            ),
          ],
        )
        // clips row widget
      ],
    );
  }
}