
class PurseCategoryListResponse {
  Data? data;
  String? message;

  PurseCategoryListResponse({
    this.data,
    this.message,
  });

  factory PurseCategoryListResponse.fromJson(Map<String, dynamic> json) => PurseCategoryListResponse(
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
    "message": message,
  };
}

class Data {
  List<PulseCategoryList>? pulseCategoryList;

  Data({
    this.pulseCategoryList,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    pulseCategoryList: json["pulse_category_list"] == null ? [] : List<PulseCategoryList>.from(json["pulse_category_list"]!.map((x) => PulseCategoryList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "pulse_category_list": pulseCategoryList == null ? [] : List<dynamic>.from(pulseCategoryList!.map((x) => x.toJson())),
  };
}

class PulseCategoryList {
  String? id;
  String? categoryName;
  String? description;
  DateTime? createdAt;
  DateTime? updatedAt;

  PulseCategoryList({
    this.id,
    this.categoryName,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  factory PulseCategoryList.fromJson(Map<String, dynamic> json) => PulseCategoryList(
    id: json["id"],
    categoryName: json["category_name"],
    description: json["description"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "category_name": categoryName,
    "description": description,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
