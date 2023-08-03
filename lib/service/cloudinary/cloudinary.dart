import 'dart:io';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:fagopay/screens/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
      Get.snackbar("Error","Failed to upload Image", colorText: Colors.white, backgroundColor: fagoSecondaryColor);
    }
    return imageResponse;
  }
}
