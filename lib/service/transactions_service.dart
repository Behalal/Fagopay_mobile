import 'dart:convert';

import 'package:fagopay/functions/functions.dart';
import 'package:fagopay/service/constants/constants.dart';
import 'package:fagopay/service/secure_storage/secure_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class TransactionService extends BaseAPI {
  Functions function = Functions();
  SecureStorage storage = SecureStorage();

  Future<String> getAllBanks() async {
    var token = await storage.tokenRead();

    http.Response response = await http.get(
      Uri.parse("${super.transactionsPath}banklist"),
      headers: {
        "Content-Type": "application/json; charset=UTF-8",
        "Authorization": "Bearer $token"
      },
    );

    var responseBody = jsonEncode({
      'status_code': response.statusCode,
      'body': jsonDecode(response.body)
    });

    return responseBody;
  }

  Future<Map<String, dynamic>> getAccountDetails(
      String bankcode, String accountNo) async {
    var token = await storage.tokenRead();

    var body = jsonEncode({
      "account_number": accountNo,
      "account_bank": bankcode,
    });

    http.Response response =
        await http.post(Uri.parse("${super.transactionsPath}resolve-bank"),
            headers: {
              "Content-Type": "application/json; charset=UTF-8",
              "Authorization": "Bearer $token"
            },
            body: body);

    var responseBody = jsonEncode({
      'status_code': response.statusCode,
      'body': jsonDecode(response.body)
    });

    return jsonDecode(responseBody);
  }

  Future<String> getFagoDetails() async {
    var token = await storage.tokenRead();

    http.Response response = await http.get(
      Uri.parse("${super.transactionsPath}banklist"),
      headers: {
        "Content-Type": "application/json; charset=UTF-8",
        "Authorization": "Bearer $token"
      },
    );

    var responseBody = jsonEncode({
      'status_code': response.statusCode,
      'body': jsonDecode(response.body)
    });

    return responseBody;
  }

  Future<String> sendMoneyToBank(
    String accountNumber,
    String accountBank,
    String amount,
    String description,
    String transactionPin,
  ) async {
    var token = await storage.tokenRead();

    var body = jsonEncode({
      "account_number": accountNumber,
      "account_bank": accountBank,
      "amount": amount,
      "description": description,
      "transaction_pin": transactionPin
    });

    http.Response response =
        await http.post(Uri.parse("${super.transactionsPath}banklist"),
            headers: {
              "Content-Type": "application/json; charset=UTF-8",
              "Authorization": "Bearer $token"
            },
            body: body);

    var responseBody = jsonEncode({
      'status_code': response.statusCode,
      'body': jsonDecode(response.body)
    });

    return responseBody;
  }

  Future<String> fundWallet() async {
    var token = await storage.tokenRead();

    http.Response response = await http.get(
      Uri.parse("${super.transactionsPath}banklist"),
      headers: {
        "Content-Type": "application/json; charset=UTF-8",
        "Authorization": "Bearer $token"
      },
    );

    var responseBody = jsonEncode({
      'status_code': response.statusCode,
      'body': jsonDecode(response.body)
    });

    return responseBody;
  }
}

final transactionServiceProvider =
    Provider<TransactionService>((ref) => TransactionService());
