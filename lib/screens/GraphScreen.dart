import 'package:covidanalyser/model/BarItem.dart';
import 'package:covidanalyser/model/CountryCase.dart';
import 'package:covidanalyser/model/CountryCaseList.dart';
import 'package:covidanalyser/model/CountryName.dart';
import 'package:covidanalyser/model/SparklineItem.dart';
import 'package:covidanalyser/presenter/GlobalCountryCasePresenter.dart';
import 'package:covidanalyser/util/Const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class GraphScreen extends StatefulWidget {
  final List<CountryName> countryName;
  final List<CountryCase> countryCase;

  GraphScreen(
      {Key key, @required this.countryName, @required this.countryCase})
      : super(key: key);

  @override
  _GraphScreenState createState() => _GraphScreenState();
}

class _GraphScreenState extends State<GraphScreen>
    with CountryCaseListViewContract {

  // LOADING DATA
  CountryCaseListPresenter _presenter;
  List<CountryName> _countryName;
  List<CountryCase> _countryCaseData;

  //DROPDOWN DATA
  CountryName _selectedCountry;

  //GRAPH DATA
  Map<String, double> _pieChartData = new Map();
  List<SparklineItem> _sparklineList = List();
  var _barChartSeries;

  //LOADING VARIABLE
  bool _isLoading = false;
  bool _isChanged = false;

  BuildContext _context;

  @override
  void initState() {
    super.initState();
    _presenter = CountryCaseListPresenter(this);
    _countryName = widget.countryName;
    _countryCaseData = widget.countryCase;
    _countryName.sort((a, b) => a.name.compareTo(b.name));

    _initData();

    _presenter.loadCountryCaseList(_selectedCountry.slug);
    _isLoading = true;
  }

  void _initData() {
    for (int i = 0; i < _countryName.length; i++) {
      if (_countryName[i].slug == "india") {
        _selectedCountry = _countryName[i];
      }
    }

    _loadPieAndBarData();
    _sparklineList.add(SparklineItem(null, null, null));
  }

  void _onCountryChanged(CountryName countryName) {
    setState(() {
      _selectedCountry = countryName;
      _isChanged = true;
    });
  }

  void _loadData() {
    _presenter.loadCountryCaseList(_selectedCountry.slug);
    setState(() {
      _isLoading = true;
    });
  }

  void _loadPieAndBarData() {
    for (int i = 0; i < _countryCaseData.length; i++) {
      if (equalsIgnoreCase(
          _countryCaseData[i].countryName, _selectedCountry.name)) {
        _pieChartData['Active'] =
            double.parse(_countryCaseData[i].countryConfirmed);
        _pieChartData['Death'] = double.parse(_countryCaseData[i].countryDeath);
        _pieChartData['Recovered'] =
            double.parse(_countryCaseData[i].countryRecovered);

        var barData = [
          BarItem("Confirmed", int.parse(_countryCaseData[i].countryConfirmed),Colors.blueAccent),
          BarItem("Death", int.parse(_countryCaseData[i].countryDeath),Colors.redAccent),
          BarItem("Recovered", int.parse(_countryCaseData[i].countryRecovered),Colors.lightGreenAccent),
        ];

        _barChartSeries = [
          charts.Series(
            id: 'Count',
            colorFn: (BarItem barItem, _) => barItem.color,
            domainFn: (BarItem barItem, _) => barItem.type,
            measureFn: (BarItem barItem, _) => barItem.count,
            data: barData,
          )
        ];

        break;
      }
    }
  }

  void _loadSparklineData(List<CountryCaseList> global) {
    List<double> confirmed = List();
    List<double> death = List();
    List<double> recovered = List();

    if (global.length > 100) {
      global.removeRange(0, global.length - 100);
    }

    for (int i = 0; i < global.length - 1; i++) {
      confirmed.add(double.parse(global[i].confirmed));
      death.add(double.parse(global[i].deaths));
      recovered.add(double.parse(global[i].recovered));
    }

    _sparklineList[0] = SparklineItem(confirmed, death, recovered);
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          expandedHeight: 180.0,
          flexibleSpace: Container(
            padding: EdgeInsets.fromLTRB(32.0, 48.0, 44.0, 16.0),
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Graphical Represention of",
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "Country",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 36.0,
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    Image(
                      height: 50.0,
                      width: 50.0,
                      image: AssetImage('images/comparison.png'),
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                ),
                _dropdownWidget(),
              ],
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
                (context, index) => Container(
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Divider(
                          color: Colors.blueGrey,
                          thickness: 3.0,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 64.0, right: 16.0, top: 4.0, bottom: 4.0),
                        child: _isLoading
                            ? CircularProgressIndicator()
                            : FloatingActionButton(
                          child: Icon(
                            Icons.done,
                            color: Colors.white,
                          ),
                          onPressed: _isChanged ? _loadData : null,
                          backgroundColor:
                          _isChanged ? Colors.green : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(16.0, 4.0, 16.0, 30.0),
                    child: (_sparklineList[0].confirmed == null ||
                        _sparklineList[0].confirmed.length == 0)
                        ? _defaultCenterWidget()
                        : Container(
                      padding: EdgeInsets.fromLTRB(8.0, 8.0, 16.0, 8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: Divider(
                                  color: Colors.grey,
                                  thickness: 0.5,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    right: 8.0, left: 8.0),
                                child: Text(
                                  "Pie Chart Represention",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12.0,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Divider(
                                  color: Colors.grey,
                                  thickness: 0.5,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding:
                            EdgeInsets.only(top: 8.0, bottom: 32.0),
                            child: _pieChartWidget(),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: Divider(
                                  color: Colors.grey,
                                  thickness: 0.5,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    right: 8.0, left: 8.0),
                                child: Text(
                                  "Bar Graph Represention",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12.0,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Divider(
                                  color: Colors.grey,
                                  thickness: 0.5,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            height: 200.0,
                            margin: EdgeInsets.only(bottom: 32.0),
                            child: _loadBarChart(),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: Divider(
                                  color: Colors.grey,
                                  thickness: 0.5,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    right: 8.0, left: 8.0),
                                child: Text(
                                  "Sparkline Represention",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12.0,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Divider(
                                  color: Colors.grey,
                                  thickness: 0.5,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            height: 150.0,
                            margin:
                            EdgeInsets.only(top: 8.0, bottom: 32.0),
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 3,
                              itemBuilder: (context, index) {
                                return Container(
                                  width: 250.0,
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 12.0),
                                  child: _sparklineWidget(index),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            childCount: 1,
          ),
        )
      ],
    );
  }

  Widget _defaultCenterWidget() {
    return Center(
      child: Text(
        "Press Ok \nAfter Selecting Country\nWhich Has One or More Cases",
        style: TextStyle(
          color: Colors.grey,
          fontStyle: FontStyle.italic,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _dropdownWidget() {
    return DropdownButton<CountryName>(
      value: _selectedCountry,
      icon: Icon(Icons.arrow_drop_down),
      hint: Text(
        "Select Country",
        style: TextStyle(color: Colors.grey),
      ),
      iconSize: 24,
      elevation: 16,
      style: TextStyle(
        color: Color(0xFF60A2D7),
        fontSize: 16.0,
      ),
      onChanged: (CountryName countryName) {
        _onCountryChanged(countryName);
      },
      items:
      _countryName.map<DropdownMenuItem<CountryName>>((CountryName value) {
        return DropdownMenuItem<CountryName>(
            value: value,
            child: Container(
              width: 220,
              child: Text(
                value.name,
                style: TextStyle(
                  color: Color(0xFF60A2D7),
                  fontSize: 16.0,
                ),
              ),
            ));
      }).toList(),
    );
  }

  Widget _pieChartWidget() {
    return PieChart(
      dataMap: _pieChartData,
      animationDuration: Duration(milliseconds: 800),
      chartLegendSpacing: 32.0,
      chartRadius: MediaQuery.of(context).size.width / 2.6,
      showChartValuesInPercentage: true,
      showChartValues: true,
      showChartValuesOutside: true,
      chartValueBackgroundColor: Colors.grey[200],
      colorList: [Colors.blueAccent, Colors.redAccent, Colors.lightGreenAccent],
      showLegends: true,
      legendPosition: LegendPosition.right,
      decimalPlaces: 1,
      showChartValueLabel: true,
      initialAngle: 0,
      chartValueStyle: defaultChartValueStyle.copyWith(
        color: Colors.blueGrey[900].withOpacity(0.9),
      ),
      chartType: ChartType.disc,
    );
  }

  Widget _loadBarChart() {
    return charts.BarChart(
      _barChartSeries,
      animate: true,
    );
  }

  Widget _sparklineWidget(int index) {
    return Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.brown,
              style: BorderStyle.solid,
              width: 0.5,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(22.0),
          child: Text(
            index == 0 ? "Confirmed" : index == 1 ? "Death" : "Recovered",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14.0,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(22.0),
          child: _sparklineItem(index),
        ),
      ],
    );
  }

  Widget _sparklineItem(int index) {
    if (index == 0) {
      if (_sparklineList[0].confirmed == null ||
          _sparklineList[0].confirmed.length == 0) {
        return _defaultCenterWidget();
      } else {
        return Sparkline(
          data: _sparklineList[0].confirmed,
          pointsMode: PointsMode.all,
          pointSize: 4.0,
          pointColor: Color(0xFF5F7BAD),
          lineColor: Color(0xFF60A2D7),
          lineWidth: 2.0,
        );
      }
    } else if (_sparklineList[0].death == null || index == 1) {
      if (_sparklineList[0].death.length == 0) {
        return _defaultCenterWidget();
      } else {
        return Sparkline(
          data: _sparklineList[0].death,
          pointsMode: PointsMode.all,
          pointSize: 4.0,
          pointColor: Color(0xFF5F7BAD),
          lineColor: Color(0xFF60A2D7),
          lineWidth: 2.0,
        );
      }
    } else {
      if (_sparklineList[0].recovered == null ||
          _sparklineList[0].recovered.length == 0) {
        return _defaultCenterWidget();
      } else {
        return Sparkline(
          data: _sparklineList[0].recovered,
          pointsMode: PointsMode.all,
          pointSize: 4.0,
          pointColor: Color(0xFF5F7BAD),
          lineColor: Color(0xFF60A2D7),
          lineWidth: 2.0,
        );
      }
    }
  }

  @override
  void onLoadException(String error) {
    Scaffold.of(_context).removeCurrentSnackBar();
    Scaffold.of(_context).showSnackBar(SnackBar(
      content: Text("Error While Fetching Data\nPlease Check Your Connection"),
      action: SnackBarAction(
        label: "Retry",
        onPressed: (){
          _loadData();
          Scaffold.of(_context).removeCurrentSnackBar();
        },
      ),
      backgroundColor: Colors.redAccent,
      duration: Duration(seconds: 4),
    ));
  }

  @override
  void onLoadCountryCaseList(List<CountryCaseList> globalCountryCase) {
    setState(() {
      _isLoading = false;
      _isChanged = false;
      _loadPieAndBarData();
      _loadSparklineData(globalCountryCase);
    });
  }
}
