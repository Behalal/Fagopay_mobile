class VerifyAccountNo {
  int? statusCode;
  Body? body;

  VerifyAccountNo({this.statusCode, this.body});

  VerifyAccountNo.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    body = json['body'] != null ? Body.fromJson(json['body']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status_code'] = statusCode;
    if (body != null) {
      data['body'] = body!.toJson();
    }
    return data;
  }
}

class Body {
  Data? data;
  String? message;

  Body({this.data, this.message});

  Body.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    return data;
  }
}

class Data {
  String? accountName;
  String? accountNumber;
  List<String>? error;
  int? code;

  Data({this.accountName, this.accountNumber, this.error, this.code});

  Data.fromJson(Map<String, dynamic> json) {
    accountName = json['account_name'];
    accountNumber = json['account_number'];
    error = json['error'].cast<String>();
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['account_name'] = accountName;
    data['account_number'] = accountNumber;
    data['error'] = error;
    data['code'] = code;
    return data;
  }
}
