import 'dart:collection';

import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hyrd/models/car_model.dart';
import 'package:hyrd/models/report_type_model.dart';
import 'package:hyrd/screens/car_details_screen.dart';
import 'package:hyrd/screens/main/detail_screen.dart';
import 'package:hyrd/services/BackendService.dart';
import 'package:hyrd/utils/fade_route.dart';
import 'package:hyrd/utils/hyrd_icons.dart';
import 'package:intl/intl.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class VerticalAdsItem extends StatefulWidget {
  final int index;
  final CarModel item;

  VerticalAdsItem({this.index, this.item});

  static const miniTextColor = Color(0xFF6E7FAA);
  static const bigTextColor = Color(0xFF222455);

  @override
  _VerticalAdsItemState createState() => _VerticalAdsItemState();
}

class _VerticalAdsItemState extends State<VerticalAdsItem> {

  TextEditingController _descriptionController = new TextEditingController();

  var reportTypes = new List<ReportTypeModel>();

  @override
  void initState() {
    super.initState();
    BackendService.getReportTypes().then((data) {
      setState(() {
        print(data[0].id);
        this.reportTypes = data;
      });
    });
  }

  int _radioValue1 = 1;
  void _handleRadioValueChange1(int value) {
    _radioValue1 = value;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 10),
      child: GestureDetector(
        onTap: () {
          Navigator.push(context,
              FadeRoute(builder: (context) => DetailScreen(item: widget.item)));
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 3,
          child: Row(
            children: <Widget>[
              Container(
                height: 80,
                width: 100,
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    fit: BoxFit.fitHeight,
                    image: (widget.item.medias.length == 0)
                        ? AssetImage('assets/images/defualt-car.png')
                        : NetworkImage(widget.item?.medias[0]?.thumb),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                height: 80,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width - 165,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            widget.item?.name ?? "",
                            style: TextStyle(
                                fontSize: 15,
                                color: VerticalAdsItem.bigTextColor),
                          ),
                          new SizedBox(
                              height: 20.0,
                              width: 25.0,
                              child: new IconButton(
                                focusColor: Colors.blue,
                                padding: new EdgeInsets.all(0.0),
                                color: Color(0xFF222455),
                                icon: new Icon(Icons.more_horiz, size: 25.0),
                                onPressed: () {
                                  _settingModalBottomSheet(
                                      context,
                                      widget.item.id.toString(),
                                      "", widget.item.user.id.toString());
                                },
                              ))
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
                                  (widget.item?.mileage ?? 0).toString(),
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: VerticalAdsItem.miniTextColor),
                                ),
                                Text(
                                  (widget.item?.capacity ?? 0).toString(),
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: VerticalAdsItem.miniTextColor),
                                ),
                                Text(
                                  widget.item?.wheelPosition ?? "",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: VerticalAdsItem.miniTextColor),
                                  // item.wheelDrive,
                                ),
                              ],
                            )),
                        Container(
                            width: 230,
                            padding: EdgeInsets.only(top: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Үнэ :" +
                                      (widget.item?.priceFormat ?? "") +
                                      "₮",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: VerticalAdsItem.bigTextColor),
                                ),
                              ],
                            )),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _settingModalBottomSheet(context, String id, String type, String userId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String savedUserId = preferences.getString("userId") ?? "";
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        isScrollControlled: true,
        builder: (BuildContext bc) {
          return Container(
              height: 310,
              padding: EdgeInsets.all(15),
              decoration: new BoxDecoration(
                  color: Colors.white,
                  borderRadius: new BorderRadius.only(
                      topLeft: const Radius.circular(15.0),
                      topRight: const Radius.circular(15.0))),
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 5, right: 10, bottom: 10),
                    width: MediaQuery.of(context).size.width,
                    child: Text("Зарын гарчиг",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Color(0xFF222455),
                            fontSize: 15,
                            fontWeight: FontWeight.bold)),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 5, right: 5),
                    width: MediaQuery.of(context).size.width,
                    child: Divider(height: 2, color: Color(0xFF222455)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  new GestureDetector(
                    onTap: () => {
                      Share.share('check out my website https://example.com',
                          subject: 'Look what I made!')
                    },
                    child: new Card(
                      elevation: 3,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(right: 10),
                                    child: Icon(
                                      Hyrd.share,
                                      color: Color(0xFF6E7FAA),
                                      size: 20,
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      "Хуваалцах",
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Color(0xFF6E7FAA),
                                      ),
                                      textAlign: TextAlign.center,
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
                  SizedBox(
                    height: 10,
                  ),
                  new GestureDetector(
                    onTap: () => {_showNotifyDialog(id)},
                    child: new Card(
                      elevation: 3,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(right: 10),
                                    child: Icon(
                                      Hyrd.report,
                                      color: Color(0xFF6E7FAA),
                                      size: 20,
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      "Мэдэгдэх",
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Color(0xFF6E7FAA),
                                      ),
                                      textAlign: TextAlign.center,
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
                  SizedBox(
                    height: 10,
                  ),
                  (userId == savedUserId)
                      ? new GestureDetector(
                          onTap: () => {_showNotifyDialog(id)},
                          child: new Card(
                            elevation: 3,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          margin: EdgeInsets.only(right: 10),
                                          child: Icon(
                                            Hyrd.edit,
                                            color: Color(0xFF6E7FAA),
                                            size: 20,
                                          ),
                                        ),
                                        Container(
                                          child: Text(
                                            "Засах",
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Color(0xFF6E7FAA),
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      : Container(),
                  (userId == savedUserId)
                      ? SizedBox(
                          height: 10,
                        )
                      : Container(),
                  (userId == savedUserId)
                      ? new GestureDetector(
                          onTap: () => {_showDeleteDialog(id)},
                          child: new Card(
                            elevation: 3,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          margin: EdgeInsets.only(right: 10),
                                          child: Icon(
                                            Hyrd.remove,
                                            color: Color(0xFF6E7FAA),
                                            size: 20,
                                          ),
                                        ),
                                        Container(
                                          child: Text(
                                            "Устгах",
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Color(0xFF6E7FAA),
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      : Container(),
                  (userId == savedUserId)
                      ? SizedBox(
                          height: 10,
                        )
                      : Container()
                ],
              ));
        });
  }

  void _showDeleteDialog(String id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.all(0.0),
          backgroundColor: Color(0xffF4F4F4),
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
                  child: Icon(
                    Hyrd.remove,
                    size: 80,
                    color: Color(0xFF584BDD),
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
                  padding: EdgeInsets.only(left: 50, bottom: 20, right: 50),
                  child: Text(
                      "Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonu.",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Color(0xff8D8D8D), fontSize: 13)),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10.0),
                        bottomRight: Radius.circular(10.0)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      SizedBox(
                        width: (MediaQuery.of(context).size.width - 96) /
                            2, // match_parent
                        child: FlatButton(
                          child: const Text('Цуцлах'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                      SizedBox(
                        width: (MediaQuery.of(context).size.width - 96) /
                            2, // match_parent
                        child: FlatButton(
                          child: const Text('Тийм'),
                          onPressed: () {
                            BackendService.crud(
                                    'delete', '/car-ads/' + id, new HashMap())
                                .then((onValue) {
                              showToast("Амжилттай", gravity: Toast.BOTTOM);
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }


  String _myActivity;
  void _showNotifyDialog(String id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.all(0.0),
          backgroundColor: Color(0xffF4F4F4),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          content: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0)),
                  ),
                  child: SizedBox(
                    width: (MediaQuery.of(context).size.width - 96), // match_parent
                    child: FlatButton(
                      child: const Text('Мэдэгдэх'),
                      onPressed: () {
                      },
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(16),
                  child: DropDownFormField(
                    titleText: 'Төрөл',
                    hintText: 'Please choose one',
                    value: _myActivity,
                    onSaved: (value) {
                      setState(() {
                        _myActivity = value;
                      });
                    },
                    onChanged: (value) {
                      setState(() {
                        _myActivity = value;
                      });
                    },
                    dataSource: (reportTypes.length>0) ? reportTypes : [],
                    textField: 'name',
                    valueField: 'id',
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 30,horizontal: 10),
                  child: new Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: 5,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        height: 100,
                        child: TextFormField(
                          controller: _descriptionController,
                          maxLines: 4,
                          validator: (value) => value.isEmpty
                              ? 'Description is required'
                              : null,
                          decoration: InputDecoration.collapsed(
                              hintText: "Та энд тайлбараа бичнэ үү ..."),
                        ),
                      )),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10.0),
                        bottomRight: Radius.circular(10.0)),
                  ),
                  child: SizedBox(
                    width: (MediaQuery.of(context).size.width - 96), // match_parent
                    child: FlatButton(
                      child: const Text('Илгээх'),
                      onPressed: () {
                        BackendService.crud(
                            'post', '/reports/car-ads/' + id, new HashMap())
                            .then((onValue) {
                          showToast("Амжилттай", gravity: Toast.BOTTOM);
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void showToast(String msg, {int duration, int gravity}) {
    Toast.show(msg, context, duration: 1, gravity: gravity);
  }
}
