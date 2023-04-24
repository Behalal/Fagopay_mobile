// To parse this JSON data, do
//
//     final nextOfKin = nextOfKinFromJson(jsonString);

import 'dart:convert';

NextOfKin nextOfKinFromJson(String str) => NextOfKin.fromJson(json.decode(str));

String nextOfKinToJson(NextOfKin data) => json.encode(data.toJson());

class NextOfKin {
    NextOfKin({
        required this.data,
        required this.message,
    });

    NextOfKinModel data;
    String message;

    factory NextOfKin.fromJson(Map<String, dynamic> json) => NextOfKin(
        data: NextOfKinModel.fromJson(json["data"]),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "message": message,
    };
}

class NextOfKinModel {
    NextOfKinModel({
         this.id,
         this.userId,
         this.fullName,
         this.bussinessId,
         this.email,
         this.phoneNumber,
         this.houseAddress,
         this.relationship,
    });

    String? id;
    String? userId;
    String? fullName;
    String? bussinessId;
    String? email;
    String? phoneNumber;
    String? houseAddress;
    String? relationship;

    factory NextOfKinModel.fromJson(Map<String, dynamic> json) => NextOfKinModel(
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
