import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hyrd/models/car_model.dart';
import 'package:hyrd/screens/main/detail_screen.dart';
import 'package:hyrd/utils/fade_route.dart';
import 'package:intl/intl.dart';

class HorizontalCarItem extends StatefulWidget {
  final int index;
  final CarModel item;
  HorizontalCarItem({this.index, this.item});

  static const miniTextColor = Color(0xFF6E7FAA);

  @override
  _HorizontalCarItemState createState() => _HorizontalCarItemState();
}

class _HorizontalCarItemState extends State<HorizontalCarItem> {
  final formatter = new NumberFormat("#,###");

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
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
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
                    child: Text("Зар устгах",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Color(0xff584BDD),
                            fontSize: 18,
                            fontWeight: FontWeight.w600)),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 50, right: 50),
                    child: Text(
                        "Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonu.",
                        textAlign: TextAlign.center,
                        style:
                            TextStyle(color: Color(0xff8D8D8D), fontSize: 13)),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 50, right: 50),
                width: MediaQuery.of(context).size.width - 96,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10.0),
                      bottomRight: Radius.circular(10.0)),
                ),
                child: Row(
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
      padding: const EdgeInsets.only(left: 10),
      width: 206,
      child: GestureDetector(
        onTap: () {
          Navigator.push(context,
              FadeRoute(builder: (context) => DetailScreen(item: widget.item)));
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 3,
              child: Column(
                children: <Widget>[
                  Hero(
                    tag: widget.item?.id ?? 0,
                    child: Container(
                      height: 170,
                      decoration: BoxDecoration(
                        borderRadius: new BorderRadius.only(
                            topLeft: const Radius.circular(5.0),
                            topRight: const Radius.circular(5.0)),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: (widget.item.medias.length == 0)
                              ? AssetImage('assets/images/defualt-car.png')
                              : CachedNetworkImageProvider(
                                  widget?.item?.medias[0]?.thumb ?? ""),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    width: double.infinity,
                    child: Text(
                      widget?.item?.name ?? "",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 13,
                      ),
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.only(left: 10, right: 10, top: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            (widget?.item?.mileage ?? 0).toString(),
                            style: TextStyle(
                                fontSize: 12,
                                color: HorizontalCarItem.miniTextColor),
                          ),
                          Text(
                            (widget?.item?.capacity ?? 0).toString(),
                            style: TextStyle(
                                fontSize: 12,
                                color: HorizontalCarItem.miniTextColor),
                          ),
                          Text(
                            widget?.item?.wheelPosition ?? "",
                            style: TextStyle(
                                fontSize: 12,
                                color: HorizontalCarItem.miniTextColor),
                          ),
                        ],
                      )),
                  Container(
                      padding: EdgeInsets.only(top: 10, bottom: 10, left: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Үнэ: " + (widget.item?.priceFormat ?? "") + " ₮",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
