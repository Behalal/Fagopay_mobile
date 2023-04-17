import 'dart:convert';

import 'package:fagopay/models/register_request/lookup_phone_model.dart';
import 'package:fagopay/models/request_money/request_money_model.dart';
import 'package:fagopay/service/constants/constants.dart';
import 'package:fagopay/service/secure_storage/secure_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

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

  final _requestedMoneyStatus = MyRequestedMoneyStatus.empty.obs;
  MyRequestedMoneyStatus get requestedMoneyStatus =>
      _requestedMoneyStatus.value;

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
      print('here 2');
      if (response.statusCode == 200) {
        var list = List.from(json['data']['my_request']);
        var products = list.map((e) => MyRequest.fromJson(e)).toList();
        if (kDebugMode) {
          print("${products.length} request");
          print(" Req ${products.first} request");
        }
        _myRequestList(products);
        products.isNotEmpty
            ? _myRequestStatus(MyRequestStatus.available)
            : _myRequestStatus(MyRequestStatus.empty);
        _myRequestStatus(MyRequestStatus.success);
      }
      return response.body;
    } catch (error) {
      _myRequestStatus(MyRequestStatus.error);
      Get.snackbar(
          'Error',
          error.toString() ==
                  "Failed host lookup: 'fagopay-coreapi-development.herokuapp.com'"
              ? 'No internet connection!'
              : error.toString());
      if (kDebugMode) {
        print('getting crops seller product Error ${error.toString()}');
      }
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
        requestedMon.isNotEmpty
            ? _requestedMoneyStatus(MyRequestedMoneyStatus.available)
            : _requestedMoneyStatus(MyRequestedMoneyStatus.empty);
        _requestedMoneyStatus(MyRequestedMoneyStatus.success);
      }
      return response.body;
    } catch (error) {
      _myRequestStatus(MyRequestStatus.error);
      Get.snackbar(
          'Error',
          error.toString() ==
                  "Failed host lookup: 'fagopay-coreapi-development.herokuapp.com'"
              ? 'No internet connection!'
              : error.toString());
      if (kDebugMode) {
        print('getting crops seller product Error ${error.toString()}');
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

  Future lookUpPhone({required String phone}) async {
    final token = await SecureStorage.readUserToken();
    try {
      _looUpPhonStatus(LookUpPhone.loading);

      var response = await http.get(
          Uri.parse(
            "${BaseAPI.lookupPhoneNum}$phone",
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
        print("lookup data ${response.body}");
      }
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);

        var phoneNumDetails =
            LookUpPhoneNumber.fromJson(json['data']['account_detail']);
        mUser(phoneNumDetails);
        if (kDebugMode) {
          print("phone number mUser $mUser request");
          // print("phone number details $phoneNumDetails request");
        }
        _looUpPhonStatus(LookUpPhone.success);
      }
      return response.body;
    } catch (error) {
      _looUpPhonStatus(LookUpPhone.error);
      Get.snackbar(
          'Error',
          error.toString() ==
                  "Failed host lookup: 'fagopay-coreapi-development.herokuapp.com'"
              ? 'No internet connection!'
              : error.toString());
      if (kDebugMode) {
        print('look up phone Error ${error.toString()}');
      }
    }
  }
}
