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


  Widget _buildCoverImage(Size screenSize) {
    return Container(
      //height: 90,
      padding: EdgeInsets.only(right: 20,left: 20,bottom: 20,top:40),
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          new SizedBox(
              height: 20.0,
              width: 25.0,
              child: new IconButton(
                focusColor: Colors.blue,
                padding: new EdgeInsets.all(0.0),
                color: Colors.white,
                icon: new Icon(Icons.arrow_back_ios, size: 25.0),
                onPressed: (){
                  Navigator.pop(context);
                },
              )
          ),
          Text(
            "Мэдэгдлүүд",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Roboto',
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          new SizedBox(
              height: 20.0,
              width: 25.0,
              child: new IconButton(
                focusColor: Colors.blue,
                padding: new EdgeInsets.all(0.0),
                color: Colors.white,
                icon: new Icon(Icons.format_line_spacing, size: 25.0),
                onPressed: (){
                  Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft,duration: Duration(microseconds: 300000), child: NotificationSettingsScreen()));
                },
              )
          )
        ],
      ),
      decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.topRight,
            colors: <Color>[Color(0xFF584BDD), Color(0xFFB755FF)],
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _buildCoverImage(screenSize),
            Container(
              padding: EdgeInsets.only(top:20,left: 20,right: 20),
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Уншаагүй",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color(0xFF222455),
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600
                    ),
                  ),
                  Text(
                    "цэвэрлэх",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color(0xFF6E7FAA),
                        fontSize: 13.0
                    ),
                  )
                ],
              ),
            ),
            Container(
              transform: Matrix4.translationValues(0.0, -10.0, 0.0),
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
              padding: EdgeInsets.only(left: 20,right: 20),
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
                        fontWeight: FontWeight.w600
                    ),
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
              padding: EdgeInsets.only(left: 20,right: 20),
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
                        fontWeight: FontWeight.w600
                    ),
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
        )
      ),
    );
  }
}
