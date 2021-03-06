import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hyrd/models/car.dart';
import 'package:hyrd/screens/main/dealer_screen.dart';
import 'package:hyrd/utils/fade_route.dart';
import 'package:hyrd/widget/horizontal_list_item.dart';

import 'add_car_screen.dart';

class CarDetailsScreen extends StatefulWidget {
  static const routeName = '/car-details';

  @override
  _CarDetailsScreenState createState() => _CarDetailsScreenState();
}

class _CarDetailsScreenState extends State<CarDetailsScreen> {
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

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    final id = routeArgs['id'];
    final rating = routeArgs['rating'];

    return Scaffold(
      backgroundColor: Color(0xfff4f4f4),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  color: Colors.blueGrey,
                  child: CarouselSlider(
                    //height: MediaQuery.of(context).size.height*0.4,
                    // initialPage: 0,
                    // height: 400,
                    // aspectRatio: MediaQuery.of(context).size.aspectRatio,
                    // enlargeCenterPage: false,
                    // autoPlay: false,
                    // viewportFraction: 1.0,
                    // reverse: false,
                    // enableInfiniteScroll: true,
                    // autoPlayInterval: Duration(seconds: 2),
                    // autoPlayAnimationDuration: Duration(milliseconds: 2000),
                    // pauseAutoPlayOnTouch: Duration(seconds: 1),
                    // scrollDirection: Axis.horizontal,
                    // onPageChanged: (index) {
                    //   setState(() {
                    //     _current = index;
                    //   });
                    // },
                    options: CarouselOptions(
                        autoPlay: true,
                        height: 400,
                        aspectRatio: MediaQuery.of(context).size.aspectRatio,
                        enlargeCenterPage: true,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _current = index;
                          });
                        }),
                    items: imgList.map((imgUrl) {
                      return Builder(
                        builder: (BuildContext context) {
                          return InkWell(
                            onTap: () {
                              print("hatnaa");
                            },
                            child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 0.0),
                                child: Image.asset(imgUrl,
                                    width: MediaQuery.of(context).size.width,
                                    fit: BoxFit.cover)),
                          );
                        },
                      );
                    }).toList(),
                  ),
                ),
                Positioned(
                  top: 40,
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
                Positioned(
                  bottom: 40,
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
                )
              ],
            ),
            Container(
                transform: Matrix4.translationValues(0.0, -40.0, 0.0),
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
                                vertical: 10, horizontal: 20),
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
                            width: MediaQuery.of(context).size.width - 200,
                            height: 50,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text(
                                  "Шүрэнцэцэг Тэмүүжин",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xFF222455),
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
                            margin: EdgeInsets.all(10),
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              borderRadius: new BorderRadius.only(
                                  topLeft: const Radius.circular(5.0),
                                  topRight: const Radius.circular(5.0)),
                              image: DecorationImage(
                                  fit: BoxFit.fitWidth,
                                  image: AssetImage(
                                      'assets/images/auction-land.png')),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    new GestureDetector(
                      onTap: () => {
                        Navigator.push(context,
                            FadeRoute(builder: (context) => DealerScreen()))
                      },
                      child: new Card(
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
                                  vertical: 10, horizontal: 20),
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
                              width: MediaQuery.of(context).size.width - 250,
                              height: 50,
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
                                ],
                              ),
                            ),
                            Container(
                              width: 100,
                              margin: EdgeInsets.only(right: 20),
                              decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: <Color>[
                                      Color(0xFFFEEC7D),
                                      Color(0xFFF5982E),
                                    ],
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8.0))),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 10),
                              child: Text("Онцгой",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16)),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      child: Text(
                        "Огноо: 2019-09-06",
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF222455),
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: 5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'Мэдээлэл',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 18, color: Color(0xFF222455)),
                                ),
                                Text(
                                  'Дэлгэрэнгүй',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 12, color: Color(0xFFB6BED4)),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(bottom: 10),
                                  width: MediaQuery.of(context).size.width / 2 -
                                      20,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                          height: 50.0,
                                          padding: EdgeInsets.only(right: 10),
                                          child: Icon(Icons.calendar_today,
                                              size: 20.0)),
                                      Container(
                                          height: 50,
                                          width: 80,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Text(
                                                'Хөдөлгүүр',
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    fontSize: 8,
                                                    color: Color(0xFF6E7FAA)),
                                              ),
                                              Text(
                                                'Бензин',
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Color(0xFF6E7FAA)),
                                              ),
                                            ],
                                          )),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(bottom: 10),
                                  width: MediaQuery.of(context).size.width / 2 -
                                      20,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                          height: 50.0,
                                          padding: EdgeInsets.only(right: 10),
                                          child: Icon(Icons.calendar_today,
                                              size: 20.0)),
                                      Container(
                                          height: 50,
                                          width: 80,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Text(
                                                'Хурдны хайрцаг',
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    fontSize: 8,
                                                    color: Color(0xFF6E7FAA)),
                                              ),
                                              Text(
                                                'Механик',
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Color(0xFF6E7FAA)),
                                              ),
                                            ],
                                          )),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(bottom: 10),
                                  width: MediaQuery.of(context).size.width / 2 -
                                      20,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                          height: 50.0,
                                          padding: EdgeInsets.only(right: 10),
                                          child: Icon(Icons.calendar_today,
                                              size: 20.0)),
                                      Container(
                                          height: 50,
                                          width: 80,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Text(
                                                'Үйлдвэрлэсэн он',
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    fontSize: 8,
                                                    color: Color(0xFF6E7FAA)),
                                              ),
                                              Text(
                                                '2017',
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Color(0xFF6E7FAA)),
                                              ),
                                            ],
                                          )),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(bottom: 10),
                                  width: MediaQuery.of(context).size.width / 2 -
                                      20,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                          height: 50.0,
                                          padding: EdgeInsets.only(right: 10),
                                          child: Icon(Icons.calendar_today,
                                              size: 20.0)),
                                      Container(
                                          height: 50,
                                          width: 80,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Text(
                                                'Орж ирсэн он',
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    fontSize: 8,
                                                    color: Color(0xFF6E7FAA)),
                                              ),
                                              Text(
                                                '2019',
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Color(0xFF6E7FAA)),
                                              ),
                                            ],
                                          )),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: 5,
                      child: Container(
                        padding: EdgeInsets.all(20),
                        width: MediaQuery.of(context).size.width - 30,
                        child: Text("Дэлгэрэнгүй тайлбар..."),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: 5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'Зарах хугацаа',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 18, color: Color(0xFF222455)),
                                ),
                                SizedBox(
                                    height: 18.0,
                                    width: 18.0,
                                    child: new IconButton(
                                      padding: new EdgeInsets.all(0.0),
                                      color: Color(0xFF6E7FAA),
                                      icon: new Icon(Icons.calendar_today,
                                          size: 20.0),
                                      onPressed: () {},
                                    )),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  height: 50,
                                  width: 50,
                                  child: IconButton(
                                    color: Color(0xFF6E7FAA),
                                    icon: new Icon(Icons.more_vert, size: 20.0),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width - 180,
                                  height: 40,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        "Monday, 08, sept",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Color(0xFF222455),
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      Text(
                                        "Monday, 08, sept",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Color(0xFF6E7FAA),
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width - 30,
                      padding: EdgeInsets.only(top: 10, left: 5, bottom: 10),
                      child: Text(
                        'Төстэй зарууд'.toUpperCase(),
                        textAlign: TextAlign.left,
                        style:
                            TextStyle(fontSize: 16, color: Color(0xFF222455)),
                      ),
                    ),
                  ],
                )),
            Container(
              transform: Matrix4.translationValues(0.0, -40.0, 0.0),
              height: 270,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: topRatedCarList.length,
                itemBuilder: (ctx, i) => HorizontalListItem(i),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 80,
        color: Colors.white,
        padding: const EdgeInsets.all(15),
        width: MediaQuery.of(context).size.width - 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width / 2,
              padding: EdgeInsets.only(left: 30, top: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "үнэ:",
                    style: TextStyle(
                      fontSize: 8,
                      color: Color(0xFF6E7FAA),
                    ),
                  ),
                  Text(
                    "24 сая₮",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF222455),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 2 - 30,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: <Color>[
                      Color(0xFFB755FF),
                      Color(0xFF584BDD),
                    ],
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(8.0))),
              padding: const EdgeInsets.all(15),
              child: Text("ХОЛБОГДОХ".toUpperCase(),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 16)),
            )
          ],
        ),
      ),
    );
  }
}
