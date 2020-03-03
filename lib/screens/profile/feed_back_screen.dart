import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:hyrd/services/BackendService.dart';
import 'package:hyrd/utils/hyrd_icons.dart';
import 'package:toast/toast.dart';

class FeedBackScreen extends StatefulWidget {
  static const routeName = '/feed-back';

  @override
  _FeedBackScreenState createState() => _FeedBackScreenState();
}

final _formKey = GlobalKey<FormState>();
TextEditingController _priceController = new TextEditingController();
TextEditingController _descriptionController = new TextEditingController();
bool _autovalidate = false;

class _FeedBackScreenState extends State<FeedBackScreen> {
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
        title: Text("Санал хүсэлт",
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
                  padding: EdgeInsets.only(top: 10, left: 20, right: 20),
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.only(top: 15, left: 5),
                        child: Text(
                          "Гарчиг",
                          style:TextStyle(fontSize: 16, color: Color(0xff222455)),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 20),
                        child: new Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 10,
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(
                                     left: 20, right: 20),
                                child: new TextFormField(
                                  validator: (value) => value.isEmpty
                                      ? 'Title is required'
                                      : null,
                                  decoration: new InputDecoration(
                                      border: InputBorder.none,
                                      suffixStyle: TextStyle(
                                          fontSize: 16,
                                          fontFamily: "Sans",
                                          fontWeight: FontWeight.bold)),
                                  controller: _priceController,
                                  style: TextStyle(
                                      fontFamily: "Sans",
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.only(top: 20, left: 5),
                        child: Text(
                          "Нэмэлт тайлбар",
                          style:
                              TextStyle(fontSize: 16, color: Color(0xff222455)),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 20),
                        child: new Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            elevation: 10,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: Container(
                              padding: EdgeInsets.all(20),
                              height: MediaQuery.of(context).size.height-395,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image:
                                      AssetImage("assets/images/screen-logo.png"),
                                  fit: BoxFit.scaleDown,
                                ),
                              ),
                              child: TextFormField(
                                controller: _descriptionController,
                                maxLines: 80,
                                validator: (value) => value.isEmpty
                                    ? 'Description is required'
                                    : null,
                                decoration: InputDecoration.collapsed(
                                    hintText: "Enter your text here"),
                              ),
                            )),
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
                    print(_priceController.text);
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();

                      Map<String, dynamic> adMap = new HashMap();
                      adMap['title'] = _priceController.text;
                      adMap['description'] = _descriptionController.text;

                      BackendService.createFeedback(taxonomy: adMap).then((onValue) {
                        print(onValue);
                          if(onValue==201){
                            _priceController.text='';
                            _descriptionController.text='';
                            showToast("Амжилттай", gravity: Toast.BOTTOM);
                            _showViewDialog();
                            //Navigator.of(context).pop();
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
                    child: const Text('Илгээх',
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
                  padding: EdgeInsets.all(20),
                  height: 100,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image:
                      AssetImage("assets/images/screen-logo.png"),
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ),
                Container(
                  child: Text("Хүлээн авлаа !",
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
                      "Санал хүсэлт илээсэн танд баярлалаа.",
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
                            showToast("Амжилттай", gravity: Toast.BOTTOM);
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
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
