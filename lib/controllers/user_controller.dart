import 'dart:convert';

import 'package:flutter/material.dart';

import '../models/company_model.dart';
import '../models/referal_earnings.dart/referal_earning.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../models/nextofkin_model.dart';
import '../models/user_model/user.dart';
import '../screens/widgets/navigation_bar.dart';
import '../service/constants/constants.dart';
import '../service/secure_storage/secure_storage.dart';
import 'company_controller.dart';
import 'login_controller.dart';

enum NextOfKinEnum {
  empty,
  loading,
  error,
  success,
}

enum RefaralEarningEnum {
  empty,
  loading,
  error,
  success,
  available,
}

class UserController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController relationshipController = TextEditingController();

  final _nextOfKinStatus = NextOfKinEnum.empty.obs;

  NextOfKinEnum get nextOfKinStatus => _nextOfKinStatus.value;
  final Rx<User?> _user = Rx(null);
  final Rx<AccountDetail?> _userAccountDetails = Rx(null);

  final _referalEarningStatus = RefaralEarningEnum.empty.obs;
  RefaralEarningEnum get referalEarningStatus => _referalEarningStatus.value;
  final Rx<RefaralEarningData?> userReferal = Rx(null);
  RefaralEarningData? get userReferalEarning => userReferal.value;

  final RxInt _switchedAccountType = 1.obs;

  int? get switchedAccountType => _switchedAccountType.value;

  set switchedAccountType(int? switchedAccountType) {
    _switchedAccountType(switchedAccountType);
  }

  User? get user => _user.value;

  set setUser(User? user) {
    _user(user);
  }

  AccountDetail? get userAccountDetails => _userAccountDetails.value;

  set setUserAccountDetails(AccountDetail? userAccountDetails) {
    _userAccountDetails(userAccountDetails);
  }

  Future uploadNextOfKin(NextOfKinModel nextofkin,) async {
    final token = await SecureStorage.readUserToken();
    try {
      _nextOfKinStatus(NextOfKinEnum.loading);
      if (kDebugMode) {
        print('updating next of kin...');
        print('Next of kin json: ${nextofkin.toJson()}');
      }
      var response = await http.post(
        Uri.parse(BaseAPI.nextofKin),
        body: jsonEncode(nextofkin.toJson()),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
      );
      var json = jsonDecode(response.body);
      print('The date supplied is ${response.body}');

      if ((response.statusCode == 200)) {
        _nextOfKinStatus(NextOfKinEnum.success);

        Get.snackbar('Success', 'Next of kin updated successfully!');
        clear();
      }
      print('here');
      // return nextOfKinFromJson(response.body);
    } catch (error) {
      _nextOfKinStatus(NextOfKinEnum.error);
      Get.snackbar(
          'Error',
          error.toString() ==
                  "Failed host lookup: 'fagopay-coreapi-development.herokuapp.com'"
              ? 'No internet connection!'
              : error.toString());
      if (kDebugMode) {
        print('creating product Error ${error.toString()}');
      }
    }
  }

  Future showReferalEarning() async {
    final token = await SecureStorage.readUserToken();
    try {
      _referalEarningStatus(RefaralEarningEnum.loading);
      if (kDebugMode) {
        print('getting referalEarning...');
      }

      var response = await http.get(
          Uri.parse(
            BaseAPI.showReferalEarning,
          ),
          headers: {
            "Content-Type": "application/json",
            'Authorization': 'Bearer $token'
          });
      //    print('here 1');
      // var json = jsonDecode(response.body);
      // if (kDebugMode) {
      //   print(response.body);
      // }
      print('here 2');
      if (kDebugMode) {
        print("showReferalEarning data ${response.body}");
      }
      print('here 3');
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        print('here 4');
        var showReferalEarning = RefaralEarningData.fromJson(json['data']);
        userReferal(showReferalEarning);
        if (kDebugMode) {
          print("Purse Details is $userReferalEarning request");
          // print("phone number details $phoneNumDetails request");
        }
        _referalEarningStatus(RefaralEarningEnum.success);
      }
      // else if (response.statusCode == 404) {
      //   // Get.snackbar(
      //   //     'Error', 'Make sure the number is a register number on fagopay');
      //   _referalEarningStatus(RefaralEarningEnum.error);
      // }
      return response.body;
    } catch (error) {
      _referalEarningStatus(RefaralEarningEnum.error);
      Get.snackbar(
          'Error',
          error.toString() ==
                  "Failed host lookup: 'fagopay-coreapi-development.herokuapp.com'"
              ? 'No internet connection!'
              : error.toString());
      if (kDebugMode) {
        print('Show purse Error ${error.toString()}');
      }
    }
  }
  ///Get user deatils old code;
  // Future<void> getUserDetails(BuildContext context) async {
  //   final _companyController = Get.find<CompanyController>();
  //   final _userController = Get.find<UserController>();
  //   final _loginController = Get.find<LoginController>();
  //
  //  // final progress = ProgressHUD.of(context);
  //   final response = await _loginController.getUserDetails();
  //   // setState(() {
  //   //   _isLoading = false;
  //   // });
  //  // progress?.dismiss();
  //   final userNextOfKinBodyData = response['data']['userdetail']['nextofkin'];
  //   if (kDebugMode) {
  //     print('User NoK details response is $userNextOfKinBodyData');
  //   }
  //   final userjsonBodyData = response['data']['userdetail'];
  //   if (kDebugMode) {
  //     print('User details response is $userjsonBodyData');
  //   }
  //   final userAccountjsonBodyData =
  //   response['data']['userdetail']['accountdetail'];
  //   final userDetails = User.fromJson(userjsonBodyData);
  //   if (kDebugMode) {
  //     print(
  //         '-----------User userAccountDetails response is $userAccountjsonBodyData');
  //   }
  //   _userController.setUser = userDetails;
  //   final userAccountDetails = AccountDetail.fromJson(userAccountjsonBodyData);
  //   _userController.setUserAccountDetails = userAccountDetails;
  //
  //   final userBusinessDetailsjsonBodyData =
  //   response['data']['business_detail']['profile'];
  //
  //   if (userBusinessDetailsjsonBodyData.length != 0) {
  //     final returnedCompanies = userBusinessDetailsjsonBodyData
  //         .map<Company>((company) => Company.fromJson(company))
  //         .toList();
  //     final companyDetails =
  //     Company.fromJson(userBusinessDetailsjsonBodyData[0]);
  //     _companyController.companies = returnedCompanies;
  //     _companyController.setCompany = companyDetails;
  //   }
  //
  //   //if (!mounted) return;
  //   Navigator.of(context).pushReplacement(
  //     MaterialPageRoute(
  //       builder: (BuildContext context) => const Dashboard(),
  //     ),
  //   );
  // }
  void clear() {
    emailController.clear();
    phoneNumController.clear();
    addressController.clear();
    nameController.clear();
    relationshipController.clear();
  }
}
