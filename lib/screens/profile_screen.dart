import 'package:flutter/material.dart';
import 'package:hyrd/screens/add_car_screen.dart';
import 'package:hyrd/screens/bottom_bar.dart';
import 'package:hyrd/screens/profile/ad_screen.dart';
import 'package:hyrd/screens/profile/follower_screen.dart';
import 'package:hyrd/screens/profile/help_screen.dart';
import 'package:hyrd/screens/profile/setting_screen.dart';
import 'package:hyrd/screens/profile/user_information_screen.dart';
import 'package:hyrd/screens/total_ad_screen.dart';
import 'package:hyrd/utils/fade_route.dart';

class ProfileScreen extends StatefulWidget {
  static const routeName = '/profile';

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final String _fullName = "Шүрэн-цэцэг Тэмүүжин";
  final String _logOut = "Системээс гарах";

  Widget _buildCoverImage(Size screenSize) {
    return Container(
      height: screenSize.height / 2.6,
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
        elevation: 5,
        child: Column(
          children: <Widget>[
            Center(
              child: Container(
                width: 140.0,
                height: 140.0,
                transform: Matrix4.translationValues(0.0, -70.0, 0.0),
                decoration: BoxDecoration(
                  boxShadow: [
                    new BoxShadow(
                      color: Colors.grey,
                      blurRadius: 5.0,
                    )
                  ],
                  image: DecorationImage(
                    image: AssetImage('assets/images/pic.png'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(80.0),
                  border: Border.all(
                    color: Colors.white,
                    width: 3.0,
                  ),
                ),
              ),
            ),
            Column(
              children: <Widget>[
                Container(
                  transform: Matrix4.translationValues(0.0, -50.0, 0.0),
                  child: Text(
                    _fullName,
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      color: Color(0xFF222455),
                      fontSize: 18.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Container(
                  transform: Matrix4.translationValues(0.0, -20.0, 0.0),
                  child: Column(
                    children: <Widget>[
                      _buildButton('Миний мэдээлэл',UserInformationScreen()),
                      _buildButton('Оруулсан зар',AdScreen()),
                      _buildButton('Тохиргоо',SettingScreen()),
                      _buildButton('Тусламж',HelpScreen()),
                      _buildButton('Дагаж байгаа',FollowerScreen()),
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

  Widget _buildButton(String name, Widget pageUrl) {
    return new MaterialButton(
      onPressed: () {
        // Navigator.of(context).pop();
         Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => pageUrl));
      },
      child: new Container(
        padding: new EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              child: Row(
                children: <Widget>[
                  new Icon(Icons.supervised_user_circle, color: Color(0xFFB6BED4), size: 30),
                  Container(
                    padding: const EdgeInsets.only(left: 20, top: 0),
                    child: new Text(name, textAlign: TextAlign.left, style:TextStyle(color: Color(0xFFB6BED4), fontSize: 16)),
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
        onPressed: () {},
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
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _buildCoverImage(screenSize),
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
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
                  SizedBox(height: screenSize.height / 6.4),
                  _buildProfileImage(),
                  _buildButtons(),
                ],
              ),
            ),
          ),
        ],
      )
    );
  }
}
