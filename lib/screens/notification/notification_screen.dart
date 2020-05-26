import 'package:flutter/material.dart';
import 'package:hyrd/screens/login/login_screen.dart';
import 'package:hyrd/screens/login/signUp/step_one.dart';
import 'package:hyrd/screens/notification/notification_settings_screen.dart';
import 'package:hyrd/screens/notification/read_list_item.dart';
import 'package:hyrd/screens/notification/today_list_item.dart';
import 'package:hyrd/screens/notification/unread_list_item.dart';
import 'package:hyrd/screens/profile/notification_screen.dart';
import 'package:hyrd/services/BackendService.dart';
import 'package:hyrd/utils/fade_route.dart';
import 'package:hyrd/utils/hyrd_new_icons_icons.dart';
import 'package:page_transition/page_transition.dart';

import '../../models/car.dart';

class NotificationScreen extends StatefulWidget {
  static const routeName = '/notification';

  @override
  _AdScreenState createState() => _AdScreenState();
}

class _AdScreenState extends State<NotificationScreen> {
  bool isLogin = false;

  @override
  void initState() {
   /* BackendService.getNotification(url: '/mark').then((value) {
      setState(() {

      });
    });*/
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    BackendService.getToken().then((_token) {
      if (mounted) {
        setState(() {
          if (_token != null && _token != "") {
            isLogin = true;
          } else
            isLogin = false;
        });
      }
    });
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
      body:  isLogin ? SingleChildScrollView(
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
      )) :
      Container(
          child:Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(top: 40),
                  padding: EdgeInsets.symmetric(vertical: 40),
                  child: Text(
                    "Та системд нэвтрэнэ үү.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color(0xff222455), fontSize: 18),
                  ),
                ),
                new Card(
                  margin: EdgeInsets.only(
                      top: 10, left: 20, right: 20, bottom: 10),
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 5,
                  child: MaterialButton(
                    padding: EdgeInsets.all(0),
                    onPressed: () {
                      Navigator.push(
                          context,
                          FadeRoute(
                              builder: (context) => LoginScreen()));
                    },
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: <Color>[
                                Color(0xFFB755FF),
                                Color(0xFF584BDD),
                              ],
                            ),
                            borderRadius: BorderRadius.all(
                                Radius.circular(8.0))),
                        padding:
                        const EdgeInsets.fromLTRB(25, 15, 25, 15),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("Нэвтрэх",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16)),
                            Icon(HyrdNewIcons.car_login,
                                color: Colors.white, size: 22.0)
                          ],
                        )),
                  ),
                ),
                new Card(
                  margin:
                  EdgeInsets.only(top: 10, left: 20, right: 20),
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 5,
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => StepOneScreen()));
                    },
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(
                                Radius.circular(8.0))),
                        padding:
                        const EdgeInsets.fromLTRB(10, 15, 10, 15),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("Бүртгүүлэх",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Color(0xff584BDD),
                                    fontSize: 16)),
                            Icon(HyrdNewIcons.car_register,
                                color: Color(0xff584BDD), size: 22.0)
                          ],
                        )),
                  ),
                )
              ],
            ),
          )
      ),
    );
  }
}
