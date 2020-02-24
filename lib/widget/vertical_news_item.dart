import 'package:flutter/material.dart';
import 'package:hyrd/models/car_model.dart';
import 'package:hyrd/screens/car_details_screen.dart';
import 'package:intl/intl.dart';

class VerticalNewsItem extends StatelessWidget {
  final int index;
  final CarModel item;
  VerticalNewsItem({this.index, this.item});
  static const miniTextColor = Color(0xFF6E7FAA);
  static const bigTextColor = Color(0xFF222455);

  @override
  Widget build(BuildContext context) {

    final formatter = new NumberFormat("#,###");


    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              CarDetailsScreen.routeName,
              arguments: {
                'id': item.id.toString(),
                'title': item.name,
                'imageUrl': "assets/images/img5.jpg",
                'description': item.description,
                'rating': item.name,
                'year': item.name,
                'duration': item.name,
              },
            );
          },
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 5,
            child: Row(
              children: <Widget>[
                Hero(
                  tag: item?.id ?? 0,
                  child: Container(
                    height: 80,
                    width: 100,
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage("assets/images/img5.jpg")
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  height: 80,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width - 180,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              item?.name ?? "",
                              style:
                                  TextStyle(fontSize: 15,fontWeight: FontWeight.bold, color: bigTextColor),
                            )
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
                                    MainAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "Дуусах хугацаа: ",
                                    style: TextStyle(
                                        fontSize: 12, color: miniTextColor),
                                  ),
                                  Text(
                                    (item?.capacity ?? 0).toString(),
                                    style: TextStyle(
                                        fontSize: 12, color: miniTextColor),
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
                                    "Үнэ :" + formatter.format(item?.price ?? 0) + "₮",
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: miniTextColor),
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
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}