import 'package:covidanalyser/util/Const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class AwareScreen extends StatelessWidget {

  final TextStyle _textStyle = TextStyle(
    fontSize: 12.0,
    color: Colors.black,
  );

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          expandedHeight: 120.0,
          flexibleSpace: Container(
            padding: EdgeInsets.fromLTRB(32.0, 48.0, 44.0, 16.0),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Safety Advice and Tips",
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "Covid19",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 36.0,
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                Image(
                  image: AssetImage('images/corona.png'),
                )
              ],
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
                (context, index) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 16.0, 168.0, 4.0),
                  child: Divider(
                    color: Colors.redAccent,
                    thickness: 2.0,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(22.0, 0.0, 16.0, 12.0),
                  child: Text(
                    "SYMPTOMS",
                    style: TextStyle(
                      color: Colors.redAccent,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  height: 140.0,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: symptomsText.length,
                    itemBuilder: (context, index) {
                      return Container(
                        width: 100.0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            CircleAvatar(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Image(
                                  image: AssetImage(symptomsImage[index]),
                                  height: 60.0,
                                  width: 60.0,
                                ),
                              ),
                              minRadius: 40.0,
                              maxRadius: 40.0,
                              backgroundColor: Colors.green[100],
                            ),
                            Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Text(
                                symptomsText[index],
                                style: _textStyle,
                                softWrap: true,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 22.0, 100.0, 4.0),
                  child: Divider(
                    color: Colors.blueGrey,
                    thickness: 2.0,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(22.0, 0.0, 16.0, 12.0),
                  child: Text(
                    "PREVENTION",
                    style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  height: 280.0,
                  child: GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: List.generate(
                      preventionText.length,
                          (index) {
                        return Container(
                          width: 100.0,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              CircleAvatar(
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Image(
                                    image: AssetImage(preventionImage[index]),
                                    height: 60.0,
                                    width: 60.0,
                                  ),
                                ),
                                minRadius: 40.0,
                                maxRadius: 40.0,
                                backgroundColor: Colors.green[100],
                              ),
                              Padding(
                                padding: EdgeInsets.all(12.0),
                                child: Text(
                                  preventionText[index],
                                  style: _textStyle,
                                  softWrap: true,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 22.0, 128.0, 4.0),
                  child: Divider(
                    color: Colors.blueAccent,
                    thickness: 2.0,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(22.0, 0.0, 16.0, 12.0),
                  child: Text(
                    "IF YOU ARE INFECTED",
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  height: 240.0,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: infectedText.length,
                    itemBuilder: (context, index) {
                      return Container(
                        width: 100.0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            CircleAvatar(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Image(
                                  image: AssetImage(infectedImage[index]),
                                  height: 60.0,
                                  width: 60.0,
                                ),
                              ),
                              minRadius: 40.0,
                              maxRadius: 40.0,
                              backgroundColor: Colors.green[100],
                            ),
                            Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Text(
                                infectedText[index],
                                style: _textStyle,
                                softWrap: true,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            childCount: 1,
          ),
        )
      ],
    );
  }
}