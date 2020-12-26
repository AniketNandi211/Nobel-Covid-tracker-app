import 'package:flutter/material.dart';

/// takes Stat info text, number info,
/// icondata and glow color
class GlobalCovidStatViewer extends StatelessWidget {

  final String statName;
  final String numberInfo;
  final IconData icon;
  final MaterialColor cardColor;

  GlobalCovidStatViewer({
    @required this.icon,
    @required this.numberInfo,
    @required this.statName,
    this.cardColor = Colors.teal,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18.0),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(18.0)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center, // default : center
        children: [
          Icon(
            icon,
            size: 42,
          ),
          SizedBox(height: 12.0,),
          Text(
            numberInfo,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              letterSpacing: 0.0,
              fontSize: 18.0
            ),
          ),
          SizedBox(height: 6.0,),
          Text(
              statName,
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
              ),
          ),
        ],
      ),
    );
  }
}
