import 'package:carousel_slider/carousel_slider.dart';
import 'package:covid19_tracker/models/Article.dart';
import 'package:covid19_tracker/providers/NewsArticleModel.dart';
import 'package:covid19_tracker/services/NewsApiService.dart';
import 'package:covid19_tracker/widgets/NewsCardList.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SymptomsPage extends StatefulWidget {

  @override
  _SymptomsPageState createState() => _SymptomsPageState();
}

class _SymptomsPageState extends State<SymptomsPage> {

  int _carouselIndex;

  @override
  void initState() {
    super.initState();
    print('making a request');
    Provider.of<NewsArticleModel>(context, listen: false).loadArticles();
    _carouselIndex = 0;
  }

  @override
  void dispose(){
    super.dispose();
  }

  // responsible for displaying news in the carousel slider
  Widget newsViewer(double parentWidth, double parentHeight) {
    NewsArticleModel articleModel = Provider.of<NewsArticleModel>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Container(
        //padding: EdgeInsets.all(0),
        //color: Colors.grey,
        child: Consumer<NewsArticleModel>(
          builder: (context, articleModel, __) {
            if(!articleModel.isReady) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            else {
              if(articleModel.hasFail) {
                  return Center(child: Text(articleModel.fail.info));
              } else {
                return CarouselSlider(
                  // children items
                  items: NewsCardList(articles: articleModel.articles)
                      .newsCardList,
                  options: CarouselOptions(
                      autoPlay: true,
                      autoPlayCurve: Curves.easeInOut,
                      autoPlayInterval: const Duration(milliseconds: 1800),
                      initialPage: _carouselIndex,
                      viewportFraction: 0.8,
                      aspectRatio: 16 / 9,
                      enlargeCenterPage: true,
                      enableInfiniteScroll: false
                  ),
                );
              }
            }
          },
          child: CarouselSlider(
            // children items
            items: NewsCardList(articles: articleModel.articles).newsCardList,
            options: CarouselOptions(
              autoPlay: true,
              autoPlayCurve: Curves.easeInOut,
              autoPlayInterval: const Duration(milliseconds: 1800),
              initialPage: _carouselIndex,
              viewportFraction: 0.8,
              aspectRatio: 16/9,
              enlargeCenterPage: true,
              enableInfiniteScroll: false,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    NewsArticleModel articleModel = Provider.of<NewsArticleModel>(context, listen: false);
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height * 0.35;
    return Container(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: BouncingScrollPhysics(),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 12,left: 12.0),
                child: InkWell(
                    onTap: () {
                      articleModel.requestNewArticles();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Latest News',
                        style: TextStyle(fontSize: 22),
                      ),
                    ),
                ),
              ),
              SizedBox(height: 12,),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  width: _width,
                  height: _height,
                  child: newsViewer(_width, _height),
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}
