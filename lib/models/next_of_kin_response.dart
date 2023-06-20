// To parse this JSON data, do
//
//     final nextOfKinResponse = nextOfKinResponseFromJson(jsonString);

import 'dart:convert';

NextOfKinResponse nextOfKinResponseFromJson(String str) => NextOfKinResponse.fromJson(json.decode(str));

String nextOfKinResponseToJson(NextOfKinResponse data) => json.encode(data.toJson());

class NextOfKinResponse {
  Data? data;
  String? message;

  NextOfKinResponse({
    this.data,
    this.message,
  });

  factory NextOfKinResponse.fromJson(Map<String, dynamic> json) => NextOfKinResponse(
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
    "message": message,
  };
}

class Data {
  String? id;
  String? userId;
  String? fullName;
  String? bussinessId;
  String? email;
  String? phoneNumber;
  String? houseAddress;
  String? relationship;

  Data({
    this.id,
    this.userId,
    this.fullName,
    this.bussinessId,
    this.email,
    this.phoneNumber,
    this.houseAddress,
    this.relationship,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    userId: json["user_id"],
    fullName: json["full_name"],
    bussinessId: json["bussiness_id"],
    email: json["email"],
    phoneNumber: json["phone_number"],
    houseAddress: json["house_address"],
    relationship: json["relationship"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "full_name": fullName,
    "bussiness_id": bussinessId,
    "email": email,
    "phone_number": phoneNumber,
    "house_address": houseAddress,
    "relationship": relationship,
  };
}
