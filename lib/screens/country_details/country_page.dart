import 'package:covid19_tracker/providers/CovidDataModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:provider/provider.dart';

class SubsGrowth {
  final int subs;
  final DateTime date;

  SubsGrowth(this.date, this.subs);
}
  List<SubsGrowth> dataset = [
  SubsGrowth(DateTime(2000, 4, 12), 1236671),
  SubsGrowth(DateTime(2000, 5, 20), 1232874),
  SubsGrowth(DateTime(2000, 6, 20), 1548721),
  SubsGrowth(DateTime(2000, 7, 20), 765123),
  SubsGrowth(DateTime(2001, 1, 20), 9873124),
];


class CountryPage extends StatefulWidget {
  @override
  _CountryPageState createState() => _CountryPageState();
}

class _CountryPageState extends State<CountryPage> {

  @override
  void initState() {
    super.initState();
    Provider.of<CovidDataModel>(context, listen: false).fetchTimeSeriesData('india', 3);
  }

  final List<charts.Series<SubsGrowth, DateTime>> seriesList = [
    charts.Series<SubsGrowth, DateTime>(
      id: 'subs growth',
      data: dataset,
      domainFn: (SubsGrowth subs, __) => subs.date,
      measureFn: (SubsGrowth subs, __) => subs.subs,
      colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
      displayName: 'Growth',
    )
  ];

  @override
  Widget build(BuildContext context) {
    CovidDataModel model = Provider.of<CovidDataModel>(context, listen: false);
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          width: double.infinity,
          height: 300,
          child: charts.TimeSeriesChart(
            seriesList,
            dateTimeFactory: const charts.LocalDateTimeFactory(),
            selectionModels: [
              charts.SelectionModelConfig(
                  changedListener: (charts.SelectionModel model) {
                    if(model.hasDatumSelection)
                      print(model.selectedSeries[0].measureFn(model.selectedDatum[0].index));
                  }
              )
            ],
          ),
        ),
        Text('${model.isTimeSeriesDataReady}')
      ],
    );
  }
}