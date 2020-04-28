import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:hyrd/models/car_model.dart';
import 'package:hyrd/screens/search_result_screen.dart';
import 'package:hyrd/services/BackendService.dart';
import 'package:hyrd/utils/color_hyrd.dart';
import 'package:hyrd/utils/fade_route.dart';
import 'package:hyrd/utils/lang.dart';
import 'package:hyrd/widget/horizontal_car_item.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = '/search-car';

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with SingleTickerProviderStateMixin {
  TextEditingController _searchController = new TextEditingController();
  bool isLogin = false;
  TabController _tabController;

  List<dynamic> searchHistory = new List();
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 3);
    BackendService.getUserSearches().then((onValue) {
      print(onValue);
      searchHistory = onValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    BackendService.getToken().then((_token) {
      if (mounted) {
        setState(() {
          if (_token != null && _token != "") {
            isLogin = true;
          } else
            isLogin = false;
        });
      }
    });
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
                        // prefixIcon:
                        //     Icon(Icons.search, color: Colors.grey, size: 30.0),
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
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              height: 60,
              child: DefaultTabController(
                length: 3,
                child: TabBar(
                  onTap: (index) {
                    currentIndex = index;
                  },
                  tabs: [
                    Tab(text: lang.CAR_ADS.toUpperCase()),
                    Tab(text: lang.INFO.toUpperCase()),
                    Tab(text: lang.AAN.toUpperCase())
                  ],
                  labelPadding: EdgeInsets.all(0),
                  indicatorPadding: EdgeInsets.all(0),
                  unselectedLabelColor: Colors.grey,
                  labelColor: ColorHyrd.C222,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(color: Colors.grey[300]),
                  ),
                ),
              ),
            ),
            isLogin
                ? Padding(
                    padding: EdgeInsets.only(top: 0, left: 15, right: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          lang.LAST_SEARCH_ADS,
                          style: TextStyle(
                            fontSize: 12,
                            color: ColorHyrd.SUB_TTL,
                          ),
                        ),
                      ],
                    ),
                  )
                : Container(),
            isLogin
                ? Column(
                    children: searchHistory.map((f) {
                    return InkWell(
                      onTap: () {
                        searchHandler(f["keyword"]);
                      },
                      child: Container(
                        width: double.infinity,
                        margin:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                        child: Text(
                          f["keyword"],
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    );
                  }).toList())
                : Container(),
            Padding(
              padding: EdgeInsets.only(top: 10, left: 15, right: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    lang.HIGHLIGHT_ADS,
                    style: TextStyle(
                      fontSize: 12,
                      color: ColorHyrd.SUB_TTL,
                    ),
                  ),
                ],
              ),
            ),
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

  searchHandler(String keyword) {
    _searchController.text = keyword;
    Navigator.push(
        context,
        FadeRoute(
            builder: (context) => SearchResultScreen(
                  keyword: keyword,
                  searchType: currentIndex,
                )));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
