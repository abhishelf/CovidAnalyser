import 'package:covidanalyser/model/CountryName.dart';
import 'package:covidanalyser/model/GlobalCase.dart';
import 'package:covidanalyser/model/IndiaCase.dart';
import 'package:covidanalyser/screens/DetailPage.dart';
import 'package:covidanalyser/screens/MainPage.dart';
import 'package:flutter/material.dart';

class MyNavigator {
  static void goToHome(BuildContext context,List<IndiaCase> indiaCase,GlobalCase globalCase,List<CountryName> countryName) {
    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context) => MainPage(indiaCase: indiaCase, globalCase: globalCase, countryName: countryName),
    ));
  }

  static void goToDetailPage(BuildContext context,String countryName, String slag) {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) => DetailPage(countryName: countryName, slug: slag),
    ));
  }
}