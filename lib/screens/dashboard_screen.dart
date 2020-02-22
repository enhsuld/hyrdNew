import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hyrd/screens/add_car_screen.dart';
import 'package:hyrd/screens/bottom_bar.dart';
import 'package:hyrd/screens/notification/notification_screen.dart';
import 'package:hyrd/screens/profile/setting_screen.dart';
import 'package:hyrd/screens/profile_screen.dart';
import 'package:hyrd/utils/fade_route.dart';
import 'package:hyrd/widget/recent_list_item.dart';
import 'package:page_transition/page_transition.dart';

import '../models/car.dart';
import '../widget/vertical_list_item.dart';
import '../widget/horizontal_list_item.dart';

class DashboardScreen extends StatefulWidget {
  static const routeName = '/home';

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  CarouselSlider carouselSlider;

  int _current = 0;

  List imgList = [
    'assets/images/audi_lonetree.png',
    'assets/images/sell-lexus.png',
    'assets/images/auction-land.png',
    'assets/images/audi_lonetree.png',
    'assets/images/sell-lexus.png',
  ];

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              padding:
                  EdgeInsets.only(top: 40, left: 20, right: 20, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Нүүр',
                    style: TextStyle(
                      fontSize: 21.0,
                      color: Color(0xFF222455),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    alignment: Alignment.topRight,
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: 30,
                          child: IconButton(
                            icon: Icon(Icons.notifications),
                            onPressed: () {
                              Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft,duration: Duration(microseconds: 300000), child: NotificationScreen()));
                            },
                            color: Color(0xFF222455),
                            iconSize: 20.0,
                          ),
                        ),
                        Container(
                          width: 30,
                          child: IconButton(
                            icon: Icon(Icons.format_line_spacing),
                            onPressed: () {
                              Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft,duration: Duration(microseconds: 300000), child: SettingScreen()));
                            },
                            color: Color(0xFF222455),
                            iconSize: 20.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            CarouselSlider(
              height: 190.0,
              initialPage: 0,
              enlargeCenterPage: true,
              autoPlay: false,
              reverse: false,
              enableInfiniteScroll: true,
              autoPlayInterval: Duration(seconds: 2),
              autoPlayAnimationDuration: Duration(milliseconds: 2000),
              pauseAutoPlayOnTouch: Duration(seconds: 10),
              scrollDirection: Axis.horizontal,
              onPageChanged: (index) {
                setState(() {
                  _current = index;
                });
              },
              items: imgList.map((imgUrl) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        ),
                        child: Stack(
                          children: <Widget>[
                            new ClipRRect(
                                borderRadius: new BorderRadius.circular(8.0),
                                child: Image.asset(imgUrl, fit: BoxFit.fill)),
                          ],
                        ));
                  },
                );
              }).toList(),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: map<Widget>(imgList, (index, url) {
                return Container(
                  width: 10.0,
                  height: 4.0,
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 3.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: _current == index ? Color(0xFF584BDD) : Colors.grey,
                  ),
                );
              }),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10, left: 20, right: 5, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Эрэлттэй зарууд',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF222455),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  FlatButton(
                    child: Text(
                      'бүгдийг харах',
                      style: TextStyle(color: Color(0xFF6E7FAA), fontSize: 13),
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            Container(
              height: 270,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: topRatedCarList.length,
                itemBuilder: (ctx, i) => HorizontalListItem(i),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, top: 20, right: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Онцлох',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF222455),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  FlatButton(
                    child: Text(
                      'бүгдийг харах',
                      style: TextStyle(color: Color(0xFF6E7FAA), fontSize: 13),
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            Container(
              height: double.parse(highlighted.length.toString()) * 118,
              padding: EdgeInsets.only(bottom: 20, top: 0, left: 10, right: 10),
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: highlighted.length,
                itemBuilder: (ctx, i) => VerticalListItem(i),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10, left: 20, right: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Мэдээлэл',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF222455),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: double.parse(recentCarList.length.toString()) * 110,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: recentCarList.length,
                itemBuilder: (ctx, i) => RecentListItem(i),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
