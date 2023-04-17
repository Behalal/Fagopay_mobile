// To parse this JSON data, do
//
//     final lookUpPhone = lookUpPhoneFromJson(jsonString);

import 'dart:convert';

LookUpPhone lookUpPhoneFromJson(String str) => LookUpPhone.fromJson(json.decode(str));

String lookUpPhoneToJson(LookUpPhone data) => json.encode(data.toJson());

class LookUpPhone {
    LookUpPhone({
        required this.data,
        required this.message,
    });

    Data data;
    String message;

    factory LookUpPhone.fromJson(Map<String, dynamic> json) => LookUpPhone(
        data: Data.fromJson(json["data"]),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "message": message,
    };
}

class Data {
    Data({
        required this.accountDetail,
    });

    LookUpPhoneNumber accountDetail;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        accountDetail: LookUpPhoneNumber.fromJson(json["account_detail"]),
    );

    Map<String, dynamic> toJson() => {
        "account_detail": accountDetail.toJson(),
    };
}

class LookUpPhoneNumber {
    LookUpPhoneNumber({
        required this.userId,
        required this.accountNumber,
        required this.accountName,
        required this.bankName,
        required this.reference,
        required this.accountType,
        required this.status,
        required this.currency,
    });

    String userId;
    String accountNumber;
    String accountName;
    String bankName;
    String reference;
    String accountType;
    String status;
    String currency;

    factory LookUpPhoneNumber.fromJson(Map<String, dynamic> json) => LookUpPhoneNumber(
        userId: json["user_id"],
        accountNumber: json["account_number"],
        accountName: json["account_name"],
        bankName: json["bank_name"],
        reference: json["reference"],
        accountType: json["account_type"],
        status: json["status"],
        currency: json["currency"],
    );

    Map<String, dynamic> toJson() => {
        "user_id": userId,
        "account_number": accountNumber,
        "account_name": accountName,
        "bank_name": bankName,
        "reference": reference,
        "account_type": accountType,
        "status": status,
        "currency": currency,
    };
}
