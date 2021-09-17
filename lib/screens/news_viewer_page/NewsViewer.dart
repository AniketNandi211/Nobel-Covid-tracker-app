import 'package:covid19_tracker/models/Article.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsViewer extends StatelessWidget {

  final Article article;
  final int index;
  final DateFormat timingFormat = DateFormat.jm();
  final DateFormat dateFormat = DateFormat.yMMMd();

  NewsViewer({@required this.article, @required this.index});

  // launch article web view
  Future<void> _launchUrl(String url) async {
    if(await canLaunch(url))
      await launch(url);
    else
      throw "Could not launch $url";
  }

  //  format the time and date
  String _dateFormat(String dateString){
    DateTime date = DateTime.parse(dateString);
    DateTime curr = DateTime.now();
    if(curr.year == date.year && date.day == curr.day && curr.month == date.month) {
      return "Today ${timingFormat.format(date)}";
    } else {
      return dateFormat.format(date);
    }
  }

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
                    tag: '$index : ${article.sourceName}',
                    child: Material(
                      child: Text(
                        article.sourceName,
                        style: Theme.of(context).primaryTextTheme.bodyText1
                      ),
                    ),
                  ),
                  Container(
                    height: 8,
                    width: 8,
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color: Color(0xff00a19d),
                      shape: BoxShape.circle
                    ),
                  ),
                  Hero(
                    tag: '$index : ${article.publishDate}',
                    child: Material(
                      color: Colors.transparent,
                      child: Text(
                          _dateFormat(article.publishDate),
                          style: Theme.of(context).primaryTextTheme.bodyText1,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20,),
              Hero(
                tag: '$index : ${article.title}',
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
                article.content == 'n/a' ? 'No content available' : article.content.split('[')[0],
                softWrap: true,
                style: Theme.of(context).primaryTextTheme.headline6,
              ),
              SizedBox(height: 15,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    child: Text(
                      'read full article..',
                      style: Theme.of(context).primaryTextTheme.bodyText1.copyWith(
                        color: Color(0xff00a19d)
                      ),
                    ),
                    splashColor: Color(0xff00a19d),
                    onTap: (){
                      _launchUrl(article.pageUrl);
                    },
                  )
                ],
              ),],
          )
        ),
      ),
    );
  }
}
