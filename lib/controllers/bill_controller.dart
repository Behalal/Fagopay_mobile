import 'dart:convert';
import 'dart:developer';

import 'package:fagopay/screens/individual/bills/models/bill_post_model.dart';
import 'package:fagopay/service/constants/constants.dart';
import 'package:fagopay/service/networking/network_helper.dart';
import 'package:fagopay/service/secure_storage/secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BillController extends GetxController {
  TextEditingController phoneController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController meterNoController = TextEditingController();

  Future<dynamic> getDatabyServiceId(String serviceID) async {
    final token = await SecureStorage.readUserToken();
    try {
      final responseData = await NetworkHelper.getRequest(
        url: "${BaseAPI.billPath}data-variation-list/$serviceID",
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
          "Authorization": "Bearer $token"
        },
      );
      return responseData;
    } catch (e) {
      log(e.toString());
      throw Exception('Error fetching user details');
    }
  }

  Future<dynamic> buyAirtime(String transactionPin) async {
    final token = await SecureStorage.readUserToken();
    String amount = buyAirtimeFields.amount;
    String serviceId = buyAirtimeFields.serviceid;
    String phone = buyAirtimeFields.getphone;

    var requestBody = jsonEncode({
      "phone": phone,
      "serviceID": serviceId,
      "amount": amount,
      "transaction_pin": transactionPin
    });

    try {
      final responseData = await NetworkHelper.postRequest(
        url: "${BaseAPI.billPath}airtime-purchase",
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

  Future<dynamic> buyData(String transactionPin) async {
    final token = await SecureStorage.readUserToken();
    String amount = buyDataFields.amount;
    String serviceId = buyDataFields.serviceid;
    String phone = buyDataFields.getphone;
    String billerCode = buyDataFields.billersCode;
    String variationCode = buyDataFields.variationCode;

    var requestBody = jsonEncode({
      "phone": phone,
      "serviceID": serviceId,
      "amount": double.parse(amount).toInt().toString(),
      "variation_code": variationCode,
      "billersCode": billerCode,
      "transaction_pin": transactionPin
    });

    try {
      final responseData = await NetworkHelper.postRequest(
        url: "${BaseAPI.billPath}purchase-data-bundle",
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

  Future<dynamic> verifyMeterNo(
      String serviceID, String billersCode, String type) async {
    final token = await SecureStorage.readUserToken();

    var requestBody = jsonEncode(
        {"serviceID": serviceID, "billersCode": billersCode, "type": type});

    try {
      final responseData = await NetworkHelper.postRequest(
        url: "${BaseAPI.billPath}verify-meter-number",
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

  Future<dynamic> verifyRouter(String billersCode) async {
    final token = await SecureStorage.readUserToken();

    var requestBody = jsonEncode({
      "billersCode": billersCode,
    });

    try {
      final responseData = await NetworkHelper.postRequest(
        url: "${BaseAPI.billPath}verify-smile-number",
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

  Future<dynamic> buyElectricity(String transactionPin) async {
    final token = await SecureStorage.readUserToken();
    String amount = buyElectricityFields.amount;
    String serviceID = buyElectricityFields.serviceid;
    String phone = buyElectricityFields.getphone;
    String billerCode = buyElectricityFields.billersCode;
    String variationCode = buyElectricityFields.variationCode;

    var requestBody = jsonEncode({
      "phone": phone,
      "serviceID": serviceID,
      "amount": amount,
      "variation_code": variationCode,
      "billersCode": billerCode,
      "transaction_pin": transactionPin
    });

    try {
      final responseData = await NetworkHelper.postRequest(
        url: "${BaseAPI.billPath}electricity-purchase",
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

  Future<dynamic> buyInternet(String transactionPin) async {
    final token = await SecureStorage.readUserToken();
    String amount = buyInternetFields.amount;
    String serviceID = buyInternetFields.serviceid;
    String billerCode = buyInternetFields.billersCode;
    String variationCode = buyInternetFields.variationCode;

    var requestBody = jsonEncode({
      "serviceID": serviceID,
      "amount": double.parse(amount).toInt(),
      "variation_code": variationCode,
      "billersCode": billerCode,
      "transaction_pin": transactionPin
    });

    try {
      final responseData = await NetworkHelper.postRequest(
        url: "${BaseAPI.billPath}internet-subscription",
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

  Future<dynamic> verifySmartCardNumber(
      String billersCode, String serviceID) async {
    final token = await SecureStorage.readUserToken();

    var requestBody =
        jsonEncode({"billersCode": billersCode, "serviceID": serviceID});

    try {
      final responseData = await NetworkHelper.postRequest(
        url: "${BaseAPI.billPath}verify-smart-card-number",
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

  Future<dynamic> buyCableSubscription(String transactionPin) async {
    final token = await SecureStorage.readUserToken();
    String amount = buyTvCableFields.amount;
    String serviceID = buyTvCableFields.serviceid;
    String phone = buyTvCableFields.getphone;
    String billerCode = buyTvCableFields.billersCode;
    String variationCode = buyTvCableFields.variationCode;

    var requestBody = jsonEncode({
      "phone": phone,
      "serviceID": serviceID,
      "amount": double.parse(amount).toInt(),
      "variation_code": variationCode,
      "billersCode": billerCode,
      "transaction_pin": transactionPin
    });

    try {
      final responseData = await NetworkHelper.postRequest(
        url: "${BaseAPI.billPath}tv-subscription",
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
