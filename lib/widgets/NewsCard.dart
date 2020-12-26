import 'package:covid19_tracker/models/Article.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

///
/// previous design for news card
//Stack(
//overflow: Overflow.clip, // Experimental
//children: <Widget>[
//Align(
//alignment: Alignment.topCenter,
//child: Container(
//padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
//width: boxConstraints.maxWidth * 0.94,
//height: boxConstraints.maxHeight * 0.6,
////color: Colors.teal,
//child: Image.network(
//article.imgUrl,
//fit: BoxFit.cover,
//color: Colors.black26,
//colorBlendMode: BlendMode.darken,
//),
//),
//),
//Positioned(
//top: boxConstraints.maxHeight * 0.6 - 16,
//child: Container(
//height: boxConstraints.maxHeight * 0.42 + 8,
//width: boxConstraints.maxWidth,
//child: Card(
//child: Padding(
//padding: const EdgeInsets.all(8.0),
//child: Stack(
//children: <Widget>[
//Text(article.desc, maxLines: 3,overflow: TextOverflow.ellipsis,),
//Align(
//alignment: Alignment.bottomRight,
//child: Text('${article.author} - ${article.publishDate}'),
//)
//],
//),
//),
//),
//),
//)
//],
//),

class NewsCard extends StatelessWidget {

  final Article article;

  //mock data
  NewsCard({@required this.article});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context,BoxConstraints boxConstraints){
        //debugPrint('width: ${boxConstraints.maxHeight} height : ${boxConstraints.maxWidth}');
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
          ),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              //color: Colors.blueAccent,
              image: DecorationImage(
                image: NetworkImage(article.imgUrl,),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken
                ),
              ),
            ),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      article.title,
                      style: TextStyle(fontSize: 20),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 8,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(article.publishDate),
                        SizedBox(width: 8,),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(3)),
                            color: Colors.white,
                          ),
                          height: 6,
                          width: 6,
                        ),
                        SizedBox(width: 8,),
                        Text(article.sourceName)
                      ],
                    ),
                  ],
                ),
            )
          )
          ,);
      },
    );
  }
}
