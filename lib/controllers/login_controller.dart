import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../screens/authentication/reset_password_screen.dart';
import '../service/constants/constants.dart';
import '../service/networking/network_helper.dart';
import '../service/secure_storage/secure_storage.dart';

enum OtpForgotVerifyStatus {
  empty,
  loading,
  error,
  success,
}

class LoginController extends GetxController {
  TextEditingController emailController =
      TextEditingController(text: 'adrick.damauri@foundtoo.com');
  TextEditingController passwordController =
      TextEditingController(text: 'Bigdaddy@123');

  final _otpForgotVerifyStatus = OtpForgotVerifyStatus.empty.obs;

  OtpForgotVerifyStatus get otpForgotVerifyStatus =>
      _otpForgotVerifyStatus.value;

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

// Future<dynamic> validateForgotResetPassword(
//       String otp, String password, String confirmedPassword) async {
//     var requestBody = jsonEncode({
//       'code': otp,

//     });
//     try {
//       final responseData = await NetworkHelper.postRequest(
//         url: "${BaseAPI.validateResetOtp}password-reset-code",
//         headers: BaseAPI.headers,
//         body: requestBody,
//       );
//       return responseData;
//     } catch (e) {
//       log(e.toString());
//       throw Exception('Failed');
//     }
//   }

  Future validateForgotResetPassword({String? otp}) async {
    _otpForgotVerifyStatus(OtpForgotVerifyStatus.loading);
    try {
      if (kDebugMode) {
        print('validating reset password otp...');
      }

      var response = await http.post(Uri.parse(BaseAPI.validateResetOtp),
          headers: {
            "Content-Type": "application/json",
          },
          body: jsonEncode({
            "code": otp,
          }));
      if (kDebugMode) {
        print(response.body);
      }
      var json = jsonDecode(response.body);
      if (json['success'] == false) {
        throw (json['message']);
      }

      if (response.statusCode == 200) {
        _otpForgotVerifyStatus(OtpForgotVerifyStatus.success);
        Get.snackbar('Success', 'Password reset validated successfully!');
        print("user id ${json['data']['code']}");
        Get.to(() => ResetPasswordScreen(
              pinCode: json['data']['code'],
            ));
      } else if (response.statusCode == 422) {
        Get.snackbar('Error', 'The selected code is invalid');
        _otpForgotVerifyStatus(OtpForgotVerifyStatus.error);
      }

      return response.body;
    } catch (error) {
      _otpForgotVerifyStatus(OtpForgotVerifyStatus.error);
      Get.snackbar(
          'Error',
          error.toString() ==
                  "Failed host lookup: 'fagopay-coreapi-development.herokuapp.com''"
              ? 'No internet connection!'
              : error.toString());
      if (kDebugMode) {
        print("error ${error.toString()}");
      }
    }
  }
}
