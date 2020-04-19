import 'package:covidanalyser/model/CountryCaseList.dart';
import 'package:covidanalyser/presenter/GlobalCountryCasePresenter.dart';
import 'package:covidanalyser/util/Const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetailPage extends StatefulWidget {
  final String countryName;
  final String slug;

  DetailPage({Key key, @required this.countryName, @required this.slug})
      : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage>
    with CountryCaseListViewContract {
  CountryCaseListPresenter _presenter;
  List<CountryCaseList> _countryCaseList = List();
  List<CountryCaseList> _listToShow = List();

  bool _isLoading = true;
  bool _isTotal = true;
  bool _isUnited = false;
  int _currentIndex = 0;

  NumberFormat _numberFormat;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();
    _numberFormat = NumberFormat('##,##,##,###', 'en_US');
    if(equalsIgnoreCase(widget.slug, "united-states")){
      _isLoading = false;
      _isUnited = true;
      return;
    }

    _isLoading = true;
    _presenter = CountryCaseListPresenter(this);
    _presenter.loadCountryCaseList(widget.slug);

    _scrollController
      ..addListener(() {
        var triggerFetchMoreSize =
            0.9 * _scrollController.position.maxScrollExtent;

        if (_scrollController.position.pixels >
            triggerFetchMoreSize) {
          if(_countryCaseList != null && _currentIndex < _countryCaseList.length){
            _loadData();
          }
        }
      });
  }

  String _getReqCases(int index, int pos) {
    if (_isTotal) {
      return pos == 0
          ? _listToShow[index].confirmed
          : pos == 1
          ? _listToShow[index].deaths
          : _listToShow[index].recovered;
    }

    if (index == _listToShow.length - 1) {
      return pos == 0
          ? _listToShow[index].confirmed
          : pos == 1
          ? _listToShow[index].deaths
          : _listToShow[index].recovered;
    } else {
      return pos == 0
          ? (int.parse(_listToShow[index].confirmed) -
          int.parse(_listToShow[index + 1].confirmed))
          .toString()
          : pos == 1
          ? (int.parse(_listToShow[index].deaths) -
          int.parse(_listToShow[index + 1].deaths))
          .toString()
          : (int.parse(_listToShow[index].recovered) -
          int.parse(_listToShow[index + 1].recovered))
          .toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          widget.countryName,
          style: TextStyle(color: Colors.white),
        ),
        actions: <Widget>[
          GestureDetector(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Icon(
                Icons.track_changes,
                color: Colors.white,
              ),
            ),
            onTap: () {
              setState(() {
                _isTotal = !_isTotal;
              });

              _scaffoldKey.currentState.removeCurrentSnackBar();
              _scaffoldKey.currentState.showSnackBar(SnackBar(
                content: _isTotal?Text("Showing Total Case Till Date"):Text("Showing Case On Given Date"),
                backgroundColor: Colors.green,
                duration: Duration(seconds: 4),
              ));
            },
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: _screenWidget(),
    );
  }

  Widget _screenWidget() {
    if ((_isUnited || (_listToShow == null || _listToShow.length == 0))) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          (!_isLoading)
              ? Center(
            child: Text(
              "Sorry!!!\nData For This Country Will Be Available Soon\nTry With Another Country For Now",
              textAlign: TextAlign.center,
              softWrap: true,
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          )
              : Center(child: CircularProgressIndicator()),
        ],
      );
    }

    return Container(
      padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 16.0),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Confirmed",
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 16.0,
                ),
              ),
              Text(
                "Deaths",
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 16.0,
                ),
              ),
              Text(
                "Recovered",
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
          Flexible(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: _listToShow.length,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        _numberFormat.format(int.parse(_getReqCases(index, 0))),
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        _numberFormat.format(int.parse(_getReqCases(index, 1))),
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        _numberFormat.format(int.parse(_getReqCases(index, 2))),
                        style: TextStyle(
                          color: Colors.orangeAccent,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  subtitle: Text(
                    convertStrToDate(_listToShow[index].date),
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  void _loadData(){
    setState(() {
      if(_currentIndex + 30 <= _countryCaseList.length){
        _listToShow..addAll(List<CountryCaseList>.from(_countryCaseList.sublist(_currentIndex,_currentIndex+30)));
      }else{
        _listToShow..addAll(List<CountryCaseList>.from(_countryCaseList.sublist(_currentIndex,_countryCaseList.length)));
      }
      _currentIndex += 30;

      _isLoading = false;
    });
  }

  @override
  void onLoadCountryCaseList(List<CountryCaseList> countryCaseList) {
    _countryCaseList = countryCaseList;
    _countryCaseList = reverseList(_countryCaseList);
    _countryCaseList.removeAt(0);
    _countryCaseList = combineListElement(countryCaseList);
    _loadData();
  }

  @override
  void onLoadException(String error) {
    setState(() {
      _isLoading = false;
    });
    print(error);
    _scaffoldKey.currentState.removeCurrentSnackBar();
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text("Please Check Your Connection"),
      action: SnackBarAction(
        label: "Retry",
        onPressed: () {
          _presenter.loadCountryCaseList(widget.slug);
          _scaffoldKey.currentState.removeCurrentSnackBar();
          setState(() {
            _isLoading = true;
          });
        },
      ),
      backgroundColor: Colors.redAccent,
      duration: Duration(minutes: 3),
    ));
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}