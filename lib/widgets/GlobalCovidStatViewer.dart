import 'package:flutter/material.dart';

/// takes Stat info text, number info,
/// IconData and card color
class GlobalCovidStatViewer extends StatelessWidget {

  final String statName;
  final String totalNumberInfo;
  final String dailyNumberInfo;
  final IconData icon;
  final MaterialColor cardColor;

  GlobalCovidStatViewer({
    @required this.icon,
    @required this.totalNumberInfo,
    @required this.statName,
    @required this.dailyNumberInfo,
    this.cardColor = Colors.teal,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 3.5,),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 4),
              color: cardColor.shade900,
              blurRadius: 5.0,
              spreadRadius: 0.1
            )
          ],
          gradient: LinearGradient(
            colors: [cardColor.shade300, cardColor.shade600, cardColor.shade900],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16.0)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center, // default : center
          children: [
            Icon(
              icon,
              size: 42,
            ),
            SizedBox(height: 8.0,),
            Text(
              totalNumberInfo,
              style: Theme.of(context).primaryTextTheme.bodyText2
            ),
            SizedBox(height: 4.0,),
            Text(
              '(+$dailyNumberInfo today)',
                style: Theme.of(context).primaryTextTheme.caption.copyWith(
                  fontSize: 14
                )
            ),
            SizedBox(height: 4.0,),
            Text(
              statName,
              style: Theme.of(context).primaryTextTheme.bodyText2
            ),
          ],
        ),
      ),
    );
  }
}
