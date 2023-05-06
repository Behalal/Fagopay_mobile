// To parse this JSON data, do
//
//     final showPurseModel = showPurseModelFromJson(jsonString);

import 'dart:convert';

ShowPurseModel showPurseModelFromJson(String str) =>
    ShowPurseModel.fromJson(json.decode(str));

String showPurseModelToJson(ShowPurseModel data) => json.encode(data.toJson());

class ShowPurseModel {
  Data data;
  String message;

  ShowPurseModel({
    required this.data,
    required this.message,
  });

  factory ShowPurseModel.fromJson(Map<String, dynamic> json) => ShowPurseModel(
        data: Data.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "message": message,
      };
}

class Data {
  PulseDetail pulseDetail;

  Data({
    required this.pulseDetail,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        pulseDetail: PulseDetail.fromJson(json["pulse_detail"]),
      );

  Map<String, dynamic> toJson() => {
        "pulse_detail": pulseDetail.toJson(),
      };
}

class PulseDetail {
  String id;
  String amount;
  String name;
  String duration;
  dynamic description;
  String userId;
  DateTime createdAt;
  DateTime updatedAt;
  List<PulseDurationModel> pulseCategories;

  PulseDetail({
    required this.id,
    required this.amount,
    required this.name,
    required this.duration,
    this.description,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    required this.pulseCategories,
  });

  factory PulseDetail.fromJson(Map<String, dynamic> json) => PulseDetail(
        id: json["id"] ?? '',
        amount: json["amount"] ?? '',
        name: json["name"] ?? '',
        duration: json["duration"] ?? '',
        description: json["description"] ?? '',
        userId: json["user_id"] ?? '',
        createdAt: DateTime.parse(json["created_at"] ?? ''),
        updatedAt: DateTime.parse(json["updated_at"] ?? ''),
        pulseCategories: List<PulseDurationModel>.from(json["pulse_categories"]
            .map((x) => PulseDurationModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "amount": amount,
        "name": name,
        "duration": duration,
        "description": description,
        "user_id": userId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "pulse_categories":
            List<dynamic>.from(pulseCategories.map((x) => x.toJson())),
      };
}

class PulseDurationModel {
  String id;
  String userId;
  String pulseId;
  String pulseCategoryId;
  String amount;
  DateTime createdAt;
  DateTime updatedAt;

  PulseDurationModel({
    required this.id,
    required this.userId,
    required this.pulseId,
    required this.pulseCategoryId,
    required this.amount,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PulseDurationModel.fromJson(Map<String, dynamic> json) =>
      PulseDurationModel(
        id: json["id"] ?? '',
        userId: json["user_id"] ?? '',
        pulseId: json["pulse_id"] ?? '',
        pulseCategoryId: json["pulse_category_id"] ?? '',
        amount: json["amount"],
        createdAt: DateTime.parse(json["created_at"] ?? ''),
        updatedAt: DateTime.parse(json["updated_at"] ?? ''),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "pulse_id": pulseId,
        "pulse_category_id": pulseCategoryId,
        "amount": amount,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
