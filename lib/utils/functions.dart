import 'package:flutter/material.dart';
import 'package:hyrd/models/car_model.dart';
import 'package:hyrd/screens/photo_wrapper.dart';

class cusfunc {
  static void openGallery(
      BuildContext context, final int index, List<Medias> _list) {
    showDialog(
      context: context,
      builder: (BuildContext context) => Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 60),
        child: GalleryPhotoViewWrapper(
          galleryItems: _list,
          backgroundDecoration: const BoxDecoration(
            color: Colors.transparent,
          ),
          initialIndex: index,
          scrollDirection: Axis.horizontal,
        ),
      ),
    );
    // Navigator.push(
    //   context,
    //   FadeRoute(
    //     builder: (context) => GalleryPhotoViewWrapper(
    //       galleryItems: _list,
    //       backgroundDecoration: const BoxDecoration(
    //         color: Colors.transparent,
    //       ),
    //       initialIndex: index,
    //       scrollDirection: verticalGallery ? Axis.vertical : Axis.horizontal,
    //     ),
    //   ),
    // );
  }
}
