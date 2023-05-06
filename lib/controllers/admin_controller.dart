import 'dart:convert';
import 'dart:developer';

import '../service/constants/constants.dart';
import '../service/networking/network_helper.dart';
import '../service/secure_storage/secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminController extends GetxController {
  TextEditingController phoneNumberController = TextEditingController();

  Future<dynamic> registerNewEmployee({
    required String phoneNumber,
  }) async {
    final token = await SecureStorage.readUserToken();

    var requestBody = jsonEncode({
      "phonenumber": phoneNumber,
    });

    try {
      final response = await NetworkHelper.postRequest(
        url: BaseAPI.employeesPath,
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
          "Authorization": "Bearer $token",
        },
        body: requestBody,
      );
      return response;
    } catch (e) {
      log(e.toString());
    }
  }
}
