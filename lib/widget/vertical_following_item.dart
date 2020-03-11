import 'dart:collection';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hyrd/models/organization_model.dart';
import 'package:hyrd/services/BackendService.dart';
import 'package:hyrd/utils/hyrd_icons.dart';
import 'package:intl/intl.dart';

class VerticalFollowingItem extends StatefulWidget {
  final int index;
  final OrganizationModel item;

  VerticalFollowingItem({this.index, this.item});

  static const miniTextColor = Color(0xFF6E7FAA);
  static const bigTextColor = Color(0xFF222455);

  @override
  _VerticalFollowingItemState createState() => _VerticalFollowingItemState();
}

class _VerticalFollowingItemState extends State<VerticalFollowingItem> {
  @override
  Widget build(BuildContext context) {
    final formatter = new NumberFormat("#,###");

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width - 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                child: Row(
                  children: <Widget>[
                    Container(
                      height: 50,
                      width: 50,
                      margin: EdgeInsets.only(top: 10, right:10,bottom: 10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFFB6BED4), width: 2),
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              widget.item?.avatar ?? "",
                            )),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width - 235,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            widget.item?.name ?? "",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: VerticalFollowingItem.bigTextColor),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            widget.item?.service ?? "",
                            style: TextStyle(
                                fontSize: 12,
                                color: VerticalFollowingItem.miniTextColor),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),


              FlatButton(
                   padding: const EdgeInsets.all(0.0),
                shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                 // color: Colors.blue,
                  textColor: Colors.white,
                  disabledColor: Colors.grey,
                  disabledTextColor: Colors.black,
                  onPressed: () {
                    print("end");
                    Map<String, dynamic> map = new HashMap();
                    map["organization_id"] = widget.item.id;

                    print(map);
                    if (widget.item.pivot.followedAt != null) {
                      BackendService.putUnfollow(body: map).then((onValue) {
                        print(onValue);
                        if (onValue != null) {
                          print(onValue);
                          if (onValue == 200) {
                            setState(() {
                              widget.item.pivot.followedAt = null;
                            });
                          }
                        }
                      });
                    } else {
                      BackendService.putFollow(body: map).then((onValue) {
                        print(onValue);
                        if (onValue != null) {
                          print(onValue);
                          if (onValue == 200) {
                            setState(() {
                              widget.item.pivot.followedAt = "asd";
                            });
                          }
                        }
                      });
                    }
                  },
                  child: Container(
                      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                      decoration: (widget.item.pivot.followedAt == null) ? BoxDecoration(
                          gradient:
                          LinearGradient(
                            begin: Alignment
                                .topCenter,
                            end: Alignment
                                .bottomCenter,
                            colors:  <Color>[
                              Color(0xFFB755FF),
                              Color(0xFF584BDD),
                            ],
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(80.0))
                      ) : BoxDecoration(
                          border: new Border.all(color: Colors.black, width: 1.0),
                          gradient:
                          LinearGradient(
                            begin: Alignment
                                .topCenter,
                            end: Alignment
                                .bottomCenter,
                            colors:  <Color>[
                              Colors.white,
                              Colors.white,
                            ],
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(80.0))
                      ),
                    child: (widget.item.pivot.followedAt != null)
                        ? Text("Following",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 15,color: Colors.black))
                        : Text("Follow",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 15))),
                  )
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
