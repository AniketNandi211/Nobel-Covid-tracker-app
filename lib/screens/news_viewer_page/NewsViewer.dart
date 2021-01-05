import 'package:covid19_tracker/models/Article.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class NewsViewer extends StatelessWidget {

  final Article article;

  NewsViewer({@required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  child: Image.network(article.imgUrl,
                        fit: BoxFit.fill,),
                  width: double.infinity,
                  height: 220,
                ),
              ),
              SizedBox(height: 20,),
              Row(
                children: [
                  Hero(
                    tag: article.sourceName,
                    child: Material(
                      child: Text(
                        article.sourceName,
                        style: TextStyle(
                          fontSize: 16
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20,),
              Hero(
                tag: article.title,
                child: Material(
                  color: Colors.transparent,
                  child: Text(
                    article.title.split('-')[0],
                    style: Theme.of(context).primaryTextTheme.headline4,
                    softWrap: true,
                    //overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Text(
                article.content.split('[')[0],
                softWrap: true,
                style: Theme.of(context).primaryTextTheme.headline6,
              ),
              SizedBox(height: 15,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Hero(
                    tag: article.publishDate,
                    child: Material(
                      color: Colors.transparent,
                      child: Text(
                          article.publishDate
                      ),
                    ),
                  ),
                ],
              )
            ],
          )
        ),
      ),
    );
  }
}
