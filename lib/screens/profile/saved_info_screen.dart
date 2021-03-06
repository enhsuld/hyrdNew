import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hyrd/models/profile_model.dart';
import 'package:hyrd/services/BackendService.dart';
import 'package:hyrd/utils/hyrd_icons.dart';
import 'package:toast/toast.dart';


class SavedInfoScreen extends StatefulWidget {
  static const routeName = '/saved-info';
  final ProfileModel user;

  SavedInfoScreen({Key key, @required this.user}) : super(key: key);
  @override
  _SavedInfoScreenState createState() => _SavedInfoScreenState();
}

class _SavedInfoScreenState extends State<SavedInfoScreen> {

  bool isSwitched = true;

  @override
  Widget build(BuildContext context) {
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
        title: Text("Хадгалагдсан мэдээлэл",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new GestureDetector(
                onTap: () => {
                  setState(() {
                    if(widget.user.data.setting.saveSearch){
                      widget.user.data.setting.saveSearch =false;
                      var map = new Map<String, dynamic>();
                      map["saveSearch"] = false;
                      BackendService.updateUser(map).then((onValue) {
                        showToast("Амжилттай",gravity: Toast.BOTTOM);
                      });
                    }
                    else{
                      widget.user.data.setting.saveSearch =true;
                      var map = new Map<String, dynamic>();
                      map["saveSearch"] = true;
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
                                child: Icon(
                                  Hyrd.floppy_disk,
                                  color: Color(0xFF6E7FAA),
                                  size: 20,
                                ),
                              ),
                              Container(
                                child: Text(
                                  "Хайлт хадгалах",
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
                              value: widget.user.data.setting.saveSearch,
                              onChanged: (value) {
                                setState(() {
                                  widget.user.data.setting.saveSearch = value;
                                  var map = new Map<String, dynamic>();
                                  map["saveSearch"] = value;
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
              SizedBox(
                height: 10,
              ),
              new GestureDetector(
                onTap: () => {
                  setState(() {
                    if(widget.user.data.setting.saveViews){
                      widget.user.data.setting.saveViews =false;
                      var map = new Map<String, dynamic>();
                      map["saveViews"] = false;
                      BackendService.updateUser(map).then((onValue) {
                        showToast("Амжилттай",gravity: Toast.BOTTOM);
                      });
                    }
                    else{
                      widget.user.data.setting.saveViews =true;
                      var map = new Map<String, dynamic>();
                      map["saveViews"] = true;
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
                                child: Icon(
                                  Hyrd.file,
                                  color: Color(0xFF6E7FAA),
                                  size: 20,
                                ),
                              ),
                              Container(
                                child: Text(
                                  "Үзэлт хадгалах",
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
                              value: widget.user.data.setting.saveViews,
                              onChanged: (value) {
                                setState(() {
                                  widget.user.data.setting.saveViews = value;
                                  var map = new Map<String, dynamic>();
                                  map["saveViews"] = value;
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
              SizedBox(
                height: 10,
              ),
              new GestureDetector(
                onTap: () => {_showViewDialog()},
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
                                  Hyrd.broom,
                                  color: Color(0xFF6E7FAA),
                                  size: 20,
                                ),
                              ),
                              Container(
                                child: Text(
                                  "Үзэлтийн түүх цэвэрлэх",
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
              SizedBox(
                height: 10,
              ),
              new GestureDetector(
                onTap: () => {_showSearchDialog()},
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
                                  Hyrd.broom,
                                  color: Color(0xFF6E7FAA),
                                  size: 20,
                                ),
                              ),
                              Container(
                                child: Text(
                                  "Хайлтын түүх цэвэрлэх",
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
            ],
          ),
        ),
      ),
    );
  }

  void _showViewDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.all(0.0),
          backgroundColor: Color(0xffF4F4F4),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          content: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(18),
                  child: Icon(
                    Hyrd.broom,
                    size: 80,
                    color: Color(0xFF584BDD),
                  ),
                ),
                Container(
                  child: Text("Үзэлтийн түүх цэвэрлэх",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color(0xff584BDD),
                          fontSize: 18,
                          fontWeight: FontWeight.w600)),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.only(left: 50,bottom: 20, right: 50),
                  child: Text(
                      "Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonu.",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Color(0xff8D8D8D), fontSize: 13)),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10.0),
                        bottomRight: Radius.circular(10.0)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      SizedBox(
                        width: (MediaQuery.of(context).size.width-96)/2, // match_parent
                        child: FlatButton(
                          child: const Text('Цуцлах'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                      SizedBox(
                        width: (MediaQuery.of(context).size.width-96)/2, // match_parent
                        child: FlatButton(
                          child: const Text('Тийм'),
                          onPressed: () {
                            BackendService.crud('delete','/user/views',new HashMap()).then((onValue) {
                              showToast("Амжилттай", gravity: Toast.BOTTOM);
                              Navigator.of(context).pop();
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  void _showSearchDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.all(0.0),
          backgroundColor: Color(0xffF4F4F4),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          content: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(18),
                  child: Icon(
                    Hyrd.broom,
                    size: 80,
                    color: Color(0xFF584BDD),
                  ),
                ),
                Container(
                  child: Text("Хайлтийн түүх цэвэрлэх",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color(0xff584BDD),
                          fontSize: 18,
                          fontWeight: FontWeight.w600)),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.only(left: 50,bottom: 20, right: 50),
                  child: Text(
                      "Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonu.",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Color(0xff8D8D8D), fontSize: 13)),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10.0),
                        bottomRight: Radius.circular(10.0)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      SizedBox(
                          width: (MediaQuery.of(context).size.width-96)/2, // match_parent
                          child: FlatButton(
                            child: const Text('Цуцлах'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                      ),
                      SizedBox(
                        width: (MediaQuery.of(context).size.width-96)/2, // match_parent
                        child: FlatButton(
                          child: const Text('Тийм'),
                          onPressed: () {
                            BackendService.crud('delete','/user/searches',new HashMap()).then((onValue) {
                              showToast("Амжилттай", gravity: Toast.BOTTOM);
                              Navigator.of(context).pop();
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void showToast(String msg, {int duration, int gravity}) {
    Toast.show(msg, context, duration: 1, gravity: gravity);
  }
}
