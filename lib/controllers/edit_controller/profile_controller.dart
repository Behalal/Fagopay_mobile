import 'dart:convert';
import 'package:fagopay/controllers/login_controller.dart';
import 'package:fagopay/models/auth_model/forgot_password_response.dart';
import 'package:fagopay/models/auth_model/reset_password_response.dart';
import 'package:fagopay/models/auth_model/verify_reset_password_otp_response.dart';
import 'package:fagopay/screens/constants/colors.dart';
import 'package:fagopay/screens/widgets/navigation_bar.dart';
import 'package:fagopay/screens/widgets/progress_indicator.dart';
import 'package:fagopay/service/local/local_storage.dart';
import 'package:fagopay/service/network_services/dio_service_config/dio_client.dart';
import 'package:fagopay/service/network_services/dio_service_config/dio_error.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;

class ProfileController extends GetxController{
  bool isSetUpPasswordLoading = false;
  final authController = Get.put(LoginController());
  String? phoneNumber;
  String? password;


  Future<ForgotPasswordResponse> changePassword({required BuildContext context})async{
    progressIndicator(context);
    isSetUpPasswordLoading = true;
    update();
    Get.put<LocalCachedData>(await LocalCachedData.create());
    final userDetails = await LocalCachedData.instance.getUserDetails();
      var emailOrPassword = userDetails?.data?.userdetail?.phoneNumber ?? userDetails?.data?.userdetail?.email ?? "";
      if(emailOrPassword.startsWith("+234")){
        phoneNumber = emailOrPassword.replaceAll("+234", "0");
      }
    try{
      var postBody = jsonEncode({
        'username': phoneNumber,
      });
      final response = await NetworkProvider().call(path: "/v1/user/forgot-password", method: RequestMethod.post, body: postBody);
      final responseMessage = ForgotPasswordResponse.fromJson(response!.data);
      Get.back();
      isSetUpPasswordLoading = false;
      update();
      return  responseMessage;
    }on dio.DioError catch (err) {
      Get.back();
      isSetUpPasswordLoading = false;
      update();
      final errorMessage = Future.error(ApiError.fromDio(err));
      Get.snackbar('Error', err.response?.data['data']['error'] ?? errorMessage.toString(), colorText: Colors.white, backgroundColor: fagoSecondaryColor);
      throw errorMessage;
    } catch (err) {
      Get.back();
      isSetUpPasswordLoading = false;
      update();
      Get.snackbar('Something Went Wrong',err.toString(), colorText: Colors.white, backgroundColor: fagoSecondaryColor);
      throw err.toString();
    }
   // await forgotPassword(emailOrPassword: userDetails?.data?.userdetail?.phoneNumber ?? userDetails?.data?.userdetail?.email ?? "", context: context, password: password);
  }

  // Future<ForgotPasswordResponse> forgotPassword({required String emailOrPassword,required String password, required BuildContext context})async{
  //
  // }        final progress = ProgressHUD.of(context);
  //                             progress!.show();

  Future<VerifyResetPasswordResponse> validateForgotResetPassword({required String otp, required String password, required BuildContext context})async{
    progressIndicator(context);
    try{
      var postBody = jsonEncode({
        'code': otp,
      });
      final response = await NetworkProvider().call(path: "/v1/verify/password-reset-code", method: RequestMethod.post, body: postBody);
      final payload = VerifyResetPasswordResponse.fromJson(response?.data);
      await setUpPassword(code: otp, password: password).then((value){
        Get.back();
        Navigator.of(Get.context!).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (BuildContext context) => const Dashboard(),
            ), (route) => false);
        Get.snackbar('Successful', value.data?.message ?? "Password reset successful", colorText: Colors.white, backgroundColor: fagoGreenColor);
      });
      return payload;
    }on dio.DioError catch (err) {
      Get.back();
      update();
      final errorMessage = Future.error(ApiError.fromDio(err));
      Get.snackbar('Error', err.response?.data['data']['error'] ?? errorMessage.toString(), colorText: Colors.white, backgroundColor: fagoSecondaryColor);
      throw errorMessage;
    } catch (err) {
      Get.back();
      update();
      Get.snackbar('Something Went Wrong',err.toString(), colorText: Colors.white, backgroundColor: fagoSecondaryColor);
      throw err.toString();
    }
  }

  Future<ResetPasswordResponse> setUpPassword({required String code, required String password}) async {
    try{
      var postBody = jsonEncode({
        'code': code,
        'password': password,
        'password_confirmation': password,
      });
      final response = await NetworkProvider().call(path: "/v1/user/create-new-password", method: RequestMethod.post, body: postBody);
      final payload = ResetPasswordResponse.fromJson(response?.data);
      return payload;
    }on dio.DioError catch (err) {
      final errorMessage = Future.error(ApiError.fromDio(err));
      update();
      Get.snackbar('Error', err.response?.data['data']['error'] ?? errorMessage.toString(), colorText: Colors.white, backgroundColor: fagoSecondaryColor);
      throw errorMessage;
    } catch (err) {
      Get.snackbar('Something Went Wrong',err.toString(), colorText: Colors.white, backgroundColor: fagoSecondaryColor);
      update();
      throw err.toString();
    }
  }

}