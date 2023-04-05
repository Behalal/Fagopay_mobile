import 'dart:convert';
import 'dart:developer';

class DataDetails {
  String variationCode;
  String name;
  String variationAmount;

  DataDetails({required this.variationCode, required this.name, required this.variationAmount});

  static DataDetails fromJson(json) => DataDetails(
        variationCode: json['variation_code'] as String,
        name: json['name'] as String,
        variationAmount: json['variation_amount'] as String,
      );
}

class Data {
  int? code;
  String? message;
  List<DataDetails>? dataValues;

  Data({
    required this.code,
    this.dataValues,
    this.message,
  });

  factory Data.fromReqBody(String body) {
    Map<String, dynamic> json = jsonDecode(body);

    var bodyData =
        (json['body']['data'] != null) ? json['body']['data']['variation'] : [];

    final List<DataDetails> bankList = [];
    for (var i = 0; i < bodyData.length; i++) {
      DataDetails eachbank = DataDetails.fromJson(jsonEncode(bodyData![i]));
      bankList.add(eachbank);
    }

    var message = json['body']['message'];
    return Data(
        code: json['status_code'],
        dataValues: (bodyData != null) ? bankList : [],
        message: (message != null) ? message : null);
  }

  void printAttributes() {
    log("code: $code\n");
    log("banks: ${dataValues![0].name}\n");
  }
}
