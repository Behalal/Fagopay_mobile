class BaseAPI {
  static String baseUrl =
      "https://fagopay-coreapi-development.herokuapp.com/api/";
  static var api = "${baseUrl}v1/";
  var userPath = "${api}user/";
  var verificationPath = "${api}verify/";
  var transactionsPath = "${api}transaction/";
  var locationPath = "${api}countries/";
  var cityPath = "${api}states/";
  var authPath = "$api/auth";
  var billPath = "${api}bills/";

  // var headers = {
  //   "Content-Type": "application/json; charset=UTF-8",
  //   "ddjd": 'Bearer ${token}'
  // };

  // more routes
  Map<String, String> headers = {
    "Content-Type": "application/json; charset=UTF-8"
  };
}

String baseUrl = "http://fagopay-coreapi-development.herokuapp.com/api/";
