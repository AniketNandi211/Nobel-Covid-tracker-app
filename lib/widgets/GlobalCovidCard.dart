import 'package:covid19_tracker/widgets/GlobalCovidStatViewer.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class GlobalCovidCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
          padding: const EdgeInsets.all(6.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(left : 1.0, top: 2.0,),
                child: Row(
                  children: [
                    Icon(
                      MdiIcons.earthPlus,
                      color: Colors.lightBlueAccent,
                      size: 32.0,
                    ),
                    SizedBox(width: 8.0,),
                    Text(
                      '12 Million active cases worldwide',
                      style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.lightBlueAccent
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 26.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.max,
                children: [
                  GlobalCovidStatViewer(
                    statName: 'Recovered',
                    numberInfo: '244 Million',
                    icon: MdiIcons.heartPlusOutline,
                    cardColor: Colors.green,
                  ),
                  GlobalCovidStatViewer(
                    statName: 'Deceased',
                    numberInfo: '892K',
                    icon: MdiIcons.emoticonDeadOutline,
                    cardColor: Colors.red,
                  ),
                 GlobalCovidStatViewer(
                   statName: 'Being treated',
                   numberInfo: '342 Million',
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
