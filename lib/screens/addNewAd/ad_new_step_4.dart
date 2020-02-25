import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hyrd/models/car_model.dart';
import 'package:hyrd/screens/addNewAd/UploadImage.dart';
import 'package:hyrd/screens/addNewAd/ad_new_step_3.dart';
import 'package:hyrd/screens/addNewAd/ad_new_step_5.dart';
import 'package:hyrd/services/BackendService.dart';
import 'package:hyrd/utils/fade_route.dart';
import 'package:dio/dio.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class AdNewStep4Screen extends StatefulWidget {
  static const routeName = '/adNew';
  final CarModel car;
  AdNewStep4Screen({Key key, @required this.car}) : super(key: key);

  @override
  _AdNewStep4ScreenState createState() => _AdNewStep4ScreenState();
}

class _AdNewStep4ScreenState extends State<AdNewStep4Screen> {

  Map<String, dynamic> formData;
  List<Asset> images = List<Asset>();
  List<UploadFileInfo> imageFiles = new List<UploadFileInfo>();

  @override
  void initState() {
    super.initState();
  }

  Widget buildGridView() {
    return GridView.count(
      crossAxisCount: 3,
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
      padding: EdgeInsets.all(4.0),
      children: List.generate(images.length, (index) {
        Asset asset = images[index];
        return Container(
            child: Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    AssetThumb(
                      asset: asset,
                      width: 300,
                      height: 300,
                    ),
                    Positioned(
                      right: 8.0,
                      bottom: 8.0,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            images.removeAt(index);
                          });
                        },
                        child: new Container(
                          decoration: new BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                              new BorderRadius.all(Radius.circular(35.0))),
                          height: 35,
                          width: 35,
                          child: Icon(
                            Icons.close,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ));
      }),
    );
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = List<Asset>();
    String error = 'No Error Dectected';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 15,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Example App",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );


      for (var asset in resultList) {
        int maxWIDTH = 500; //keep ratio
        int height = ((500 * asset.originalHeight) / asset.originalWidth).round();

        ByteData byteData =
        await asset.requestThumbnail(maxWIDTH, height, quality: 80);

        if (byteData != null) {
          List<int> imageData = byteData.buffer.asUint8List();
          UploadFileInfo u = UploadFileInfo.fromBytes(imageData, asset.name);
          imageFiles.add(u);
        }
      }
    } on Exception catch (e) {
      error = e.toString();
    }

    if (!mounted) return;

    setState(() {
      images = resultList;
    });
  }

  List<String> uploadImage() {
    print(imageFiles.length);

    BackendService.uploadFiles(widget.car.toJson(),imageFiles).then((response) {
      UploadImage image = UploadImage.fromJson(response);
      return image.images;
    });

    return null;
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
          actions: <Widget>[
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: Container(
                  padding: EdgeInsets.only(right: 20, left: 10),
                  child: new SizedBox(
                      height: 15.0,
                      width: 15.0,
                      child: new Icon(Icons.close,
                          color: Colors.white, size: 30.0)),
                ),
              ),
            )
          ],
          title: Text("Зар оруулах 4/5",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
          elevation: 0.0,
        ),
        body:Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top:20,bottom: 20),
              width: MediaQuery.of(context).size.width - 40,
              child: RaisedButton(
                onPressed: loadAssets,
                elevation: 0,
                color: Colors.white,
                shape: new RoundedRectangleBorder(
                    side: BorderSide(color: Colors.grey[300], width: 1),
                    borderRadius: new BorderRadius.circular(7.0)),
                child: SizedBox(
                    height: 100,
                    /*  width: 90,
                      height: 90,*/
                    child: Column(
                      children: <Widget>[
                        Center(
                          child: Icon(
                            Icons.linked_camera,
                            color: Color(0xFF584BDD),
                            size: 70,
                          ),
                        ),
                        Center(
                          child: Text('Upload media',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Color(0xFF584BDD),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600)),
                        )
                      ],
                    )),
              ),
            ),
            Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: buildGridView(),
                )
            ),
            Container(
              padding:
              EdgeInsets.only(right: 0, left: 0, top: 10, bottom: 20),
              width: MediaQuery.of(context).size.width,
              child: FlatButton(
                onPressed: () {
                  uploadImage();
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
                  child: const Text('Үргэлжлүүлэх',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
              ),
            ),
          ],
        ),
      );
  }
}
