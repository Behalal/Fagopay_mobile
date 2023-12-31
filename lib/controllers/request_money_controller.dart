import 'dart:convert';
import 'package:dio/dio.dart' as dio;
import 'package:fagopay/models/request_money/verify_phoneNumber_response_model.dart';
import 'package:fagopay/screens/constants/colors.dart';
import 'package:fagopay/service/network_services/dio_service_config/dio_client.dart';
import 'package:fagopay/service/network_services/dio_service_config/dio_error.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../models/register_request/lookup_phone_model.dart';
import '../models/request_money/request_money_model.dart';
import '../service/constants/constants.dart';
import '../service/secure_storage/secure_storage.dart';

enum MyRequestStatus {
  empty,
  loading,
  error,
  success,
  available,
}

enum MyRequestedMoneyStatus {
  empty,
  loading,
  error,
  success,
  available,
}

enum LookUpPhone {
  empty,
  loading,
  error,
  success,
  available,
}

class RequestMoney extends GetxController {
  final Rx<List<MyRequest>> _myRequestList = Rx([]);
  List<MyRequest> get myRequestList => _myRequestList.value;

  final Rx<List<MyRequest>> _requestedMoneyList = Rx([]);
  List<MyRequest> get requestedMoneyList => _requestedMoneyList.value;

  final _myRequestStatus = MyRequestStatus.empty.obs;
  MyRequestStatus get myRequestStatus => _myRequestStatus.value;
  final Rx<String> editPayment = ''.obs;
  String get  paymentPin  => editPayment.value;
  final _requestedMoneyStatus = MyRequestedMoneyStatus.empty.obs;
  MyRequestedMoneyStatus get requestedMoneyStatus => _requestedMoneyStatus.value;

  final _looUpPhonStatus = LookUpPhone.empty.obs;
  LookUpPhone get looUpPhonStatus => _looUpPhonStatus.value;

  final Rx<LookUpPhoneNumber?> mUser = Rx(null);
  LookUpPhoneNumber? get user => mUser.value;

  Future getMyRequest() async {
    final token = await SecureStorage.readUserToken();

    try {
      _myRequestStatus(MyRequestStatus.loading);
      if (kDebugMode) {
        print('getting my request...');
      }
      var response = await http.get(
        Uri.parse(BaseAPI.myRequest),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
      );
      print('here 1');
      var json = jsonDecode(response.body);
      if (kDebugMode) {
        print(response.body);
      }
      print('here 3');
      // if (response.statusCode == 200) {
      //   throw (json['message']);
      // }
      if (response.statusCode == 200) {
        var list = List.from(json['data']['my_request']);
        var products = list.map((e) => MyRequest.fromJson(e)).toList();
        _myRequestList(products);
        products.isNotEmpty ? _myRequestStatus(MyRequestStatus.available) : _myRequestStatus(MyRequestStatus.empty);
        _myRequestStatus(MyRequestStatus.success);
      } else if (response.statusCode == 409) {
        Get.snackbar('Error', 'Go and verify your KYC', colorText: Colors.white, backgroundColor: fagoSecondaryColor);
        _myRequestStatus(MyRequestStatus.error);
      }
      print('response body = ${response.body}');
      return response.body;
    } catch (error) {
      _myRequestStatus(MyRequestStatus.error);
      Get.snackbar(
          'Error',
          error.toString() ==
                  "Failed host lookup: 'fagopay-coreapi-development.herokuapp.com'"
              ? 'No internet connection!'
              : error.toString(), colorText: Colors.white, backgroundColor: fagoSecondaryColor);
      if (kDebugMode) {
        print('my request Error ${error.toString()}');
      }
    }
  }


  Future cancelRequestMoney(String id) async {
    //print('yp');
    _myRequestStatus(MyRequestStatus.loading);
    final token = await SecureStorage.readUserToken();
    http.Response? response;
    try{
      print('Start');
    //  _myRequestStatus(MyRequestStatus.loading);
      response = await http.get(
        Uri.parse("${BaseAPI.transactionsPath}cancel-money-request/$id"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
      );
      if(response.statusCode == 200){
        _myRequestStatus(MyRequestStatus.success);
      }else{
        _myRequestStatus(MyRequestStatus.error);
      }
      print(response.body);
    }catch (error) {
      Get.snackbar(
          'Error',
          error.toString() ==
              "Failed host lookup: 'fagopay-coreapi-development.herokuapp.com'"
              ? 'No internet connection!'
              : error.toString(), colorText: Colors.white, backgroundColor: fagoSecondaryColor);
      if (kDebugMode) {
        print('requested money Error ${error.toString()}');
      }
    }
   return response!;
  }
  Future<dio.Response<dynamic>?> processRequestMoney({ required Map data}) async {
    try{
      var postBody = jsonEncode(data);
      final response = await NetworkProvider().call(path: "/v1/transaction/process-money-request", method: RequestMethod.post, body: postBody);
      return response;
    }on dio.DioError catch (err) {
      Get.back();
      final errorMessage = Future.error(ApiError.fromDio(err));
      update();
      Get.snackbar('Error', err.response?.data['data']['error'] ?? errorMessage.toString(), colorText: Colors.white, backgroundColor: fagoSecondaryColor);
      throw errorMessage;
    } catch (err) {
      Get.back();
      Get.snackbar('Error', err.toString() == "Failed host lookup: 'fagopay-coreapi-development.herokuapp.com'"
          ? 'No internet connection!' : err.toString(), colorText: Colors.white, backgroundColor: fagoSecondaryColor);
      throw err.toString();
    }
  }
  Future requestedMoney() async {
    final token = await SecureStorage.readUserToken();
    try {
      _requestedMoneyStatus(MyRequestedMoneyStatus.loading);
      if (kDebugMode) {
        print('getting my request...');
      }
      var response = await http.get(
        Uri.parse(BaseAPI.requestedMoney),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
      );
      print('here 1');
      var json = jsonDecode(response.body);
      if (kDebugMode) {
        print(response.body);
      }
      print('here 3');
      // if (response.statusCode == 200) {
      //   throw (json['message']);
      // }
      print('here 2');
      if (response.statusCode == 200) {
        var list = List.from(json['data']['requested_list']);
        var requestedMon = list.map((e) => MyRequest.fromJson(e)).toList();
        if (kDebugMode) {
          print("${requestedMon.length} request");
          print(" Req list ${requestedMon.first} request");
        }

        _requestedMoneyList(requestedMon);
        requestedMon.isNotEmpty ? _requestedMoneyStatus(MyRequestedMoneyStatus.available) : _requestedMoneyStatus(MyRequestedMoneyStatus.empty);
        _requestedMoneyStatus(MyRequestedMoneyStatus.success);
      } else if (response.statusCode == 409) {
        Get.snackbar('Error', 'Go and verify your KYC', colorText: Colors.white, backgroundColor: fagoSecondaryColor);
        _requestedMoneyStatus(MyRequestedMoneyStatus.error);
      }
      return response.body;
    } catch (error) {
      _myRequestStatus(MyRequestStatus.error);
      Get.snackbar(
          'Error',
          error.toString() ==
                  "Failed host lookup: 'fagopay-coreapi-development.herokuapp.com'"
              ? 'No internet connection!'
              : error.toString(), colorText: Colors.white, backgroundColor: fagoSecondaryColor);
      if (kDebugMode) {
        print('requested money Error ${error.toString()}');
      }
    }
  }

  // Future requestMoneyApi({String? otp}) async {
  //   final token = await SecureStorage.readUserToken();
  //   _requestMoneyApiStatus(RequestMoneyApi.loading);
  //   try {
  //     if (kDebugMode) {
  //       print('validating reset password otp...');
  //     }

  //     var response = await http.post(Uri.parse(BaseAPI.requestMoneyapi),
  //         headers: {
  //           "Content-Type": "application/json",
  //           "Authorization": "Bearer $token"
  //         },
  //         body: jsonEncode({
  //           "phone_number": otp,
  //           "amount": 3500,
  //           "description": "Kennyobey request testing"
  //         }));
  //     if (kDebugMode) {
  //       print(response.body);
  //     }
  //     var json = jsonDecode(response.body);
  //     if (json['success'] == false) {
  //       throw (json['message']);
  //     }

  //     if (response.statusCode == 200) {
  //       _requestMoneyApiStatus(RequestMoneyApi.success);
  //       Get.snackbar('Success', 'Password reset validated successfully!');
  //       print("user id ${json['data']['code']}");
  //       // Get.to(() => ResetPasswordScreen(
  //       //       pinCode: json['data']['code'],
  //       //     ));
  //     } else if (response.statusCode == 422) {
  //       Get.snackbar('Error', 'The selected code is invalid');
  //       _requestMoneyApiStatus(RequestMoneyApi.error);
  //     }

  //     return response.body;
  //   } catch (error) {
  //     _requestMoneyApiStatus(RequestMoneyApi.error);
  //     Get.snackbar(
  //         'Error',
  //         error.toString() ==
  //                 "Failed host lookup: 'fagopay-coreapi-development.herokuapp.com''"
  //             ? 'No internet connection!'
  //             : error.toString());
  //     if (kDebugMode) {
  //       print("error ${error.toString()}");
  //     }
  //   }
  // }

  String accountName = '';
  bool? onLookUpNumberLoadingState;
  bool? onLookUpNumberErrorState;
  Future<void> lookUpPhone({required String phoneNumber})async{
    onLookUpNumberLoadingState = true;
    onLookUpNumberErrorState = false;
    update();
    try{
      final response = await NetworkProvider().call(path: "/v1/transaction/account-lookup-by-phone/$phoneNumber", method: RequestMethod.get);
      final responseMessage = VerifyPhoneNumberResponse.fromJson(response!.data);
      onLookUpNumberLoadingState = false;
      onLookUpNumberErrorState = false;
      accountName = responseMessage.data!.accountDetail!.accountName!;
      update();
    }on dio.DioError catch (err) {
      onLookUpNumberLoadingState = false;
      onLookUpNumberErrorState = true;
      update();
      final errorMessage = Future.error(ApiError.fromDio(err));
      accountName = err.response?.data['data']['error'] ?? "Couldn't find number";
      throw errorMessage;
    } catch (err) {
      onLookUpNumberLoadingState = false;
      onLookUpNumberErrorState = true;
      update();
      accountName = "Couldn't find number";
      throw err.toString();
    }
  }


  // Future lookUpPhone({required String phone}) async {
  //   final token = await SecureStorage.readUserToken();
  //   try {
  //     _looUpPhonStatus(LookUpPhone.loading);
  //
  //     var response = await http.get(
  //         Uri.parse(
  //           "${BaseAPI.lookupPhoneNum}$phone",
  //         ),
  //         headers: {
  //           "Content-Type": "application/json",
  //           'Authorization': 'Bearer $token'
  //         });
  //     if (kDebugMode) {
  //       print("lookup data ${response.body}");
  //     }
  //     if (response.statusCode == 200) {
  //       var json = jsonDecode(response.body);
  //       var phoneNumDetails = LookUpPhoneNumber.fromJson(json['data']['account_detail']);
  //       mUser(phoneNumDetails);
  //       if (kDebugMode) {
  //         print("phone number mUser $mUser request");
  //         // print("phone number details $phoneNumDetails request");
  //       }
  //       _looUpPhonStatus(LookUpPhone.success);
  //     } else if (response.statusCode == 404) {
  //       // Get.snackbar(
  //       //     'Error', 'Make sure the number is a register number on fagopay');
  //       _looUpPhonStatus(LookUpPhone.error);
  //     }
  //     return response.body;
  //   } catch (error) {
  //     _looUpPhonStatus(LookUpPhone.error);
  //     Get.snackbar(
  //         'Error',
  //         error.toString() == "Failed host lookup: 'fagopay-coreapi-development.herokuapp.com'" ? 'No internet connection!' : error.toString());
  //     if (kDebugMode) {
  //       print('look up phone Error ${error.toString()}');
  //     }
  //   }
  // }
}
