import 'dart:convert';
import 'package:dio/dio.dart' as dio;
import 'package:fagopay/controllers/user_controller.dart';
import 'package:fagopay/screens/constants/colors.dart';
import 'package:fagopay/screens/widgets/progress_indicator.dart';
import 'package:fagopay/service/network_services/dio_service_config/dio_client.dart';
import 'package:fagopay/service/network_services/dio_service_config/dio_error.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../service/constants/constants.dart';
import '../service/secure_storage/secure_storage.dart';
import 'company_controller.dart';

class PaymentLinkController extends GetxController{
  Future<dio.Response<dynamic>?> generatePaymentPin(BuildContext context) async {
    progressIndicator(context);
    final _userController = Get.find<UserController>();
    final _companyController = Get.find<CompanyController>();
    final body =   _userController.switchedAccountType == 2 ? jsonEncode({
      "amount": amount.text.trim(),
      "customer_name": "${_userController.user?.firstName} ${_userController.user?.lastName}",
      "company_id": _companyController.company?.id,
      ///This thing was working before i don't know why its not working again
      //"account_id": _companyController.company?.accountDetails?.accountNumber,
    }):jsonEncode({
      "amount": amount.text.trim(),
      "customer_name": "${_userController.user?.firstName} ${_userController.user?.lastName}"
      // "company_id": "1000",
      //"account_id": "1000"
    });
    try{
      final response = await NetworkProvider().call(path: "/v1/transaction/generate-link", method: RequestMethod.post, body: body);
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('paymentLink', response?.data['data']['link']);
      Get.back();
      Get.snackbar('Success', response?.data['message'] ?? "Link generated", colorText: Colors.white, backgroundColor: fagoGreenColor);
      return response;
    }on dio.DioError catch (err) {
      Get.back();
      final errorMessage = Future.error(ApiError.fromDio(err));
      Get.snackbar('Error', err.response?.data['data']['error'] ?? errorMessage.toString(), colorText: Colors.white, backgroundColor: fagoSecondaryColor);
      throw errorMessage;
    } catch (err) {
      Get.back();
      Get.snackbar('Something Went Wrong',err.toString(), colorText: Colors.white, backgroundColor: fagoSecondaryColor);
      throw err.toString();
    }
  }
  TextEditingController amount = TextEditingController();
  RxString paymentUrl = 'yo'.obs;
  // Future<http.Response> generatePaymentPin()async{
  //
  //   final _userController = Get.find<UserController>();
  //   final _companyController = Get.find<CompanyController>();
  //   final token = await SecureStorage.readUserToken();
  //
  //   http.Response? response;
  //   final body =   _userController.switchedAccountType == 2 ? jsonEncode({
  //     "amount": amount.text.trim(),
  //     "customer_name": "${_userController.user?.firstName} ${_userController.user?.lastName}",
  //     "company_id": _companyController.company?.id,
  //     ///This thing was working before i don't know why its not working again
  //     //"account_id": _companyController.company?.accountDetails?.accountNumber,
  //   }):jsonEncode({
  //     "amount": amount.text.trim(),
  //     "customer_name": "${_userController.user?.firstName} ${_userController.user?.lastName}"
  //     // "company_id": "1000",
  //     //"account_id": "1000"
  //   });
  //   Map<String, String> headers = {
  //     "Content-Type": "application/json",
  //     'Authorization': 'Bearer $token'
  //   };
  //   try{
  //     print(body);
  //     response = await http.post(
  //         Uri.parse( BaseAPI.paymentLink,),
  //         headers: headers,
  //       body: body,
  //     );
  //
  //    // print(response.body);
  //   }catch(e){
  //     if(kDebugMode){
  //       print('Unable to generate payment pin reson ${e.toString()}');
  //     }
  //   }
  //   return response!;
  // }
}