import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:covid19_tracker/models/Fails.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:covid19_tracker/models/Article.dart';
import 'package:http/http.dart' as http;

class NewsApiService {
      // load api_key from env file
  //static final String _newsApiKey = DotEnv().env['NEWS_API_KEY'];
  static final String _newsApiKey = 'fake_key'; // for testing
  final String _baseUrl = 'http://newsapi.org/v2/top-headlines?country=in&apiKey=$_newsApiKey';

  Future<List<Article>> loadArticles() async {
    List<Article> _articles = <Article>[];
    //print('News api service running');
    try{
      http.Response response = await http.get(_baseUrl);
      dynamic jsonData = json.decode(response.body);
      if(jsonData['status'] == 'error'){
        // throw server error if occurs
        throw Fails(
          codeName: 'Internal_Server_Error',
          code: 102,
          info: jsonData['message']
        );
      }
      else {
      for(var article in jsonData['articles']) {
        _articles.add(
            Article.withJson(article)
        );
      }

      }
    } on SocketException {
      throw Fails.generateFail(FailsType.NoNetwork);
    } on HttpException {
      throw Fails.generateFail(FailsType.BadRequest);
    } catch (err) {
      rethrow;
    }
    return _articles;
  }

}
