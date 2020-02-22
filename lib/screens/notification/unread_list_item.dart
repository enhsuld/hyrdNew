import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hyrd/models/car.dart';

class UnreadListItem extends StatelessWidget {
  final int index;
  UnreadListItem(this.index);
  static const miniTextColor = Color(0xFF6E7FAA);
  static const bigTextColor = Color(0xFF222455);


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

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            _showDialog();
          },
          child: Card(
           //   elevation: 2,
              child: ClipPath(
                child: Container(
                  child: Row(
                    children: <Widget>[
                      Hero(
                        tag: highlighted[index].id,
                        child: Container(
                          height: 60,
                          width: 60,
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(color: Colors.blueGrey),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(highlighted[index].imageUrl)
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
                                        icon: new Icon(Icons.lens, size: 9.0,color: Color(0xFFB755FF)),
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
                                    width: MediaQuery.of(context).size.width - 135,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          highlighted[index].millage.toString()+ ' '+highlighted[index].millageUnit,
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
                      border: Border(left: BorderSide(color: Color(0xFFB755FF), width: 5))),
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
