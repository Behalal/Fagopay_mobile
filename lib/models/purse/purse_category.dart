class AutoGenerate {
  AutoGenerate({
    required this.data,
    required this.message,
  });
  late final PurseCategory data;
  late final String message;

  AutoGenerate.fromJson(Map<String, dynamic> json) {
    data = PurseCategory.fromJson(json['data']);
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.toJson();
    _data['message'] = message;
    return _data;
  }
}

class PurseCategory {
  PurseCategory({
    required this.pulseCategoryList,
  });
  late final List<PulseCategoryList> pulseCategoryList;

  PurseCategory.fromJson(Map<String, dynamic> json) {
    pulseCategoryList = List.from(json['pulse_category_list'])
        .map((e) => PulseCategoryList.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['pulse_category_list'] =
        pulseCategoryList.map((e) => e.toJson()).toList();
    return data;
  }
}

class PulseCategoryList {
  PulseCategoryList({
    required this.id,
    required this.categoryName,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });
  late final String id;
  late final String categoryName;
  late final String description;
  late final String createdAt;
  late final String updatedAt;

  PulseCategoryList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryName = json['category_name'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['category_name'] = categoryName;
    data['description'] = description;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
