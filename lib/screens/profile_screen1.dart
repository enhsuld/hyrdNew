import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hyrd/models/profile_model.dart';
import 'package:hyrd/screens/profile/ad_screen.dart';
import 'package:hyrd/screens/profile/follower_screen.dart';
import 'package:hyrd/screens/profile/help_screen.dart';
import 'package:hyrd/screens/profile/setting_screen.dart';
import 'package:hyrd/screens/profile/user_information_screen.dart';
import 'package:hyrd/services/BackendService.dart';
import 'package:hyrd/utils/hyrd_icons.dart';

class ProfileScreen1 extends StatefulWidget {
  static const routeName = '/profile';
  final Function onLogOut;

  ProfileScreen1({this.onLogOut});

  @override
  _ProfileScreen1State createState() => _ProfileScreen1State();
}

class _ProfileScreen1State extends State<ProfileScreen1> {
  final String _logOut = "Системээс гарах";

  ProfileModel user;

  @override
  void initState() {
    super.initState();

    BackendService.getToken().then((_token) {
      if (mounted) {
        setState(() {
          if (_token != null && _token != "") {
            BackendService.getUserProfileData().then((data) {
              setState(() {
                this.user = data;
                print(data);
              });
            });
          }
        });
      }
    });
  }

  Widget _buildCoverImage(Size screenSize) {
    return Container(
      height: 200,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.topRight,
        colors: <Color>[Color(0xFF584BDD), Color(0xFFB755FF)],
      )),
    );
  }

  Widget _buildProfileImage() {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 2,
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 90, bottom: 20),
            child: Text(
              (this.user?.data?.lastname ?? "") +
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
            thickness: 2,
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10),
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
    return Card(
      //margin: EdgeInsets.symmetric(horizontal: 15),
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 2,
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
                borderRadius: BorderRadius.all(Radius.circular(8.0))),
            padding: const EdgeInsets.fromLTRB(10, 15, 15, 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(_logOut.toUpperCase(),
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Color(0xff584BDD), fontSize: 16)),
                Icon(Icons.exit_to_app, color: Color(0xff584BDD), size: 22.0)
              ],
            )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    BackendService.getToken().then((_token) {
      if (mounted) {
        setState(() {
          if (_token != "")
            BackendService.isLogin = true;
          else
            BackendService.isLogin = false;
        });
      }
    });

    return Column(
      children: <Widget>[
        _buildProfileImage(),
        SizedBox(height: 20),
        _buildButtons(),
        SizedBox(height: 30)
      ],
    );
  }
}
