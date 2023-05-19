// To parse this JSON data, do
//
//     final refaralEarning = refaralEarningFromJson(jsonString);

import 'dart:convert';

RefaralEarningModel refaralEarningFromJson(String str) =>
    RefaralEarningModel.fromJson(json.decode(str));

String refaralEarningToJson(RefaralEarningModel data) =>
    json.encode(data.toJson());

class RefaralEarningModel {
  RefaralEarningData data;

  RefaralEarningModel({
    required this.data,
  });

  factory RefaralEarningModel.fromJson(Map<String, dynamic> json) =>
      RefaralEarningModel(
        data: RefaralEarningData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class RefaralEarningData {
  int? referalJoin;
  int? completedReferal;
  int? totalEarned;
  List<dynamic>? referals;

  RefaralEarningData({
     this.referalJoin,
     this.completedReferal,
     this.totalEarned,
     this.referals,
  });

  factory RefaralEarningData.fromJson(Map<String, dynamic> json) =>
      RefaralEarningData(
        referalJoin: json["referal_join"] ?? '',
        completedReferal: json["completed_referal"] ?? '',
        totalEarned: json["total_earned"] ?? '',
        referals: List<dynamic>.from(json["referals"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "referal_join": referalJoin,
        "completed_referal": completedReferal,
        "total_earned": totalEarned,
        "referals": List<dynamic>.from(referals!.map((x) => x)),
      };
}
