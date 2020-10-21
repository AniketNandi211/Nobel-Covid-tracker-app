import 'package:covid19_tracker/models/Article.dart';
import 'package:covid19_tracker/providers/NewsArticleModel.dart';
import 'package:covid19_tracker/widgets/NewsCard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewsCardList {

  final List<Article> articles;

  NewsCardList({
    @required this.articles
  });

  List<NewsCard> get newsCardList {
    return articles.map(
          (_article) => NewsCard(article: _article,)
      ,).toList();
  }

}
