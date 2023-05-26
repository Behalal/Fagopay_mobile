// To parse this JSON data, do
//
//     final initiateSwap = initiateSwapFromJson(jsonString);

import 'dart:convert';

InitiateSwap initiateSwapFromJson(String str) =>
    InitiateSwap.fromJson(json.decode(str));

String initiateSwapToJson(InitiateSwap data) => json.encode(data.toJson());

class InitiateSwap {
  Data data;
  String message;

  InitiateSwap({
    required this.data,
    required this.message,
  });

  factory InitiateSwap.fromJson(Map<String, dynamic> json) => InitiateSwap(
        data: Data.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "message": message,
      };
}

class Data {
  SwappingDetailModel swappingDetail;
  UserDetail userDetail;

  Data({
    required this.swappingDetail,
    required this.userDetail,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        swappingDetail: SwappingDetailModel.fromJson(json["swapping_detail"]),
        userDetail: UserDetail.fromJson(json["user_detail"]),
      );

  Map<String, dynamic> toJson() => {
        "swapping_detail": swappingDetail.toJson(),
        "user_detail": userDetail.toJson(),
      };
}

class SwappingDetailModel {
  String? phoneNumber;
  String? confirm_phone_number;
  String? network;
  String? amount;
  String? fee;
  String? airtimeValue;
  String? userId;

  SwappingDetailModel(
      {this.phoneNumber,
      this.network,
      this.amount,
      this.fee,
      this.airtimeValue,
      this.userId,
      this.confirm_phone_number});

  factory SwappingDetailModel.fromJson(Map<String, dynamic> json) =>
      SwappingDetailModel(
        phoneNumber: json["phone_number"] ?? '',
        network: json["network"] ?? '',
        amount: json["amount"] ?? '',
        fee: json["fee"] ?? '',
        airtimeValue: json["airtime_value"] ?? '',
        userId: json["user_id"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "phone_number": phoneNumber,
        "confirm_phone_number": confirm_phone_number,
        "network": network,
        "amount": amount,
        "fee": fee,
        "airtime_value": airtimeValue,
        "user_id": userId,
      };
}

class UserDetail {
  String fullname;
  String email;

  UserDetail({
    required this.fullname,
    required this.email,
  });

  factory UserDetail.fromJson(Map<String, dynamic> json) => UserDetail(
        fullname: json["fullname"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "fullname": fullname,
        "email": email,
      };
}
