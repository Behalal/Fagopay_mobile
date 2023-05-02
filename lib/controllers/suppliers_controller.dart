import 'dart:convert';
import 'dart:developer';

import '../models/supplier_model.dart';
import '../service/constants/constants.dart';
import '../service/networking/network_helper.dart';
import '../service/secure_storage/secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SupplierController extends GetxController {
  bool isLoading = false;
  final Rx<List<Supplier>> _suppliers = Rx([]);

  List<Supplier> get suppliers {
    return [..._suppliers.value];
  }

  set suppliers(List<Supplier> suppliers) {
    _suppliers(suppliers);
  }

  Supplier findSupplierById(String id) {
    return suppliers.firstWhere((supplier) => supplier.id == id);
  }

  final accountNumberController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final addressController = TextEditingController();

  Future<dynamic> getSuppliers() async {
    final token = await SecureStorage.readUserToken();
    try {
      final responseData = await NetworkHelper.getRequest(
        url: BaseAPI.suppliersPath,
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

    Future<dynamic> createNewSupplier(
      {required String bankCode,
      required String accountNumber,
      required String accountName,
      required String email,
      required String phone,
      required String address,
      required String countryId,
      required String stateId,
      required String cityId}) async {
    final token = await SecureStorage.readUserToken();

    var requestBody = jsonEncode({
  "bank_code": bankCode,
  "account_number": accountNumber,
  "account_name": accountName,
  "name": accountName,
  "email": email,
  "phone": phone,
  "address": address,
  "country_id": countryId,
  "state_id": stateId,
  "city_id": cityId
    });

    try {
      final response = await NetworkHelper.postRequest(
        url: BaseAPI.suppliersPath,
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
