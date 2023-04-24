import 'dart:convert';

import 'package:fagopay/models/nextofkin_model.dart';
import 'package:fagopay/service/constants/constants.dart';
import 'package:fagopay/service/secure_storage/secure_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../models/user_model/user.dart';
import 'package:http/http.dart' as http;

enum NextOfKinEnum {
  empty,
  loading,
  error,
  success,
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

  User? get user => _user.value;

  set setUser(User? user) {
    _user(user);
  }

  AccountDetail? get userAccountDetails => _userAccountDetails.value;

  set setUserAccountDetails(AccountDetail? userAccountDetails) {
    _userAccountDetails(userAccountDetails);
  }

  Future uploadNextOfKin(
    NextOfKinModel nextofkin,
  ) async {
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

  void clear() {
    emailController.clear();
    phoneNumController.clear();
    addressController.clear();
    nameController.clear();
    relationshipController.clear();
  }
}
