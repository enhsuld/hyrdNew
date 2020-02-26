import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hyrd/models/car_model.dart';
import 'package:hyrd/screens/car_details_screen.dart';
import 'package:intl/intl.dart';

class VerticalOwnAdsItem extends StatelessWidget {
  final int index;
  final CarModel item;
  VerticalOwnAdsItem(this.index, this.item);
  static const miniTextColor = Color(0xFF6E7FAA);
  static const bigTextColor = Color(0xFF222455);

  @override
  Widget build(BuildContext context) {

    final formatter = new NumberFormat("#,###");
    final formatterDate = new DateFormat.yMMMMd('en_US');


    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 10,
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 0,horizontal: 10),
          child:  GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(
                CarDetailsScreen.routeName,
                arguments: {
                  'id': item.id.toString(),
                  'title': item.name,
                  'imageUrl': "assets/images/img4.jpg",
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
              elevation: 3,
              child: Row(
                children: <Widget>[
                  Hero(
                    tag: item?.id ?? 0,
                    child: Container(
                      height: 80,
                      width: 100,
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage("assets/images/img1.jpg")
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                    height: 80,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width - 160,
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
                                    color: (item?.publishTariff ?? 1) != null ?  Color(0xFFA153F7):  Color(0xFFFF1A70),
                                    icon: new Icon(Icons.lens, size: 12.0),
                                    onPressed: () {},
                                  )
                              )
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width - 160,
                          child: Text(
                            "Дуусах хугацаа: " + formatter.format(item?.price ?? 0)+ " хоног үлдсэн",
                            style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFF6E7FAA)),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width - 160,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                formatterDate.format(DateTime.parse(item.createdAt)),
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF6E7FAA)),
                              ),
                              new SizedBox(
                                  height: 20.0,
                                  width: 25.0,
                                  child: new IconButton(
                                    focusColor: Colors.blue,
                                    padding: new EdgeInsets.all(0.0),
                                    color: (item?.publishTariff ?? 1) != null ?  Color(0xFFA153F7):  Color(0xFFFF1A70),
                                    icon: new Icon(Icons.edit, size: 12.0),
                                    onPressed: () {},
                                  )
                              )
                            ],
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
      ],
    );
  }
}
