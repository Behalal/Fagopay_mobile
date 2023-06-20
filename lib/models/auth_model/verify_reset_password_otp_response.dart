
class VerifyResetPasswordResponse {
  Data? data;
  String? message;

  VerifyResetPasswordResponse({
    this.data,
    this.message,
  });

  factory VerifyResetPasswordResponse.fromJson(Map<String, dynamic> json) => VerifyResetPasswordResponse(
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
    "message": message,
  };
}

class Data {
  String? code;

  Data({
    this.code,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
  };
}
