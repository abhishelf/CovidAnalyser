import 'package:covidanalyser/screens/SplashScreen.dart';
import 'package:covidanalyser/util/DependencyInjection.dart';
import 'package:flutter/material.dart';

void main(){
  Injector.configure(Flavor.PROD);
  runApp(CovidAnalyser());
}

class CovidAnalyser extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      color: Colors.white,
      title: "CovidAnalyser",
      home: SplashScreen(),
    );
  }
}