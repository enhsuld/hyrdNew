import 'package:flutter/material.dart';
import 'package:hyrd/models/profile_model.dart';
import 'package:hyrd/screens/login/login_screen.dart';
import 'package:hyrd/screens/login/signUp/step_one.dart';
import 'package:hyrd/screens/profile/feed_back_screen.dart';
import 'package:hyrd/screens/profile/notification_screen.dart';
import 'package:hyrd/screens/profile/saved_info_screen.dart';
import 'package:hyrd/screens/profile/term_screen.dart';
import 'package:hyrd/services/BackendService.dart';
import 'package:hyrd/utils/fade_route.dart';
import 'package:hyrd/utils/hyrd_icons.dart';
import 'package:hyrd/utils/hyrd_new_icons_icons.dart';
import 'package:toast/toast.dart';

class SettingScreen extends StatefulWidget {
  static const routeName = '/settings';

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool isSwitched = true;

  ProfileModel user;
  bool isLogin = false;

  @override
  void initState() {
    super.initState();
    BackendService.getToken().then((_token) {
      if (mounted) {
        if (_token != null && _token != "") {
          BackendService.getUserProfileData().then((data) {
            setState(() {
              this.user = data;
              print(data);
            });
          });
        }
      }
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
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.topRight,
            colors: <Color>[Color(0xFF584BDD), Color(0xFFB755FF)],
          )),
        ),
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
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
        elevation: 0.0,
      ),
      body: isLogin
          ? SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    new GestureDetector(
                      onTap: () => {
                        setState(() {
                          if(this.user.data.setting.autoLogin){
                            this.user.data.setting.autoLogin =false;
                            var map = new Map<String, dynamic>();
                            map["autoLogin"] = false;
                            BackendService.updateUser(map).then((onValue) {
                              showToast("Амжилттай",gravity: Toast.BOTTOM);
                            });
                          }
                          else{
                            this.user.data.setting.autoLogin =true;
                            var map = new Map<String, dynamic>();
                            map["autoLogin"] = true;
                            BackendService.updateUser(map).then((onValue) {
                              showToast("Амжилттай",gravity: Toast.BOTTOM);
                            });
                          }
                        })
                      },
                      child: new Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        elevation: 5,
                        child: Container(
                          padding: EdgeInsets.only(
                              left: 20, top: 20, bottom: 20, right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(right: 20),
                                      child: Icon(
                                        Hyrd.auto_login,
                                        color: Color(0xFF6E7FAA),
                                        size: 20,
                                      ),
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
                                child: Transform.scale(
                                  scale: 1,
                                  child: Switch(
                                    value:
                                        this.user?.data?.setting?.autoLogin ??
                                            false,
                                    onChanged: (value) {
                                      setState(() {
                                        this.user.data.setting.autoLogin =
                                            value;
                                        var map = new Map<String, dynamic>();
                                        map["autoLogin"] = value;
                                        BackendService.updateUser(map)
                                            .then((onValue) {
                                          showToast("Амжилттай",
                                              gravity: Toast.BOTTOM);
                                        });
                                      });
                                    },
                                    activeTrackColor:
                                        Color(0xFFB755FF).withOpacity(0.4),
                                    activeColor: Color(0xFFB755FF),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    new GestureDetector(
                      onTap: () => {
                        setState(() {
                          if(this.user.data.setting.mobileData){
                            this.user.data.setting.mobileData =false;
                            var map = new Map<String, dynamic>();
                            map["mobileData"] = false;
                            BackendService.updateUser(map).then((onValue) {
                              showToast("Амжилттай",gravity: Toast.BOTTOM);
                            });
                          }
                          else{
                            this.user.data.setting.mobileData =true;
                            var map = new Map<String, dynamic>();
                            map["mobileData"] = true;
                            BackendService.updateUser(map).then((onValue) {
                              showToast("Амжилттай",gravity: Toast.BOTTOM);
                            });
                          }
                        })
                      },
                      child: new Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        elevation: 5,
                        child: Container(
                          padding: EdgeInsets.only(
                              left: 20, top: 20, bottom: 20, right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(right: 20),
                                      child: Icon(
                                        Hyrd.mobile_data,
                                        color: Color(0xFF6E7FAA),
                                        size: 20,
                                      ),
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
                                child: Transform.scale(
                                  scale: 1,
                                  child: Switch(
                                    value:
                                        this.user?.data?.setting?.mobileData ??
                                            false,
                                    onChanged: (value) {
                                      setState(() {
                                        print(value);
                                        this.user.data.setting.mobileData =
                                            value;
                                        var map = new Map<String, dynamic>();
                                        map["mobileData"] = value;
                                        BackendService.updateUser(map)
                                            .then((onValue) {
                                          showToast("Амжилттай",
                                              gravity: Toast.BOTTOM);
                                        });
                                      });
                                    },
                                    activeTrackColor:
                                        Color(0xFFB755FF).withOpacity(0.4),
                                    activeColor: Color(0xFFB755FF),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    new GestureDetector(
                      onTap: () => {
                        Navigator.push(
                            context,
                            FadeRoute(
                                builder: (context) =>
                                    NotificationSettingsScreen(
                                        user: this.user)))
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
                                      child: Icon(
                                        Hyrd.bell,
                                        color: Color(0xFF6E7FAA),
                                        size: 20,
                                      ),
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
                                child: Icon(
                                  Icons.keyboard_arrow_right,
                                  color: Color(0xFF6E7FAA),
                                  size: 25,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    new GestureDetector(
                      onTap: () => {
                        Navigator.push(
                            context,
                            FadeRoute(
                                builder: (context) =>
                                    SavedInfoScreen(user: this.user)))
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
                                      child: Icon(
                                        Hyrd.floppy_disk,
                                        color: Color(0xFF6E7FAA),
                                        size: 20,
                                      ),
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
                                child: Icon(
                                  Icons.keyboard_arrow_right,
                                  color: Color(0xFF6E7FAA),
                                  size: 25,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    new GestureDetector(
                      onTap: () => {
                        Navigator.push(context,
                            FadeRoute(builder: (context) => FeedBackScreen()))
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
                                      child: Icon(
                                        Hyrd.mail,
                                        color: Color(0xFF6E7FAA),
                                        size: 20,
                                      ),
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
                                child: Icon(
                                  Icons.keyboard_arrow_right,
                                  color: Color(0xFF6E7FAA),
                                  size: 25,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    new GestureDetector(
                      onTap: () => {
                        Navigator.push(context,
                            FadeRoute(builder: (context) => TermScreen()))
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
                                      child: Icon(
                                        Hyrd.cog_hand,
                                        color: Color(0xFF6E7FAA),
                                        size: 20,
                                      ),
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
                                child: Icon(
                                  Icons.keyboard_arrow_right,
                                  color: Color(0xFF6E7FAA),
                                  size: 25,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    new GestureDetector(
                      onTap: () => {
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
                                      child: Icon(
                                        Hyrd.download,
                                        color: Color(0xFF6E7FAA),
                                        size: 20,
                                      ),
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
            )
          : Container(
          child:Container(
            margin: EdgeInsets.only(top:25),
            color: Colors.white,
            child: Column(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(top: 40),
                  padding: EdgeInsets.symmetric(vertical: 40),
                  child: Text(
                    "Та системд нэвтрэнэ үү.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color(0xff222455), fontSize: 18),
                  ),
                ),
                new Card(
                  margin: EdgeInsets.only(
                      top: 10, left: 20, right: 20, bottom: 10),
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 5,
                  child: MaterialButton(
                    padding: EdgeInsets.all(0),
                    onPressed: () {
                      Navigator.push(
                          context,
                          FadeRoute(
                              builder: (context) => LoginScreen()));
                    },
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0)),
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
                            borderRadius: BorderRadius.all(
                                Radius.circular(8.0))),
                        padding:
                        const EdgeInsets.fromLTRB(25, 15, 25, 15),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("Нэвтрэх",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16)),
                            Icon(HyrdNewIcons.car_login,
                                color: Colors.white, size: 22.0)
                          ],
                        )),
                  ),
                ),
                new Card(
                  margin:
                  EdgeInsets.only(top: 10, left: 20, right: 20),
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 5,
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => StepOneScreen()));
                    },
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(
                                Radius.circular(8.0))),
                        padding:
                        const EdgeInsets.fromLTRB(10, 15, 10, 15),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("Бүртгүүлэх",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Color(0xff584BDD),
                                    fontSize: 16)),
                            Icon(HyrdNewIcons.car_register,
                                color: Color(0xff584BDD), size: 22.0)
                          ],
                        )),
                  ),
                )
              ],
            ),
          )
      )
    );
  }

  void showToast(String msg, {int duration, int gravity}) {
    Toast.show(msg, context, duration: 1, gravity: gravity);
  }
}
