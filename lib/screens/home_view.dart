import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:covid19_tracker/screens/country_details/country_page.dart';
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
      icon: Icon(FontAwesomeIcons.eye),
      title: Text(' At a glance'),
      inactiveColor: Color(0xff28FFBF),
      activeColor: Color(0xff28FFBF)
    ),
    BottomNavyBarItem(
      icon: Icon(FontAwesomeIcons.chartLine),
      title: Text(' Overview'),
      inactiveColor: Color(0xff3DB2FF),
      activeColor: Color(0xff3DB2FF)
    ),
    BottomNavyBarItem(
      icon: Icon(FontAwesomeIcons.questionCircle),
      title: Text(' FAQ'),
      inactiveColor: Color(0xff00A19D),
      activeColor: Color(0xff00A19D)
    ),
  ];

  @override
  void initState() {
    super.initState();
    _currentPage = 0;
    _pageController = PageController(initialPage: 0);
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
          PreventionPage(),
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
