import 'dart:convert';
import 'dart:developer';

import '../service/constants/constants.dart';
import '../service/networking/network_helper.dart';
import '../service/secure_storage/secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GovernmentIdentityVerificationController extends GetxController {
  final documentNumberController = TextEditingController();
  final ninController = TextEditingController();
  final businessAddressController = TextEditingController();

  Future<dynamic> submitIdentityDetails(String countryId, String docType,
      String docNumber, String docUrl, String nin) async {
    final token = await SecureStorage.readUserToken();

    var requestBody = jsonEncode({
      "country_id": countryId,
      "document_type": docType,
      "document_number": docNumber,
      "document_url": docUrl,
      "number_nin": nin
    });

    try {
      final responseData = await NetworkHelper.postRequest(
        url: "${BaseAPI.verificationPath}government-identity",
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

  Future<dynamic> submitProofOfAddress(String utilityType, String imageUrl,
      String address, String cityId, String stateId) async {
    final token = await SecureStorage.readUserToken();

    var requestBody = jsonEncode({
  "utility_type": utilityType,
  "utility_url": imageUrl,
  "address": address,
  "city": cityId,
  "state": stateId
});

    try {
      final responseData = await NetworkHelper.postRequest(
        url: "${BaseAPI.verificationPath}utility-bill",
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
