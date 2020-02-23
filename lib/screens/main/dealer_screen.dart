import 'package:carousel_slider/carousel_slider.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hyrd/models/car.dart';
import 'package:hyrd/models/car_model.dart';
import 'package:hyrd/screens/dashboard_screen.dart';
import 'package:hyrd/screens/main/tab_address_screen.dart';
import 'package:hyrd/screens/main/tab_advertisement_screen.dart';
import 'package:hyrd/screens/main/tab_home_screen.dart';
import 'package:hyrd/screens/main/tab_news_screen.dart';
import 'package:hyrd/screens/profile_screen.dart';
import 'package:hyrd/screens/search_car_screen.dart';
import 'package:hyrd/screens/total_ad_screen.dart';
import 'package:hyrd/services/BackendService.dart';
import 'package:hyrd/widget/horizontal_list_item.dart';
import 'package:hyrd/widget/vertical_ads_item.dart';

class DealerScreen extends StatefulWidget {
  static const routeName = '/dealer-details';

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

  @override
  void initState() {
    tabList.add(new Tab(
      text: 'Нүүр',
    ));
    tabList.add(new Tab(
      text: 'Хаяг',
    ));
    tabList.add(new Tab(
      text: 'Зарууд',
    ));
    tabList.add(new Tab(
      text: 'Мэдээлэл',
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

    return Container(
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
                      height: 250,
                      color: Colors.blueGrey,
                      child: CarouselSlider(
                        initialPage: 0,
                        height: 400,
                        aspectRatio: MediaQuery.of(context).size.aspectRatio,
                        enlargeCenterPage: false,
                        autoPlay: false,
                        viewportFraction: 1.0,
                        reverse: false,
                        enableInfiniteScroll: true,
                        autoPlayInterval: Duration(seconds: 2),
                        autoPlayAnimationDuration: Duration(milliseconds: 2000),
                        pauseAutoPlayOnTouch: Duration(seconds: 1),
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
                                  margin: EdgeInsets.symmetric(horizontal: 0.0),
                                  child: Image.asset(imgUrl,
                                      width: MediaQuery.of(context).size.width,
                                      fit: BoxFit.cover));
                            },
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  new Positioned(
                    top: 30,
                    right: 20,
                    left: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        IconButton(
                          padding: new EdgeInsets.only(left: 5),
                          color: Colors.white,
                          icon: new Icon(Icons.arrow_back_ios, size: 25.0),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        Text(
                          "Ulaanbaatar mongolia",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        SizedBox(
                            height: 18.0,
                            width: 18.0,
                            child: new IconButton(
                              padding: new EdgeInsets.all(0.0),
                              color: Colors.white,
                              icon: new Icon(Icons.more_vert, size: 25.0),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            )),
                      ],
                    ),
                  ),
                  new Positioned(
                    top: 210,
                    right: 20,
                    left: 20,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: map<Widget>(imgList, (index, url) {
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
                  new Positioned(
                      right: 10,
                      left: 10,
                      top: 230,
                      child:  Container(
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
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      height: 50,
                                      width: 50,
                                      margin: EdgeInsets.symmetric(
                                          vertical: 20, horizontal: 20),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Color(0xFFB6BED4), width: 2),
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: AssetImage(
                                                'assets/images/auction-land.png')),
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width - 260,
                                      height: 70,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          Text(
                                            "Tavan bogd",
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Color(0xFF222455),
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                          Text(
                                            "Car Dealer",
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: Color(0xFF6E7FAA),
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                          Text(
                                            "(+976) 89951555",
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: Color(0xFF6E7FAA),
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: 70,
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: <Widget>[
                                              Container(
                                                  child: new Icon(
                                                      Icons.supervised_user_circle,
                                                      color: Color(0xFF6E7FAA),
                                                      size: 20.0)),
                                              Text(
                                                "330 follows",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Color(0xFF6E7FAA),
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: <Widget>[
                                              Container(
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
                                                padding: const EdgeInsets.symmetric(
                                                    vertical: 5, horizontal: 10),
                                                child: Text("Дагах",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 15)),
                                              ),
                                              Container(
                                                margin:
                                                EdgeInsets.only(left: 5, right: 20),
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
                                                padding: const EdgeInsets.symmetric(
                                                    vertical: 5, horizontal: 10),
                                                child: new Icon(
                                                    Icons.supervised_user_circle,
                                                    color: Colors.white,
                                                    size: 20.0),
                                              )
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
                          ))
                  ),
                  new Positioned(
                    width: screenSize,
                    top: 325,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: new Column(
                        children: <Widget>[
                          new Container(
                            padding:EdgeInsets.only(bottom: 10),
                            child: new Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                elevation: 5,
                                child: Container(
                                  padding: EdgeInsets.only(right: 10,left: 10),
                                  child: new TabBar(
                                      labelPadding: EdgeInsets.all(0),
                                      controller: _tabController,
                                      indicator: UnderlineTabIndicator(
                                          borderSide: BorderSide(width: 2.0,color: Color(0xFF584BDD)),
                                          insets: EdgeInsets.symmetric(horizontal:35.0)
                                      ),
                                      labelColor: Color(0xFF222455),
                                      unselectedLabelColor: Color(0xFFB6BED4),
                                      indicatorSize: TabBarIndicatorSize.tab,
                                      tabs: tabList
                                  ),
                                )
                            ),
                          ),
                          new Container(
                            height: screenSize ,
                            child: new TabBarView(
                              controller: _tabController,
                              children: <Widget>[
                                TabHomeScreen(),
                                TabAddressScreen(),
                                TabAdvertisementScreen(),
                                TabNewsScreen(),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ));
  }

}
