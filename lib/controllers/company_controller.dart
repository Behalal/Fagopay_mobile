import 'dart:convert';
import 'dart:developer';

import 'package:fagopay/models/user_model/user.dart';
import 'package:flutter/material.dart';

import '../models/company_model.dart';
import '../service/constants/constants.dart';
import '../service/networking/network_helper.dart';
import '../service/secure_storage/secure_storage.dart';
import 'package:get/get.dart';

class CompanyController extends GetxController {
  final companyNameController = TextEditingController();
  final rcNumberController = TextEditingController();

  final Rx<List<Profile>> _companies = Rx([]);

  List<Profile> get companies {
    return [..._companies.value];
  }

  set companies(List<Profile> companies) {
    _companies(companies);
  }

  Profile findCompanyById(String id) {
    return companies.firstWhere((company) => company.id == id);
  }

  final Rx<Profile?> _company = Rx(null);

  Profile? get company => _company.value;

  set setCompany(Profile company) {
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
      "company_name": companyName,
      "type": companyType,
      "rc_number": rcNumber,
      "document_url": docUrl
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
