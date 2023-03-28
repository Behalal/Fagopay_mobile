import 'dart:convert';
import 'dart:developer';

class RegisterResponse {
  int? code;
  String? token;
  String? error;
  String? tokenType;

  RegisterResponse(
      {required this.code, this.error, this.token, this.tokenType});

  factory RegisterResponse.fromReqBody(String body) {
    Map<String, dynamic> json = jsonDecode(body);

    return RegisterResponse(
      code: (json['status_code'] != null) ? json['status_code'] : null,
      token: (json['body']['token'] != null) ? json['body']['token'] : null,
      error: (json['body']['data'] != null)
          ? ((json['body']['data'] != null)
              ? ((json['body']['data']['error'] is List)
                  ? json['body']['data']['error'][0]
                  : json['body']['data']['error'])
              : null)
          : null,
      tokenType:
          (json['body']['data'] != null) ? json['body']['token_type'] : null,
    );
  }

  void printAttributes() {
    log("code: $code\n");
    log("token: $token\n");
    log("error: $error\n");
    log("tokenType: $tokenType\n");
  }
}
