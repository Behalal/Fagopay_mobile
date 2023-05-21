import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';

import '../models/company_model.dart';
import '../service/constants/constants.dart';
import '../service/networking/network_helper.dart';
import '../service/secure_storage/secure_storage.dart';
import 'package:get/get.dart';

class CompanyController extends GetxController {
  final companyNameController = TextEditingController();
  final rcNumberController = TextEditingController();

  final Rx<Company?> _company = Rx(null);

  Company? get company => _company.value;

  set setCompany(Company company) {
    _company(company);
  }

  Future<dynamic> getCompany() async {
    final token = await SecureStorage.readUserToken();
    try {
      final responseData = await NetworkHelper.getRequest(
        url: BaseAPI.companyPath,
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

  Future<dynamic> createCompany(String companyName, String companyType,
      String rcNumber, String docUrl) async {
    final token = await SecureStorage.readUserToken();

    var requestBody = jsonEncode({
      "company_name": "Schneider and sons",
      "type": "RC|BN|IT|LL|LLP",
      "rc_number": "RC123456",
      "document_url": "upload_url"
    });

    try {
      final responseData = await NetworkHelper.postRequest(
        url: BaseAPI.companyPath,
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
}
