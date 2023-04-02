import 'dart:convert';
import 'dart:developer';

import '../service/constants/constants.dart';
import '../service/networking/network_helper.dart';
import '../service/secure_storage/secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<dynamic> loginUser() async {
    var requestBody = jsonEncode({
      'username': emailController.text,
      'password': passwordController.text
    });
    try {
      final responseData = await NetworkHelper.postRequest(
        url: "${BaseAPI.userPath}login",
        headers: BaseAPI.headers,
        body: requestBody,
      );
      return responseData;
    } catch (e) {
      log(e.toString());
      throw Exception('Login Failed');
    }
  }

  Future<dynamic> getUserDetails() async {
    final token = await SecureStorage.readUserToken();
    try {
      final responseData = await NetworkHelper.getRequest(
        url: "${BaseAPI.userPath}dashboard",
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
          "Authorization": "Bearer $token"
        },
      );
      return responseData;
    } catch (e) {
      log(e.toString());
      throw Exception('Error fetching user details');
    }
  }
}
