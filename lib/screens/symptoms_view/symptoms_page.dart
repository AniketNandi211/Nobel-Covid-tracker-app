import 'package:carousel_slider/carousel_slider.dart';
import 'package:covid19_tracker/providers/CovidDataModel.dart';
import 'package:covid19_tracker/providers/NewsArticleModel.dart';
import 'package:covid19_tracker/widgets/CountryCovidCard.dart';
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
    _carouselIndex = 0;
    Provider.of<NewsArticleModel>(context, listen: false).loadArticles();
    Provider.of<CovidDataModel>(context, listen: false)..fetchGlobalData()
                                                       ..fetchCountriesData();
  }

  @override
  void dispose(){
    super.dispose();
  }

  // responsible for displaying news in the carousel slider
  Widget newsViewer(double parentWidth, double parentHeight) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Container(
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
                    'Feeds',
                    style: Theme.of(context).primaryTextTheme.headline4,
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
                  'Covid updates',
                  style: Theme.of(context).primaryTextTheme.headline4,
                ),
              ),
              SizedBox(height: 16.0,),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                ),
                child: Consumer<CovidDataModel>(
                    builder: (context, covidDataModel, _) {
                      if(!covidDataModel.isGlobalCovidDataReady){
                        return SizedBox(
                          height: 200,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      } else {
                        return GlobalCovidCard(globalCovidData: covidDataModel.globalCovidData,);
                      }
                    }),
              ),
              SizedBox(height: 16.0,),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  'Most affected countries',
                  style: Theme.of(context).primaryTextTheme.headline6,
                ),
              ),
              Container(
                margin: const EdgeInsets.all(12.0),
                child: Consumer<CovidDataModel>(
                  builder: (context, covidDataModel, _) {
                    if(!covidDataModel.isCountriesCovidDataReady){
                      return SizedBox(
                          height: 200,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                      );
                    } else {
                        // sort countries by most affected attribute
                      covidDataModel.countriesCovidDataList.sort(
                          (a, b) => int.parse(b.totalConfirmed).compareTo(int.parse(a.totalConfirmed))
                      );
                      return ListView.builder(
                        shrinkWrap: true,   // to extent the list inside a column
                        physics: NeverScrollableScrollPhysics(), // to disable ListView.builder scrollable
                        itemCount: 20,
                          itemBuilder: (BuildContext context,int index) {
                            return CountryCovidCard(countryCovidData: covidDataModel.countriesCovidDataList[index]);
                          }
                      );
                    }
                  }
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}
