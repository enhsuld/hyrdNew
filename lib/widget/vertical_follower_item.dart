import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hyrd/models/car_model.dart';
import 'package:hyrd/screens/car_details_screen.dart';
import 'package:intl/intl.dart';

class VerticalFollowerItem extends StatelessWidget {
  final int index;
  final CarModel item;
  VerticalFollowerItem({this.index, this.item});
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

          },
          child: Container(
            width: MediaQuery.of(context).size.width-40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  height: 50,
                  width: 50,
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
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
                  width: MediaQuery.of(context).size.width-235,
                  height: 50,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
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
                      Text(
                        "Toyota-tavanbogd",
                        style: TextStyle(
                            fontSize: 12, color: miniTextColor),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Card(
                    elevation: 3,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                      child: Row(
                        children: <Widget>[
                          Container(
                            margin:EdgeInsets.only(right: 5),
                            child: Icon(Icons.supervised_user_circle, color: Color(0xFF6E7FAA), size: 20.0),
                          ),
                          Text("Дагагч",  style: TextStyle(
                            fontSize: 10,
                            color: Color(0xFF6E7FAA),
                          ),)
                        ],
                      ),
                    )
                  ),
                )
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
