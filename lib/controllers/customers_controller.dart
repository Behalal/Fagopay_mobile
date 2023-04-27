import 'dart:convert';
import 'dart:developer';

import '../models/customer_model.dart';
import '../service/constants/constants.dart';
import '../service/networking/network_helper.dart';
import '../service/secure_storage/secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerController extends GetxController {
  // final Rx<Customer?> _customer = Rx(null);
  final Rx<List<Customer>> _customers = Rx([]);

  List<Customer> get customers {
    return [..._customers.value];
  }

  set customers(List<Customer> customers) {
    _customers(customers);
  }

  Customer findCustomerById(String id) {
    return customers.firstWhere((customer) => customer.id == id);
  }

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
        url: BaseAPI.customersPath,
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
      "country_id": countryId,
      "state_id": stateId,
      "city_id": cityId,
    });

    try {
      final response = await NetworkHelper.postRequest(
        url: BaseAPI.customersPath,
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

  // Future<dynamic> getCustomerDetails(String id) async {}
}
