import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hyrd/models/car.dart';
import 'package:hyrd/models/car_model.dart';
import 'package:hyrd/screens/main/dealer_screen.dart';
import 'package:hyrd/utils/fade_route.dart';
import 'package:hyrd/utils/hyrd_icons.dart';
import 'package:hyrd/widget/horizontal_list_item.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailScreen extends StatefulWidget {
  static const routeName = '/item-details';

  final CarModel item;

  DetailScreen({Key key, @required this.item}) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
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

  final formatter = new NumberFormat("#,###");
  final formatterDate = new DateFormat.yMMMMd('en_US');

  @override
  Widget build(BuildContext context) {
    print(widget.item.medias);
    print(widget.item.toJson());
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
                    items: widget.item.medias.map((imgUrl) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                              margin: EdgeInsets.symmetric(horizontal: 0.0),
                              child: Image.network(imgUrl.optimized,
                                  width: MediaQuery.of(context).size.width,
                                  fit: BoxFit.cover));
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
                        widget.item.markName + ' ' + widget.item.modelName,
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
                    children: map<Widget>(widget.item.medias, (index, url) {
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
                    (widget.item?.user?.type ?? 0) == 0
                        ? Card(
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
                                  width:
                                      MediaQuery.of(context).size.width - 200,
                                  height: 50,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Text(
                                        (widget.item?.ownerLastname ?? "") +
                                            ' ' +
                                            (widget.item?.ownerFirstname ?? ""),
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Color(0xFF222455),
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      Text(
                                        widget.item?.ownerHandphone ?? "",
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
                                  height: 50,
                                  width: 50,
                                  margin: EdgeInsets.only(right: 10),
                                  transform: Matrix4.translationValues(
                                      0.0, -17.0, 0.0),
                                  child: Icon(
                                    Hyrd.bookmark,
                                    color: Color(0xFFF5982E),
                                    size: 60,
                                  ),
                                )
                              ],
                            ),
                          )
                        : GestureDetector(
                            onTap: () => {
                              Navigator.push(context, FadeRoute(builder: (context) => DealerScreen(item: widget.item)))
                            },
                            child: new Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              elevation: 5,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                    width:
                                        MediaQuery.of(context).size.width - 250,
                                    height: 50,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8.0))),
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
                        "Огноо: " +
                            formatterDate
                                .format(DateTime.parse(widget.item.createdAt)),
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
                                FlatButton(
                                  child: Text(
                                    'Дэлгэрэнгүй',
                                    style: TextStyle(
                                        color: Color(0xFFB6BED4), fontSize: 12),
                                  ),
                                  onPressed: () {
                                    _settingModalBottomSheet(context, "", "");
                                  },
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
                                          child: Icon(Hyrd.gasoline_pump,
                                              color: Color(0xFF6E7FAA),
                                              size: 25.0)),
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
                                              Wrap(
                                                children: <Widget>[
                                                  Text(
                                                    widget.item?.fuelType ?? "",
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color:
                                                            Color(0xFF6E7FAA)),
                                                  ),
                                                ],
                                              )
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
                                          child: Icon(Hyrd.manual_transmission,
                                              color: Color(0xFF6E7FAA),
                                              size: 25.0)),
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
                                                widget.item?.transmission ?? "",
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    fontSize: 14,
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
                                          child: Icon(Hyrd.timetable,
                                              color: Color(0xFF6E7FAA),
                                              size: 25.0)),
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
                                                widget.item?.buildYear ?? "",
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    fontSize: 14,
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
                                          child: Icon(Hyrd.calendar2,
                                              color: Color(0xFF6E7FAA),
                                              size: 25.0)),
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
                                                widget.item?.importDate ?? "",
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    fontSize: 14,
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
                        child: Text(
                          widget.item.description,
                          style:
                              TextStyle(color: Color(0xFF222455), fontSize: 14),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
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
                    (widget.item?.priceFormat ?? "") + "₮",
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
              padding: EdgeInsets.all(0),
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
              child: new FlatButton(
                padding: EdgeInsets.all(0),
                child: Text("ХОЛБОГДОХ".toUpperCase(),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 16)),
                onPressed: () {
                  launch("tel://" + widget.item.ownerHandphone);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  _settingModalBottomSheet(context, String id, String type) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        isScrollControlled: true,
        builder: (BuildContext bc) {
          return Container(
              height: MediaQuery.of(context).size.height*0.8,
              decoration: new BoxDecoration(
                  color: Colors.white,
                  borderRadius: new BorderRadius.only(
                      topLeft: const Radius.circular(15.0),
                      topRight: const Radius.circular(15.0))),
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      padding: EdgeInsets.only(left: 20,top:30, bottom: 10),
                      child: Text("Мэдээлэл",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Color(0xFF2D3853),
                              fontWeight: FontWeight.w600)),
                    ),
                  ),
                  Container(
                      height: MediaQuery.of(context).size.height*0.8-60,
                      child: ListView(
                        padding: EdgeInsets.all(0),
                        children: ListTile.divideTiles(
                          context: context,
                          tiles: [
                            ListTile(
                              title: Text('Sun'),
                            ),
                            ListTile(
                              title: Text('Moon'),
                            ),
                            ListTile(
                              title: Text('Star'),
                            ),
                          ],
                        ).toList(),
                      ))
                ],
              ));
        });
  }
}
