class VerifyElectricity {
  Data? data;

  VerifyElectricity({this.data});

  VerifyElectricity.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<String>? error;
  String? message;
  int? code;

  Data({this.error, this.message, this.code});

  Data.fromJson(Map<String, dynamic> json) {
    error = json['error'].cast<String>();
    message = json['message'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['error'] = error;
    data['message'] = message;
    data['code'] = code;
    return data;
  }
}
