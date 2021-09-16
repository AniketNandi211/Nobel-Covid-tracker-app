import 'package:covid19_tracker/providers/ChartSeriesDataProvider.dart';
import 'package:covid19_tracker/providers/CovidDataModel.dart';
import 'package:covid19_tracker/providers/NewsArticleModel.dart';
import 'package:covid19_tracker/screens/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() async{
  // Load all env variables
  await DotEnv().load('.env');

  // Do testing stuff here -->


  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of my application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<NewsArticleModel>(
          create: (context) => NewsArticleModel(),
        ),
        ChangeNotifierProvider<CovidDataModel>(
          create: (context) => CovidDataModel(),
        ),
        ChangeNotifierProvider<ChartSeriesDataProvider>(
          create: (context) => ChartSeriesDataProvider(),
        )
      ],
      child: MaterialApp(
        title: 'Covid-19 App',
        theme: ThemeData(
          primarySwatch: Colors.pink,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          brightness: Brightness.dark,
          primaryTextTheme: TextTheme(
            headline1: TextStyle(
                color: Colors.white
            ),
            headline2:GoogleFonts.dosis(
                fontWeight: FontWeight.bold,
                color: Colors.white
            ),
            headline3: TextStyle(
                color: Colors.white
            ),
            headline4: GoogleFonts.dosis(
                textStyle: Theme.of(context).primaryTextTheme.headline4.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white
                )
            ),
            headline5: GoogleFonts.dosis(
                textStyle: Theme.of(context).primaryTextTheme.headline5.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                )
            ),
            headline6: GoogleFonts.dosis(
                textStyle: Theme.of(context).primaryTextTheme.headline6.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                )
            ),
            bodyText1: GoogleFonts.dosis(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey[300]
            ),
            bodyText2: GoogleFonts.dosis(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white
            ),
            caption: GoogleFonts.dosis(
                fontSize: 16,
                // fontWeight: FontWeight.bold,
                color: Colors.white
            ),
        )
        ),
        home: HomeView(),
      ),
    );
  }
}
