import 'package:covid19_tracker/models/CountryCovidData.dart';
import 'package:covid19_tracker/utils/NumberScaleFormatter.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class CountryCovidCard extends StatelessWidget {

  final CountryCovidData countryCovidData;

  CountryCovidCard({@required this.countryCovidData});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 286,
        margin: const EdgeInsets.symmetric(vertical : 6.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: Colors.white.withOpacity(0.01),
          border: Border.all(
            color: Colors.grey.shade800,
          )
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(width: 4,),
                ClipRRect(
                  clipBehavior: Clip.antiAlias,
                  borderRadius: BorderRadius.circular(18),
                  child: Container(
                    color: Colors.grey.shade800,
                    height: 40,
                    width: 65,
                    child: Image.network(
                      countryCovidData.countryFlagUrl,
                        color: Colors.white.withOpacity(0.3),
                        fit: BoxFit.fill,
                        colorBlendMode: BlendMode.overlay
                    ),
                  ),
                ),
                SizedBox(width: 12,),
                Flexible(
                  fit: FlexFit.tight, // for taking the entire space
                  child: Text(
                    countryCovidData.countryName,
                    overflow: TextOverflow.ellipsis,
                    textDirection: TextDirection.ltr,
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 26,
                    ),
                  ),
                ),
                Spacer(),
                CircleAvatar(
                  foregroundColor: Colors.transparent,
                  child: Icon(
                    Icons.star_border_rounded,
                    size: 28,
                    color: Colors.yellowAccent,
                  ),
                  radius: 20,
                  backgroundColor: Colors.transparent,
                )
              ],
            ),
            SizedBox(height: 4,),
            Divider(
              thickness: 1.0,
              color: Colors.grey,
            ),
            DataTable(
              columns: [
                DataColumn(
                  label: Text('Attributes',
                    style: Theme.of(context).primaryTextTheme.bodyText1.copyWith(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic
                    ),
                  )
                  ,),
                // DataColumn(label: Icon(MdiIcons.abTesting, color: Colors.blue,),),
                // DataColumn(
                //     label: Text('Attributes',
                //       style: Theme.of(context).primaryTextTheme.bodyText1.copyWith(
                //         fontWeight: FontWeight.bold,
                //         fontStyle: FontStyle.italic
                //       ),
                //     ),
                // ),
                DataColumn(
                    label: Text('Total',
                      style: Theme.of(context).primaryTextTheme.bodyText1.copyWith(
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic
                      ),
                    )
                  ,),
                DataColumn(
                  label: Text('Daily',
                    style: Theme.of(context).primaryTextTheme.bodyText1.copyWith(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic
                    ),
                  )
                  ,),
                //DataColumn(label: Text('Daily')),,
              ],
              rows: [
                DataRow(
                  cells: [
                    DataCell(
                        Icon(MdiIcons.heartPlusOutline, color: Colors.green,size: 28,),
                    ),
                    // DataCell(
                    //   Text('Recovery'),
                    // ),
                    DataCell(
                      Text(NumberScaleFormatter.adjustScaling(countryCovidData.totalRecovery)),
                    ),
                    DataCell(
                      Text(NumberScaleFormatter.adjustScaling(countryCovidData.dailyRecovery)),
                    ),
                  ],
                ),
                DataRow(
                    cells: [
                      DataCell(
                        Icon(MdiIcons.emoticonDeadOutline, color: Colors.red,size: 28,),
                      ),
                      // DataCell(
                      //   Text('Deaths'),
                      // ),
                      DataCell(
                        Text(NumberScaleFormatter.adjustScaling(countryCovidData.totalDeath)),
                      ),
                      DataCell(
                        Text(NumberScaleFormatter.adjustScaling(countryCovidData.dailyDeath)),
                      ),
                    ],
                ),
                DataRow(
                  cells: [
                    DataCell(
                      Icon(MdiIcons.virusOutline, color: Colors.teal,size: 28,),
                    ),
                    // DataCell(
                    //   Text('Affected',),
                    // ),
                    DataCell(
                      Text(NumberScaleFormatter.adjustScaling(countryCovidData.totalConfirmed)),
                    ),
                    DataCell(
                      Text(NumberScaleFormatter.adjustScaling(countryCovidData.dailyConfirmed)),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      );
  }
}
