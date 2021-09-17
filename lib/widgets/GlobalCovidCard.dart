import 'package:covid19_tracker/models/GlobalCovidData.dart';
import 'package:covid19_tracker/utils/NumberScaleFormatter.dart';
import 'package:covid19_tracker/widgets/GlobalCovidStatViewer.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class GlobalCovidCard extends StatelessWidget {

  final GlobalCovidData globalCovidData;

  GlobalCovidCard({@required this.globalCovidData});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(1.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(left : 1.0, top: 0.0,),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              children: [
                Icon(
                  MdiIcons.earthPlus,
                  color: Color(0xff1cc5dc),
                  size: 36.0,
                ),
                SizedBox(width: 6.0,),
                Text(
                  NumberScaleFormatter.adjustScaling(globalCovidData.totalConfirmed),
                  style: Theme.of(context).primaryTextTheme.headline4.copyWith(
                    color: Color(0xff1cc5dc)
                  )
                ),
                SizedBox(width: 4.0,),
                Text(
                  'active cases worldwide',
                  style: Theme.of(context).primaryTextTheme.bodyText2
                )
              ],
            ),
          ),
          SizedBox(height: 22.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            children: [
              GlobalCovidStatViewer(
                statName: 'Recovered',
                totalNumberInfo: NumberScaleFormatter.adjustScaling(globalCovidData.totalRecovery),
                dailyNumberInfo: NumberScaleFormatter.adjustScaling(globalCovidData.dailyRecovery),
                icon: MdiIcons.heartPlusOutline,
                cardColor: Colors.lightBlue,
              ),
              GlobalCovidStatViewer(
                statName: 'Deceased',
                totalNumberInfo: NumberScaleFormatter.adjustScaling(globalCovidData.totalDeath),
                dailyNumberInfo: NumberScaleFormatter.adjustScaling(globalCovidData.dailyDeath),
                icon: MdiIcons.emoticonDeadOutline,
                cardColor: Colors.red,
              ),
             GlobalCovidStatViewer(
               statName: 'Pending',
               totalNumberInfo: NumberScaleFormatter.adjustScaling(globalCovidData.activeCases),
               dailyNumberInfo: NumberScaleFormatter.adjustScaling(globalCovidData.dailyConfirmed),
               cardColor : Colors.deepOrange,
               icon: MdiIcons.bottleTonicPlusOutline,
             ),
            ],
          ),
        ],
      ),
    );
  }
}
