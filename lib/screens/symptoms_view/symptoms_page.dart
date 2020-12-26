import 'package:carousel_slider/carousel_slider.dart';
import 'package:covid19_tracker/providers/NewsArticleModel.dart';
import 'package:covid19_tracker/widgets/GlobalCovidCard.dart';
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
        // color: Colors.grey,
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
                    scrollPhysics: BouncingScrollPhysics(),
                      autoPlay: false,
                      autoPlayCurve: Curves.easeInOut,
                      autoPlayInterval: const Duration(milliseconds: 2000),
                      initialPage: _carouselIndex,
                      viewportFraction: 0.8,
                      aspectRatio: 16 / 9,
                      enlargeCenterPage: true,
                      enableInfiniteScroll: false,
                  ),
                );
              }
            }
          },
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
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal : 6.0,
                      vertical: 2.0
                  ),
                  child: Text(
                    '@ Feeds',
                    style: TextStyle(fontSize: 22),
                  ),
                ),
              ),
              SizedBox(height: 4,),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  width: _width,
                  height: _height,
                  child: newsViewer(_width, _height),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12.0, top: 6.0),
                child: Text(
                  '@ Covid updates',
                  style: TextStyle(fontSize: 22),
                ),
              ),
              SizedBox(height: 20.0,),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                ),
                child: GlobalCovidCard(),
              ),
            ],
          ),
        ),
      )
    );
  }
}
