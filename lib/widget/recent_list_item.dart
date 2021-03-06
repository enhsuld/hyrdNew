import 'package:flutter/material.dart';
import 'package:hyrd/screens/car_details_screen.dart';
import '../models/car.dart';

class RecentListItem extends StatelessWidget {
  final int index;
  RecentListItem(this.index);
  static const miniTextColor = Color(0xFF6E7FAA);
  static const bigTextColor = Color(0xFF222455);



  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              CarDetailsScreen.routeName,
              arguments: {
                'id': recentCarList[index].id,
                'title': recentCarList[index].title,
                'imageUrl': recentCarList[index].imageUrl,
                'description': recentCarList[index].description,
                'rating': recentCarList[index].title,
                'year': recentCarList[index].title,
                'duration': recentCarList[index].title,
              },
            );
          },
          child: Row(
            children: <Widget>[
              Hero(
                tag: recentCarList[index].id,
                child: Container(
                  height: 80,
                  width: 100,
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                        fit: BoxFit.fitWidth,
                        image: AssetImage(recentCarList[index].imageUrl)
                      /*    image: NetworkImage(
                          recentCarList[index].imageUrl,
                        ),*/
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left:10,right: 10),
                height: 80,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      recentCarList[index].title,
                      style: TextStyle(
                          fontSize: 15,
                          color: bigTextColor
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  recentCarList[index].millage.toString()+ ' '+recentCarList[index].millageUnit,
                                  style: TextStyle(
                                      fontSize: 12, color: miniTextColor
                                  ),
                                ),
                                Text(
                                  recentCarList[index].capacity.toString()+ ' '+recentCarList[index].capacityUnit.toString(),
                                  style: TextStyle(
                                      fontSize: 12, color: miniTextColor
                                  ),
                                ),
                                Text(
                                  recentCarList[index].wheelDrive.toString(),
                                  style: TextStyle(
                                      fontSize: 12, color: miniTextColor
                                  ),
                                  // recentCarList[index].wheelDrive,
                                ),
                              ],
                            )
                        ),
                        Container(
                            width: 230,
                            padding: EdgeInsets.only(top: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Үнэ :"+recentCarList[index].price.toString()+"₮",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: bigTextColor
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
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
