import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../functions/functions.dart';
import '../models/register_request/register.model.dart';
import '../service/constants/constants.dart';
import '../service/networking/network_helper.dart';
import '../service/secure_storage/secure_storage.dart';

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
  late final accountType = registrationData.getAccountType;

  Future<dynamic> selectAccountType() async {
    String typeKey = "";
    if (function.validateEmail(email.text)) {
      typeKey = 'email';
    } else {
      typeKey = 'phone_number';
    }
    try {
      var requestBody =
          jsonEncode({typeKey: typeKey == 'email' ? email.text :  phone.text});
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

  // Future<dynamic> registerDetails() async {
  //   final userIdentifier = await SecureStorage.readUserIdentifier();
  //   try {
  //     var requestBody = jsonEncode({
  //       'first_name': firstname.text,
  //       "last_name": lastname.text,
  //       'email': email.text,
  //       'phone_number': phone.text,
  //       'password': password.text,
  //       'password_confirmation': confirmPassword.text,
  //       'referal_by': referral.text,
  //       'identifier': '$userIdentifier'
  //     });
  //     final responseData = await NetworkHelper.postRequest(
  //       url: "${BaseAPI.userPath}register-detail",
  //       headers: BaseAPI.headers,
  //       body: requestBody,
  //     );
  //     return responseData;
  //   } catch (e) {
  //     throw Exception('Error: $e');
  //   }
  // }

  Future<dynamic> setPassCode(
      String id, String passcode, String confirmedPasscode) async {
    final token = await SecureStorage.readUserToken();
    try {
      var requestBody = jsonEncode({
        'passcode': passcode,
        'confirm_passcode': confirmedPasscode,
        'identifier': id,
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
  Future changePassword(Map data)async{
    final token = await SecureStorage.readUserToken();
    try{
      final res = await http.post(
        Uri.parse( "${BaseAPI.userPath}create-new-password"),
        headers: {
         // "Content-Type": "application/json; charset=UTF-8",
          "Authorization": "Bearer $token"
        },
        body: data,
      );
      print(res.body);
      return res;
    }catch (e){
      throw Exception('Error: $e');
    }
  }
  Future sendOtp(Map data)async{
    final token = await SecureStorage.readUserToken();
    try{
      final res = await http.post(
        Uri.parse( "${BaseAPI.userPath}forgot-password"),
        headers: {
          // "Content-Type": "application/json; charset=UTF-8",
          "Authorization": "Bearer $token"
        },
        body: data,
      );
      print(res.body);
      return res;
    }catch (e){
      throw Exception('Error: $e');
    }
  }
}
