import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hyrd/models/banner_model.dart';
import 'package:hyrd/models/car_model.dart';
import 'package:hyrd/models/post_model.dart';
import 'package:hyrd/screens/notification/notification_screen.dart';
import 'package:hyrd/screens/special_ads_screen.dart';
import 'package:hyrd/screens/total_post_screen.dart';
import 'package:hyrd/services/BackendService.dart';
import 'package:hyrd/utils/fade_route.dart';
import 'package:hyrd/utils/hyrd_icons.dart';
import 'package:hyrd/utils/lang.dart';
import 'package:hyrd/widget/horizontal_car_item.dart';
import 'package:hyrd/widget/vertical_ads_item.dart';
import 'package:hyrd/widget/vertical_news_item.dart';
import 'package:url_launcher/url_launcher.dart';

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

  // var reportTypes = new List<ReportTypeModel>();
  var banners = new List<BannerModel>();
  Future<dynamic> cars;
  @override
  void initState() {
    super.initState();
    BackendService.getBanner().then((data) {
      setState(() {
        this.banners = data;
      });
    });
    // BackendService.getReportTypes().then((data) {
    //   setState(() {
    //     this.reportTypes = data;
    //   });
    // });
    cars = BackendService.fetchCars(page: 1, pageSize: 5);
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
              padding: EdgeInsets.only(top: 0, left: 20, right: 20, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    lang.HOME.toUpperCase(),
                    style: TextStyle(
                      fontSize: 21.0,
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
                              Navigator.push(
                                  context,
                                  FadeRoute(
                                      builder: (context) =>
                                          NotificationScreen()));
                            },
                            color: Color(0xFF222455),
                            iconSize: 22.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            (banners != null && banners.length > 0)
                ? CarouselSlider(
                    options: CarouselOptions(
                        autoPlay: true,
                        height: 190,
                        viewportFraction: 0.8,
                        autoPlayInterval: Duration(seconds: 2),
                        aspectRatio: MediaQuery.of(context).size.aspectRatio,
                        enlargeCenterPage: true,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _current = index;
                          });
                        }),
                    items: banners.map((imgUrl) {
                      return Builder(
                        builder: (BuildContext context) {
                          return InkWell(
                            onTap: () => _launchURL(imgUrl.link),
                            child: Container(
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.symmetric(horizontal: 10.0),
                                child: Stack(
                                  children: <Widget>[
                                    new ClipRRect(
                                        borderRadius:
                                            new BorderRadius.circular(8.0),
                                        child: CachedNetworkImage(
                                            imageUrl: imgUrl.banner,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: MediaQuery.of(context)
                                                .size
                                                .height,
                                            fit: BoxFit.fill)),
                                  ],
                                )),
                          );
                        },
                      );
                    }).toList(),
                  )
                : Container(),
            // CarouselSlider(
            //     options: CarouselOptions(
            //         autoPlay: true,
            //         height: 190,
            //         aspectRatio: MediaQuery.of(context).size.aspectRatio,
            //         enlargeCenterPage: true,
            //         onPageChanged: (index, reason) {
            //           setState(() {
            //             _current = index;
            //           });
            //         }),
            //     items: imgList.map((imgUrl) {
            //       return Builder(
            //         builder: (BuildContext context) {
            //           return Container(
            //               width: MediaQuery.of(context).size.width,
            //               margin: EdgeInsets.symmetric(horizontal: 10.0),
            //               child: Stack(
            //                 children: <Widget>[
            //                   new ClipRRect(
            //                       borderRadius:
            //                           new BorderRadius.circular(8.0),
            //                       child: Image.asset(imgUrl,
            //                           width:
            //                               MediaQuery.of(context).size.width,
            //                           height: MediaQuery.of(context)
            //                               .size
            //                               .height,
            //                           fit: BoxFit.fill)),
            //                 ],
            //               ));
            //         },
            //       );
            //     }).toList(),
            //   ),
            (banners != null && banners.length > 0)
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: map<Widget>(
                        (banners != null && banners.length > 0)
                            ? banners
                            : imgList, (index, url) {
                      return Container(
                        width: 10.0,
                        height: 4.0,
                        margin: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 3.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: _current == index
                              ? Color(0xFF584BDD)
                              : Colors.grey,
                        ),
                      );
                    }),
                  )
                : Container(),
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
                      lang.ALLVIEW,
                      style: TextStyle(color: Color(0xFF6E7FAA), fontSize: 13),
                    ),
                    onPressed: () {
                      Navigator.push(context,
                          FadeRoute(builder: (context) => SpecialAdsScreen()));
                    },
                  ),
                ],
              ),
            ),
            FutureBuilder(
              future: cars,
              builder: (context, snapshot) {
                List<dynamic> lists;
                if (snapshot.hasData) {
                  lists = snapshot.data;
                  return Container(
                    height: 270,
                    padding:
                        EdgeInsets.only(bottom: 0, top: 0, left: 10, right: 10),
                    child: ListView.builder(
                      padding: EdgeInsets.only(top: 0, bottom: 0),
                      scrollDirection: Axis.horizontal,
                      //physics: NeverScrollableScrollPhysics(),
                      itemCount: lists.length,
                      itemBuilder: (ctx, i) => HorizontalCarItem(
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
                      Navigator.push(context,
                          FadeRoute(builder: (context) => SpecialAdsScreen()));
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
                    height: double.parse(lists.length.toString()) * 105,
                    padding:
                        EdgeInsets.only(bottom: 0, top: 0, left: 10, right: 10),
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
              padding: EdgeInsets.only(left: 20, bottom: 0, right: 5),
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
                  FlatButton(
                    child: Text(
                      'бүгдийг харах',
                      style: TextStyle(color: Color(0xFF6E7FAA), fontSize: 13),
                    ),
                    onPressed: () {
                      Navigator.push(context,
                          FadeRoute(builder: (context) => TotalPostsScreen()));
                    },
                  ),
                ],
              ),
            ),
            FutureBuilder(
              future: BackendService.getPostsMain(1, 4),
              builder: (context, snapshot) {
                List<dynamic> lists;
                if (snapshot.hasData) {
                  lists = snapshot.data;
                  return Container(
                    height: double.parse(lists.length.toString()) * 155,
                    padding: EdgeInsets.only(
                        bottom: 10, top: 0, left: 10, right: 10),
                    child: ListView.builder(
                      padding: EdgeInsets.only(top: 0, bottom: 0),
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: lists.length,
                      itemBuilder: (ctx, i) => VerticalNewsItem(
                        index: i,
                        item: PostModel.fromJson(lists[i]),
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
            SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }

  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
