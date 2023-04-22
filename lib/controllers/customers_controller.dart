import 'dart:convert';
import 'dart:developer';

import 'package:fagopay/service/constants/constants.dart';
import 'package:fagopay/service/networking/network_helper.dart';
import 'package:fagopay/service/secure_storage/secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  Future<dynamic> getCustomers() async {
    final token = await SecureStorage.readUserToken();
    try {
      final responseData = await NetworkHelper.getRequest(
        url: BaseAPI.customerPath,
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
          "Authorization": "Bearer $token",
        },
      );
      return responseData;
    } catch (e) {
      log(e.toString());
    }
  }

  Future<dynamic> registerNewCustomer(
      {required String name,
      required String phoneNumber,
      required String email,
      required String address,
      required String countryId,
      required String stateId,
      required String cityId}) async {
    final token = await SecureStorage.readUserToken();

    var requestBody = jsonEncode({
      "fullname": name,
      "phone_number": phoneNumber,
      "email": email,
      "address": address,
      "country_id": "0d9534ec-6d5f-43c5-b5b0-54e063088ad7",
      "state_id": "76eff75c-1fef-44a0-9c9d-88752ea2513b",
      "city_id": "20b9083a-8450-40eb-9344-67f67f4de9e7",
    });

    try {
      final response = await NetworkHelper.postRequest(
        url: BaseAPI.customerPath,
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
          "Authorization": "Bearer $token",
        },
        body: requestBody,
      );
      return response;
    } catch (e) {
      log(e.toString());
    }
  }
}
