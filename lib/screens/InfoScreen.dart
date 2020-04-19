import 'dart:math';

import 'package:covidanalyser/util/Const.dart';
import 'package:covidanalyser/util/GlobalWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoScreen extends StatefulWidget {
  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          expandedHeight: 150.0,
          flexibleSpace: Container(
            padding: EdgeInsets.fromLTRB(32.0, 48.0, 44.0, 16.0),
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Important Links",
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "Info",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 36.0,
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      child: Icon(Icons.share,color: Colors.blue,size: 22.0,),
                      onTap: (){
                        //TODO 2
                        _launchURL("");
                      },
                    ),
                    GestureDetector(
                      // TODO 3
                      child: Icon(Icons.star_half,color: Colors.green,size: 22.0,),
                      onTap: (){
                        _launchURL("");
                      },
                    ),
                    GestureDetector(
                      child: Icon(Icons.email,color: Colors.brown,size: 22.0,),
                      onTap: (){
                        _launchURL("mailto:imabhishek.dev@gmail.com?subject=Covid19");
                      },
                    )
                  ],
                )
              ],
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
                (context, index) => GestureDetector(
              onTap: (){
                if(index<linkList.length){
                  _launchURL(linkList[index].link);
                }
              },
              child: Container(
                child: _getListItem(index),
              ),
            ),
            childCount: linkList.length+1,
          ),
        ),
      ],
    );
  }

  Widget _getListItem(int index) {
    if(index == linkList.length){
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 16.0,bottom: 8.0),
          ),
          Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(right:8.0,left: 16.0),
                  child: Divider(
                    color: Colors.grey,
                    thickness: 0.5,
                  ),
                ),
              ),
              Text(
                "Developed By\nAbhishek",
                style: TextStyle(color: Colors.grey, fontSize: 14.0),
                textAlign: TextAlign.center,
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(right:16.0,left: 8.0),
                  child: Divider(
                    color: Colors.grey,
                    thickness: 0.5,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 16.0),
          ),
        ],
      );
    }

    if(index == 0){
      return Padding(
        padding: const EdgeInsets.only(top:12.0),
        child: ListTile(
          title: Text(
            linkList[index].source,
            style: TextStyle(color: Colors.black),
          ),
          subtitle: Text(
            linkList[index].link,
            style: TextStyle(color: Colors.blue),
          ),
          leading: CircleAvatar(
            backgroundColor: colorOne[Random().nextInt(colorOne.length)],
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image(
                image: AssetImage(linkList[index].images),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      );
    }

    return ListTile(
      title: Text(
        linkList[index].source,
        style: TextStyle(color: Colors.black),
      ),
      subtitle: Text(
        linkList[index].link,
        style: TextStyle(color: Colors.blue),
      ),
      leading: CircleAvatar(
        backgroundColor: colorTwo[Random().nextInt(colorTwo.length)],
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image(
            image: AssetImage(linkList[index].images),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}