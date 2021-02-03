import 'package:covid19_tracker/models/Article.dart';
import 'package:covid19_tracker/screens/news_viewer_page/NewsViewer.dart';
import 'package:covid19_tracker/widgets/NewsCard.dart';
import 'package:flutter/material.dart';
class NewsCardList {

  final List<Article> articles;
  final BuildContext context;

  NewsCardList({
    @required this.articles,
    @required  this.context
  });

  List<Widget> get newsCardList {

    /**
     * added each article index along with the actual article data cuz
     * hero widget was causing problems with the reason being, there were
     * multiple heroes having same tags
     *
     * e.g. : two or more articles from same source like NDTV news or etc.
     *        creates multiple same tags in the widget tree and the NewsViewer
     *        page crashes upon clicking
     *
     *        adding every article's index with it seems to solve that problem
     *        I just came up with this idea damn, I'm so smart
     *
     */


    return articles.asMap().entries.map(
          (_article) => InkWell(
            splashColor: Colors.transparent,
            onTap: () {
              //print('title ${_article.title} ${_article.sourceName} ${_article.publishDate} ');
              Navigator.of(context).push(PageRouteBuilder(
                  transitionDuration: const Duration(milliseconds: 800),
                  pageBuilder: (BuildContext context, _, __) {
                    return NewsViewer(article: _article.value, index: _article.key,);
                  }
                ),
              );
            },
              // actual widget that shows each article data on card
              child: NewsCard(article: _article.value, index: _article.key))
      ,).toList();  // this converts all NewsCards to a list -> List<Widget>
  }

}

//
// class NewsCardList extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }
