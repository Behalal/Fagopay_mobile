// import 'dart:convert';
// import 'dart:developer';

// import 'package:fagopay/functions/functions.dart';
// import 'package:fagopay/service/constants/constants.dart';
// import 'package:fagopay/service/secure_storage/secure_storage.dart';
// import 'package:http/http.dart' as http;

// class AuthService extends BaseAPI {
//   Functions function = Functions();
//   SecureStorage storage = SecureStorage();

//   Future<String> login(String email, String password) async {
//     var body = jsonEncode({'username': email, 'password': password});

//     try {
//       http.Response response = await http.post(
//         Uri.parse("${super.userPath}login"),
//         headers: super.headers,
//         body: body,
//       );

//       var responseBody = jsonEncode({
//         'status_code': response.statusCode,
//         'body': jsonDecode(response.body)
//       });

//       log(responseBody);
//       return responseBody;
//     } catch (e) {
//       log(e.toString());
//       throw Exception('Login Failed');
//     }
//   }

//   Future<String> selectAccountType(
//       String accountType, String verification) async {
//     String typeKey = "";
//     if (function.validateEmail(verification)) {
//       typeKey = 'email';
//     } else {
//       typeKey = 'phone_number';
//     }

//     var body = jsonEncode({'account_type': accountType, typeKey: verification});

//     http.Response response = await http.post(
//         Uri.parse("${super.userPath}register"),
//         headers: super.headers,
//         body: body);

//     var responseBody = jsonEncode({
//       'status_code': response.statusCode,
//       'body': jsonDecode(response.body)
//     });

//     log(responseBody);

//     return responseBody;
//   }

//   Future<String> resendCode(String id) async {
//     var body = jsonEncode({'identifier': id});

//     http.Response response = await http.post(
//         Uri.parse("${super.verificationPath}resend-new-user-otp"),
//         headers: super.headers,
//         body: body);

//     var responseBody = jsonEncode({
//       'status_code': response.statusCode,
//       'body': jsonDecode(response.body)
//     });

//     log(responseBody);

//     return responseBody;
//   }

//   Future<String> validateCode(String id, String code) async {
//     var body = jsonEncode({'identifier': id, "otp": code});

//     http.Response response = await http.post(
//         Uri.parse("${super.verificationPath}validate-new-user-otp"),
//         headers: super.headers,
//         body: body);

//     var responseBody = jsonEncode({
//       'status_code': response.statusCode,
//       'body': jsonDecode(response.body)
//     });

//     log(responseBody);

//     return responseBody;
//   }

//   Future<String> setPassCode(String code) async {
//     var body = jsonEncode({"passcode": code});
//     var token = await storage.tokenRead();

//     log(token);

//     http.Response response =
//         await http.post(Uri.parse("${super.userPath}passcode-setup"),
//             headers: {
//               "Content-Type": "application/json; charset=UTF-8",
//               "Authorization": "Bearer $token"
//             },
//             body: body);

//     var responseBody = jsonEncode({
//       'status_code': response.statusCode,
//       'body': jsonDecode(response.body)
//     });

//     return responseBody;
//   }

//   Future<String> registerDetails(
//       String id,
//       String firstname,
//       String lastname,
//       String email,
//       String password,
//       String confirmPassword,
//       String referral) async {
//     var body = jsonEncode({
//       'identifier': id,
//       "first_name": firstname,
//       "last_name": lastname,
//       "email": email,
//       "password": password,
//       "password_confirmation": confirmPassword,
//       "referal_by": referral,
//     });

//     http.Response response = await http.post(
//       Uri.parse("${super.userPath}register-detail"),
//       headers: super.headers,
//       body: body,
//     );

//     var responseBody = jsonEncode({
//       'status_code': response.statusCode,
//       'body': jsonDecode(response.body)
//     });

//     log(responseBody);

//     return responseBody;
//   }

//   Future<String> getUserDetails() async {
//     var token = await storage.tokenRead();

//     http.Response response = await http.get(
//       Uri.parse("${super.userPath}dashboard"),
//       headers: {
//         "Content-Type": "application/json; charset=UTF-8",
//         "Authorization": "Bearer $token"
//       },
//     );

//     var responseBody = jsonEncode({
//       'status_code': response.statusCode,
//       'body': jsonDecode(response.body)
//     });

//     return responseBody;
//   }

//   // Future<Response> login(String email, String password) async {
//   //   String url = "${baseUrl}v1/user/login";
//   //   try {
//   //     Response response = await _dio.post(
//   //       url,
//   //       data: {'username': email, 'password': password},
//   //     );

//   //     return response.data;
//   //   } on DioError catch (e) {
//   //     //returns the error object if any
//   //     var response;
//   //     if (e.response != null) {
//   //       response = e.response!.data['data'];
//   //     } else {
//   //       response = e.response;
//   //     }
//   //     return response;
//   //   }
//   // }
// }

// // final authServiceProvider = Provider<AuthService>((ref) => AuthService());
