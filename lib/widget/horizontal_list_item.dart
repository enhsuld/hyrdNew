import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../models/car.dart';

class HorizontalListItem extends StatelessWidget {
  final int index;
  HorizontalListItem(this.index);

  static const miniTextColor = Color(0xFF6E7FAA);

  @override
  Widget build(BuildContext context) {


    void _showDialog() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            backgroundColor: Color(0xffF4F4F4),
            contentPadding: EdgeInsets.all(10.0),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
            content: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(18),
                    child: SvgPicture.asset(
                      "assets/images/mainLogo.svg",
                      color: Color(0xff584BDD),
                      width: MediaQuery.of(context).size.width - 250,
                      semanticsLabel: 'Acme Logo',
                      fit: BoxFit.contain,
                    ),
                  ),
                  Container(
                    child:  Text("Зар устгах",textAlign: TextAlign.center,style: TextStyle(color: Color(0xff584BDD),fontSize: 18, fontWeight: FontWeight.w600)),
                  ),
                  SizedBox(height: 20,),
                  Container(
                      padding: EdgeInsets.only(left: 50,right: 50),
                    child:  Text("Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonu.",textAlign: TextAlign.center,style: TextStyle(color: Color(0xff8D8D8D),fontSize: 13)),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              Container(
                padding: EdgeInsets.only(left:50,right: 50),
                width:  MediaQuery.of(context).size.width-96,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10.0),
                      bottomRight: Radius.circular(10.0)),
                ),
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FlatButton(
                      child: const Text('Цуцлах'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    FlatButton(
                      child: const Text('Тийм'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                ),
              ),
            ],
          );
        },
      );
    }

    return Container(
      padding: const EdgeInsets.only(bottom: 10, left: 10),
      width: 206,
      child: GestureDetector(
        onTap: () {
          _showDialog();
        /*  Navigator.of(context).pushNamed(
            MovieDetailsScreen.routeName,
            arguments: {
              'id': topRatedCarList[index].id,
              'title': topRatedCarList[index].title,
              'imageUrl': topRatedCarList[index].imageUrl,
              'description': topRatedCarList[index].description,
              'rating': topRatedCarList[index].title,
              'year': topRatedCarList[index].title,
              'duration': topRatedCarList[index].title,
            },
          );*/
        },
        child: Column(
          children: <Widget>[
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 3,
              child: Column(
                children: <Widget>[
                  Hero(
                    tag: topRatedCarList[index].id,
                    child: Container(
                      height: 160,
                      decoration: BoxDecoration(
                          borderRadius: new BorderRadius.only(
                              topLeft: const Radius.circular(5.0),
                              topRight: const Radius.circular(5.0)),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                            image: AssetImage(topRatedCarList[index].imageUrl)
                            /*    image: NetworkImage(
                          besttopRatedCarList[index].imageUrl,
                        ),*/
                         // image: NetworkImage(topRatedCarList[index].imageUrl),
                        ),
                      ),
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            topRatedCarList[index].title.toString(),
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 13,
                            ),
                          ),
                        ],
                      )
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10,right: 10,top: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            topRatedCarList[index].millage.toString()+ ' '+topRatedCarList[index].millageUnit,
                            style: TextStyle(
                                fontSize: 12, color: miniTextColor
                            ),
                          ),
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
                  Container(
                      padding: EdgeInsets.only(top: 10,bottom: 10,left: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Үнэ :"+topRatedCarList[index].price.toString()+"₮",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      )
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
