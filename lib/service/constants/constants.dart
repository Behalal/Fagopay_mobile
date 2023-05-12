class BaseAPI {
  static String baseUrl =
      "https://fagopay-coreapi-development.herokuapp.com/api/";
  static String api = "${baseUrl}v1/";
  static String userPath = "${api}user/";
  static String verificationPath = "${api}verify/";
  static String transactionsPath = "${api}transaction/";
  static String countriesPath = "${api}countries/";
  static String statesPath = "${api}states/";
  static String citiesPath = "${api}city-state/";
  static String authPath = "$api/auth";
  static String billPath = "${api}bills/";
  static String customersPath = "${api}customer";
  static String employeesPath = "${api}employee";
  static String suppliersPath = "${api}supplier";
  static String companyPath = "${api}company";
  static String businessSalesPath = "${api}businesssales";
  static String businessExpensesPath = "${api}businessexpenses";
  static String businessExpensesCategoryPath = "${api}businessexpensecategory";
  static String validateResetOtp = "${api}verify/password-reset-code";
  static String nextofKin = "${api}kyc/create-update-nextofkin";

// RequestMoney Endpoint
  static String myRequest = "${api}transaction/requestee-request-list";
  static String requestedMoney = "${api}transaction/requester-request-list";
  static String requestMoneyapi = "${api}transaction/request-money";
  static String lookupPhoneNum = "${api}transaction/account-lookup-by-phone/";
  static String transactionHistory = "${api}transaction/history";

  //bills
static String airtimeSwapCharges = "${api}airtimeswap/get_fee/";
static String initiateSwap = "${api}airtimeswap";

 

  // purse
  static String pulseCategory = "${api}pulsecategory";
  static String createPurse = "${api}pulse";
  static String showPurse = "${api}pulse/";

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
