import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hyrd/models/car.dart';

class SettingsListItem extends StatelessWidget {
  final int index;

  SettingsListItem(this.index);

  static const miniTextColor = Color(0xFF6E7FAA);
  static const bigTextColor = Color(0xFF222455);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        GestureDetector(
          onTap: () {},
          child: Card(
            //elevation: 2,
            child: Container(
                child: Row(
              children: <Widget>[
                Hero(
                  tag: recentCarList[index].id,
                  child: Container(
                    height: 60,
                    width: 60,
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.blueGrey),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(recentCarList[index].imageUrl)),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width - 135,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              recentCarList[index].title,
                              style:
                                  TextStyle(fontSize: 15, color: bigTextColor),
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
                              width: MediaQuery.of(context).size.width - 135,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    recentCarList[index].millage.toString() +
                                        ' ' +
                                        recentCarList[index].millageUnit,
                                    style: TextStyle(
                                        fontSize: 12, color: miniTextColor),
                                  )
                                ],
                              )),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            )),
          ),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
