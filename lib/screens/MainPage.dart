import 'package:covidanalyser/model/CountryName.dart';
import 'package:covidanalyser/model/GlobalCase.dart';
import 'package:covidanalyser/model/IndiaCase.dart';
import 'package:covidanalyser/screens/IndiaScreen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import 'AwareScreen.dart';
import 'GlobalScreen.dart';
import 'GraphScreen.dart';
import 'InfoScreen.dart';

class MainPage extends StatefulWidget {
  final List<IndiaCase> indiaCase;
  final GlobalCase globalCase;
  final List<CountryName> countryName;

  MainPage(
      {Key key,
        @required this.indiaCase,
        @required this.globalCase,
        @required this.countryName})
      : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Widget> pageList;

  int _currentPage = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();

  final PageStorageBucket bucket = PageStorageBucket();

  @override
  void initState() {
    super.initState();
    pageList = [
      IndiaScreen(
          key: PageStorageKey("CountryScreen"), indiaCase: widget.indiaCase),
      GlobalScreen(
          key: PageStorageKey("GlobalScreen"), globalCase: widget.globalCase),
      GraphScreen(
        key: PageStorageKey("CompareScreen"),
        countryName: widget.countryName,countryCase: widget.globalCase.countryCase,),
      AwareScreen(),
      InfoScreen()
    ];
  }

  void onBottomNavItemTap(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 0,
        height: 50.0,
        items: <Widget>[
          Icon(
            Icons.location_on,
            color: Colors.white,
            size: 22.0,
          ),
          Icon(
            Icons.public,
            color: Colors.white,
            size: 22.0,
          ),
          Icon(
            Icons.trending_up,
            color: Colors.white,
            size: 22.0,
          ),
          Icon(
            Icons.person,
            color: Colors.white,
            size: 22.0,
          ),
          Icon(
            Icons.info_outline,
            color: Colors.white,
            size: 22.0,
          ),
        ],
        color: Colors.green,
        buttonBackgroundColor: Colors.green,
        backgroundColor: Colors.white,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 600),
        onTap: onBottomNavItemTap,
      ),
      body: PageStorage(
        bucket: bucket,
        child: pageList[_currentPage],
      ),
    );
  }
}