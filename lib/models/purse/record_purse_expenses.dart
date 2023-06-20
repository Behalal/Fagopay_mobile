// To parse this JSON data, do
//
//     final recordPurseExpensesResponse = recordPurseExpensesResponseFromJson(jsonString);

import 'dart:convert';

RecordPurseExpensesResponse recordPurseExpensesResponseFromJson(String str) => RecordPurseExpensesResponse.fromJson(json.decode(str));

String recordPurseExpensesResponseToJson(RecordPurseExpensesResponse data) => json.encode(data.toJson());

class RecordPurseExpensesResponse {
  Data? data;

  RecordPurseExpensesResponse({
    this.data,
  });

  factory RecordPurseExpensesResponse.fromJson(Map<String, dynamic> json) => RecordPurseExpensesResponse(
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
  };
}

class Data {
  String? message;
  int? code;

  Data({
    this.message,
    this.code,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    message: json["message"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "code": code,
  };
}
