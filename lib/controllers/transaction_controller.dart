import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../service/constants/constants.dart';
import '../service/networking/network_helper.dart';
import '../service/secure_storage/secure_storage.dart';

class TransactionController extends GetxController {
  TextEditingController accountNumberController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  Future<dynamic> getAllBanks() async {
    final token = await SecureStorage.readUserToken();
    try {
      final responseData = await NetworkHelper.getRequest(
        url: "${BaseAPI.transactionsPath}banklist",
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
          "Authorization": "Bearer $token"
        },
      );
      return responseData;
    } catch (e) {
      log(e.toString());
      throw Exception('Error fetching banks');
    }
  }

  Future<dynamic> getBankDetails(String bankCode, String accountNo) async {
    final token = await SecureStorage.readUserToken();
    var requestBody = jsonEncode({
      "account_number": accountNo,
      "account_bank": bankCode,
    });

    try {
      final responseData = await NetworkHelper.postRequest(
        url: "${BaseAPI.transactionsPath}resolve-bank",
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

  Future<dynamic> fundWallet(String amount) async {
    final token = await SecureStorage.readUserToken();
    var requestBody = jsonEncode({
      "topup_amount": amount,
    });

    try {
      final responseData = await NetworkHelper.postRequest(
        url: "${BaseAPI.transactionsPath}fund-wallet",
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
