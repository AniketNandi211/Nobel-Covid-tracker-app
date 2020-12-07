import 'package:covid19_tracker/models/Fails.dart';
import 'package:covid19_tracker/models/Article.dart';
import 'package:covid19_tracker/services/CacheService.dart';
import 'package:covid19_tracker/services/NewsApiService.dart';
import 'package:flutter/foundation.dart';

enum NewsArticleModelState {
  working,
  ready
}

class NewsArticleModel with ChangeNotifier {

  List<Article> _articles = <Article>[];
  Fails _fail;
  NewsArticleModelState _state = NewsArticleModelState.working;

  void _setArticles(List<Article> articles){
    _articles = articles;
  }

  void _setFail(Fails fail){
    _fail = fail;
  }

  void _setState (NewsArticleModelState state) {
    _state = state;
    notifyListeners();
  }

  /// convert raw json object to dart Article object
  List<Article> _convertFromJsonToArticle(List<dynamic> jsonData) {
    List<Article> articles = <Article>[];
    //print(jsonData);
    jsonData.forEach((articleJson) => articles.add(Article.withJson(articleJson)));
    return articles;
  }

      // getters
  List<Article> get articles => _articles;
  Fails get fail => _fail;
  bool get isWorking => _state == NewsArticleModelState.working;
  bool get isReady => _state == NewsArticleModelState.ready;
  bool get hasFail => _fail != null;




   Future<void> _getArticles() async {
     await CacheService.instance;
    try {
      _fail = null;
      List<dynamic> articleJsonData = await CacheService.articles;
      //print(articleJsonData.map((dataSet) => print(dataSet['source']['name'])));
      if(articleJsonData != null) {
        _setArticles(_convertFromJsonToArticle(articleJsonData));
      }
    } on Fails catch(f) {
      print('from Article Provider(Fails) : ${f.toString()}');
      _setFail(f);
    } catch (e) {
      print('from Article Provider : ${e.toString()}');
      _setFail(Fails.generateFail(FailsType.Unknown)..info = e.toString());
    }
  }


  Future<void> loadArticles() async {
    await _getArticles();
    _setState(NewsArticleModelState.ready);
  }

  Future<void> requestNewArticles() async {
    _setState(NewsArticleModelState.working);
    await _getArticles();
    _setState(NewsArticleModelState.ready);
  }

}