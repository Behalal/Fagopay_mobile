import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../service/constants/constants.dart';
import '../service/networking/network_helper.dart';
import '../service/secure_storage/secure_storage.dart';

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

  Future<dynamic> forgotPassword(String email) async {
    var requestBody = jsonEncode({
      'username': email,
    });
    try {
      final responseData = await NetworkHelper.postRequest(
        url: "${BaseAPI.userPath}forgot-password",
        headers: BaseAPI.headers,
        body: requestBody,
      );
      return responseData;
    } catch (e) {
      log(e.toString());
      throw Exception('Failed');
    }
  }

  Future<dynamic> createNewPassword(
      String otp, String password, String confirmedPassword) async {
    var requestBody = jsonEncode({
      'code': otp,
      'password': password,
      'password_confirmation': confirmedPassword,
    });
    try {
      final responseData = await NetworkHelper.postRequest(
        url: "${BaseAPI.userPath}create-new-password",
        headers: BaseAPI.headers,
        body: requestBody,
      );
      return responseData;
    } catch (e) {
      log(e.toString());
      throw Exception('Failed');
    }
  }
}
