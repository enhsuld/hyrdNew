import 'package:flutter/material.dart';
import 'package:hyrd/models/profile_model.dart';
import 'package:hyrd/screens/profile/feed_back_screen.dart';
import 'package:hyrd/screens/profile/notification_screen.dart';
import 'package:hyrd/screens/profile/saved_info_screen.dart';
import 'package:hyrd/screens/profile/term_screen.dart';
import 'package:hyrd/services/BackendService.dart';
import 'package:hyrd/utils/fade_route.dart';
import 'package:hyrd/utils/hyrd_icons.dart';
import 'package:toast/toast.dart';


class SettingScreen extends StatefulWidget {
  static const routeName = '/settings';

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool isSwitched = true;

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

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF584BDD),
        centerTitle: true,
        leading: Builder(builder: (BuildContext context) {
          return new SizedBox(
              height: 18.0,
              width: 18.0,
              child: new IconButton(
                padding: new EdgeInsets.all(0.0),
                color: Colors.white,
                icon: new Icon(Icons.arrow_back_ios, size: 20.0),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ));
        }),
        title: Text("Тохиргоо",
            style:
            TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new GestureDetector(
              onTap: ()=> {
                //Navigator.push(context, FadeRoute(builder: (context) => DealerScreen()))
              },
              child: new Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                elevation: 5,
                child: Container(
                  padding: EdgeInsets.only(left:20,top: 20,bottom: 20,right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(right: 20),
                              child: Icon(Hyrd.auto_login,color: Color(0xFF6E7FAA),size: 20,),
                            ),
                            Container(
                              child: Text(
                                "Автоматаар нэвтрэх",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF6E7FAA),
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 20,
                        child: Transform.scale( scale: 1,
                          child:  Switch(
                            value: this.user?.data?.setting?.autoLogin ?? false,
                            onChanged: (value) {
                              setState(() {
                                this.user.data.setting.autoLogin = value;
                                var map = new Map<String, dynamic>();
                                map["autoLogin"] = value;
                                BackendService.updateUser(map).then((onValue) {
                                  showToast("Амжилттай", gravity: Toast.BOTTOM);
                                });
                              });
                            },
                            activeTrackColor: Color(0xFFB755FF).withOpacity(0.4),
                            activeColor: Color(0xFFB755FF),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 10,),
            new GestureDetector(
              onTap: ()=> {
                //Navigator.push(context, FadeRoute(builder: (context) => DealerScreen()))
              },
              child: new Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                elevation: 5,
                child: Container(
                  padding: EdgeInsets.only(left:20,top: 20,bottom: 20,right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(right: 20),
                              child: Icon(Hyrd.mobile_data,color: Color(0xFF6E7FAA),size: 20,),
                            ),
                            Container(
                              child: Text(
                                "Mobile Data ашиглах",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF6E7FAA),
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 20,
                        child: Transform.scale( scale: 1,
                          child:  Switch(
                            value: this.user?.data?.setting?.mobileData ?? false,
                            onChanged: (value) {
                              setState(() {
                                print(value);
                                this.user.data.setting.mobileData = value;
                                var map = new Map<String, dynamic>();
                                map["mobileData"] = value;
                                BackendService.updateUser(map).then((onValue) {
                                  showToast("Амжилттай", gravity: Toast.BOTTOM);
                                });
                              });
                            },
                            activeTrackColor: Color(0xFFB755FF).withOpacity(0.4),
                            activeColor: Color(0xFFB755FF),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 10,),
            new GestureDetector(
              onTap: ()=> {
                Navigator.push(context, FadeRoute(builder: (context) => NotificationSettingsScreen(user: this.user)))
              },
              child: new Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                elevation: 5,
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(right: 20),
                              child: Icon(Hyrd.bell,color: Color(0xFF6E7FAA),size: 20,),
                            ),
                            Container(
                              child: Text(
                                "Мэдэгдлийн тохиргоо",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF6E7FAA),
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 20,
                        child: Icon(Icons.keyboard_arrow_right,color: Color(0xFF6E7FAA),size: 25,),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 10,),
            new GestureDetector(
              onTap: ()=> {
                Navigator.push(context, FadeRoute(builder: (context) => SavedInfoScreen(user: this.user)))
              },
              child: new Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                elevation: 5,
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(right: 20),
                              child: Icon(Hyrd.floppy_disk,color: Color(0xFF6E7FAA),size: 20,),
                            ),
                            Container(
                              child: Text(
                                "Хадгалагдсан мэдээлэл",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF6E7FAA),
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 20,
                        child: Icon(Icons.keyboard_arrow_right,color: Color(0xFF6E7FAA),size: 25,),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 10,),
            new GestureDetector(
              onTap: ()=> {
                Navigator.push(context, FadeRoute(builder: (context) => FeedBackScreen()))
              },
              child: new Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                elevation: 5,
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(right: 20),
                              child: Icon(Hyrd.mail,color: Color(0xFF6E7FAA),size: 20,),
                            ),
                            Container(
                              child: Text(
                                "Санал хүсэлт илгээх",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF6E7FAA),
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 20,
                        child: Icon(Icons.keyboard_arrow_right,color: Color(0xFF6E7FAA),size: 25,),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 10,),
            new GestureDetector(
              onTap: ()=> {
                Navigator.push(context, FadeRoute(builder: (context) => TermScreen()))
              },
              child: new Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                elevation: 5,
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(right: 20),
                              child: Icon(Hyrd.cog_hand,color: Color(0xFF6E7FAA),size: 20,),
                            ),
                            Container(
                              child: Text(
                                "Үйлчилгээний нөхцөл",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF6E7FAA),
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 20,
                        child: Icon(Icons.keyboard_arrow_right,color: Color(0xFF6E7FAA),size: 25,),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 10,),
            new GestureDetector(
              onTap: ()=> {
                //Navigator.push(context, FadeRoute(builder: (context) => DealerScreen()))
              },
              child: new Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                elevation: 5,
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(right: 20),
                              child: Icon(Hyrd.download,color: Color(0xFF6E7FAA),size: 20,),
                            ),
                            Container(
                              child: Text(
                                "Хувилбар V1.0.0",
                                style: TextStyle(
                                  fontSize: 16,
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
          ],
        ),
        ),
      ),
    );
  }

  void showToast(String msg, {int duration, int gravity}) {
    Toast.show(msg, context, duration: 1, gravity: gravity);
  }
}
