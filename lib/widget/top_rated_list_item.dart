import 'package:flutter/material.dart';
import 'package:hyrd/screens/car_details_screen.dart';

import '../models/car.dart';

class TopRatedListItem extends StatelessWidget {
  final int index;
  TopRatedListItem(this.index);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: 160,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(
            CarDetailsScreen.routeName,
            arguments: {
              'id': topRatedCarList[index].id,
              'title': topRatedCarList[index].title,
              'imageUrl': topRatedCarList[index].imageUrl,
              'description': topRatedCarList[index].description,
              'rating': topRatedCarList[index].title,
              'year': topRatedCarList[index].title,
              'duration': topRatedCarList[index].title,
            },
          );
        },
        child: Column(
          children: <Widget>[
            Card(
              elevation: 10,
              child: Hero(
                tag: topRatedCarList[index].id,
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage(topRatedCarList[index].imageUrl)
                      //image: NetworkImage(topRatedCarList[index].imageUrl),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              topRatedCarList[index].title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
