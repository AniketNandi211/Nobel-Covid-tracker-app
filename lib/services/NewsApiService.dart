import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:covid19_tracker/models/Fails.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:covid19_tracker/models/Article.dart';
import 'package:http/http.dart' as http;

class NewsApiService {
      // load api_key from env file
  //static final String _newsApiKey = DotEnv().env['NEWS_API_KEY'];
  static final String _newsApiKey = 'fake_key'; // for testing
  static final String _baseUrl = 'http://newsapi.org/v2/top-headlines?country=in&apiKey=$_newsApiKey';

      // Private constructor to prohibit making of an instance of this class
  NewsApiService._();

  static Future<String> loadArticles() async {
     try{
    //    http.Response response = await http.get(_baseUrl);
    //    dynamic jsonData = json.decode(response.body);
    //    if(jsonData['status'] == 'error'){
    //      // throw server error if occurs
    //      throw Fails(
    //        codeName: 'Internal_Server_Error',
    //        code: 102,
    //        info: jsonData['message']
    //      );
    //    }
    //    else { print(jsonData['articles']); return jsonData['articles']; }
      return Future.delayed(const Duration(seconds: 1), () => '[{"a" : "b", "c" : {"d": "e"}}, {"c" : {"r" : "t"}}]');
    } on SocketException {
      throw Fails.generateFail(FailsType.NoNetwork);
    } on HttpException {
      throw Fails.generateFail(FailsType.BadRequest);
    } catch (_) {
      //rethrow;
      throw Fails.generateFail(FailsType.Unknown).info = _.toString();
    }
  }

}
