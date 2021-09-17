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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: 4,),
                ClipRRect(
                  clipBehavior: Clip.antiAlias,
                  borderRadius: BorderRadius.circular(18),
                  child: Container(
                    color: Colors.grey.shade800,
                    height: 35,
                    width: 60,
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
                    style: Theme.of(context).primaryTextTheme.headline5
                  ),
                ),
                Spacer(),
                InkWell(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  splashColor: Colors.yellowAccent.withOpacity(0.4),
                  onTap: () {
                    // let's not do anything
                  },
                  child: Icon(
                    Icons.star_border_rounded,
                    size: 28,
                    color: Colors.yellowAccent,
                  ),
                )
              ],
            ),
            SizedBox(height: 6,),
            Divider(
              thickness: 1.0,
              color: Colors.grey,
            ),
            DataTable(
              columns: [
                DataColumn(
                  label: Text('Attributes',
                    style: Theme.of(context).primaryTextTheme.bodyText2
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
                      style: Theme.of(context).primaryTextTheme.bodyText2
                    )
                  ,),
                DataColumn(
                  label: Text('Daily',
                    style: Theme.of(context).primaryTextTheme.bodyText2
                  )
                  ,),
                //DataColumn(label: Text('Daily')),,
              ],
              rows: [
                DataRow(
                  cells: [
                    DataCell(
                        Icon(MdiIcons.heartPlusOutline, color: Color(0xff28ffbf),size: 28,),
                    ),
                    // DataCell(
                    //   Text('Recovery'),
                    // ),
                    DataCell(
                      Text(NumberScaleFormatter.adjustScaling(countryCovidData.totalRecovery),
                        style: Theme.of(context).primaryTextTheme.caption,),
                    ),
                    DataCell(
                      Text(NumberScaleFormatter.adjustScaling(countryCovidData.dailyRecovery),
                        style: Theme.of(context).primaryTextTheme.caption,),
                    ),
                  ],
                ),
                DataRow(
                    cells: [
                      DataCell(
                        Icon(MdiIcons.emoticonDeadOutline, color: Color(
                            0xfffa1635),size: 28,),
                      ),
                      // DataCell(
                      //   Text('Deaths'),
                      // ),
                      DataCell(
                        Text(NumberScaleFormatter.adjustScaling(countryCovidData.totalDeath),
                          style: Theme.of(context).primaryTextTheme.caption,),
                      ),
                      DataCell(
                        Text(NumberScaleFormatter.adjustScaling(countryCovidData.dailyDeath),
                          style: Theme.of(context).primaryTextTheme.caption,),
                      ),
                    ],
                ),
                DataRow(
                  cells: [
                    DataCell(
                      Icon(MdiIcons.virusOutline, color: Color(0xff002272),size: 28,),
                    ),
                    // DataCell(
                    //   Text('Affected',),
                    // ),
                    DataCell(
                      Text(NumberScaleFormatter.adjustScaling(countryCovidData.totalConfirmed),
                        style: Theme.of(context).primaryTextTheme.caption,),
                    ),
                    DataCell(
                      Text(NumberScaleFormatter.adjustScaling(countryCovidData.dailyConfirmed),
                        style: Theme.of(context).primaryTextTheme.caption,),
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
