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
      sourceName: jsonData['source']['name'] ?? 'n/a',
      author: jsonData['author'] ?? 'n/a',
      title: jsonData['title'] ?? 'n/a',
      desc: jsonData['description'] ?? 'n/a',
      content: jsonData['url'] ?? 'n/a',
      imgUrl: jsonData['urlToImage'] ?? 'n/a',
      pageUrl: jsonData['publishedAt'] ?? 'n/a',
      publishDate: jsonData['content' ?? 'n/a']
    );
  }

}

