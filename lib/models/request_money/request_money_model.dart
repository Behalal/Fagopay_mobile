// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    required this.data,
    required this.message,
  });

  Data data;
  String message;

  factory User.fromJson(Map<String, dynamic> json) => User(
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
    required this.myRequest,
  });

  List<MyRequest> myRequest;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        myRequest: List<MyRequest>.from(
            json["my_request"].map((x) => MyRequest.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "my_request": List<dynamic>.from(myRequest.map((x) => x.toJson())),
      };
}

class MyRequest {
  MyRequest({
    this.id,
    this.requestedby,
    this.requestedfrom,
    this.description,
    this.comment,
    this.status,
    this.requestedAmount,
    this.amountApproved,
    this.reference,
    this.createdAt,
    this.requestedbyname,
    this.requestedfromname,
  });

  String? id;
  String? requestedby;
  String? requestedfrom;
  String? description;
  dynamic comment;
  String? status;
  String? requestedAmount;
  String? amountApproved;
  String? reference;
  DateTime? createdAt;
  String? requestedbyname;
  String? requestedfromname;

  factory MyRequest.fromJson(Map<String, dynamic> json) => MyRequest(
        id: json["id"] ?? '',
        requestedby: json["requestedby"] ?? '',
        requestedfrom: json["requestedfrom"] ?? '',
        description: json["description"] ?? '',
        comment: json["comment"] ?? '',
        status: json["status"] ?? '',
        requestedAmount: json["requested_amount"] ?? '',
        amountApproved: json["amount_approved"] ?? '',
        reference: json["reference"] ?? '',
        createdAt: DateTime.parse(json["created_at"] ?? ''),
        requestedbyname: json["requestedbyname"] ?? '',
        requestedfromname: json["requestedfromname"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "requestedby": requestedby,
        "requestedfrom": requestedfrom,
        "description": description,
        "comment": comment,
        "status": status,
        "requested_amount": requestedAmount,
        "amount_approved": amountApproved,
        "reference": reference,
        "created_at": createdAt!.toIso8601String(),
        "requestedbyname": requestedbyname,
        "requestedfromname": requestedfromname,
      };
}
