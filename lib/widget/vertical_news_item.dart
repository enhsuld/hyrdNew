import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hyrd/models/car_model.dart';
import 'package:hyrd/models/post_model.dart';
import 'package:hyrd/screens/car_details_screen.dart';
import 'package:intl/intl.dart';

class VerticalNewsItem extends StatelessWidget {
  final int index;
  final PostModel item;

  VerticalNewsItem({this.index, this.item});

  static const miniTextColor = Color(0xFF6E7FAA);
  static const bigTextColor = Color(0xFF222455);

  @override
  Widget build(BuildContext context) {
    final formatter = new NumberFormat("#,###");
    final formatterDate = new DateFormat.yMMMMd('en_US');
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        GestureDetector(
          onTap: () {},
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Hero(
                  tag: item?.id ?? 0,
                  child: Container(
                    height: 80,
                    width: 100,
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(item.coverImage)),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width - 180,
                        child: Wrap(
                          children: <Widget>[
                            Text(
                              item?.title ?? "",
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: bigTextColor),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width - 180,
                        child: Wrap(
                          alignment: WrapAlignment.spaceAround,
                          children: <Widget>[
                            Text(
                              item?.summary ?? "",
                              textAlign: TextAlign.justify,
                              style:
                                  TextStyle(fontSize: 13, color: bigTextColor),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        formatterDate.format(DateTime.parse(item.publishedAt)),
                        style: TextStyle(
                            fontSize: 13,
                            color: bigTextColor),
                      ),
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
