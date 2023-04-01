import 'dart:convert';

import 'package:fagopay/functions/functions.dart';
import 'package:fagopay/models/register_request/register.model.dart';
import 'package:fagopay/service/constants/constants.dart';
import 'package:fagopay/service/networking/network_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegistrationController extends GetxController {
  Functions function = Functions();
  TextEditingController userAuthDataController = TextEditingController();
  final accountType = registrationData.getAccountType;

  Future<dynamic> selectAccountType() async {
    String typeKey = "";
    if (function.validateEmail(userAuthDataController.text)) {
      typeKey = 'email';
    } else {
      typeKey = 'phone_number';
    }
    try {
      var requestBody = jsonEncode(
          {'account_type': accountType, typeKey: userAuthDataController.text});

      final responseData = await NetworkHelper.postRequest(
        url: "${BaseAPI.userPath}register",
        headers: BaseAPI.headers,
        body: requestBody,
      );

      return responseData;
    } catch (e) {
      print(e);
    }
  }
}
