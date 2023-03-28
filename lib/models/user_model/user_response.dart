import 'dart:convert';
import 'dart:developer';

class UserResponse {
  int? code;
  String? message;
  String? error;

  UserResponse({required this.code, this.error, this.message});

  factory UserResponse.fromReqBody(String body) {
    Map<String, dynamic> json = jsonDecode(body);

    return UserResponse(
      code: (json['status_code'] != null) ? json['status_code'] : null,
      message:
          (json['body']['message'] != null) ? json['body']['message'] : null,
      error: (json['data'] != null)
          ? ((json['data']['error'] is List)
              ? json['data']['error'][0]
              : json['data']['error'])
          : null,
    );
  }

  void printAttributes() {
    log("code: $code\n");
    log("message: $message\n");
    log("error: $error\n");
  }
}
