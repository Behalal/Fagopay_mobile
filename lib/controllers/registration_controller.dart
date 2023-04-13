import 'dart:convert';

import '../service/secure_storage/secure_storage.dart';

import '../functions/functions.dart';
import '../models/register_request/register.model.dart';
import '../service/constants/constants.dart';
import '../service/networking/network_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegistrationController extends GetxController {
  Functions function = Functions();
  // TextEditingController userAuthDataController = TextEditingController();
  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController referral = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  TextEditingController passCode = TextEditingController();
  TextEditingController passCodeConfirm = TextEditingController();
  final accountType = registrationData.getAccountType;

  Future<dynamic> selectAccountType() async {
    String typeKey = "";
    if (function.validateEmail(email.text)) {
      typeKey = 'email';
    } else {
      typeKey = 'phone_number';
    }
    try {
      var requestBody = jsonEncode(
          {'account_type': accountType, typeKey: typeKey == 'email' ? email.text : phone.text});
      final responseData = await NetworkHelper.postRequest(
        url: "${BaseAPI.userPath}register",
        headers: BaseAPI.headers,
        body: requestBody,
      );
      return responseData;
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<dynamic> validateCode(String identifier, String code) async {
    try {
      var requestBody = jsonEncode({'identifier': identifier, "otp": code});

      final responseData = await NetworkHelper.postRequest(
        url: "${BaseAPI.verificationPath}validate-new-user-otp",
        headers: BaseAPI.headers,
        body: requestBody,
      );
      return responseData;
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<dynamic> registerDetails() async {
    final userIdentifier = await SecureStorage.readUserIdentifier();
    try {
      var requestBody = jsonEncode({
        'first_name': firstname.text,
        "last_name": lastname.text,
        'email': email.text,
        'phone_number': phone.text,
        'password': password.text,
        'password_confirmation': confirmPassword.text,
        'referal_by': referral.text,
        'identifier': '$userIdentifier'
      });
      final responseData = await NetworkHelper.postRequest(
        url: "${BaseAPI.userPath}register-detail",
        headers: BaseAPI.headers,
        body: requestBody,
      );
      return responseData;
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<dynamic> setPassCode() async {
    final token = await SecureStorage.readUserToken();
    try {
      var requestBody = jsonEncode({
        'passcode': passCode.text,
      });
      final responseData = await NetworkHelper.postRequest(
        url: "${BaseAPI.userPath}passcode-setup",
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
          "Authorization": "Bearer $token"
        },
        body: requestBody,
      );
      return responseData;
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
