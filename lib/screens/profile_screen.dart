import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hyrd/models/profile_model.dart';
import 'package:hyrd/screens/dashboard_screen.dart';
import 'package:hyrd/screens/login/login_screen.dart';
import 'package:hyrd/screens/profile/ad_screen.dart';
import 'package:hyrd/screens/profile/follower_screen.dart';
import 'package:hyrd/screens/profile/help_screen.dart';
import 'package:hyrd/screens/profile/setting_screen.dart';
import 'package:hyrd/screens/profile/user_information_screen.dart';
import 'package:hyrd/services/BackendService.dart';
import 'package:hyrd/utils/fade_route.dart';
import 'package:hyrd/utils/hyrd_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  static const routeName = '/profile';
  final Function onLogOut;
  ProfileScreen({this.onLogOut});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final String _logOut = "Системээс гарах";

  bool isLogin = false;

  ProfileModel user;

  @override
  void initState() {
    super.initState();
    BackendService.getUserProfileData().then((data) {
      setState(() {
        this.user = data;
        print(data);
      });
    });
  }

  Widget _buildCoverImage(Size screenSize) {
    return Container(
      height: 250,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.topRight,
        colors: <Color>[Color(0xFF584BDD), Color(0xFFB755FF)],
      )),
    );
  }

  Widget _buildProfileImage() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 5,
        child: Column(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 100, bottom: 30),
                  child: Text(
                    (this.user?.data?.lastname ?? "").toUpperCase() +
                        ' ' +
                        (this.user?.data?.firstname ?? ""),
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      color: Color(0xFF222455),
                      fontSize: 18.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                new Divider(
                  color: Color(0xFF6E7FAA),
                  height: 2,
                  thickness: 2,
                ),
                Container(
                  padding: EdgeInsets.only(top: 30),
                  child: Column(
                    children: <Widget>[
                      _buildButton(Hyrd.profile, 'Миний мэдээлэл',
                          UserInformationScreen(user: this.user)),
                      _buildButton(Hyrd.star, 'Оруулсан зар', AdScreen()),
                      _buildButton(Hyrd.settings, 'Тохиргоо', SettingScreen()),
                      _buildButton(Hyrd.report, 'Тусламж', HelpScreen()),
                      _buildButton(Hyrd.team, 'Дагаж байгаа', FollowerScreen()),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildButton(IconData icon, String name, Widget pageUrl) {
    return new MaterialButton(
      onPressed: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (BuildContext context) => pageUrl));
      },
      child: new Container(
        padding: new EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              child: Row(
                children: <Widget>[
                  new Icon(icon, color: Color(0xFFB6BED4), size: 20),
                  Container(
                    padding: const EdgeInsets.only(left: 20, top: 0),
                    child: new Text(name,
                        textAlign: TextAlign.left,
                        style:
                            TextStyle(color: Color(0xFFB6BED4), fontSize: 16)),
                  ),
                ],
              ),
            ),
            new Icon(Icons.arrow_forward_ios,
                color: Color(0xFFB6BED4), size: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildButtons() {
    return Container(
      padding: EdgeInsets.only(right: 0, left: 0, top: 10, bottom: 20),
      width: MediaQuery.of(context).size.width,
      // height: 95,
      child: FlatButton(
        onPressed: () {
          BackendService.logOut().then((onValue) {
            widget.onLogOut();
          });
        },
        textColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[
                    Color(0xFFB755FF),
                    Color(0xFF584BDD),
                  ],
                ),
                borderRadius: BorderRadius.all(Radius.circular(8.0))),
            padding: const EdgeInsets.fromLTRB(30, 15, 15, 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(_logOut.toUpperCase(),
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Colors.white, fontSize: 16)),
                Icon(Icons.exit_to_app, color: Colors.white, size: 22.0)
              ],
            )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
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

    return Container(
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: <Widget>[
            Scaffold(
              body: isLogin
                  ? Stack(
                      children: <Widget>[
                        Positioned(
                          right: 0,
                          left: 0,
                          child: _buildCoverImage(screenSize),
                        ),
                        Positioned(
                          left: 10,
                          top: 30,
                          child: Container(
                            padding: EdgeInsets.only(top: 40, left: 20),
                            width: MediaQuery.of(context).size.width - 20,
                            child: Text(
                              "Profile",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                color: Colors.white,
                                fontSize: 18.0,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 10,
                          right: 10,
                          top: 180,
                          child: _buildProfileImage(),
                        ),
                        Positioned(
                            right: 0,
                            left: 0,
                            top: 120,
                            child: Center(
                              child: Container(
                                width: 140.0,
                                height: 140.0,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    new BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 5.0,
                                    )
                                  ],
                                  image: DecorationImage(
                                    image: (this.user?.data?.avatar == null)
                                        ? AssetImage('assets/images/pic.png')
                                        : NetworkImage(this.user?.data?.avatar),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.circular(80.0),
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 3.0,
                                  ),
                                ),
                              ),
                            )),
                        Positioned(
                          left: 10,
                          right: 10,
                          bottom: 80,
                          child: _buildButtons(),
                        ),
                      ],
                    )
                  : Center(
                      child: FlatButton(
                          onPressed: () {
                            Navigator.push(context,
                                FadeRoute(builder: (context) => LoginScreen()));
                          },
                          child: Text("Нэвтрэх")),
                    ),
            )
          ],
        ));
  }
}
