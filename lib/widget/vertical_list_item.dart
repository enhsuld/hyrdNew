import 'package:flutter/material.dart';
import 'package:hyrd/screens/car_details_screen.dart';
import '../models/car.dart';

class VerticalListItem extends StatelessWidget {
  final int index;
  VerticalListItem(this.index);
  static const miniTextColor = Color(0xFF6E7FAA);
  static const bigTextColor = Color(0xFF222455);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              CarDetailsScreen.routeName,
              arguments: {
                'id': highlighted[index].id,
                'title': highlighted[index].title,
                'imageUrl': highlighted[index].imageUrl,
                'description': highlighted[index].description,
                'rating': highlighted[index].title,
                'year': highlighted[index].title,
                'duration': highlighted[index].title,
              },
            );
          },
          child: Card(
            elevation: 3,
            child: Row(
              children: <Widget>[
                Hero(
                  tag: highlighted[index].id,
                  child: Container(
                    height: 80,
                    width: 100,
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        fit: BoxFit.fitWidth,
                        image: AssetImage(highlighted[index].imageUrl)
                    /*    image: NetworkImage(
                          highlighted[index].imageUrl,
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
                      Container(
                        width: MediaQuery.of(context).size.width - 160,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              highlighted[index].title,
                              style: TextStyle(
                                  fontSize: 15,
                                  color: bigTextColor
                              ),
                            ),
                            new SizedBox(
                                height: 20.0,
                                width: 25.0,
                                child: new IconButton(
                                  focusColor: Colors.blue,
                                  padding: new EdgeInsets.all(0.0),
                                  color: Color(0xFF222455),
                                  icon: new Icon(Icons.more_horiz, size: 25.0),
                                  onPressed: (){},
                                )
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
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    highlighted[index].millage.toString()+ ' '+highlighted[index].millageUnit,
                                    style: TextStyle(
                                        fontSize: 12, color: miniTextColor
                                    ),
                                  ),
                                  Text(
                                    highlighted[index].capacity.toString()+ ' '+highlighted[index].capacityUnit.toString(),
                                    style: TextStyle(
                                        fontSize: 12, color: miniTextColor
                                    ),
                                  ),
                                  Text(
                                    highlighted[index].wheelDrive.toString(),
                                    style: TextStyle(
                                      fontSize: 12, color: miniTextColor
                                    ),
                                    // highlighted[index].wheelDrive,
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
                                    "Үнэ :"+highlighted[index].price.toString()+"₮",
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
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
