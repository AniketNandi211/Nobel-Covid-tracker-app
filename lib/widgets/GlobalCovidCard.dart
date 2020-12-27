import 'package:covid19_tracker/widgets/GlobalCovidStatViewer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class GlobalCovidCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
          padding: const EdgeInsets.all(2.0),
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
                      color: Colors.lightBlueAccent,
                      size: 36.0,
                    ),
                    SizedBox(width: 6.0,),
                    Text(
                      '12 Million',
                      style: TextStyle(
                          fontSize: 26.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.lightBlueAccent
                      ),
                    ),
                    SizedBox(width: 4.0,),
                    Text(
                      'active cases worldwide',
                      style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.lightBlueAccent
                      ),
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
                    numberInfo: '244 Billion',
                    icon: MdiIcons.heartPlusOutline,
                    cardColor: Colors.green,
                  ),
                  GlobalCovidStatViewer(
                    statName: 'Deceased',
                    numberInfo: '892 Million',
                    icon: MdiIcons.emoticonDeadOutline,
                    cardColor: Colors.red,
                  ),
                 GlobalCovidStatViewer(
                   statName: 'Being treated',
                   numberInfo: '34 Trillion',
                   cardColor : Colors.orange,
                   icon: MdiIcons.bottleTonicPlusOutline,
                 ),
                ],
              ),
            ],
          )
      ),
    );
  }
}
