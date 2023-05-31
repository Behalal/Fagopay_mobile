import 'dart:convert';

import 'package:fagopay/controllers/user_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../service/constants/constants.dart';
import '../service/secure_storage/secure_storage.dart';
import 'company_controller.dart';

class PaymentLinkController extends GetxController{
  TextEditingController amount = TextEditingController();
  RxString paymentUrl = 'yo'.obs;
  Future<http.Response> generatePaymentPin()async{

    final _userController = Get.find<UserController>();
    final _companyController = Get.find<CompanyController>();
    final token = await SecureStorage.readUserToken();

    http.Response? response;
    final body =   _userController.switchedAccountType == 2 ? jsonEncode({
      "amount": amount.text.trim(),
      "customer_name": "${_userController.user?.firstName} ${_userController.user?.lastName}",
      "company_id": _companyController.company?.id,
      "account_id": _companyController.company?.accountDetails?.accountNumber,
    }):jsonEncode({
      "amount": amount.text.trim(),
      "customer_name": "${_userController.user?.firstName} ${_userController.user?.lastName}"
      // "company_id": "1000",
      //"account_id": "1000"
    });
    Map<String, String> headers = {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token'
    };
    try{
      print(body);
      response = await http.post(
          Uri.parse( BaseAPI.paymentLink,),
          headers: headers,
        body: body,
      );

     // print(response.body);
    }catch(e){
      if(kDebugMode){
        print('Unable to generate payment pin reson ${e.toString()}');
      }
    }
    return response!;
  }
}