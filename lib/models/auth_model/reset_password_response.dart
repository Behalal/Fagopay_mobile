

class ResetPasswordResponse {
  Data? data;

  ResetPasswordResponse({
    this.data,
  });

  factory ResetPasswordResponse.fromJson(Map<String, dynamic> json) => ResetPasswordResponse(
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
