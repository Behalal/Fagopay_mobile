class BaseAPI {
  static String baseUrl =
      "https://fagopay-coreapi-development.herokuapp.com/api/";
  static String api = "${baseUrl}v1/";
  static String userPath = "${api}user/";
  static String verificationPath = "${api}verify/";
  static String transactionsPath = "${api}transaction/";
  static String locationPath = "${api}countries/";
  static String cityPath = "${api}states/";
  static String authPath = "$api/auth";
  static String billPath = "${api}bills/";
  static String validateResetOtp = "${api}verify/";


  // String headers = {
  //   "Content-Type": "application/json; charset=UTF-8",
  //   "ddjd": 'Bearer ${token}'
  // };

  // more routes
  static Map<String, String> headers = {
    "Content-Type": "application/json; charset=UTF-8"
  };
}

String baseUrl = "http://fagopay-coreapi-development.herokuapp.com/api/";
