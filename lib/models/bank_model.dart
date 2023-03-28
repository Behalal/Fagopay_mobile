import 'dart:convert';
import 'dart:developer';

class BankDetails {
  String bankCode;
  String bankName;

  BankDetails({required this.bankCode, required this.bankName});

  factory BankDetails.fromReqBody(String body) {
    Map<String, dynamic> json = jsonDecode(body);

    var code = json['code'];
    var name = json['name'];
    return BankDetails(bankCode: code, bankName: name);
  }
}

class Banks {
  int? code;
  String? message;
  List<BankDetails>? banks;

  Banks({
    required this.code,
    this.banks,
    this.message,
  });

  factory Banks.fromReqBody(String body) {
    Map<String, dynamic> json = jsonDecode(body);

    var bodyData = json['body']['data'];

    final List<BankDetails> bankList = [];
    for (var i = 0; i < bodyData!.length; i++) {
      BankDetails eachbank = BankDetails.fromReqBody(jsonEncode(bodyData![i]));
      bankList.add(eachbank);
    }

    var message = json['body']['message'];
    return Banks(
        code: json['status_code'],
        banks: (bodyData != null) ? bankList : [],
        message: (message != null) ? message : null);
  }

  void printAttributes() {
    log("code: $code\n");
    log("banks: ${banks![0].bankName}\n");
  }
}
