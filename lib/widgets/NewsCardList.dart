import 'package:covid19_tracker/models/Article.dart';
import 'package:covid19_tracker/providers/NewsArticleModel.dart';
import 'package:covid19_tracker/screens/news_viewer_page/NewsViewer.dart';
import 'package:covid19_tracker/widgets/NewsCard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewsCardList {

  final List<Article> articles;
  final BuildContext context;

  NewsCardList({
    @required this.articles,
    @required  this.context
  });

  List<Widget> get newsCardList {
    return articles.map(
          (_article) => InkWell(
            splashColor: Colors.transparent,
            onTap: () {
              //print('registered ${_article.content}');
              Navigator.of(context).push(PageRouteBuilder(
                  transitionDuration: const Duration(milliseconds: 800),
                  pageBuilder: (BuildContext context, _, __) {
                    return NewsViewer(article: _article);
                  }
                ),
              );
            },
              child: NewsCard(article: _article,))
      ,).toList();
  }

}

//
// class NewsCardList extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }
