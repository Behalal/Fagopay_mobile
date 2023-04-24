import 'dart:convert';
import 'dart:developer';

import 'package:fagopay/models/transaction.dart/transaction_history_model.dart';
import 'package:fagopay/screens/individual/transactions/transaction_history.dart';
import 'package:flutter/foundation.dart';

import '../screens/individual/bills/models/transaction_post_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../service/constants/constants.dart';
import '../service/networking/network_helper.dart';
import '../service/secure_storage/secure_storage.dart';
import 'package:http/http.dart' as http;

enum TransactionHistoryStatus {
  empty,
  loading,
  error,
  success,
  available,
}

class TransactionController extends GetxController {
  final Rx<List<TransactionHistoryModel>> _transactionHistoryList = Rx([]);
  List<TransactionHistoryModel> get transactionHistoryList =>
      _transactionHistoryList.value;

  final _transactionHistoryStatus = TransactionHistoryStatus.empty.obs;
  TransactionHistoryStatus get transactionHistoryStatus =>
      _transactionHistoryStatus.value;

  TextEditingController accountNumberController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController dexcriptionController = TextEditingController();

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

  Future<dynamic> requestMoney(
      String phoneNumber, String amount, String needDescription) async {
    final token = await SecureStorage.readUserToken();
    var requestBody = jsonEncode({
      "phone_number": phoneNumber,
      "amount": amount,
      "description": needDescription,
    });
    try {
      final responseData = await NetworkHelper.postRequest(
        url: "${BaseAPI.transactionsPath}request-money",
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

  Future<dynamic> bankTransfer(String transactionPin) async {
    final token = await SecureStorage.readUserToken();

    String accountNumber = bankTransferFields.accountNumber;
    String accountBank = bankTransferFields.bankId;
    String amount = bankTransferFields.amount;
    String description = bankTransferFields.narration;

    var requestBody = jsonEncode({
      "account_number": accountNumber,
      "account_bank": accountBank,
      "amount": amount,
      "description": description,
      "transaction_pin": transactionPin
    });
    try {
      final responseData = await NetworkHelper.postRequest(
        url: "${BaseAPI.transactionsPath}bank-transfer",
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

  Future<dynamic> fagoToFagoTransfer(String transactionPin) async {
    final token = await SecureStorage.readUserToken();

    String phoneNumber = bankTransferFields.phoneNumber;
    String amount = bankTransferFields.amount;
    String description = bankTransferFields.narration;

    var requestBody = jsonEncode({
      "phonenumber": phoneNumber,
      "amount": amount,
      "description": description,
      "transaction_pin": transactionPin
    });

    try {
      final responseData = await NetworkHelper.postRequest(
        url: "${BaseAPI.transactionsPath}fago-to-fago",
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

  Future getTransactionHistory() async {
    final token = await SecureStorage.readUserToken();
    try {
      _transactionHistoryStatus(TransactionHistoryStatus.loading);
      if (kDebugMode) {
        print('getting my request...');
      }
      var response = await http.get(
        Uri.parse(BaseAPI.transactionHistory),
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
        var list = List.from(json['data']['transactions']);
        var transactionList =
            list.map((e) => TransactionHistoryModel.fromJson(e)).toList();
        if (kDebugMode) {
          print("${transactionList.length} request");
          print(" Req ${transactionList.first} request");
        }
        _transactionHistoryList(transactionList);
        transactionList.isNotEmpty
            ? _transactionHistoryStatus(TransactionHistoryStatus.available)
            : _transactionHistoryStatus(TransactionHistoryStatus.empty);
        _transactionHistoryStatus(TransactionHistoryStatus.success);
      } else if (response.statusCode == 409) {
        Get.snackbar('Error',
            'Go and verify your KYC in other to be able to perform transactions');
        _transactionHistoryStatus(TransactionHistoryStatus.error);
      }
      return response.body;
    } catch (error) {
      _transactionHistoryStatus(TransactionHistoryStatus.error);
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
}
