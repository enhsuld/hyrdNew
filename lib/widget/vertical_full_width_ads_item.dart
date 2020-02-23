import 'package:flutter/material.dart';
import 'package:hyrd/models/car_model.dart';
import 'package:hyrd/screens/car_details_screen.dart';
import 'package:intl/intl.dart';

class VerticalFullWidthAdsItem extends StatelessWidget {
  final int index;
  final CarModel item;
  VerticalFullWidthAdsItem({this.index, this.item});
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
                'imageUrl': "assets/images/auction-land.png",
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
            child: Column(
              children: <Widget>[
                Container(
                  height: 120,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: new BorderRadius.only(
                        topLeft: const Radius.circular(10.0),
                        topRight: const Radius.circular(10.0)),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage("assets/images/img4.jpg")
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.only(top:10),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                item?.name ?? "",
                                style:
                                TextStyle(fontSize: 15, color: bigTextColor),
                              ),
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
                              ),
                            ],
                          )),
                      Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.only(top:10,bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "Үнэ :" + formatter.format(item?.price ?? 0) + "₮",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: bigTextColor),
                              ),
                              Text(
                                item?.createdAt?.substring(0,4) ?? "",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: bigTextColor),
                              ),
                            ],
                          )),
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
