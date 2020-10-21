import 'package:flutter/foundation.dart';

///
/// @ Author - Aniket Nandi
/// Article class holds each
/// article have been / being / to be fetched from
/// News.api ORG
///

class Article{

  final String sourceName;
  final String author;
  final String title;
  final String desc;
  final String content;
  final String imgUrl;
  final String pageUrl;
  final String publishDate;

  Article({
    @required this.title,
    @required this.desc,
    @required this.imgUrl,
    @required this.author,
    @required this.content,
    @required this.pageUrl,
    @required this.sourceName,
    @required this.publishDate
  });

  factory Article.withJson(Map<String, dynamic> jsonData){
    return Article(
      sourceName: jsonData['source']['name'],
      author: jsonData['author'],
      title: jsonData['title'],
      desc: jsonData['description'],
      content: jsonData['url'],
      imgUrl: jsonData['urlToImage'],
      pageUrl: jsonData['publishedAt'],
      publishDate: jsonData['content']
    );
  }

}

