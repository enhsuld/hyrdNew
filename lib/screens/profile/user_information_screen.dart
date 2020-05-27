import 'dart:collection';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hyrd/models/profile_model.dart';
import 'package:hyrd/models/taxonomy.dart';
import 'package:hyrd/screens/addNewAd/UploadFileInfo.dart';
import 'package:hyrd/screens/profile/ad_screen.dart';
import 'package:hyrd/screens/profile/notification_screen.dart';
import 'package:hyrd/screens/profile/reset_password_screen.dart';
import 'package:hyrd/services/BackendService.dart';
import 'package:hyrd/utils/fade_route.dart';
import 'package:hyrd/utils/hyrd_icons.dart';
import 'package:hyrd/utils/hyrd_new_icons_icons.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:toast/toast.dart';

class UserInformationScreen extends StatefulWidget {
  static const routeName = '/user_information';

  ProfileModel user;

  UserInformationScreen({Key key, @required this.user}) : super(key: key);

  @override
  _UserInformationScreenState createState() => _UserInformationScreenState();
}

bool _autovalidate = false;

class _UserInformationScreenState extends State<UserInformationScreen> {
  List<Asset> images = List<Asset>();
  List<UploadFileInfo> files = new List<UploadFileInfo>();
  final _formKey = GlobalKey<FormState>();
  TextEditingController _lastNameController = new TextEditingController();
  TextEditingController _firstNameController = new TextEditingController();
  TextEditingController _regNumController = new TextEditingController();

  TextEditingController _plateNumberController = new TextEditingController();
  TextEditingController _cabinNumberController = new TextEditingController();

  var carMarks = new List<TaxonomyModel>();
  var carModels = new List<TaxonomyModel>();

  TaxonomyModel carMark, carModel;

  @override
  void initState() {
    super.initState();

    _lastNameController.value =
        TextEditingValue(text: widget.user?.data?.lastname ?? "");
    _firstNameController.value =
        TextEditingValue(text: widget.user?.data?.firstname ?? "");
    _regNumController.value =
        TextEditingValue(text: widget.user?.data?.regnum ?? "");

    _plateNumberController.value =
        TextEditingValue(text: widget.user?.data?.plateNumber ?? "");
    _cabinNumberController.value =
        TextEditingValue(text: widget.user?.data?.cabinNumber ?? "");
    BackendService.getTaxonomies(taxonomy: '/mark').then((taxonomy) {
      setState(() {
        this.carMarks = taxonomy;
      });
    });
  }

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
    FormData formData = new FormData.fromMap({"avatar": files});
    BackendService.uploadProfile(url: 'avatar', data: formData)
        .then((response) {
      setState(() {
        widget.user.data.avatar = response['avatar'];
      });
    });
    return null;
  }

  List<DropdownMenuItem<TaxonomyModel>> buildAndGetDropDownMenuItems(
      List carTypes) {
    List<DropdownMenuItem<TaxonomyModel>> items = List();
    for (TaxonomyModel item in carTypes) {
      items.add(DropdownMenuItem(value: item, child: Text(item.name)));
    }
    return items;
  }

  bool isChange = false;

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
        actions: <Widget>[
          new Container(
              height: 18.0,
              width: 18.0,
              margin: EdgeInsets.only(right: 20),
              child: new IconButton(
                padding: new EdgeInsets.all(0.0),
                color: Colors.white,
                icon: new Icon(HyrdNewIcons.floppy_disk, size: 20.0),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();

                    Map<String, dynamic> adMap = new HashMap();
                    adMap['firstname'] = _firstNameController.text;
                    adMap['lastname'] = _lastNameController.text;
                    adMap['regnum'] = _regNumController.text;
                    adMap['plateNumber'] = _plateNumberController.text;
                    adMap['cabinNumber'] = _cabinNumberController.text;
                    adMap['markName'] = carMark.name;
                    adMap['modelName'] = carModel.name;

                    BackendService.crud('put', 'user', adMap).then((onValue) {
                      setState(() {
                        widget.user.data.regnum = onValue["data"]["regnum"];
                        widget.user.data.firstname =
                            onValue["data"]["firstname"];
                        widget.user.data.lastname = onValue["data"]["lastname"];
                        widget.user.data.plateNumber =
                            onValue["data"]["plateNumber"];
                        widget.user.data.cabinNumber =
                            onValue["data"]["cabinNumber"];
                        widget.user.data.markName = onValue["data"]["markName"];
                        widget.user.data.modelName =
                            onValue["data"]["modelName"];
                      });
                      if (onValue != null) {
                        showToast("Амжилттай", gravity: Toast.CENTER);
                      }
                    });
                  } else {
                    setState(() {
                      _autovalidate = true;
                    });
                  }
                },
              ))
        ],
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
                                                      'assets/images/defualt-user.png'),
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
                                          : Container(
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
                                                  image: NetworkImage(
                                                      widget.user.data.avatar),
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
                                          color: Colors.white,
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
                                width: MediaQuery.of(context).size.width - 200,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 10),
                                      child: Text(
                                          widget.user?.data?.lastname ?? "",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              color: Color(0xff222455),
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    Text(widget.user?.data?.firstname ?? "",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            color: Color(0xff222455),
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold))
                                  ],
                                ))
                          ],
                        ),
                      ),
                      new Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
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
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Please enter some text';
                                          }
                                          return null;
                                        },
                                        controller: _lastNameController,
                                        style: TextStyle(
                                            fontFamily: 'Roboto',
                                            color: Color(0xFF6E7FAA),
                                            fontSize: 15.0),
                                        textAlign: TextAlign.left,
                                        decoration: InputDecoration(
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
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Please enter some text';
                                          }
                                          return null;
                                        },
                                        controller: _firstNameController,
                                        style: TextStyle(
                                            fontFamily: 'Roboto',
                                            color: Color(0xFF6E7FAA),
                                            fontSize: 15.0),
                                        textAlign: TextAlign.left,
                                        decoration: InputDecoration(
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
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Please enter some text';
                                          }
                                          return null;
                                        },
                                        controller: _regNumController,
                                        style: TextStyle(
                                            fontFamily: 'Roboto',
                                            color: Color(0xFF6E7FAA),
                                            fontSize: 15.0),
                                        textAlign: TextAlign.left,
                                        decoration: InputDecoration(
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
                      new Card(
                        margin: EdgeInsets.only(top: 20, left: 5, right: 5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        elevation: 5,
                        child: Container(
                          padding: EdgeInsets.only(
                              left: 20, top: 20, bottom: 20, right: 10),
                          child: Column(
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width,
                                child: Text("Улсын дугаар"),
                              ),
                              Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: TextFormField(
                                    /*  validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please enter some text';
                                      }
                                      return null;
                                    },*/
                                    controller: _plateNumberController,
                                    style: TextStyle(
                                        fontFamily: 'Roboto',
                                        color: Color(0xFF6E7FAA),
                                        fontSize: 15.0),
                                    textAlign: TextAlign.left,
                                    decoration: InputDecoration(
                                        hintStyle: TextStyle(
                                            fontSize: 15.0,
                                            color: Color(0xFF6E7FAA)),
                                        contentPadding: EdgeInsets.fromLTRB(
                                            0.0, 15.0, 0.0, 15.0),
                                        border: new UnderlineInputBorder(
                                            borderSide: new BorderSide(
                                                color: Colors.red))),
                                  )),
                              Container(
                                padding: EdgeInsets.only(top: 20),
                                width: MediaQuery.of(context).size.width,
                                child: Text("Арлын дугаар"),
                              ),
                              Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: TextFormField(
                                    /*   validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please enter some text';
                                      }
                                      return null;
                                    },*/
                                    controller: _cabinNumberController,
                                    style: TextStyle(
                                        fontFamily: 'Roboto',
                                        color: Color(0xFF6E7FAA),
                                        fontSize: 15.0),
                                    textAlign: TextAlign.left,
                                    decoration: InputDecoration(
                                        hintStyle: TextStyle(
                                            fontSize: 15.0,
                                            color: Color(0xFF6E7FAA)),
                                        contentPadding: EdgeInsets.fromLTRB(
                                            0.0, 15.0, 0.0, 15.0),
                                        border: new UnderlineInputBorder(
                                            borderSide: new BorderSide(
                                                color: Colors.red))),
                                  )),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.only(top: 20),
                                    width: MediaQuery.of(context).size.width,
                                    child: Text("Үйлдвэр"),
                                  ),
                                  Container(
                                    padding:
                                        EdgeInsets.only(top: 10, bottom: 10),
                                    width: (MediaQuery.of(context).size.width *
                                            2) /
                                        5,
                                    child: DropdownButtonHideUnderline(
                                      child: ButtonTheme(
                                        child: DropdownButtonFormField<
                                                TaxonomyModel>(
                                            value: carMark,
                                            hint: Text("Сонгох"),
                                            isDense: true,
                                            validator: (value) => value == null
                                                ? 'field required'
                                                : null,
                                            style: TextStyle(
                                              color: Color(0xFF6E7FAA),
                                            ),
                                            onChanged: (TaxonomyModel item) {
                                              setState(() {
                                                isChange = true;
                                              });
                                              BackendService.getTaxonomies(
                                                      taxonomy: '/' + item.name)
                                                  .then((taxonomy) {
                                                setState(() {
                                                  carMark = item;
                                                  this.carModels = taxonomy;
                                                });
                                              });
                                            },
                                            items: buildAndGetDropDownMenuItems(
                                                carMarks)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.only(top: 20),
                                    width: MediaQuery.of(context).size.width,
                                    child: Text("Загвар"),
                                  ),
                                  Container(
                                    padding:
                                        EdgeInsets.only(top: 10, bottom: 10),
                                    width: (MediaQuery.of(context).size.width *
                                            2) /
                                        5,
                                    child: DropdownButtonHideUnderline(
                                      child: ButtonTheme(
                                        child: DropdownButtonFormField<
                                                TaxonomyModel>(
                                            value: isChange ? null : carModel,
                                            hint: Text("Сонгох"),
                                            isDense: true,
                                            validator: (value) => value == null
                                                ? 'field required'
                                                : null,
                                            style: TextStyle(
                                              color: Color(0xFF6E7FAA),
                                            ),
                                            onChanged: (TaxonomyModel item) {
                                              setState(() {
                                                isChange = false;
                                                carModel = item;
                                              });
                                            },
                                            items: buildAndGetDropDownMenuItems(
                                                carModels)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      new Card(
                        margin: EdgeInsets.only(top: 20, left: 5, right: 5),
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        elevation: 5,
                        child: FlatButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    ResetPasswordScreen(user: widget.user)));
                          },
                          textColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0)),
                          child: Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8.0))),
                              padding:
                                  const EdgeInsets.fromLTRB(10, 15, 15, 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text("Нууц үг шинэчлэх",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: Color(0xff584BDD),
                                          fontSize: 16)),
                                  Icon(Icons.exit_to_app,
                                      color: Color(0xff584BDD), size: 22.0)
                                ],
                              )),
                        ),
                      ),
                    ],
                  ),
                )),
              ),

              /* Container(
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
              ),*/
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
