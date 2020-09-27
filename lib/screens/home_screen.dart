import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hyrd/models/profile_model.dart';
import 'package:hyrd/screens/add_car_screen.dart';
import 'package:hyrd/screens/dashboard_screen.dart';
import 'package:hyrd/screens/login/login_screen.dart';
import 'package:hyrd/screens/profile_screen.dart';
import 'package:hyrd/screens/search_car_screen.dart';
import 'package:hyrd/screens/total_ad_screen.dart';
import 'package:hyrd/services/BackendService.dart';
import 'package:hyrd/utils/hyrd_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  TabController _tabController;
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  List<Widget> _children = [];

  ProfileModel user;
  String token = "";
  SharedPreferences sharedPreferences;

  @override
  void initState() {
    super.initState();
    _children = [
      DashboardScreen(),
      SearchCarScreen(),
      TotalAdScreen(),
      ProfileScreen(onLogOut: () {
        _selectedTab(0);
      }),
      AddCarScreen()
    ];
    _tabController = TabController(vsync: this, length: _children.length);
    BackendService.getToken().then((_token) {
      if (mounted) {
        setState(() {
          if (_token != null && _token != "") BackendService.isLogin = true;
        });
      }
    });
  }

  int currentIndex = 0;

  void _selectedTab(int index) {
    setState(() {
      print(BackendService.isLogin);
      if (index == 4) {
        if (!BackendService.isLogin) {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => LoginScreen()));
        } else {
          currentIndex = index;
          _tabController.animateTo(currentIndex);
        }
      } else {
        if (index == 3) {
          if (!BackendService.isLogin) {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => LoginScreen()));
          }
        }
        currentIndex = index;
        _tabController.animateTo(currentIndex);
      }
    });
  }

  void navigationPage() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (this.mounted) {
      setState(() {
        token = sharedPreferences.getString("token") ?? "";
        if (token != "") {
          BackendService.isLogin = true;
        } else
          BackendService.isLogin = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    navigationPage();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.black,
        statusBarIconBrightness: Brightness.light));

    // Container(
    //       decoration: BoxDecoration(
    //           gradient: LinearGradient(
    //         colors: [Color(0xff584BDD), Color(0xffB755FF)],
    //       )),
    //       width: double.infinity,
    //       height: MediaQuery.of(context).padding.top,
    //     ),

    final bottomBar = FABBottomAppBar(
      onTabSelected: _selectedTab,
      color: Colors.grey[400],
      selectedColor: Colors.black,
      notchedShape: CircularNotchedRectangle(),
      items: [
        FABBottomAppBarItem(iconData: Hyrd.home, text: 'Home'),
        FABBottomAppBarItem(iconData: Hyrd.search, text: 'Place'),
        FABBottomAppBarItem(iconData: Hyrd.calendar_star, text: 'Style'),
        FABBottomAppBarItem(iconData: Hyrd.avatar, text: 'Profile')
      ],
    );

    return Scaffold(
        key: _scaffoldkey,
        backgroundColor: Colors.black,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Container(
          height: 60,
          width: 60,
          child: FloatingActionButton(
            backgroundColor: Color(0xFF584BDD),
            child: const Icon(
              Icons.add,
              size: 26,
            ),
            onPressed: () {
              // Navigator.push(                  context, FadeRoute(builder: (context) => AddCarScreen()));
              _selectedTab(4);
            },
          ),
        ),
        extendBody: true,
        bottomNavigationBar: bottomBar,
        body: Stack(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              //top: MediaQuery.of(context).padding.top,
              child: TabBarView(
                  children: _children,
                  controller: _tabController,
                  physics: NeverScrollableScrollPhysics()),
            ),
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                colors: [Color(0xff584BDD), Color(0xffB755FF)],
              )),
              width: double.infinity,
              height: MediaQuery.of(context).padding.top,
            ),
          ],
        ));
  }
}

class FABBottomAppBarItem {
  FABBottomAppBarItem({this.iconData, this.text});

  IconData iconData;
  String text;
}

class FABBottomAppBar extends StatefulWidget {
  FABBottomAppBar({
    this.items,
    this.centerItemText,
    this.height: 55.0,
    this.iconSize: 24.0,
    this.backgroundColor,
    this.color,
    this.selectedColor,
    this.notchedShape,
    this.onTabSelected,
  }) {
    assert(this.items.length == 2 || this.items.length == 4);
  }

  final List<FABBottomAppBarItem> items;
  final String centerItemText;
  final double height;
  final double iconSize;
  final Color backgroundColor;
  final Color color;
  final Color selectedColor;
  final NotchedShape notchedShape;
  final ValueChanged<int> onTabSelected;

  @override
  _FABBottomAppBarState createState() => _FABBottomAppBarState();
}

class _FABBottomAppBarState extends State<FABBottomAppBar> {
  int _selectedIndex = 0;

  _updateIndex(int index) {
    widget.onTabSelected(index);
    setState(() {
      _selectedIndex = index;
      print('selecte state $index');
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> items = List.generate(widget.items.length, (int index) {
      return _buildTabItem(
        item: widget.items[index],
        index: index,
        onPressed: _updateIndex,
      );
    });

    items.insert(items.length >> 1, _buildMiddleTabItem());

    return BottomAppBar(
      shape: widget.notchedShape,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items,
      ),
      color: widget.backgroundColor,
    );
  }

  Widget _buildMiddleTabItem() {
    return Expanded(
      child: SizedBox(
        height: widget.height,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: widget.iconSize,
            ),
            // Text(
            //   widget.centerItemText ?? '',
            //   style: TextStyle(color: widget.color),
            // )
          ],
        ),
      ),
    );
  }

  Widget _buildTabItem({
    FABBottomAppBarItem item,
    int index,
    ValueChanged<int> onPressed,
  }) {
    Color color = _selectedIndex == index ? widget.selectedColor : widget.color;
    return Expanded(
      child: SizedBox(
        height: widget.height,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: () => onPressed(index),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  item.iconData,
                  color: color,
                  size: widget.iconSize,
                ),
                // Text(
                //   item.text,
                //   style: TextStyle(color: color),
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
