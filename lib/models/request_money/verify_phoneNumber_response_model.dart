

class VerifyPhoneNumberResponse {
  Data? data;
  String? message;

  VerifyPhoneNumberResponse({
    this.data,
    this.message,
  });

  factory VerifyPhoneNumberResponse.fromJson(Map<String, dynamic> json) => VerifyPhoneNumberResponse(
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
    "message": message,
  };
}

class Data {
  AccountDetail? accountDetail;

  Data({
    this.accountDetail,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    accountDetail: json["account_detail"] == null ? null : AccountDetail.fromJson(json["account_detail"]),
  );

  Map<String, dynamic> toJson() => {
    "account_detail": accountDetail?.toJson(),
  };
}

class AccountDetail {
  String? userId;
  String? accountNumber;
  String? accountName;
  String? bankName;
  String? accountType;
  String? currency;

  AccountDetail({
    this.userId,
    this.accountNumber,
    this.accountName,
    this.bankName,
    this.accountType,
    this.currency,
  });

  factory AccountDetail.fromJson(Map<String, dynamic> json) => AccountDetail(
    userId: json["user_id"],
    accountNumber: json["account_number"],
    accountName: json["account_name"],
    bankName: json["bank_name"],
    accountType: json["account_type"],
    currency: json["currency"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "account_number": accountNumber,
    "account_name": accountName,
    "bank_name": bankName,
    "account_type": accountType,
    "currency": currency,
  };
}
