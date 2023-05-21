import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Cloudinary {
  static final cloudinaryUsers =
      CloudinaryPublic('danb20riq', 'upload', cache: false);

  static Future<String> uploadUserImage(
    BuildContext context,
    File? selectedImagePath,
  ) async {
    late String imageResponse;
    try {
      CloudinaryResponse response = await cloudinaryUsers.uploadFile(
        CloudinaryFile.fromFile(selectedImagePath!.path,
            resourceType: CloudinaryResourceType.Image),
      );
      imageResponse = response.secureUrl;
    } on CloudinaryException {
      Fluttertoast.showToast(
        msg: "Failed to upload Image",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
    return imageResponse;
  }
}
