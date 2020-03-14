import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hyrd/models/car_model.dart';
import 'package:hyrd/screens/car_details_screen.dart';
import 'package:hyrd/screens/main/detail_screen.dart';
import 'package:hyrd/utils/fade_route.dart';
import 'package:hyrd/utils/hyrd_icons.dart';
import 'package:intl/intl.dart';
import 'package:share/share.dart';

class VerticalAdsItem extends StatelessWidget {
  final int index;
  final CarModel item;
  VerticalAdsItem({this.index, this.item});
  static const miniTextColor = Color(0xFF6E7FAA);
  static const bigTextColor = Color(0xFF222455);



  @override
  Widget build(BuildContext context) {

    return  Container(
      padding: EdgeInsets.only(bottom: 10),
      child:  GestureDetector(
        onTap: () {
          Navigator.push(context, FadeRoute(builder: (context) => DetailScreen(item: item)));
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 3,
          child: Row(
            children: <Widget>[
              Container(
                height: 80,
                width: 100,
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                      fit: BoxFit.fitHeight,
                      image: (item.medias.length==0)
                          ? AssetImage('assets/images/defualt-car.png')
                          : NetworkImage(item?.medias[0]?.thumb),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                height: 80,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width - 165,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            item?.name ?? "",
                            style:
                            TextStyle(fontSize: 15, color: bigTextColor),
                          ),
                          new SizedBox(
                              height: 20.0,
                              width: 25.0,
                              child: new IconButton(
                                focusColor: Colors.blue,
                                padding: new EdgeInsets.all(0.0),
                                color: Color(0xFF222455),
                                icon: new Icon(Icons.more_horiz, size: 25.0),
                                onPressed: () {
                                  _settingModalBottomSheet(context,item.id.toString(),"");
                                },
                              ))
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: <Widget>[
                        Container(
                            width: 230,
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  (item?.mileage ?? 0).toString(),
                                  style: TextStyle(
                                      fontSize: 12, color: miniTextColor),
                                ),
                                Text(
                                  (item?.capacity ?? 0).toString(),
                                  style: TextStyle(
                                      fontSize: 12, color: miniTextColor),
                                ),
                                Text(
                                  item?.wheelPosition ?? "",
                                  style: TextStyle(
                                      fontSize: 12, color: miniTextColor),
                                  // item.wheelDrive,
                                ),
                              ],
                            )),
                        Container(
                            width: 230,
                            padding: EdgeInsets.only(top: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Үнэ :" +  (item?.priceFormat??"") + "₮",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: bigTextColor),
                                ),
                              ],
                            )),


                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
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
              height: 360,
              padding: EdgeInsets.all(15),
              decoration: new BoxDecoration(
                  color: Colors.white,
                  borderRadius: new BorderRadius.only(
                      topLeft: const Radius.circular(15.0),
                      topRight: const Radius.circular(15.0))),
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 5,right: 10,bottom: 10),
                    width: MediaQuery.of(context).size.width,
                    child: Text("Зарын гарчиг",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Color(0xFF222455),fontSize: 15,fontWeight: FontWeight.bold)),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 5,right: 5),
                    width: MediaQuery.of(context).size.width,
                    child: Divider(height: 2,color: Color(0xFF222455)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  new GestureDetector(
                    onTap: () => {
                      Share.share('check out my website https://example.com', subject: 'Look what I made!')
                    },
                    child: new Card(
                      elevation: 3,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(right: 10),
                                    child: Icon(
                                      Hyrd.share,
                                      color: Color(0xFF6E7FAA),
                                      size: 20,
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      "Хуваалцах",
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Color(0xFF6E7FAA),
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  new GestureDetector(
                    onTap: () => {

                    },
                    child: new Card(
                      elevation: 3,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(right: 10),
                                    child: Icon(
                                      Hyrd.report,
                                      color: Color(0xFF6E7FAA),
                                      size: 20,
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      "Мэдэгдэх",
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Color(0xFF6E7FAA),
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  new GestureDetector(
                    onTap: () => {

                    },
                    child: new Card(
                      elevation: 3,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(right: 10),
                                    child: Icon(
                                      Hyrd.edit,
                                      color: Color(0xFF6E7FAA),
                                      size: 20,
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      "Засах",
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Color(0xFF6E7FAA),
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  new GestureDetector(
                    onTap: () => {

                    },
                    child: new Card(
                      elevation: 3,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(right: 10),
                                    child: Icon(
                                      Hyrd.remove,
                                      color: Color(0xFF6E7FAA),
                                      size: 20,
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      "Устгах",
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Color(0xFF6E7FAA),
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  new GestureDetector(
                    onTap: () => {

                    },
                    child: new Card(
                      elevation: 3,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(right: 10),
                                    child: Icon(
                                      Hyrd.page,
                                      color: Color(0xFF6E7FAA),
                                      size: 20,
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      "Хуудасруу орох",
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Color(0xFF6E7FAA),
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ));
        });
  }
}
