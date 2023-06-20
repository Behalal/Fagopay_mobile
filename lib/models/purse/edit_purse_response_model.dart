import 'dart:convert';

EditPurseResponse editPurseResponseFromJson(String str) => EditPurseResponse.fromJson(json.decode(str));
String editPurseResponseToJson(EditPurseResponse data) => json.encode(data.toJson());

class EditPurseResponse {
  Data? data;
  String? message;

  EditPurseResponse({
    this.data,
    this.message,
  });

  factory EditPurseResponse.fromJson(Map<String, dynamic> json) => EditPurseResponse(
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
    "message": message,
  };
}

class Data {
  int? pulse;

  Data({
    this.pulse,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    pulse: json["pulse"],
  );

  Map<String, dynamic> toJson() => {
    "pulse": pulse,
  };
}
