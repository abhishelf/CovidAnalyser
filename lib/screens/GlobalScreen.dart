import 'package:covidanalyser/model/CountryCase.dart';
import 'package:covidanalyser/model/GlobalCase.dart';
import 'package:covidanalyser/util/MyNavigator.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../util/GlobalWidget.dart';

class GlobalScreen extends StatefulWidget {
  final GlobalCase globalCase;

  GlobalScreen({Key key, @required this.globalCase}) : super(key: key);

  @override
  _GlobalScreenState createState() => _GlobalScreenState();
}

class _GlobalScreenState extends State<GlobalScreen> {
  List<CountryCase> _list = List();
  int _menuCurrentIndex = 2;

  NumberFormat _format;

  @override
  void initState() {
    super.initState();
    _list = widget.globalCase.countryCase;
    _format = NumberFormat('##,##,##,###', 'en_US');

    sortList(2);
  }

  void sortList(int index) {
    setState(() {
      _menuCurrentIndex = index;
      if (index == 1) /*BY NAME*/ {
        _list.sort((a, b) => a.countryName.compareTo(b.countryName));
      } else if (index == 2) /*BY CONFIRMED*/ {
        _list.sort((a, b) => (int.parse(b.countryConfirmed)
            .compareTo(int.parse(a.countryConfirmed))));
      } else if (index == 3) /*Last 24 Hour Confirmed*/ {
        _list.sort((a, b) => (int.parse(b.deltaCountryConfirmed)
            .compareTo(int.parse(a.deltaCountryConfirmed))));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          pinned: false,
          floating: true,
          snap: true,
          expandedHeight: 240.0,
          flexibleSpace: Container(
            color: Colors.white,
            padding: EdgeInsets.fromLTRB(0.0, 32.0, 0.0, 0.0),
            child: Card(
              color: Colors.white,
              elevation: 12.0,
              margin: EdgeInsets.all(8.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0)),
              ),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        headerTitleWidget(heading: "Cases In", subHeading: "World"),
                        GestureDetector(
                          child: Container(
                            width: 80.0,
                            height: 40.0,
                            child: Icon(
                              Icons.sort,
                              color: Colors.blue,
                            ),
                          ),
                          onTap: () {
                            _showBottomSheet(context);
                          },
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 16.0),
                    ),
                    headerTotalCaseWidget(
                        confirmed: _format.format(
                            int.parse(widget.globalCase.globalConfirmed)),
                        deaths: _format
                            .format(int.parse(widget.globalCase.globalDeath)),
                        recovered: _format.format(
                            int.parse(widget.globalCase.globalRecovered)),
                        confirmedChange: _format.format(
                            int.parse(widget.globalCase.deltaGlobalConfirmed)),
                        deathsChange: _format.format(
                            int.parse(widget.globalCase.deltaGlobalDeath)),
                        recoveredChange: _format.format(
                            int.parse(widget.globalCase.deltaGlobalRecovered))),
                  ],
                ),
              ),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
                (context, index) => Container(
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  GestureDetector(
                    child: globalCaseWidgetItem(
                        name: _list[index].countryName,
                        total: _format
                            .format(int.parse(_list[index].countryConfirmed)),
                        change: _format.format(
                            int.parse(_list[index].deltaCountryConfirmed))),
                    onTap: () {
                      _showBottomSheetWithCase(context, index);
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(64.0, 0.0, 16.0, 0.0),
                    child: Divider(
                      height: 1.0,
                      color: Colors.grey,
                    ),
                  )
                ],
              ),
            ),
            childCount: _list.length,
          ),
        ),
      ],
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext con) {
        return Container(
          child: Wrap(
            children: <Widget>[
              Center(
                child: Text(
                  "Sort By",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16.0,
                  ),
                ),
              ),
              ListTile(
                title: Text('Country Name'),
                trailing: Radio(
                  value: 1,
                  groupValue: _menuCurrentIndex,
                  onChanged: (value) {
                    sortList(value);
                    Navigator.pop(context);
                  },
                ),
              ),
              ListTile(
                title: Text('Total Confirmed'),
                trailing: Radio(
                  value: 2,
                  groupValue: _menuCurrentIndex,
                  onChanged: (value) {
                    sortList(value);
                    Navigator.pop(context);
                  },
                ),
              ),
              ListTile(
                title: Text('Last Day Confirmed'),
                trailing: Radio(
                  value: 3,
                  groupValue: _menuCurrentIndex,
                  onChanged: (value) {
                    sortList(value);
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showBottomSheetWithCase(BuildContext context, int index) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext con) {
        return Container(
          child: Wrap(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: Center(
                  child: Text(
                    _list[index].countryName,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              ListTile(
                title: Text(
                    _format.format(int.parse(_list[index].countryConfirmed))),
                subtitle: Text("Confirmed"),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Icon(
                      Icons.arrow_drop_up,
                      color: Colors.redAccent,
                      size: 14.0,
                    ),
                    Text(
                      _format.format(
                          int.parse(_list[index].deltaCountryConfirmed)),
                      style: TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 12.0,
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                title: Text(
                    _format.format(int.parse(_list[index].countryRecovered))),
                subtitle: Text("Recovered"),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Icon(
                      Icons.arrow_drop_up,
                      color: Colors.redAccent,
                      size: 14.0,
                    ),
                    Text(
                      _format.format(
                          int.parse(_list[index].deltaCountryRecovered)),
                      style: TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 12.0,
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                title:
                Text(_format.format(int.parse(_list[index].countryDeath))),
                subtitle: Text("Deaths"),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Icon(
                      Icons.arrow_drop_up,
                      color: Colors.redAccent,
                      size: 14.0,
                    ),
                    Text(
                      _format.format(int.parse(_list[index].deltaCountryDeath)),
                      style: TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 12.0,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0,vertical: 8.0),
                    child: FloatingActionButton(
                      child: Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                      backgroundColor: Colors.blue,
                      onPressed: () {
                        MyNavigator.goToDetailPage(
                          context,
                          _list[index].countryName,
                          _list[index].countrySlug,
                        );
                      },
                    ),
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}