import 'package:flutter/material.dart';
import 'package:hyrd/screens/notification/notification_settings_screen.dart';
import 'package:hyrd/screens/notification/read_list_item.dart';
import 'package:hyrd/screens/notification/today_list_item.dart';
import 'package:hyrd/screens/notification/unread_list_item.dart';
import 'package:hyrd/screens/profile/notification_screen.dart';
import 'package:page_transition/page_transition.dart';

import '../../models/car.dart';

class NotificationScreen extends StatefulWidget {
  static const routeName = '/notification';

  @override
  _AdScreenState createState() => _AdScreenState();
}

class _AdScreenState extends State<NotificationScreen> {

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.topRight,
                colors: <Color>[Color(0xFF584BDD), Color(0xFFB755FF)],
              )),
        ),
        centerTitle: true,
        leading: Builder(builder: (BuildContext context) {
          return new SizedBox(
              height: 18.0,
              width: 18.0,
              child: new IconButton(
                padding: new EdgeInsets.all(0.0),
                color: Colors.white,
                icon: new Icon(Icons.arrow_back_ios, size: 20.0),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ));
        }),
        title: Text("Мэдэгдлүүд",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
          child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 10, left: 20, right: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Уншаагүй',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF222455),
                  ),
                ),
                FlatButton(
                  child: Text(
                    'цэвэрлэх',
                    style: TextStyle(color: Color(0xFF6E7FAA), fontSize: 13),
                  ),
                  onPressed: () {
                    //  Navigator.push(context, FadeRoute(builder: (context) => PopularAdsScreen()));
                  },
                ),
              ],
            ),
          ),
          Container(
            height: double.parse(highlighted.length.toString()) * 118,
            padding: EdgeInsets.only(left: 10, right: 10),
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: highlighted.length,
              itemBuilder: (ctx, i) => UnreadListItem(i),
            ),
          ),
          Container(
            transform: Matrix4.translationValues(0.0, -10.0, 0.0),
            padding: EdgeInsets.only(left: 20, right: 20),
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Өнөөдөр",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color(0xFF222455),
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600),
                )
              ],
            ),
          ),
          Container(
            transform: Matrix4.translationValues(0.0, -10.0, 0.0),
            height: double.parse(topRatedCarList.length.toString()) * 118,
            padding: EdgeInsets.only(bottom: 20, top: 0, left: 10, right: 10),
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: topRatedCarList.length,
              itemBuilder: (ctx, i) => TodayListItem(i),
            ),
          ),
          Container(
            transform: Matrix4.translationValues(0.0, -10.0, 0.0),
            padding: EdgeInsets.only(left: 20, right: 20),
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Уншигдсан",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color(0xFF222455),
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600),
                )
              ],
            ),
          ),
          Container(
            transform: Matrix4.translationValues(0.0, -10.0, 0.0),
            height: double.parse(recentCarList.length.toString()) * 118,
            padding: EdgeInsets.only(bottom: 20, top: 0, left: 10, right: 10),
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: recentCarList.length,
              itemBuilder: (ctx, i) => ReadListItem(i),
            ),
          ),
        ],
      )),
    );
  }
}
