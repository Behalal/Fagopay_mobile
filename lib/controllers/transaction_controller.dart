import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart' as dio;
import 'package:fagopay/controllers/user_controller.dart';
import 'package:fagopay/fund_wallet.dart';
import 'package:fagopay/models/request_money/verify_phoneNumber_response_model.dart';
import 'package:fagopay/screens/constants/colors.dart';
import 'package:fagopay/screens/constants/keys.dart';
import 'package:fagopay/screens/widgets/info_dialog.dart';
import 'package:fagopay/screens/widgets/navigation_bar.dart';
import 'package:fagopay/screens/widgets/progress_indicator.dart';
import 'package:fagopay/service/network_services/dio_service_config/dio_client.dart';
import 'package:fagopay/service/network_services/dio_service_config/dio_error.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/transaction.dart/transaction_history_model.dart';
import '../models/transaction.dart/tx_filter.dart';
import '../screens/individual/bills/models/transaction_post_model.dart';
import '../service/constants/constants.dart';
import '../service/networking/network_helper.dart';
import '../service/secure_storage/secure_storage.dart';

enum TransactionHistoryStatus {
  empty,
  loading,
  error,
  success,
  available,
}
enum TxFlters{
  active,
  unActive,
}
enum FagoAccUserStatus{
  free,
  notFound,
  found
}
enum TxFilterEnum{
  active,
  unActive,
}
class TransactionController extends GetxController {
  final Rx<TxFlters> txFilter = TxFlters.unActive.obs;
  TxFlters get  txFilterData => txFilter.value;
  final userNameId = FagoAccUserStatus.free.obs;
  FagoAccUserStatus get userName => userNameId.value;
  final Rx<TxFilterEnum> _isFilter = TxFilterEnum.unActive.obs;

  final Rx<List<TransactionFilter>> _txFilter = Rx([]);
  List<TransactionFilter> get txFilterList => _txFilter.value;

  TxFilterEnum get isFilterLoading => _isFilter.value;
  TextEditingController accountNumberController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController dexcriptionController = TextEditingController();


  Future<TxFilterModel> txFilterApi()async {
    final token = await SecureStorage.readUserToken();
    TxFilterModel ?txFilterModel;
    try{
      final res  = await http.get(
        Uri.parse('${BaseAPI.api}transactionfilter/transactionfiltertype'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
      );
      txFilterModel = TxFilterModel.fromJson(jsonDecode(res.body));
      // var json = jsonDecode(res.body);
      // if (res.statusCode == 200) {
      //   var list =  List.from(json['data']['transaction_filter']);
      //   var transactionList = list.map((e) => TransactionFilter.fromJson(e)).toList();
      //   _txFilter(transactionList);
      //   print('this list $txFilterList');
        // transactionList.isNotEmpty
        //     ? _isFilter(TxFilterEnum.active)
        //     : _isFilter(TxFilterEnum.unActive);
        // _transactionHistoryStatus(TransactionHistoryStatus.success);
        // isFilter(TxFilterEnum.active);
   //   return res.body;
    }catch(e){
      if(kDebugMode){
        print('cant fetch filter model reason - $e');
      }
    }
    return txFilterModel!;
  }

  Future<dynamic> getAllBanks() async {
    final token = await SecureStorage.readUserToken();
    try {
      final responseData = await NetworkHelper.getRequest(
        url: "${BaseAPI.transactionsPath}banklist",
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
          "Authorization": "Bearer $token"
        },
      );
      return responseData;
    } catch (e) {
      log(e.toString());
      throw Exception('Error fetching banks');
    }
  }
  bool? getBankDetailsLoadingState;
  bool? getBankDetailsErrorState;
  String? verifiedReceipientUser;
  Future<dio.Response<dynamic>?> getBankDetails(String bankCode, String accountNo) async {
    getBankDetailsLoadingState = true;
    getBankDetailsErrorState = false;
    update();
    var requestBody = jsonEncode({
      "account_number": accountNo,
      "account_bank": bankCode,
    });
    try {
      final response = await NetworkProvider().call(path: "/v1/transaction/resolve-bank", method: RequestMethod.post, body: requestBody);
      getBankDetailsLoadingState = false;
      getBankDetailsErrorState = false;
      verifiedReceipientUser = response?.data['data']['account_name'];
      update();
      return response;
    }on dio.DioError catch (err) {
      final errorMessage = Future.error(ApiError.fromDio(err));
      getBankDetailsLoadingState = false;
      getBankDetailsErrorState = true;
      if(err.response?.data['data']['error'] == null){
        verifiedReceipientUser = "No user found";
        update();
      }else{
        verifiedReceipientUser = "No user found";
        update();
      }
      update();
      throw errorMessage;
    } catch (err) {
      if(err.toString() == "null"){
        getBankDetailsLoadingState = false;
        getBankDetailsErrorState = true;
        verifiedReceipientUser = "No user found";
        update();
      }else{
        getBankDetailsLoadingState = false;
        getBankDetailsErrorState = true;
        verifiedReceipientUser = "No user found";
        update();
      }
      // Get.snackbar('Something Went Wrong',err.toString());
      throw err.toString();
    }
  }

  String accountName = '';
  bool? onLookUpNumberLoadingState;
  bool? onLookUpNumberErrorState;
  Future<void> lookUpPhone({required String phoneNumber})async{
    onLookUpNumberLoadingState = true;
    onLookUpNumberErrorState = false;
    update();
    try{
      final response = await NetworkProvider().call(path: "/v1/transaction/account-lookup-by-phone/$phoneNumber", method: RequestMethod.get);
      final responseMessage = VerifyPhoneNumberResponse.fromJson(response!.data);
      onLookUpNumberLoadingState = false;
      onLookUpNumberErrorState = false;
      accountName = responseMessage.data!.accountDetail!.accountName!;
      update();
      update();
    }on dio.DioError catch (err) {
      final errorMessage = Future.error(ApiError.fromDio(err));
      accountName = err.response?.data['data']['error'] ?? "Couldn't find account";
      onLookUpNumberLoadingState = false;
      onLookUpNumberErrorState = true;
      update();
      update();
      throw errorMessage;
    } catch (err) {
      if(err.toString() == "Internal Server Error"){
        onLookUpNumberLoadingState = false;
        onLookUpNumberErrorState = false;
        accountName = "Couldn't find account";
        update();
        update();
      }else{
        onLookUpNumberLoadingState = false;
        onLookUpNumberErrorState = true;
        accountName = "Couldn't find number";
        update();
        update();
      }
      throw err.toString();
    }
  }

  // Future<dynamic> getAccountDetailsByPhone(String phoneNo) async {
  //   final token = await SecureStorage.readUserToken();
  //
  //   try {
  //     final responseData = await NetworkHelper.getRequest(
  //       url: "${BaseAPI.transactionsPath}account-lookup-by-phone/$phoneNo",
  //       headers: {
  //         "Content-Type": "application/json; charset=UTF-8",
  //         "Authorization": "Bearer $token"
  //       },
  //     );
  //     return responseData;
  //   } catch (e) {
  //     log(e.toString());
  //     throw Exception('Failed');
  //   }
  // }
  Future<dio.Response<dynamic>?> fundWallet({required String amount}) async {
    progressIndicator(Get.context!);
    var requestBody = jsonEncode({
      "topup_amount": amount,
    });
    try {
      final response = await NetworkProvider().call(path: "/v1/transaction/fund-wallet", method: RequestMethod.post, body: requestBody);
      if(response!.statusCode == 200 || response.statusCode == 201){
        Get.back();
        RequestPayWithCardPayment(encryptionKey, publicKey, amount,
            _userUcontroller.user?.email ?? "", _userUcontroller.user?.phoneNumber ?? "",
            "${_userUcontroller.user?.firstName ?? ""} ${_userUcontroller.user?.firstName ?? ""}", Get.context!, response.data["data"]["reference"]).chargeCard();
      }
      return response;
    }on dio.DioError catch (err) {
      Get.back();
      final errorMessage = Future.error(ApiError.fromDio(err));
      Get.snackbar('Error', err.response?.data['data']['error'] ?? errorMessage.toString(), colorText: Colors.white, backgroundColor: fagoSecondaryColor);
      throw errorMessage;
    } catch (err) {
      Get.back();
      Get.snackbar('Something Went Wrong',err.toString(), colorText: Colors.white, backgroundColor: fagoSecondaryColor);
      throw err.toString();
    }
  }

  Future<dio.Response<dynamic>?> verificationCallBack({required String reference}) async {
    try {
      final response = await NetworkProvider().call(path: "/v1/transaction/flutterwave-callback/$reference", method: RequestMethod.get);
      Get.offAll(()=>const Dashboard());
      return response;
    }on dio.DioError catch (err) {
      Get.back();
      final errorMessage = Future.error(ApiError.fromDio(err));
      Get.snackbar('Error', err.response?.data['data']['error'] ?? errorMessage.toString(), colorText: Colors.white, backgroundColor: fagoSecondaryColor);
      throw errorMessage;
    } catch (err) {
      Get.back();
      Get.snackbar('Something Went Wrong',err.toString(), colorText: Colors.white, backgroundColor: fagoSecondaryColor);
      throw err.toString();
    }
  }

  Future<dio.Response<dynamic>?> requestMoney(String phoneNumber, String amount, String needDescription, BuildContext context) async {
    progressIndicator(context);
    var requestBody = jsonEncode({
      "phone_number": phoneNumber,
      "amount": amount,
      "description": needDescription,
    });
    try {
      final response = await NetworkProvider().call(path: "/v1/transaction/request-money", method: RequestMethod.post, body: requestBody);
      Get.back();
      Get.back();
      Get.back();
      Get.snackbar("Success",response?.data["message"] ?? "Request Sent Successfully.",colorText: Colors.white, backgroundColor: fagoGreenColor);
      return response;
    }on dio.DioError catch (err) {
      Get.back();
      final errorMessage = Future.error(ApiError.fromDio(err));
      Get.snackbar('Error', err.response?.data['data']['error'] ?? errorMessage.toString(), colorText: Colors.white, backgroundColor: fagoSecondaryColor);
      throw errorMessage;
    } catch (err) {
      Get.back();
      Get.snackbar('Something Went Wrong',err.toString(), colorText: Colors.white, backgroundColor: fagoSecondaryColor);
      throw err.toString();
    }
  }
  final _userUcontroller = Get.find<UserController>();
  Future<dio.Response<dynamic>?> bankTransfer(String transactionPin) async {
    String accountNumber = bankTransferFields.accountNumber;
    String accountBank = bankTransferFields.bankId;
    String amount = bankTransferFields.amount;
    String description = bankTransferFields.narration;
    await fetchAccountId().then((value){
      if(value.isEmpty || value == ""){
        accountId = "";
      }else{
        accountId = value;
      }
    });
    await fetchCompanyId().then((value){
      if(value.isEmpty || value == ""){
        companyId = "";
      }else{
        companyId = value;
      }
    });

    var requestBody = jsonEncode({
      "account_number": accountNumber,
      "account_bank": accountBank,
      "amount": amount,
      "description": description,
      "transaction_pin": transactionPin
    });
    var requestBodyCompany = jsonEncode({
      "account_number": accountNumber,
      "account_bank": accountBank,
      "amount": amount,
      "description": description,
      "transaction_pin": transactionPin,
      "company_id": companyId,
      "account": accountId,
    });
    try {
      final responseData = await NetworkProvider().call(path: "/v1/transaction/bank-transfer", method: RequestMethod.post, body: _userUcontroller.switchedAccountType == 2 ? requestBodyCompany : requestBody);
      return responseData;
    }on dio.DioError catch (err) {
      Get.back();
      final errorMessage = Future.error(ApiError.fromDio(err));
      Get.snackbar('Error', err.response?.data['data']['error'] ?? errorMessage.toString(), colorText: Colors.white, backgroundColor: fagoSecondaryColor);
      throw errorMessage;
    } catch (err) {
      Get.back();
      Get.snackbar('Something Went Wrong',err.toString(), colorText: Colors.white, backgroundColor: fagoSecondaryColor);
      throw err.toString();
    }
  }

  Future<dio.Response<dynamic>?> fagoToFagoTransfer(String transactionPin) async {

    String phoneNumber = bankTransferFields.phoneNumber;
    String amount = bankTransferFields.amount;
    String description = bankTransferFields.narration;
    await fetchAccountId().then((value){
      if(value.isEmpty || value == ""){
        accountId = "";
      }else{
        accountId = value;
      }
    });
    await fetchCompanyId().then((value){
      if(value.isEmpty || value == ""){
        companyId = "";
      }else{
        companyId = value;
      }
    });

    var requestBody = jsonEncode({
      "phonenumber": phoneNumber,
      "amount": amount,
      "description": description,
      "transaction_pin": transactionPin
    });

    var requestBodyCompany = jsonEncode({
      "phonenumber": phoneNumber,
      "amount": amount,
      "description": description,
      "transaction_pin": transactionPin,
      "company_id": companyId,
      "account": accountId,
    });

    try {
      final responseData = await NetworkProvider().call(path: "/v1/transaction/fago-to-fago", method: RequestMethod.post, body: _userUcontroller.switchedAccountType == 2 ? requestBodyCompany : requestBody);
      return responseData;
    }on dio.DioError catch (err) {
      Get.back();
      final errorMessage = Future.error(ApiError.fromDio(err));
      Get.snackbar('Error', err.response?.data['data']['error'] ?? errorMessage.toString(), colorText: Colors.white, backgroundColor: fagoSecondaryColor);
      throw errorMessage;
    } catch (err) {
      Get.back();
      Get.snackbar('Something Went Wrong',err.toString(), colorText: Colors.white, backgroundColor: fagoSecondaryColor);
      throw err.toString();
    }
  }
  List<TransactionHistoryModel> businessTransactionHistory = <TransactionHistoryModel>[].obs;
  bool? onLoadingBusinessTransactionHistoryLoadingState;
  bool? onLoadingBusinessTransactionHistoryErrorState;
  Future<String> fetchAccountId() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    String? accountId = sharedPreferences.getString("accountId");
    return accountId ?? "";
  }
  Future<String> fetchCompanyId() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    String? companyId = sharedPreferences.getString("companyId");
    return companyId ?? "";
  }
  String? companyId;
  String? accountId;

  Future<void> getBusinessTransactionHistory({required int type,String? startDate, String ? endDate, String? filter}) async {
    onLoadingBusinessTransactionHistoryLoadingState = true;
    onLoadingBusinessTransactionHistoryErrorState = false;
    update();
    await fetchAccountId().then((value){
      if(value.isEmpty || value == ""){
        accountId = "%22%22";
      }else{
        accountId = value;
      }
    });
    await fetchCompanyId().then((value){
      if(value.isEmpty || value == ""){
        companyId = "%22%22";
      }else{
        companyId = value;
      }
    });
    type == 2 ? txFilter(TxFlters.active): txFilter(TxFlters.unActive);
    try {
      final response = await NetworkProvider().call(path: type ==1?"/v1/transaction/business/history/$companyId/$accountId":
      "/v1/transaction/business-transaction-filter/$companyId/$accountId/$startDate/$endDate/$filter", method: RequestMethod.get);
      onLoadingBusinessTransactionHistoryLoadingState = false;
      onLoadingBusinessTransactionHistoryErrorState = false;
      var list =  List.from(response?.data['data']['transactions']);
      businessTransactionHistory = list.map((e) => TransactionHistoryModel.fromJson(e)).toList();
      update();
    }on dio.DioError catch (err) {
      onLoadingBusinessTransactionHistoryLoadingState = false;
      onLoadingBusinessTransactionHistoryErrorState = true;
      update();
      final errorMessage = Future.error(ApiError.fromDio(err));
      Get.snackbar('Error', err.response?.data['data']['error'] ?? errorMessage.toString(), colorText: Colors.white, backgroundColor: fagoSecondaryColor);
      throw errorMessage;
    }  catch (error) {
      if(error.toString() == "KYC Not yet verified" || error.toString() == "Company Identifier and account number is required"){
        businessTransactionHistory = [];
        onLoadingBusinessTransactionHistoryLoadingState = false;
        onLoadingBusinessTransactionHistoryErrorState = false;
        showInformationDialog(Get.context!, "You don't have transaction record. Kindly complete your kyc verification to make a transaction", "No KYC Verification");
        update();
      }else{
        onLoadingBusinessTransactionHistoryLoadingState = false;
        onLoadingBusinessTransactionHistoryErrorState = true;
        update();
        Get.snackbar('Error', error.toString() == "Failed host lookup: 'fagopay-coreapi-development.herokuapp.com'"
            ? 'No internet connection!' : error.toString(), colorText: Colors.white, backgroundColor: fagoSecondaryColor);
      }
    }
  }


  List<TransactionHistoryModel> transactionHistory = <TransactionHistoryModel>[].obs;
  bool? onLoadingTransactionHistoryLoadingState;
  bool? onLoadingTransactionHistoryErrorState;
  Future<void> getTransactionHistory({required int type,String? startDate, String ? endDate, String? filter}) async {
    type == 2 ? txFilter(TxFlters.active): txFilter(TxFlters.unActive);
    onLoadingTransactionHistoryLoadingState = true;
    onLoadingTransactionHistoryErrorState = false;
    update();
    try {
      log("2");
      final response = await NetworkProvider().call(path: type ==1?"/v1/transaction/history":
      "/v1/transaction/transaction-filter/$startDate/$endDate/$filter", method: RequestMethod.get);
      onLoadingTransactionHistoryLoadingState = false;
      onLoadingTransactionHistoryErrorState = false;
      update();
        var list =  List.from(response?.data['data']['transactions']);
        transactionHistory = list.map((e) => TransactionHistoryModel.fromJson(e)).toList();
        update();
    }on dio.DioError catch (err) {
      onLoadingTransactionHistoryLoadingState = false;
      onLoadingTransactionHistoryErrorState = true;
      update();
      final errorMessage = Future.error(ApiError.fromDio(err));
      Get.snackbar('Error', err.response?.data['data']['error'] ?? errorMessage.toString(), colorText: Colors.white, backgroundColor: fagoSecondaryColor);
      throw errorMessage;
    }  catch (error) {
      if(error.toString() == "KYC Not yet verified"){
        log("3");
        log(error.toString());
        transactionHistory = [];
        onLoadingTransactionHistoryLoadingState = false;
        onLoadingTransactionHistoryErrorState = false;
        showInformationDialog(Get.context!, "You don't have transaction record. Kindly complete your kyc verification to make a transaction", "No KYC Verification");
        update();
      }else{
        onLoadingTransactionHistoryLoadingState = false;
        onLoadingTransactionHistoryErrorState = true;
        update();
        Get.snackbar('Error', error.toString() == "Failed host lookup: 'fagopay-coreapi-development.herokuapp.com'"
            ? 'No internet connection!' : error.toString(), colorText: Colors.white, backgroundColor: fagoSecondaryColor);
      }
    }
  }
}
