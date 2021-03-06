import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hyrd/models/car_model.dart';
import 'package:hyrd/models/post_model.dart';
import 'package:hyrd/services/BackendService.dart';
import 'package:hyrd/utils/lang.dart';
import 'package:hyrd/widget/vertical_ads_item.dart';

class SearchResultScreen extends StatefulWidget {
  static const routeName = '/search-car';
  final String keyword;
  final int searchType;
  final Map<String, String> filter;

  SearchResultScreen({this.keyword, this.searchType, this.filter});

  @override
  _SearchResultScreenState createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  TextEditingController _searchController = new TextEditingController();
  bool isLogin = false;

  List<dynamic> searchHistory = new List();
  List<CarModel> cars = new List();
  List<PostModel> posts = new List();
  List<CarModel> orgs = new List();
  String cnt = "0";

  String result;

  @override
  void initState() {
    super.initState();
    searchHandler(widget.keyword);
    _searchController.text = widget.keyword;
  }

  searchHandler(String keyword) {
    Map<String, String> body = new HashMap();
    body["keyword"] = keyword;
    _searchController.text = keyword;
    BackendService.getSearch(body: body).then((onValue) {
      setState(() {
        result = onValue;
        var jsonss = json.decode(result.toString());
        //print(jsonss["results"]["car_ads"]);
        if (widget.searchType == 0) {
          cars = CarModel.fromJsonListNoData(jsonss["results"]["car_ads"]);
          cnt = cars.length.toString();
        } else if (widget.searchType == 0) {
          posts = PostModel.fromJsonList(jsonss["results"]["posts"]);
          cnt = posts.length.toString();
        } else {
          orgs = CarModel.fromJsonListNoData(jsonss["results"]["orgs"]);
          cnt = orgs.length.toString();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                colors: [Color(0xff584BDD), Color(0xffB755FF)],
              )),
              width: double.infinity,
              height: MediaQuery.of(context).padding.top,
            ),
            Padding(
              padding: EdgeInsets.only(top: 12, left: 15.0, right: 15.0),
              child: Material(
                elevation: 8.0,
                borderRadius: BorderRadius.circular(8.0),
                child: TextFormField(
                    autofocus: true,
                    textInputAction: TextInputAction.search,
                    onFieldSubmitted: (term) {
                      searchHandler(term);
                    },
                    controller: _searchController,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon:
                            Icon(Icons.search, color: Colors.grey, size: 30.0),
                        suffixIcon: IconButton(
                          icon: Container(
                            padding: EdgeInsets.all(3),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFF676E79)),
                            child: new Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 15,
                            ),
                          ),
                          onPressed: () {
                            _searchController.clear();
                          },
                        ),
                        contentPadding: EdgeInsets.only(left: 15.0, top: 15.0),
                        hintText: 'Хайлт хийх',
                        hintStyle: TextStyle(
                            color: Colors.grey, fontFamily: 'Quicksand'))),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15, left: 15, right: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    lang.SEARCH_RESULT + " ($cnt)",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            _buildList(),
            // FutureBuilder(
            //   future: BackendService.getHighlight(page: 1, pageSize: 5),
            //   builder: (context, snapshot) {
            //     List<dynamic> lists;
            //     if (snapshot.hasData) {
            //       lists = snapshot.data;
            //       return Container(
            //         height: double.parse(lists.length.toString()) * 105,
            //         padding:
            //             EdgeInsets.only(bottom: 0, top: 0, left: 10, right: 10),
            //         child: ListView.builder(
            //           padding: EdgeInsets.only(top: 0, bottom: 0),
            //           physics: NeverScrollableScrollPhysics(),
            //           itemCount: lists.length,
            //           itemBuilder: (ctx, i) => VerticalAdsItem(
            //             index: i,
            //             item: CarModel.fromJson(lists[i]["car_ad"]),
            //           ),
            //         ),
            //       );
            //     } else {
            //       return Center(
            //         child: CircularProgressIndicator(),
            //       );
            //     }
            //   },
            // ),
            // Container(
            //     height: 270,
            //     child: FutureBuilder(
            //       future: BackendService.getPopular(page: 1, pageSize: 5),
            //       builder: (context, snapshot) {
            //         List<dynamic> adsPopulars;
            //         if (snapshot.hasData) {
            //           adsPopulars = snapshot.data;
            //           return ListView.builder(
            //             padding: EdgeInsets.only(top: 0, bottom: 0),
            //             scrollDirection: Axis.horizontal,
            //             itemCount: adsPopulars.length,
            //             itemBuilder: (ctx, i) => HorizontalCarItem(
            //                 index: i, item: CarModel.fromJson(adsPopulars[i])),
            //           );
            //         } else {
            //           return Center(
            //             child: CircularProgressIndicator(),
            //           );
            //         }
            //       },
            //     )),
          ],
        ),
      ),
    );
  }

  Widget _buildList() {
    switch (widget.searchType) {
      case 0:
        return Container(
          height: double.parse(cars.length.toString()) * 105,
          padding: EdgeInsets.only(bottom: 0, top: 0, left: 10, right: 10),
          child: ListView.builder(
            padding: EdgeInsets.only(top: 0, bottom: 0),
            physics: NeverScrollableScrollPhysics(),
            itemCount: cars.length,
            itemBuilder: (ctx, i) => VerticalAdsItem(
              index: i,
              item: cars[i],
            ),
          ),
        );
        break;
      case 1:
        return Container(
          height: double.parse(posts.length.toString()) * 105,
          padding: EdgeInsets.only(bottom: 0, top: 0, left: 10, right: 10),
          child: ListView.builder(
            padding: EdgeInsets.only(top: 0, bottom: 0),
            physics: NeverScrollableScrollPhysics(),
            itemCount: posts.length,
            itemBuilder: (ctx, i) => Text(posts[i].title),
          ),
        );
        break;
      case 2:
        return Container(
          height: double.parse(orgs.length.toString()) * 105,
          padding: EdgeInsets.only(bottom: 0, top: 0, left: 10, right: 10),
          child: ListView.builder(
            padding: EdgeInsets.only(top: 0, bottom: 0),
            physics: NeverScrollableScrollPhysics(),
            itemCount: orgs.length,
            itemBuilder: (ctx, i) => VerticalAdsItem(
              index: i,
              item: orgs[i],
            ),
          ),
        );
        break;
      default:
        return Container();
    }
  }
}
