import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';
import 'package:hyrd/models/car_model.dart';
import 'package:hyrd/models/post_model.dart';
import 'package:hyrd/screens/notification/notification_screen.dart';
import 'package:hyrd/screens/popular_ads_screen.dart';
import 'package:hyrd/screens/profile/setting_screen.dart';
import 'package:hyrd/screens/special_ads_screen.dart';
import 'package:hyrd/services/BackendService.dart';
import 'package:hyrd/utils/fade_route.dart';
import 'package:hyrd/utils/hyrd_icons.dart';
import 'package:hyrd/widget/horizontal_car_item.dart';
import 'package:hyrd/widget/recent_list_item.dart';
import 'package:hyrd/widget/vertical_ads_item.dart';
import 'package:hyrd/widget/vertical_news_item.dart';
import 'package:page_transition/page_transition.dart';

import '../models/car.dart';

class DashboardScreen extends StatefulWidget {
  static const routeName = '/home';

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  CarouselSlider carouselSlider;

  static const int PAGE_SIZE = 2;

  int _current = 1;

  List imgList = [
    'assets/images/img1.jpg',
    'assets/images/img2.jpg',
    'assets/images/img3.png',
    'assets/images/img4.jpg',
    'assets/images/img5.jpg',
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
                            icon: Icon(Hyrd.notification_on),
                            onPressed: () {
                              Navigator.push(context, FadeRoute(builder: (context) => NotificationScreen()));
                            },
                            color: Color(0xFF222455),
                            iconSize: 20.0,
                          ),
                        ),
                        Container(
                          width: 30,
                          child: IconButton(
                            icon: Icon(Hyrd.settings),
                            onPressed: () {
                              Navigator.push(context, FadeRoute(builder: (context) => SettingScreen()));
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
              initialPage: 1,
              viewportFraction: 0.8,
              aspectRatio: MediaQuery.of(context).size.aspectRatio,
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
                        child: Stack(
                          children: <Widget>[
                            new ClipRRect(
                                borderRadius: new BorderRadius.circular(8.0),
                                child: Image.asset(imgUrl,
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height,
                                    fit: BoxFit.fill)),
                          ],
                        ));
                  },
                );
              }).toList(),
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
              padding: EdgeInsets.only(top: 10, left: 20, right: 5),
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
                    onPressed: () {
                      Navigator.push(context, FadeRoute(builder: (context) => PopularAdsScreen()));
                    },
                  ),
                ],
              ),
            ),
            Container(
                height: 270,
                child: FutureBuilder(
                  future: BackendService.getPopular(page: 1, pageSize: 5),
                  builder: (context, snapshot) {
                    List<dynamic> adsPopulars;
                    if (snapshot.hasData) {
                      adsPopulars = snapshot.data;
                      return ListView.builder(
                        padding: EdgeInsets.only(top: 0, bottom: 0),
                        scrollDirection: Axis.horizontal,
                        itemCount: adsPopulars.length,
                        itemBuilder: (ctx, i) => HorizontalCarItem(
                            index: i, item: CarModel.fromJson(adsPopulars[i])),
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                )),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 5),
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
                    onPressed: () {
                      Navigator.push(context, FadeRoute(builder: (context) => SpecialAdsScreen()));
                    },
                  ),
                ],
              ),
            ),
            FutureBuilder(
              future: BackendService.getHighlight(page: 1, pageSize: 5),
              builder: (context, snapshot) {
                List<dynamic> lists;
                if (snapshot.hasData) {
                  lists = snapshot.data;
                  return Container(
                    height: double.parse(lists.length.toString()) * 110,
                    padding: EdgeInsets.only(
                        bottom: 20, top: 0, left: 10, right: 10),
                    child: ListView.builder(
                      padding: EdgeInsets.only(top: 0, bottom: 0),
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: lists.length,
                      itemBuilder: (ctx, i) => VerticalAdsItem(
                        index: i,
                        item: CarModel.fromJson(lists[i]["car_ad"]),
                      ),
                    ),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Шинээр нэмэгдсэн',
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
                    onPressed: () {
                      Navigator.push(context, FadeRoute(builder: (context) => SpecialAdsScreen()));
                    },
                  ),
                ],
              ),
            ),
            FutureBuilder(
              future: BackendService.getHighlight(page: 1, pageSize: 5),
              builder: (context, snapshot) {
                List<dynamic> lists;
                if (snapshot.hasData) {
                  lists = snapshot.data;
                  return Container(
                    height: double.parse(lists.length.toString()) * 110,
                    padding: EdgeInsets.only(
                        bottom: 10, top: 0, left: 10, right: 10),
                    child: ListView.builder(
                      padding: EdgeInsets.only(top: 0, bottom: 0),
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: lists.length,
                      itemBuilder: (ctx, i) => VerticalAdsItem(
                        index: i,
                        item: CarModel.fromJson(lists[i]["car_ad"]),
                      ),
                    ),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 5),
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
              height: 400,
              padding: EdgeInsets.only(top:15,left:10,right:10),
              child: RefreshIndicator(
                onRefresh: () async {
                  PagewiseLoadController(
                      pageSize: PAGE_SIZE,
                      pageFuture: (pageIndex) => BackendService.getPosts(
                          pageIndex + 1,
                          PAGE_SIZE)).reset();
                  await Future.value({});
                },
                child: PagewiseListView(
                  padding: EdgeInsets.all(0),
                  itemBuilder: this._itemBuilder,
                  pageLoadController: PagewiseLoadController(
                      pageSize: PAGE_SIZE,
                      pageFuture: (pageIndex) => BackendService.getPosts(
                          pageIndex + 1,
                          PAGE_SIZE)),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }
  Widget _itemBuilder(context, PostModel entry, _) {
    return VerticalNewsItem(item: entry);
  }
}
