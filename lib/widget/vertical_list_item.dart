import 'package:flutter/material.dart';
import '../models/car.dart';
import '../screens/movie_details_screen.dart';

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
              MovieDetailsScreen.routeName,
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
            elevation: 5,
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
                      Text(
                        highlighted[index].title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
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
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    "Үнэ :"+highlighted[index].price.toString(),
                                    style: TextStyle(
                                      fontSize: 16,
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
