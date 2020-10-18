import 'dart:collection';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hyrd/models/car_model.dart';
import 'package:hyrd/screens/login/login_screen.dart';
import 'package:hyrd/screens/main/tab_address_screen.dart';
import 'package:hyrd/screens/main/tab_advertisement_screen.dart';
import 'package:hyrd/screens/main/tab_home_screen.dart';
import 'package:hyrd/screens/main/tab_news_screen.dart';
import 'package:hyrd/services/BackendService.dart';
import 'package:hyrd/utils/fade_route.dart';
import 'package:hyrd/utils/functions.dart';
import 'package:hyrd/utils/hyrd_icons.dart';
import 'package:hyrd/utils/lang.dart';

class DealerScreen extends StatefulWidget {
  static const routeName = '/dealer-details';

  final CarModel item;

  DealerScreen({Key key, @required this.item}) : super(key: key);

  @override
  _DealerScreenState createState() => _DealerScreenState();
}

class _DealerScreenState extends State<DealerScreen>
    with TickerProviderStateMixin {
  CarouselSlider carouselSlider;
  int _current = 0;
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

  double screenSize;
  double screenRatio;
  AppBar appBar;
  List<Tab> tabList = List();
  TabController _tabController;

  bool isFollowing = false;

  @override
  void initState() {
    Map<String, dynamic> map = new HashMap();
    map["organization_id"] = widget.item.user.org.id;

    BackendService.getIsFollowing(body: map).then((data) {
      setState(() {
        this.isFollowing = data;
        print(data);
      });
    });

    tabList.add(new Tab(
      text: lang.HOME,
    ));
    tabList.add(new Tab(
      text: lang.ADDRESS,
    ));
    tabList.add(new Tab(text: lang.ADSs));
    tabList.add(new Tab(
      text: lang.INFO,
    ));
    _tabController = new TabController(vsync: this, length: tabList.length);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    appBar = AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
    );
    screenSize = MediaQuery.of(context).size.width;

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
        title: Text(lang.ORG,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
        elevation: 0.0,
      ),
      body: Container(
          color: Colors.blue,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: <Widget>[
              Scaffold(
                body: Stack(
                  children: <Widget>[
                    new Positioned(
                      right: 0,
                      left: 0,
                      top: 0,
                      child: Container(
                        color: Colors.blueGrey,
                        child: CarouselSlider(
                          options: CarouselOptions(
                              autoPlay: true,
                              height: 200,
                              aspectRatio:
                                  MediaQuery.of(context).size.aspectRatio,
                              enlargeCenterPage: true,
                              viewportFraction: 1,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  _current = index;
                                });
                              }),
                          items: widget.item.user.org.medias.map((imgUrl) {
                            return InkWell(
                                onTap: () {
                                  cusfunc.openGallery(context, _current,
                                      widget.item.user.org.medias);
                                },
                                child: Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 0.0),
                                    child: Image.network(imgUrl.optimized,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        fit: BoxFit.fitWidth)));
                          }).toList(),
                        ),
                      ),
                    ),
                    // new Positioned(
                    //   top: 30,
                    //   right: 20,
                    //   left: 0,
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: <Widget>[
                    //       IconButton(
                    //         padding: new EdgeInsets.only(left: 5),
                    //         color: Colors.white,
                    //         icon: new Icon(Icons.arrow_back_ios, size: 25.0),
                    //         onPressed: () {
                    //           Navigator.of(context).pop();
                    //         },
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    new Positioned(
                      top: 170,
                      right: 20,
                      left: 20,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: map<Widget>(widget.item.user.org.medias,
                            (index, url) {
                          return Container(
                            width: 10.0,
                            height: 3.0,
                            margin: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 3.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: _current == index
                                  ? Color(0xFF584BDD)
                                  : Colors.white,
                            ),
                          );
                        }),
                      ),
                    ),
                    Positioned(
                        right: 10,
                        left: 10,
                        top: 190,
                        child: Container(
                            width: MediaQuery.of(context).size.width - 30,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  elevation: 5,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        child: Row(
                                          children: <Widget>[
                                            Container(
                                              height: 50,
                                              width: 50,
                                              margin: EdgeInsets.symmetric(
                                                  vertical: 20, horizontal: 20),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Color(0xFFB6BED4),
                                                    width: 2),
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                  image: (widget.item?.user?.org
                                                              ?.avatar ==
                                                          null)
                                                      ? AssetImage(
                                                          'assets/images/defualt-org.png')
                                                      : NetworkImage(widget.item
                                                          .user.org.avatar),
                                                  fit: BoxFit.cover,
                                                ),
                                                /*image: DecorationImage(fit: BoxFit.cover, image: NetworkImage(widget.item.user.org.avatar)),*/
                                              ),
                                            ),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  260,
                                              height: 70,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: <Widget>[
                                                  Text(
                                                    widget.item.user.org.name,
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: Color(0xFF222455),
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  Text(
                                                    widget
                                                        .item.user.org.service,
                                                    style: TextStyle(
                                                      fontSize: 10,
                                                      color: Color(0xFF6E7FAA),
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  Text(
                                                    widget.item.user.org.phone,
                                                    style: TextStyle(
                                                      fontSize: 10,
                                                      color: Color(0xFF6E7FAA),
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(right: 20),
                                        height: 70,
                                        width: 120,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: <Widget>[
                                                Container(
                                                    margin: EdgeInsets.only(
                                                        right: 10),
                                                    child: new Icon(Hyrd.team,
                                                        color:
                                                            Color(0xFF6E7FAA),
                                                        size: 16.0)),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      right: 15),
                                                  child: Text(
                                                    (widget
                                                                ?.item
                                                                ?.user
                                                                ?.org
                                                                ?.count
                                                                ?.followers ??
                                                            0)
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        color:
                                                            Color(0xFF6E7FAA)),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                )
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: <Widget>[
                                                InkWell(
                                                  onTap: () {
                                                    BackendService.getToken()
                                                        .then((_token) {
                                                      if (mounted) {
                                                        setState(() {
                                                          if (_token != null &&
                                                              _token != "") {
                                                          } else {
                                                            Navigator.push(
                                                                context,
                                                                FadeRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            LoginScreen()));
                                                          }
                                                        });
                                                      }
                                                    });
                                                  },
                                                  child: FlatButton(
                                                    padding:
                                                        EdgeInsets.all(0.0),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        80.0)),
                                                    textColor: Colors.white,
                                                    disabledColor: Colors.grey,
                                                    disabledTextColor:
                                                        Colors.black,
                                                    onPressed: () {
                                                      Map<String, dynamic> map =
                                                          new HashMap();
                                                      map["organization_id"] =
                                                          widget?.item?.user
                                                                  ?.org?.id ??
                                                              0;

                                                      print(map);
                                                      if (this.isFollowing) {
                                                        BackendService
                                                                .putUnfollow(
                                                                    body: map)
                                                            .then((onValue) {
                                                          print(onValue);
                                                          if (onValue != null) {
                                                            print(onValue);
                                                            if (onValue ==
                                                                200) {
                                                              setState(() {
                                                                isFollowing =
                                                                    false;
                                                              });
                                                            }
                                                          }
                                                        });
                                                      } else {
                                                        BackendService
                                                                .putFollow(
                                                                    body: map)
                                                            .then((onValue) {
                                                          if (onValue != null) {
                                                            if (onValue ==
                                                                200) {
                                                              setState(() {
                                                                isFollowing =
                                                                    true;
                                                              });
                                                            }
                                                          }
                                                        });
                                                      }
                                                    },
                                                    child: Container(
                                                        padding:
                                                            const EdgeInsets.fromLTRB(
                                                                10, 5, 10, 5),
                                                        decoration: (!(isFollowing ??
                                                                false))
                                                            ? BoxDecoration(
                                                                gradient: LinearGradient(
                                                                    begin: Alignment
                                                                        .topCenter,
                                                                    end: Alignment
                                                                        .bottomCenter,
                                                                    colors: [
                                                                      Color(
                                                                          0xFFB755FF),
                                                                      Color(
                                                                          0xFF584BDD),
                                                                    ]),
                                                                borderRadius:
                                                                    BorderRadius.all(
                                                                        Radius.circular(
                                                                            80.0)))
                                                            : BoxDecoration(
                                                                border: new Border.all(
                                                                    color:
                                                                        Color(0xFF6E7FAA),
                                                                    width: 1.0),
                                                                gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: <Color>[Colors.white, Colors.white]),
                                                                borderRadius: BorderRadius.all(Radius.circular(80.0))),
                                                        child: (isFollowing ?? false) ? Text(lang.FOLLOWING, textAlign: TextAlign.center, style: TextStyle(fontSize: 15, color: Color(0xFF6E7FAA))) : Text(lang.FOLLOW, textAlign: TextAlign.center, style: TextStyle(fontSize: 15))),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ))),
                    Positioned(
                      top: 290,
                      left: 10,
                      right: 10,
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: new Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                elevation: 5,
                                child: Container(
                                  padding: EdgeInsets.only(right: 10, left: 10),
                                  child: TabBar(
                                      labelPadding: EdgeInsets.all(0),
                                      controller: _tabController,
                                      indicator: UnderlineTabIndicator(
                                          borderSide: BorderSide(
                                              width: 2.0,
                                              color: Color(0xFF584BDD)),
                                          insets: EdgeInsets.symmetric(
                                              horizontal: 35.0)),
                                      labelColor: Color(0xFF222455),
                                      unselectedLabelColor: Color(0xFFB6BED4),
                                      indicatorSize: TabBarIndicatorSize.tab,
                                      tabs: tabList),
                                )),
                          ),
                          Container(
                            height: screenSize,
                            child: new TabBarView(
                              controller: _tabController,
                              children: <Widget>[
                                TabHomeScreen(item: widget.item),
                                TabAddressScreen(item: widget.item),
                                TabAdvertisementScreen(item: widget.item),
                                TabNewsScreen(item: widget.item),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
