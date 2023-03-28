import 'dart:convert';
import 'dart:developer';

class DataDetails {
  String variationCode;
  String name;
  String variationAmount;

  DataDetails(
      {required this.variationCode,
      required this.name,
      required this.variationAmount});

  factory DataDetails.fromReqBody(String body) {
    Map<String, dynamic> json = jsonDecode(body);

    var code = json['variation_code'];
    var name = json['name'];
    var amount = json['variation_amount'];
    return DataDetails(
        variationCode: code, name: name, variationAmount: amount);
  }
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
      DataDetails eachbank = DataDetails.fromReqBody(jsonEncode(bodyData![i]));
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
