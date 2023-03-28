import 'dart:convert';
import 'dart:developer';

import 'package:fagopay/functions/functions.dart';
import 'package:fagopay/service/constants/constants.dart';
import 'package:fagopay/service/secure_storage/secure_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class BillService extends BaseAPI {
  Functions function = Functions();
  SecureStorage storage = SecureStorage();

  Future<String> buyAirtime(String phone, String serviceID, String amount,
      String transactionPin) async {
    var token = await storage.tokenRead();

    var body = jsonEncode({
      "phone": phone,
      "serviceID": serviceID,
      "amount": amount,
      "transaction_pin": transactionPin
    });

    http.Response response =
        await http.post(Uri.parse("${super.billPath}airtime-purchase"),
            headers: {
              "Content-Type": "application/json; charset=UTF-8",
              "Authorization": "Bearer $token"
            },
            body: body);

    log("${super.billPath}airtime-purchase");
    log(response.statusCode.toString());

    var responseBody = jsonEncode({
      'status_code': response.statusCode,
      'body': jsonDecode(response.body)
    });

    return responseBody;
  }

  Future<String> getDataCodesByServiceId(String serviceid) async {
    var token = await storage.tokenRead();

    http.Response response = await http.get(
      Uri.parse("${super.billPath}data-variation-list/$serviceid"),
      headers: {
        "Content-Type": "application/json; charset=UTF-8",
        "Authorization": "Bearer $token"
      },
    );

    log("${super.billPath}airtime-purchase");
    log(response.statusCode.toString());

    var responseBody = jsonEncode({
      'status_code': response.statusCode,
      'body': jsonDecode(response.body)
    });

    return responseBody;
  }

  Future<String> buyData(String phone, String serviceID, String variationCode,
      String billerCode, String amount, String transactionPin) async {
    var token = await storage.tokenRead();

    amount = double.parse(amount).toInt().toString();

    var body = jsonEncode({
      "phone": phone,
      "serviceID": serviceID,
      "amount": amount,
      "variation_code": variationCode,
      "billersCode": billerCode,
      "transaction_pin": transactionPin
    });

    http.Response response =
        await http.post(Uri.parse("${super.billPath}purchase-data-bundle"),
            headers: {
              "Content-Type": "application/json; charset=UTF-8",
              "Authorization": "Bearer $token"
            },
            body: body);

    log(response.statusCode.toString(), time: DateTime.now());

    var responseBody = jsonEncode({
      'status_code': response.statusCode,
      'body': jsonDecode(response.body)
    });

    return responseBody;
  }

  Future<String> verifyInternrtNo(String billerNo) async {
    var token = await storage.tokenRead();

    var body = jsonEncode({
      "billersCode": billerNo,
    });

    http.Response response =
        await http.post(Uri.parse("${super.billPath}verify-smile-number"),
            headers: {
              "Content-Type": "application/json; charset=UTF-8",
              "Authorization": "Bearer $token"
            },
            body: body);

    log(response.statusCode.toString());

    var responseBody = jsonEncode({
      'status_code': response.statusCode,
      'body': jsonDecode(response.body)
    });

    return responseBody;
  }

  Future<String> buyInternet(
      String phone,
      String serviceID,
      String variationCode,
      String billerCode,
      String amount,
      String transactionPin) async {
    var token = await storage.tokenRead();

    var body = jsonEncode({
      "phone": phone,
      "serviceID": serviceID,
      "amount": double.parse(amount).toInt(),
      "variation_code": variationCode,
      "billersCode": billerCode,
      "transaction_pin": transactionPin
    });

    http.Response response =
        await http.post(Uri.parse("${super.billPath}internet-subscription"),
            headers: {
              "Content-Type": "application/json; charset=UTF-8",
              "Authorization": "Bearer $token"
            },
            body: body);

    log(response.statusCode.toString());

    var responseBody = jsonEncode({
      'status_code': response.statusCode,
      'body': jsonDecode(response.body)
    });

    return responseBody;
  }

  Future<String> verifyMeterNo(
      String serviceID, String billersCode, String type) async {
    var token = await storage.tokenRead();

    var body = jsonEncode(
        {"serviceID": serviceID, "billersCode": billersCode, "type": type});

    http.Response response =
        await http.post(Uri.parse("${super.billPath}verify-meter-number"),
            headers: {
              "Content-Type": "application/json; charset=UTF-8",
              "Authorization": "Bearer $token"
            },
            body: body);

    log(response.statusCode.toString());

    var responseBody = jsonEncode({
      'status_code': response.statusCode,
      'body': jsonDecode(response.body)
    });

    return responseBody;
  }

  Future<String> buyElectricity(
      String phone,
      String serviceID,
      String variationCode,
      String billerCode,
      String amount,
      String transactionPin) async {
    var token = await storage.tokenRead();

    var body = jsonEncode({
      "phone": phone,
      "serviceID": serviceID,
      "amount": amount,
      "variation_code": variationCode,
      "billersCode": billerCode,
      "transaction_pin": transactionPin
    });

    http.Response response =
        await http.post(Uri.parse("${super.billPath}electricity-purchase"),
            headers: {
              "Content-Type": "application/json; charset=UTF-8",
              "Authorization": "Bearer $token"
            },
            body: body);

    log(response.statusCode.toString());

    var responseBody = jsonEncode({
      'status_code': response.statusCode,
      'body': jsonDecode(response.body)
    });

    return responseBody;
  }

  Future<String> verifySmartCard(String billersCode, String serviceID) async {
    var token = await storage.tokenRead();

    var body = jsonEncode({"billersCode": billersCode, "serviceID": serviceID});

    http.Response response =
        await http.post(Uri.parse("${super.billPath}verify-smart-card-number"),
            headers: {
              "Content-Type": "application/json; charset=UTF-8",
              "Authorization": "Bearer $token"
            },
            body: body);

    log(response.statusCode.toString());

    var responseBody = jsonEncode({
      'status_code': response.statusCode,
      'body': jsonDecode(response.body)
    });

    return responseBody;
  }

  Future<String> cableSubscription(
      String phone,
      String serviceID,
      String variationCode,
      String billerCode,
      String amount,
      String transactionPin) async {
    var token = await storage.tokenRead();

    var body = jsonEncode({
      "phone": phone,
      "serviceID": serviceID,
      "amount": amount,
      "variation_code": variationCode,
      "billersCode": billerCode,
      "transaction_pin": transactionPin
    });

    http.Response response =
        await http.post(Uri.parse("${super.billPath}tv-suv"),
            headers: {
              "Content-Type": "application/json; charset=UTF-8",
              "Authorization": "Bearer $token"
            },
            body: body);

    log(response.statusCode.toString());

    var responseBody = jsonEncode({
      'status_code': response.statusCode,
      'body': jsonDecode(response.body)
    });

    return responseBody;
  }
}

final billServiceProvider = Provider<BillService>((ref) => BillService());
