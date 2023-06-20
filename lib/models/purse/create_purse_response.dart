

class CreatePurseResponse {
  Data? data;
  String? message;

  CreatePurseResponse({
    this.data,
    this.message,
  });

  factory CreatePurseResponse.fromJson(Map<String, dynamic> json) => CreatePurseResponse(
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
    "message": message,
  };
}

class Data {
  Pulse? pulse;

  Data({
    this.pulse,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    pulse: json["pulse"] == null ? null : Pulse.fromJson(json["pulse"]),
  );

  Map<String, dynamic> toJson() => {
    "pulse": pulse?.toJson(),
  };
}

class Pulse {
  String? id;
  String? amount;
  String? name;
  String? duration;
  dynamic description;
  String? userId;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<PulseCategory>? pulseCategories;

  Pulse({
    this.id,
    this.amount,
    this.name,
    this.duration,
    this.description,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.pulseCategories,
  });

  factory Pulse.fromJson(Map<String, dynamic> json) => Pulse(
    id: json["id"],
    amount: json["amount"],
    name: json["name"],
    duration: json["duration"],
    description: json["description"],
    userId: json["user_id"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    pulseCategories: json["pulse_categories"] == null ? [] : List<PulseCategory>.from(json["pulse_categories"]!.map((x) => PulseCategory.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "amount": amount,
    "name": name,
    "duration": duration,
    "description": description,
    "user_id": userId,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "pulse_categories": pulseCategories == null ? [] : List<dynamic>.from(pulseCategories!.map((x) => x.toJson())),
  };
}

class PulseCategory {
  String? id;
  String? userId;
  String? pulseId;
  String? pulseCategoryId;
  String? budgetedAmount;
  String? categoryName;
  int? amountSpend;
  int? amountLeftToSpend;

  PulseCategory({
    this.id,
    this.userId,
    this.pulseId,
    this.pulseCategoryId,
    this.budgetedAmount,
    this.categoryName,
    this.amountSpend,
    this.amountLeftToSpend,
  });

  factory PulseCategory.fromJson(Map<String, dynamic> json) => PulseCategory(
    id: json["id"],
    userId: json["user_id"],
    pulseId: json["pulse_id"],
    pulseCategoryId: json["pulse_category_id"],
    budgetedAmount: json["budgeted_amount"],
    categoryName: json["category_name"],
    amountSpend: json["amount_spend"],
    amountLeftToSpend: json["amount_left_to_spend"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "pulse_id": pulseId,
    "pulse_category_id": pulseCategoryId,
    "budgeted_amount": budgetedAmount,
    "category_name": categoryName,
    "amount_spend": amountSpend,
    "amount_left_to_spend": amountLeftToSpend,
  };
}
