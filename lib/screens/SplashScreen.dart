import 'dart:async';
import 'package:covidanalyser/model/CountryName.dart';
import 'package:covidanalyser/model/GlobalCase.dart';
import 'package:covidanalyser/model/IndiaCase.dart';
import 'package:covidanalyser/presenter/CountryNamePresenter.dart';
import 'package:covidanalyser/presenter/GlobalCasePresenter.dart';
import 'package:covidanalyser/presenter/IndiaCasePresenter.dart';
import 'package:covidanalyser/util/MyNavigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    implements
        IndiaCaseViewContract,
        GlobalCaseViewContract,
        CountryNameViewContract {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  CountryNamePresenter _countryNamePresenter;
  List<CountryName> _countryName;

  IndiaCaseListPresenter _indiaCaseListPresenter;
  List<IndiaCase> _indiaCase;

  GlobalCaseListPresenter _globalCaseListPresenter;
  GlobalCase _globalCase;

  String _loadingText = "Fetching All\nCountry Name";
  bool _isTimerCompleted;

  double _value = 0;

  _SplashScreenState() {
    _countryNamePresenter = CountryNamePresenter(this);
    _indiaCaseListPresenter = IndiaCaseListPresenter(this);
    _globalCaseListPresenter = GlobalCaseListPresenter(this);
  }

  @override
  void initState() {
    super.initState();
    _isTimerCompleted = false;

    _countryNamePresenter.loadCountryName();

    Timer(Duration(seconds: 5), () {
      _isTimerCompleted = true;
      if (_globalCase != null) {
        MyNavigator.goToHome(context, _indiaCase, _globalCase, _countryName);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.greenAccent,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 50.0,
                        child: Image(
                          image: AssetImage("images/corona.png"),
                          color: Colors.greenAccent,
                          height: 50.0,
                          width: 50.0,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                      ),
                      Text(
                        "CovidAnalyser",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 24.0),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 64.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            height: 10,
                            child: LinearProgressIndicator(
                              value: _value, // percent filled
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.greenAccent),
                              backgroundColor: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20.0),
                      ),
                      Text(
                        _loadingText,
                        softWrap: true,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                            color: Colors.greenAccent),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  void onLoadException(String error) {
    _scaffoldKey.currentState.removeCurrentSnackBar();
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text("Please Check Your Connection"),
      action: SnackBarAction(
        label: "Retry",
        onPressed: () {
          _countryNamePresenter.loadCountryName();
          _scaffoldKey.currentState.removeCurrentSnackBar();
        },
      ),
      backgroundColor: Colors.redAccent,
      duration: Duration(seconds: 60),
    ));
  }

  @override
  void onLoadCountryName(List<CountryName> countryName) {
    setState(() {
      _countryName = countryName;
      _loadingText = "Fetching Cases\nIn India";
      _value = 0.30;
    });
    _indiaCaseListPresenter.loadIndiaCase();
  }

  @override
  void onLoadIndiaCases(List<IndiaCase> indiaCase) {
    setState(() {
      _indiaCase = indiaCase;
      _loadingText = "Fetching Cases\nGloabally";
      _globalCaseListPresenter.loadGlobalCase();
      _value = 0.50;
    });
  }

  @override
  void onLoadGlobalCases(GlobalCase globalCase) {
    setState(() {
      _globalCase = globalCase;
      _loadingText = "Loading\nPlease Wait";
      _value = 0.90;
    });

    if (_isTimerCompleted) {
      MyNavigator.goToHome(context, _indiaCase, _globalCase, _countryName);
    }
  }
}