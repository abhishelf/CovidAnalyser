import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

List<Color> colorOne = [
  Colors.brown,
  Colors.greenAccent[200],
  Colors.orangeAccent,
  Colors.blueGrey,
  Colors.deepPurpleAccent,
  Colors.cyan
];

List<Color> colorTwo = [
  Colors.brown,
  Colors.greenAccent[100],
  Colors.orangeAccent,
  Colors.blueGrey,
  Colors.amberAccent[100]
];

Widget headerTitleWidget({@required String heading, @required String subHeading}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Text(
        heading,
        style: TextStyle(
          color: Colors.black54,
          fontSize: 16.0,
          fontWeight: FontWeight.w500,
        ),
      ),
      Text(
        subHeading,
        style: TextStyle(
          color: Colors.black,
          fontSize: 36.0,
          fontWeight: FontWeight.w700,
        ),
      ),
    ],
  );
}

Widget headerTotalCaseWidget(
    {@required String confirmed,
    @required String deaths,
    @required String recovered,
    @required String confirmedChange,
    @required String deathsChange,
    @required String recoveredChange}) {
  return Container(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Confirmed",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16.0,
                  ),
                ),
                Text(
                  confirmed,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 22.0,
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.arrow_drop_up,
                  color: Colors.redAccent,
                ),
                Text(
                  confirmedChange,
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 16.0,
                  ),
                )
              ],
            )
          ],
        ),
        Padding(
          padding: EdgeInsets.only(top: 16.0),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            totalCaseWidgetItem("Recovered", recovered, recoveredChange,
                Colors.lightGreenAccent),
            totalCaseWidgetItem("Death", deaths, deathsChange, Colors.purpleAccent),
          ],
        )
      ],
    ),
  );
}

Widget totalCaseWidgetItem(
    String title, String total, String change, Color materialColor) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Icon(
            Icons.arrow_drop_up,
            color: materialColor,
            size: 16.0,
          ),
          Text(
            change,
            style: TextStyle(color: Colors.blueGrey, fontSize: 12.0),
          ),
          Padding(
            padding: EdgeInsets.only(left: 4.0),
          ),
          Text(
            total,
            style: TextStyle(color: Colors.black, fontSize: 18.0),
          ),
        ],
      ),
      Text(
        title,
        style: TextStyle(color: Colors.grey, fontSize: 16.0),
      ),
    ],
  );
}

Widget globalCaseWidgetItem(
    {@required String name, @required String total, @required String change}) {
  return ListTile(
    title: Text(
      total,
      style: TextStyle(
        color: Colors.black,
        fontSize: 16.0,
      ),
    ),
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
          change,
          style: TextStyle(
            color: Colors.blueGrey,
            fontSize: 12.0,
          ),
        ),
      ],
    ),
    leading: CircleAvatar(
      backgroundColor: colorOne[Random().nextInt(colorOne.length)],
      child: Text(
        name[0],
        style: TextStyle(
          color: Colors.white,
          fontSize: 16.0,
        ),
      ),
    ),
    subtitle: Text(
      name,
      style: TextStyle(color: Colors.grey, fontSize: 12.0),
    ),
  );
}
