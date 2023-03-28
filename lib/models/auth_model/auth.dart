import 'dart:convert';
import 'dart:developer';

class Auth {
  int? code;
  String? identifier;
  String? token;
  String? error;
  String? message;

  Auth(
      {required this.code,
      this.error,
      this.identifier,
      this.message,
      this.token});

  factory Auth.fromReqBody(String body) {
    Map<String, dynamic> json = jsonDecode(body);
    return Auth(
        code: json['status_code'],
        identifier: (json['body']['data'] != null)
            ? json['body']['data']['identifier']
            : null,
        error: (json['body']['data'] != null)
            ? ((json['body']['data']['error'] is List)
                ? json['body']['data']['error'][0]
                : json['body']['data']['error'])
            : null,
        message:
            (json['body']['data'] != null) ? json['body']['message'] : null,
        token: (json['body']['token'] != null) ? json['body']['token'] : null);
  }

  void printAttributes() {
    log("code: $code\n");
    log("identifier: $identifier\n");
    log("error: $error\n");
    log("message: $message\n");
    log("token: $token\n");
  }
}
