import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:covid19_tracker/screens/country_details/country_page.dart';
import 'package:covid19_tracker/screens/feeds_view/feed_page.dart';
import 'package:covid19_tracker/screens/origin_page/history_page.dart';
import 'package:covid19_tracker/screens/prevention_view/prevention_page.dart';
import 'package:covid19_tracker/screens/symptoms_view/symptoms_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeView extends StatefulWidget {

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  int _currentPage;
  PageController _pageController;

  final List<BottomNavyBarItem> bottomNavBarItems = [
    BottomNavyBarItem(
      icon: Icon(FontAwesomeIcons.virus),
      title: Text('Feeds'),
      inactiveColor: Colors.green[600].withOpacity(0.6),
      activeColor: Colors.green[600]
    ),
    BottomNavyBarItem(
      icon: Icon(FontAwesomeIcons.building),
      title: Text('CountryWise'),
      inactiveColor: Colors.orange[800].withOpacity(0.6),
      activeColor: Colors.orange[800]
    ),
    BottomNavyBarItem(
      icon: Icon(FontAwesomeIcons.globeAsia),
      title: Text('Worldwide'),
      inactiveColor: Colors.blue.withOpacity(0.6),
      activeColor: Colors.blue
    ),
    BottomNavyBarItem(
      icon: Icon(FontAwesomeIcons.satelliteDish),
      title: Text('Prevention'),
      inactiveColor: Colors.red.withOpacity(0.6),
      activeColor: Colors.red
    ),
    BottomNavyBarItem(
      icon: Icon(FontAwesomeIcons.history),
      title: Text('Insights'),
      inactiveColor: Colors.teal.withOpacity(0.6),
      activeColor: Colors.teal
    ),
  ];

  @override
  void initState() {
    super.initState();
    _currentPage = 2;
    _pageController = PageController(initialPage: 2);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Covid-19'),
        centerTitle: true,
      ),
      body: PageView(
        controller: _pageController,
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          SymptomsPage(),
          CountryPage(),
          FeedPage(),
          PreventionPage(),
          HistoryPage()
        ],
        onPageChanged: (index){
          setState(() {
            _currentPage = index;
          });
        },
      ),
      bottomNavigationBar: BottomNavyBar(
          items: bottomNavBarItems,
          selectedIndex: _currentPage,
          iconSize: 24,
          onItemSelected: (int index){
            setState(() {
              _currentPage = index;
            });
            _pageController.jumpToPage(index);
          }
      )
    );
  }
}
