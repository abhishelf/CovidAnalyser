import 'package:covidanalyser/model/IndiaCase.dart';
import 'package:covidanalyser/util/GlobalWidget.dart';
import 'package:covidanalyser/util/MyNavigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';

class IndiaScreen extends StatefulWidget {
  final List<IndiaCase> indiaCase;

  IndiaScreen({Key key, @required this.indiaCase}) : super(key: key);

  @override
  _IndiaScreenState createState() => _IndiaScreenState();
}

class _IndiaScreenState extends State<IndiaScreen>
    with SingleTickerProviderStateMixin {
  List<IndiaCase> _list = List();
  int _currentIndex = 2;

  NumberFormat _format;

  String _confirmed;
  String _deaths;
  String _recovered;
  String _deltaConfirmed;
  String _deltaDeaths;
  String _deltaRecovered;

  @override
  void initState() {
    super.initState();
    for (int i = 1; i < widget.indiaCase.length; i++) {
      _list.add(widget.indiaCase[i]);
    }
    _confirmed = widget.indiaCase[0].confirmed;
    _deaths = widget.indiaCase[0].deaths;
    _recovered = widget.indiaCase[0].recovered;
    _deltaConfirmed = widget.indiaCase[0].deltaConfirmed;
    _deltaDeaths = widget.indiaCase[0].deltaDeaths;
    _deltaRecovered = widget.indiaCase[0].deltaRecovered;

    _format = NumberFormat('##,##,##,###', 'en_US');
  }

  void sortList(int index) {
    setState(() {
      _currentIndex = index;
      if (index == 1) /*BY NAME*/ {
        _list.sort((a, b) => a.placeName.compareTo(b.placeName));
      } else if (index == 2) /*BY CONFIRMED*/ {
        _list.sort((a, b) =>
        (int.parse(b.confirmed).compareTo(int.parse(a.confirmed))));
      } else if (index == 3) /*Last 24 Hour Confirmed*/ {
        _list.sort((a, b) => (int.parse(b.deltaConfirmed)
            .compareTo(int.parse(a.deltaConfirmed))));
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
                        headerTitleWidget(heading: "Cases In", subHeading: "India"),
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
                        confirmed: _format.format(int.parse(_confirmed)),
                        deaths: _format.format(int.parse(_deaths)),
                        recovered: _format.format(int.parse(_recovered)),
                        confirmedChange:
                        _format.format(int.parse(_deltaConfirmed)),
                        deathsChange: _format.format(int.parse(_deltaDeaths)),
                        recoveredChange:
                        _format.format(int.parse(_deltaRecovered))),
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
                        name: _list[index].placeName,
                        total: _format.format(int.parse(_list[index].confirmed)),
                        change: _format
                            .format(int.parse(_list[index].deltaConfirmed))),
                    onTap: (){
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
                title: Text('State Name'),
                trailing: Radio(
                  value: 1,
                  groupValue: _currentIndex,
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
                  groupValue: _currentIndex,
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
                  groupValue: _currentIndex,
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
                    _list[index].placeName,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              ListTile(
                title: Text(_format.format(int.parse(_list[index].confirmed))),
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
                      _format.format(int.parse(_list[index].deltaConfirmed)),
                      style: TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 12.0,
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                title: Text(_format.format(int.parse(_list[index].recovered))),
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
                      _format.format(int.parse(_list[index].deltaRecovered)),
                      style: TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 12.0,
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                title: Text(_format.format(int.parse(_list[index].deaths))),
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
                      _format.format(int.parse(_list[index].deltaDeaths)),
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
                          "India",
                          "india",
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