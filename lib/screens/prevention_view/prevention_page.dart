import 'package:covid19_tracker/utils/CovidQueries.dart';
import 'package:flutter/material.dart';

class PreventionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: CovidQueries.queries.length,
        physics: BouncingScrollPhysics(),
        itemBuilder: (BuildContext ctx, int index) {
          return
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              margin: const EdgeInsets.only(bottom: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${CovidQueries.queries[index].question}',
                      style: Theme.of(context).primaryTextTheme.headline4,
                    ),
                    SizedBox(height: 12,),
                    Text('${CovidQueries.queries[index].answer}',
                      style: Theme.of(context).primaryTextTheme.bodyText1.copyWith(
                        fontSize: 16
                      ),
                    ),
                  ],
                ),
            );
        }
    );
  }
}