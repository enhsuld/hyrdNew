import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hyrd/models/car.dart';

class TodayListItem extends StatelessWidget {
  final int index;
  TodayListItem(this.index);
  static const miniTextColor = Color(0xFF6E7FAA);
  static const bigTextColor = Color(0xFF222455);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        GestureDetector(
          onTap: () {

          },
          child: Card(
       //       elevation: 2,
              child: ClipPath(
                child: Container(
                  child: Row(
                    children: <Widget>[
                      Hero(
                        tag: topRatedCarList[index].id,
                        child: Container(
                          height: 60,
                          width: 60,
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(color: Colors.blueGrey),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(topRatedCarList[index].imageUrl)
                            ),
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
                                    topRatedCarList[index].title,
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: bigTextColor
                                    ),
                                  ),
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
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          topRatedCarList[index].millage.toString()+ ' '+topRatedCarList[index].millageUnit,
                                          style: TextStyle(
                                              fontSize: 12, color: miniTextColor
                                          ),
                                        )
                                      ],
                                    )
                                ),
                                Container(
                                    width: MediaQuery.of(context).size.width - 135,
                                    padding: EdgeInsets.only(top: 10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          topRatedCarList[index].capacity.toString()+ ' '+topRatedCarList[index].capacityUnit.toString(),
                                          style: TextStyle(
                                              fontSize: 12, color: miniTextColor
                                          ),
                                        ),
                                        Text(
                                          topRatedCarList[index].wheelDrive.toString(),
                                          style: TextStyle(
                                              fontSize: 12, color: miniTextColor
                                          ),
                                        ),
                                      ],
                                    )
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                      border: Border(left: BorderSide(color: Color(0xFFF5982E), width: 5))),
                ),
                clipper: ShapeBorderClipper(shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3))),
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
