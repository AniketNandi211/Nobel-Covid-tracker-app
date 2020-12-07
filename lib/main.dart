import 'dart:io';
import 'package:covid19_tracker/providers/NewsArticleModel.dart';
import 'package:covid19_tracker/screens/home_view.dart';
import 'package:covid19_tracker/services/CacheService.dart';
import 'package:covid19_tracker/utils/FileManager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'models/Fails.dart';

void main() async{
  // Load all env variables
  await DotEnv().load('.env');


  // Do testing stuff here -->

  // run the application
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
        )
      ],
      child: MaterialApp(
        title: 'Covid-19 tracker and News',
        theme: ThemeData(
          primarySwatch: Colors.teal,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          brightness: Brightness.dark
        ),
        home: HomeView(),
      ),
    );
  }
}
