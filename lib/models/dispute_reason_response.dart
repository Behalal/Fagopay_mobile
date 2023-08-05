

class DisputeReasonResponse {
  Data? data;
  String? message;

  DisputeReasonResponse({
    this.data,
    this.message,
  });

  factory DisputeReasonResponse.fromJson(Map<String, dynamic> json) => DisputeReasonResponse(
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
    "message": message,
  };
}

class Data {
  List<DisputeReason>? disputeReason;

  Data({
    this.disputeReason,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    disputeReason: json["dispute_reason"] == null ? [] : List<DisputeReason>.from(json["dispute_reason"]!.map((x) => DisputeReason.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "dispute_reason": disputeReason == null ? [] : List<dynamic>.from(disputeReason!.map((x) => x.toJson())),
  };
}

class DisputeReason {
  String? id;
  String? title;
  String? description;
  DateTime? createdAt;
  DateTime? updatedAt;

  DisputeReason({
    this.id,
    this.title,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  factory DisputeReason.fromJson(Map<String, dynamic> json) => DisputeReason(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
