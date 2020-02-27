import 'dart:collection';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hyrd/models/profile_model.dart';
import 'package:hyrd/screens/profile/notification_screen.dart';
import 'package:hyrd/services/BackendService.dart';
import 'package:hyrd/utils/fade_route.dart';
import 'package:hyrd/utils/hyrd_icons.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:toast/toast.dart';

class UserInformationScreen extends StatefulWidget {
  static const routeName = '/user_information';

  final ProfileModel user;

  UserInformationScreen({Key key, @required this.user}) : super(key: key);

  
  @override
  _UserInformationScreenState createState() => _UserInformationScreenState();
}

final _formKey = GlobalKey<FormState>();
TextEditingController _lastNameController = new TextEditingController();
TextEditingController _firstNameController = new TextEditingController();
TextEditingController _regNumController = new TextEditingController();
bool _autovalidate = false;

class _UserInformationScreenState extends State<UserInformationScreen> {
  

  List<Asset> images = List<Asset>();
  List<UploadFileInfo> files = new List<UploadFileInfo>();

  Future<void> loadAssets() async {
    files.clear();

    List<Asset> resultList = List<Asset>();
    //String error = 'No Error Dectected';
    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 1,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#DF2626",
          actionBarTitle: "Зураг",
          statusBarColor: "#DF2626",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );

      for (var r in resultList) {
        var t = await r.getByteData();
        print(t);
      }
    } on Exception catch (e) {
      print(e.toString());
    }

    for (var asset in resultList) {
      int maxWIDTH = 500; //keep ratio
      int height = ((500 * asset.originalHeight) / asset.originalWidth).round();

      ByteData byteData =
          await asset.requestThumbnail(maxWIDTH, height, quality: 80);

      if (byteData != null) {
        List<int> imageData = byteData.buffer.asUint8List();
        UploadFileInfo u = UploadFileInfo.fromBytes(imageData, asset.name);
        files.add(u);
        uploadImage();
      }
    }

    if (!mounted) return;

    setState(() {
      images = resultList;
    });
  }

  List<String> uploadImage() {
    FormData formData = new FormData.from({"avatar": files});
    BackendService.uploadProfile(url: 'avatar', data: formData)
        .then((response) {
      setState(() {
        widget.user.data.avatar = response['avatar'];
      });
      return null;
    });

    return null;
  }

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
        title: Text("Миний мэдээлэл",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
        elevation: 0.0,
      ),
      body: Container(
        child: Form(
          key: _formKey,
          autovalidate: false,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: SingleChildScrollView(
                    child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Row(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(top: 30, bottom: 30),
                              width: 150,
                              child: Stack(
                                children: [
                                  Container(
                                      height: 120,
                                      width: 120,
                                      margin: EdgeInsets.only(left: 10),
                                      child: (widget.user?.data?.avatar == null)
                                          ? Container(
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
                                                  image: AssetImage(
                                                      'assets/images/pic.png'),
                                                  fit: BoxFit.cover,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(80.0),
                                                border: Border.all(
                                                  color: Colors.white,
                                                  width: 3.0,
                                                ),
                                              ),
                                            )
                                          :  Container(
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
                                            image: NetworkImage(widget.user.data.avatar),
                                            fit: BoxFit.cover,
                                          ),
                                          borderRadius:
                                          BorderRadius.circular(80.0),
                                          border: Border.all(
                                            color: Colors.white,
                                            width: 3.0,
                                          ),
                                        ),
                                      )),
                                  Positioned(
                                    right: 10,
                                    top: 60,
                                    child: Container(
                                        decoration: BoxDecoration(
                                          color:
                                              Colors.white,
                                          borderRadius:
                                              new BorderRadius.circular(25.0),
                                        ),
                                        child: new IconButton(
                                          padding: new EdgeInsets.all(0.0),
                                          color: Colors.blue,
                                          icon: new Icon(
                                            Icons.photo_camera,
                                            size: 28.0,
                                            color: Color(0xFF584BDD),
                                          ),
                                          onPressed: () {
                                            print("profilePage clicked");
                                            loadAssets();
                                          },
                                        )),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width-200 ,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 10),
                                    child:  Text(widget.user?.data?.lastname ?? "",textAlign: TextAlign.left,style: TextStyle(color: Color(0xff222455),fontSize: 20, fontWeight: FontWeight.bold)),
                                  ),
                                  Text(widget.user?.data?.firstname ?? "",textAlign: TextAlign.left,style: TextStyle(color: Color(0xff222455),fontSize: 20, fontWeight: FontWeight.bold))
                                ],
                              )
                            )
                          ],
                        ),
                      ),
                      new Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        elevation: 5,
                        child: Container(
                          padding: EdgeInsets.only(
                              left: 20, top: 20, bottom: 20, right: 10),
                          child: Column(
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: Text("Овог"),
                                  ),
                                  Container(
                                      width: MediaQuery.of(context).size.width,
                                      child: TextFormField(
                                        validator: (value) => value.isEmpty
                                            ? 'Capacity is required'
                                            : null,
                                        obscureText: false,
                                        controller: _lastNameController,
                                        style: TextStyle(
                                            fontFamily: 'Roboto',
                                            color: Color(0xFF6E7FAA),
                                            fontSize: 15.0),
                                        textAlign: TextAlign.left,
                                        decoration: InputDecoration(
                                            hintText:
                                                widget.user?.data?.lastname ?? "",
                                            hintStyle: TextStyle(
                                                fontSize: 15.0,
                                                color: Color(0xFF6E7FAA)),
                                            contentPadding: EdgeInsets.fromLTRB(
                                                0.0, 15.0, 0.0, 15.0),
                                            border: new UnderlineInputBorder(
                                                borderSide: new BorderSide(
                                                    color: Colors.red))),
                                      )),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.only(top: 20),
                                    width: MediaQuery.of(context).size.width,
                                    child: Text("Нэр"),
                                  ),
                                  Container(
                                      width: MediaQuery.of(context).size.width,
                                      child: TextFormField(
                                        validator: (value) => value.isEmpty
                                            ? 'Capacity is required'
                                            : null,
                                        obscureText: false,
                                        controller: _firstNameController,
                                        style: TextStyle(
                                            fontFamily: 'Roboto',
                                            color: Color(0xFF6E7FAA),
                                            fontSize: 15.0),
                                        textAlign: TextAlign.left,
                                        decoration: InputDecoration(
                                            hintText:
                                                widget.user?.data?.firstname ??
                                                    "",
                                            hintStyle: TextStyle(
                                                fontSize: 15.0,
                                                color: Color(0xFF6E7FAA)),
                                            contentPadding: EdgeInsets.fromLTRB(
                                                0.0, 15.0, 0.0, 15.0),
                                            border: new UnderlineInputBorder(
                                                borderSide: new BorderSide(
                                                    color: Colors.red))),
                                      )),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.only(top: 20),
                                    width: MediaQuery.of(context).size.width,
                                    child: Text("Регистрийн дугаар"),
                                  ),
                                  Container(
                                      width: MediaQuery.of(context).size.width,
                                      child: TextFormField(
                                        validator: (value) => value.isEmpty
                                            ? 'RegNum is required'
                                            : null,
                                        obscureText: false,
                                        controller: _regNumController,
                                        style: TextStyle(
                                            fontFamily: 'Roboto',
                                            color: Color(0xFF6E7FAA),
                                            fontSize: 15.0),
                                        textAlign: TextAlign.left,
                                        decoration: InputDecoration(
                                            hintText:
                                                widget.user?.data?.regnum ?? "",
                                            hintStyle: TextStyle(
                                                fontSize: 15.0,
                                                color: Color(0xFF6E7FAA)),
                                            contentPadding: EdgeInsets.fromLTRB(
                                                0.0, 15.0, 0.0, 15.0),
                                            border: new UnderlineInputBorder(
                                                borderSide: new BorderSide(
                                                    color: Colors.red))),
                                      )),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
              ),
              Container(
                padding:
                    EdgeInsets.only(right: 0, left: 0, top: 10, bottom: 20),
                width: MediaQuery.of(context).size.width,
                child: FlatButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();

                      Map<String, dynamic> adMap = new HashMap();
                      adMap['firstname'] = _firstNameController.text;
                      adMap['lastname'] = _lastNameController.text;
                      adMap['regnum'] = _regNumController.text;

                      BackendService.crud('put', 'user', adMap).then((onValue) {
                        print(onValue);
                        if (onValue == 200) {
                          showToast("Амжилттай", gravity: Toast.BOTTOM);
                          Navigator.of(context).pop();
                        }
                      });
                    } else {
                      setState(() {
                        _autovalidate = true;
                      });
                    }
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
                        borderRadius: BorderRadius.all(Radius.circular(8.0))),
                    padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                    child: const Text('Хадгалах',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 16)),
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
