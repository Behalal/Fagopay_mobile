import 'dart:convert';
import 'dart:developer';

import 'package:fagopay/controllers/user_controller.dart';
import 'package:fagopay/screens/constants/colors.dart';
import 'package:fagopay/service/network_services/dio_service_config/dio_client.dart';
import 'package:fagopay/service/network_services/dio_service_config/dio_error.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/swap_airtime_model.dart/initiateSwap.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import '../models/swap_airtime_model.dart/swapCharges_Model.dart';
import '../screens/individual/bills/models/bill_post_model.dart';
import '../service/constants/constants.dart';
import '../service/networking/network_helper.dart';
import '../service/secure_storage/secure_storage.dart';
import 'package:http/http.dart' as http;

import 'company_controller.dart';

enum SwapChargesEnum {
  empty,
  loading,
  error,
  success,
  available,
}

enum InitiateSwapEnum {
  empty,
  loading,
  error,
  success,
  available,
}

class BillController extends GetxController {
  TextEditingController phoneController = TextEditingController();
  TextEditingController confirmPhoneController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController meterNoController = TextEditingController();

  bool isLoadingElectricity = false;

  final _swapChargesStatus = SwapChargesEnum.empty.obs;
  SwapChargesEnum get swapChargesStatus => _swapChargesStatus.value;

  final Rx<SwapCharges?> chargesAmount = Rx(null);
  SwapCharges? get userchargesAmount => chargesAmount.value;

  final _initiateSwapStatus = InitiateSwapEnum.empty.obs;
  InitiateSwapEnum get initiateSwapStatus => _initiateSwapStatus.value;

  Future<dynamic> getDatabyServiceId(String serviceID) async {
    final token = await SecureStorage.readUserToken();
    try {
      final responseData = await NetworkHelper.getRequest(
        url: "${BaseAPI.billPath}data-variation-list/$serviceID",
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


  Future<String> fetchAccountId() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    String? accountId = sharedPreferences.getString("accountId");
    return accountId ?? "";
  }
  Future<String> fetchCompanyId() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    String? companyId = sharedPreferences.getString("companyId");
    return companyId ?? "";
  }
  String? companyId;
  String? accountId;
  final _userUcontroller = Get.find<UserController>();

  Future<dio.Response<dynamic>?> buyAirtime(String transactionPin) async {
    String amount = buyAirtimeFields.amount;
    String serviceId = buyAirtimeFields.serviceid;
    String phone = buyAirtimeFields.getphone;
    await fetchAccountId().then((value){
      if(value.isEmpty || value == ""){
        accountId = "";
      }else{
        accountId = value;
      }
    });
    await fetchCompanyId().then((value){
      if(value.isEmpty || value == ""){
        companyId = "";
      }else{
        companyId = value;
      }
    });
    var requestBody = jsonEncode({
      "phone": phone,
      "serviceID": serviceId,
      "amount": amount,
      "transaction_pin": transactionPin,
    });
    var requestBodyCompany = jsonEncode({
      "phone": phone,
      "serviceID": serviceId,
      "amount": amount,
      "transaction_pin": transactionPin,
      "company_id": companyId,
      "account": accountId,
    });
    try{
      final response = await NetworkProvider().call(path: "/v1/bills/airtime-purchase", method: RequestMethod.post,
          body: _userUcontroller.switchedAccountType == 2 ? requestBodyCompany : requestBody);
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

  Future<dio.Response<dynamic>?> buyData(String transactionPin) async {
    String amount = buyDataFields.amount;
    String serviceId = buyDataFields.serviceid;
    String phone = buyDataFields.getphone;
    String billerCode = buyDataFields.billersCode;
    String variationCode = buyDataFields.variationCode;
    await fetchAccountId().then((value){
      if(value.isEmpty || value == ""){
        accountId = "";
      }else{
        accountId = value;
      }
    });
    await fetchCompanyId().then((value){
      if(value.isEmpty || value == ""){
        companyId = "";
      }else{
        companyId = value;
      }
    });

    var requestBody = jsonEncode({
      "phone": phone,
      "serviceID": serviceId,
      "amount": double.parse(amount).toInt().toString(),
      "variation_code": variationCode,
      "billersCode": billerCode,
      "transaction_pin": transactionPin
    });

    var requestBodyCompany = jsonEncode({
      "phone": phone,
      "serviceID": serviceId,
      "amount": double.parse(amount).toInt().toString(),
      "variation_code": variationCode,
      "billersCode": billerCode,
      "transaction_pin": transactionPin,
      "company_id": companyId,
      "account": accountId,
    });

    try {
      final responseData = await NetworkProvider().call(path: "/v1/bills/purchase-data-bundle", method: RequestMethod.post,
          body: _userUcontroller.switchedAccountType == 2 ? requestBodyCompany : requestBody);
      return responseData;
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

  Future<dynamic> verifyMeterNo(
      String serviceID, String billersCode, String type) async {
    final token = await SecureStorage.readUserToken();

    var requestBody = jsonEncode(
        {"serviceID": serviceID, "billersCode": billersCode, "type": type});

    try {
      final responseData = await NetworkHelper.postRequest(
        url: "${BaseAPI.billPath}verify-meter-number",
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
          "Authorization": "Bearer $token"
        },
        body: requestBody,
      );

      return responseData;
    } catch (e) {
      log(e.toString());
      throw Exception('Failed');
    }
  }

  Future<dynamic> verifyRouter(String billersCode) async {
    final token = await SecureStorage.readUserToken();

    var requestBody = jsonEncode({
      "billersCode": billersCode,
    });

    try {
      final responseData = await NetworkHelper.postRequest(
        url: "${BaseAPI.billPath}verify-smile-number",
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
          "Authorization": "Bearer $token"
        },
        body: requestBody,
      );

      return responseData;
    } catch (e) {
      log(e.toString());
      throw Exception('Failed');
    }
  }

  Future<dio.Response<dynamic>?> buyElectricity(String transactionPin) async {
    String amount = buyElectricityFields.amount;
    String serviceID = buyElectricityFields.serviceid;
    String phone = buyElectricityFields.getphone;
    String billerCode = buyElectricityFields.billersCode;
    String variationCode = buyElectricityFields.variationCode;
    await fetchAccountId().then((value){
      if(value.isEmpty || value == ""){
        accountId = "";
      }else{
        accountId = value;
      }
    });
    await fetchCompanyId().then((value){
      if(value.isEmpty || value == ""){
        companyId = "";
      }else{
        companyId = value;
      }
    });
    var requestBody = jsonEncode({
      "phone": phone,
      "serviceID": serviceID,
      "amount": amount,
      "variation_code": variationCode,
      "billersCode": billerCode,
      "transaction_pin": transactionPin
    });
    var requestBodyCompany = jsonEncode({
      "phone": phone,
      "serviceID": serviceID,
      "amount": amount,
      "variation_code": variationCode,
      "billersCode": billerCode,
      "transaction_pin": transactionPin,
      "company_id": companyId,
      "account": accountId,
    });

    try {

      final responseData = await NetworkProvider().call(path: "/v1/bills/electricity-purchase", method: RequestMethod.post,
          body: _userUcontroller.switchedAccountType == 2 ? requestBodyCompany : requestBody);
      return responseData;
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

  Future<dio.Response<dynamic>?> buyInternet(String transactionPin) async {
    String amount = buyInternetFields.amount;
    String serviceID = buyInternetFields.serviceid;
    String billerCode = buyInternetFields.billersCode;
    String variationCode = buyInternetFields.variationCode;
    await fetchAccountId().then((value){
      if(value.isEmpty || value == ""){
        accountId = "";
      }else{
        accountId = value;
      }
    });
    await fetchCompanyId().then((value){
      if(value.isEmpty || value == ""){
        companyId = "";
      }else{
        companyId = value;
      }
    });
    var requestBody = jsonEncode({
      "serviceID": serviceID,
      "amount": double.parse(amount).toInt(),
      "variation_code": variationCode,
      "billersCode": billerCode,
      "transaction_pin": transactionPin,
    });
    var requestBodyCompany = jsonEncode({
      "serviceID": serviceID,
      "amount": double.parse(amount).toInt(),
      "variation_code": variationCode,
      "billersCode": billerCode,
      "transaction_pin": transactionPin,
      "company_id": companyId,
      "account": accountId,
    });

    try {
      final responseData = await NetworkProvider().call(path: "/v1/bills/internet-subscription", method: RequestMethod.post,
          body: _userUcontroller.switchedAccountType == 2 ? requestBodyCompany : requestBody);
      return responseData;
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

  Future<dio.Response<dynamic>?> verifySmartCardNumber(
      String billersCode, String serviceID) async {
    var requestBody =
        jsonEncode({"billersCode": billersCode, "serviceID": serviceID});

    try {
      final responseData = await NetworkProvider().call(path: "/v1/bills/verify-smart-card-number", method: RequestMethod.post,
          body: requestBody);
      return responseData;
    }on dio.DioError catch (err) {
      Get.back();
      final errorMessage = Future.error(ApiError.fromDio(err));
      Get.snackbar('Error', err.response?.data['data']['error'] ?? errorMessage.toString());
      throw errorMessage;
    } catch (err) {
      Get.back();
      Get.snackbar('Something Went Wrong',err.toString());
      throw err.toString();
    }
  }

  Future<dio.Response<dynamic>?> buyCableSubscription(String transactionPin) async {
    String amount = buyTvCableFields.amount;
    String serviceID = buyTvCableFields.serviceid;
    String phone = buyTvCableFields.getphone;
    String billerCode = buyTvCableFields.billersCode;
    String variationCode = buyTvCableFields.variationCode;
    await fetchAccountId().then((value){
      if(value.isEmpty || value == ""){
        accountId = "";
      }else{
        accountId = value;
      }
    });
    await fetchCompanyId().then((value){
      if(value.isEmpty || value == ""){
        companyId = "";
      }else{
        companyId = value;
      }
    });
    var requestBody = jsonEncode({
      "phone": phone,
      "serviceID": serviceID,
      "amount": double.parse(amount).toInt(),
      "variation_code": variationCode,
      "billersCode": billerCode,
      "transaction_pin": transactionPin
    });
    var requestBodyCompany = jsonEncode({
      "phone": phone,
      "serviceID": serviceID,
      "amount": double.parse(amount).toInt(),
      "variation_code": variationCode,
      "billersCode": billerCode,
      "transaction_pin": transactionPin,
      "company_id": companyId,
      "account": accountId,
    });

    try {
      final responseData = await NetworkProvider().call(path: "/v1/bills/tv-subscription", method: RequestMethod.post,
          body: _userUcontroller.switchedAccountType == 2 ? requestBodyCompany : requestBody);
      return responseData;
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

  Future swapCharge({required String network, required String amount}) async {
    final token = await SecureStorage.readUserToken();
    try {
      _swapChargesStatus(SwapChargesEnum.loading);

      var response = await http.get(
          Uri.parse(
            "${BaseAPI.airtimeSwapCharges}$network/$amount",
          ),
          headers: {
            "Content-Type": "application/json",
            'Authorization': 'Bearer $token'
          });
      print('here 1');
      var json = jsonDecode(response.body);
      if (kDebugMode) {
        print(response.body);
      }
      print('here 3');
      if (kDebugMode) {
        print("swap charge ${response.body}");
      }
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);

        var phoneNumDetails =
            SwapCharges.fromJson(json['data']['swap_charges']);
        chargesAmount(phoneNumDetails);
        if (kDebugMode) {
          print("swap charge chargesAmount $chargesAmount request");
          // print("phone number details $phoneNumDetails request");
        }
        _swapChargesStatus(SwapChargesEnum.success);
      } else if (response.statusCode == 404) {
        // Get.snackbar(
        //     'Error', 'Make sure the number is a register number on fagopay');
        _swapChargesStatus(SwapChargesEnum.error);
      }
      return response.body;
    } catch (error) {
      _swapChargesStatus(SwapChargesEnum.error);
      Get.snackbar(
          'Error',
          error.toString() ==
                  "Failed host lookup: 'fagopay-coreapi-development.herokuapp.com'"
              ? 'No internet connection!'
              : error.toString(), colorText: Colors.white, backgroundColor: fagoSecondaryColor);
      if (kDebugMode) {
        print('swap charges amount Error ${error.toString()}');
      }
    }
  }

  Future initiateSwap(
    SwappingDetailModel swapDetails,
  ) async {
    final token = await SecureStorage.readUserToken();
    try {
      _initiateSwapStatus(InitiateSwapEnum.loading);

      if (kDebugMode) {
        print('initiating swap...');
        print('initate swap json: ${swapDetails.toJson()}');
      }
      var response = await http.post(
        Uri.parse(BaseAPI.initiateSwap),
        body: jsonEncode(swapDetails.toJson()),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
      );
      var json = jsonDecode(response.body);
      print('The date supplied is ${response.body}');

      if ((response.statusCode == 200)) {
        _initiateSwapStatus(InitiateSwapEnum.success);

        Get.snackbar('Success', 'Airtime Swap successfully!', colorText: Colors.white, backgroundColor: fagoGreenColor);
        clear();
      }
      print('here');
      // return nextOfKinFromJson(response.body);
    } catch (error) {
      _initiateSwapStatus(InitiateSwapEnum.error);
      Get.snackbar(
          'Error',
          error.toString() ==
                  "Failed host lookup: 'fagopay-coreapi-development.herokuapp.com'"
              ? 'No internet connection!'
              : error.toString(), colorText: Colors.white, backgroundColor: fagoSecondaryColor);
      if (kDebugMode) {
        print('swap initiate Error ${error.toString()}');
      }
    }
  }

  void clear() {
    phoneController.clear();
    confirmPhoneController.clear();
    amountController.clear();
    meterNoController.clear();
  }
}
