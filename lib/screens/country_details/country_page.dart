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

  int chartSeriesMinScale, chartSeriesMaxScale;

  @override
  void initState() {
    super.initState();
    chartSeriesMinScale = chartSeriesMaxScale = 0;
    Provider.of<CovidDataModel>(context, listen: false).fetchTimeSeriesData('india', 50);
  }

  List<charts.Series<SeriesData, DateTime>> buildSeriesList(CovidDataModel model) {
    return [
      charts.Series<SeriesData, DateTime>(
      id: 'subs growth',
      data: model.countryTimeSeriesData.deathSeries,
      domainFn: (SeriesData series, __) => series.date,
      measureFn: (SeriesData series, __) => series.caseCount,
      colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
      displayName: 'Growth',
    ),
    charts.Series<SeriesData, DateTime>(
      id: 'subs growth',
      data: model.countryTimeSeriesData.infectionSeries,
      domainFn: (SeriesData series, __) => series.date,
      measureFn: (SeriesData series, __) => series.caseCount,
      colorFn: (_, __) => charts.MaterialPalette.deepOrange.shadeDefault,
      displayName: 'Growth',
    ),
    charts.Series<SeriesData, DateTime>(
      id: 'subs growth',
      data: model.countryTimeSeriesData.recoverSeries,
      domainFn: (SeriesData series, __) => series.date,
      measureFn: (SeriesData series, __) => series.caseCount,
      colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
      displayName: 'Growth',
    ),
    ];
  }

  List<int> buildListFromSeries(List<SeriesData> series){
    List<int> list = [];
    series.forEach(
            (seriesData) {
              list.add(seriesData.caseCount);
            });
    return list;
  }

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
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          width: double.infinity,
          height: 250,
          child: charts.TimeSeriesChart(
            buildSeriesList(model),
            dateTimeFactory: const charts.LocalDateTimeFactory(),
            selectionModels: [
              charts.SelectionModelConfig(
                  changedListener: (charts.SelectionModel model) {
                    if(model.hasDatumSelection)
                      print(model.selectedSeries[0].measureFn(model.selectedDatum[0].index));
                  }
              )
            ],
            primaryMeasureAxis: charts.NumericAxisSpec(
              tickFormatterSpec: charts.BasicNumericTickFormatterSpec.fromNumberFormat(
                NumberFormat.compact()
              ),
              // viewport: chartsNumberScaleExtent(model),
            ),
          ),
        ),
        Text('${model.isTimeSeriesDataReady}')
      ],
    );
  }
}