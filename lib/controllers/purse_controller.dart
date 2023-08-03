import 'dart:convert';
import 'package:fagopay/models/purse/create_purse_response.dart';
import 'package:fagopay/models/purse/edit_purse_response_model.dart';
import 'package:fagopay/models/purse/purse_category_list_response_model.dart';
import 'package:fagopay/models/purse/purse_expenses_response_model.dart';
import 'package:fagopay/models/purse/record_purse_expenses.dart';
import 'package:fagopay/screens/constants/colors.dart';
import 'package:fagopay/screens/widgets/progress_indicator.dart';
import 'package:fagopay/service/network_services/dio_service_config/dio_client.dart';
import 'package:dio/dio.dart' as dio;
import 'package:fagopay/service/network_services/dio_service_config/dio_error.dart';
import 'package:flutter/material.dart';
import '../models/purse/purse_list_model.dart';
import '../models/purse/showPurse_Model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../screens/widgets/navigation_bar.dart';
import '../service/constants/constants.dart';
import '../service/secure_storage/secure_storage.dart';
import 'package:http/http.dart' as http;

enum CreatePurseEnum {
  empty,
  loading,
  error,
  success,
  available,
}

enum ShowPurseEnum {
  empty,
  loading,
  error,
  success,
  available,
}

class PurseController extends GetxController {
  late final budgetController = TextEditingController();
  late final amountController = TextEditingController();

  final _createPurseStatus = CreatePurseEnum.empty.obs;

  CreatePurseEnum get nextOfKinStatus => _createPurseStatus.value;

  final Rx<List<PulseDurationModel>> _purseDurationList = Rx([]);
  List<PulseDurationModel> get purseDurationList => _purseDurationList.value;


  final _showPurseStatus = ShowPurseEnum.empty.obs;
  ShowPurseEnum get showPurseStatus => _showPurseStatus.value;

  final Rx<PulseDetail?> userPurse = Rx(null);
  PulseDetail? get userPurseDetails => userPurse.value;

  bool? onPurseCategoryListLoadingState;
  bool? onPurseCategoryListErrorState;
  List<PulseCategoryList>? pulseCategoryList = <PulseCategoryList>[].obs;

  PurseListModel ?purseListModel;
  // PurseExpensesResponse? purseExpensesResponse;
  bool? onLoadingPurseListLoadingState;
  bool? onLoadPurseListErrorState;
  ///OG Dev
  Future<void> purseList()async{
    final token = await SecureStorage.readUserToken();
    onLoadingPurseListLoadingState = true;
    onLoadPurseListErrorState = false;
    update();
    try{
      var response = await http.get(
        Uri.parse('http://fagopay-coreapi-development.herokuapp.com/api/v1/pulse'),
        headers: {"Content-Type": "application/json", "Authorization": "Bearer $token"},
      );
      purseListModel = PurseListModel.fromJson(jsonDecode(response.body));
      // final response1 = await NetworkProvider().call(path: "/v1/pulseexpenses", method: RequestMethod.get);
      // final payload = PurseExpensesResponse.fromJson(response1?.data);
        // purseExpensesResponse = payload;
        onLoadingPurseListLoadingState = false;
        onLoadPurseListErrorState = false;
        update();
    }catch (error) {
        onLoadingPurseListLoadingState = false;
        onLoadPurseListErrorState = true;
        update();
        Get.snackbar('Error', error.toString() == "Failed host lookup: 'fagopay-coreapi-development.herokuapp.com'"
            ? 'No internet connection!' : error.toString(), colorText: Colors.white, backgroundColor: fagoSecondaryColor);
        if (kDebugMode) {
          print('Purse Category listt Error ${error.toString()}');
        }
    }
  }

  Future<void> deletePurse({required String purseId, required BuildContext context}) async {
    progressIndicator(context);
    try {
      final response = await NetworkProvider().call(path: "/v1/pulse/$purseId", method: RequestMethod.delete);
      if(response?.statusCode == 200 || response?.statusCode == 201){
        await purseList();
        Get.back();
        Get.back();
        Get.snackbar("Success", response?.data["data"]["message"] ?? "Purse has been deleted successfully", colorText: Colors.white, backgroundColor: fagoGreenColor);
      }
    }on dio.DioError catch (err) {
      Get.back();
      final errorMessage = Future.error(ApiError.fromDio(err));
      Get.snackbar('Error', err.response?.data['data']['error'] ?? errorMessage.toString(), colorText: Colors.white, backgroundColor: fagoSecondaryColor);
      throw errorMessage;
    } catch (error) {
      Get.back();
      Get.snackbar('Error', error.toString(), colorText: Colors.white, backgroundColor: fagoSecondaryColor);
      throw error.toString();
    }
  }

  Future <CreatePurseResponse> createPurse(Map data, BuildContext context) async {
    progressIndicator(context);
    try {
      _createPurseStatus(CreatePurseEnum.loading);
      final response = await NetworkProvider().call(path: "/v1/pulse", method: RequestMethod.post, body: data);
      if ((response?.statusCode == 200 || response?.statusCode == 201)) {
        CreatePurseResponse.fromJson(response?.data);
        update();
        Get.to(()=>Dashboard());
        _createPurseStatus(CreatePurseEnum.success);
       // Get.snackbar('Success', 'Next of kin created successfully!');
      }else if((response?.statusCode == 409)){
        update();
        Get.to(()=>Dashboard());
      Get.snackbar('Error', '${response?.data['data']['error']}',colorText: white,backgroundColor: fagoSecondaryColor);
      }
    //  print('here');
      return CreatePurseResponse.fromJson(response?.data);
    }on dio.DioError catch (err) {
      Get.back();
      update();
      _createPurseStatus(CreatePurseEnum.error);
      final errorMessage = Future.error(ApiError.fromDio(err));
      Get.snackbar('Error', err.response?.data['data']['error'] ?? errorMessage.toString(), colorText: Colors.white, backgroundColor: fagoSecondaryColor);
      throw errorMessage;
    } catch (err) {
      Get.back();
      update();
      _createPurseStatus(CreatePurseEnum.error);
      Get.snackbar(
          'Error',
          err.toString() ==
              "Failed host lookup: 'fagopay-coreapi-development.herokuapp.com'"
              ? 'No internet connection!'
              : err.toString(), colorText: Colors.white, backgroundColor: fagoSecondaryColor);
      throw err.toString();
    }
  }

  Future <RecordPurseExpensesResponse> recordExpenses(Map data, BuildContext context) async {
    Get.back();
    progressIndicator(context);
    try {
      final response = await NetworkProvider().call(path: "/v1/pulseexpenses", method: RequestMethod.post, body: data);
      if ((response?.statusCode == 200 || response?.statusCode == 201)) {
        RecordPurseExpensesResponse.fromJson(response?.data);
        await purseList();
        Get.back();
        update();
      }else if((response?.statusCode == 409)){
        Get.back();
        update();
        Get.snackbar('Error', '${response?.data['data']['error']}',colorText: white,backgroundColor: fagoSecondaryColor);
      }
      return RecordPurseExpensesResponse.fromJson(response?.data);
    }on dio.DioError catch (err) {
      Get.back();
      update();
      final errorMessage = Future.error(ApiError.fromDio(err));
      Get.snackbar('Error', err.response?.data['data']['error'] ?? errorMessage.toString(), colorText: Colors.white, backgroundColor: fagoSecondaryColor);
      throw errorMessage;
    } catch (err) {
      Get.back();
      update();
      Get.snackbar(
          'Error',
          err.toString() ==
              "Failed host lookup: 'fagopay-coreapi-development.herokuapp.com'"
              ? 'No internet connection!'
              : err.toString(), colorText: Colors.white, backgroundColor: fagoSecondaryColor);
      throw err.toString();
    }
  }

  Future <PurseExpensesResponse> getPurseExpense() async {
    try {
      final response = await NetworkProvider().call(path: "/v1/pulseexpenses", method: RequestMethod.get);
      final payload = PurseExpensesResponse.fromJson(response?.data);
      return  payload;
    }on dio.DioError catch (err) {
      onLoadingPurseListLoadingState = false;
      onLoadPurseListErrorState = true;
      update();
      final errorMessage = Future.error(ApiError.fromDio(err));
      Get.snackbar('Error', err.response?.data['data']['error'] ?? errorMessage.toString(), colorText: Colors.white, backgroundColor: fagoGreenColor);
      throw errorMessage;
    } catch (err) {
        onLoadingPurseListLoadingState = false;
        onLoadPurseListErrorState = true;
        update();
        Get.snackbar(
            'Error',
            err.toString() ==
                "Failed host lookup: 'fagopay-coreapi-development.herokuapp.com'"
                ? 'No internet connection!'
                : err.toString(), colorText: Colors.white, backgroundColor: fagoSecondaryColor);
      throw err.toString();
    }
  }
  // final _purseController = Get.put(PurseController());
  Future <CreatePurseResponse> editPurse(Map data, BuildContext context, String purseId) async {
    progressIndicator(context);
    try {
      _createPurseStatus(CreatePurseEnum.loading);
      final response = await NetworkProvider().call(path: "/v1/pulse/$purseId", method: RequestMethod.delete).then((value) async {
        final response = await NetworkProvider().call(path: "/v1/pulse", method: RequestMethod.post, body: data);
        if ((response?.statusCode == 200 || response?.statusCode == 201)) {
          CreatePurseResponse.fromJson(response?.data);
          await purseList();
          // Get.back();
          Get.back();
          update();
          _createPurseStatus(CreatePurseEnum.success);
          // Get.snackbar('Success', 'Next of kin created successfully!');
        }else if((response?.statusCode == 409)){
          Get.back();
          update();
          Get.snackbar('Error', '${response?.data['data']['error']}',colorText: white,backgroundColor: fagoSecondaryColor);
        }
      });
      //  print('here');
      return CreatePurseResponse.fromJson(response?.data);
    }on dio.DioError catch (err) {
      Get.back();
      update();
      _createPurseStatus(CreatePurseEnum.error);
      final errorMessage = Future.error(ApiError.fromDio(err));
      Get.snackbar('Error', err.response?.data['data']['error'] ?? errorMessage.toString());
      throw errorMessage;
    } catch (err) {
      Get.back();
      update();
      _createPurseStatus(CreatePurseEnum.error);
      // Get.snackbar(
      //     'Error',
      //     err.toString() ==
      //         "Failed host lookup: 'fagopay-coreapi-development.herokuapp.com'"
      //         ? 'No internet connection!'
      //         : err.toString());
      throw err.toString();
    }
  }

  Future showPurse(String id) async {
    final token = await SecureStorage.readUserToken();
    try {
      _showPurseStatus(ShowPurseEnum.loading);
      if (kDebugMode) {
        print('getting showPurse...');
      }

      var response = await http.get(
          Uri.parse(
            "${BaseAPI.showPurse}$id",
          ),
          headers: {
            "Content-Type": "application/json",
            'Authorization': 'Bearer $token'
          });
      //    print('here 1');
      // var json = jsonDecode(response.body);
      // if (kDebugMode) {
      //   print(response.body);
      // }
      print('here 2');
      if (kDebugMode) {
        print("showPurse data ${response.body}");
      }
      print('here 3');
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        print('here 4');
        var showPurseDetails =
            PulseDetail.fromJson(json['data']['pulse_detail']);
        userPurse(showPurseDetails);
        if (kDebugMode) {
          print("Purse Details is $userPurse request");
          // print("phone number details $phoneNumDetails request");
        }
        _showPurseStatus(ShowPurseEnum.success);
      }
      // else if (response.statusCode == 404) {
      //   // Get.snackbar(
      //   //     'Error', 'Make sure the number is a register number on fagopay');
      //   _showPurseStatus(ShowPurseEnum.error);
      // }
      return response.body;
    } catch (error) {
      _showPurseStatus(ShowPurseEnum.error);
      Get.snackbar(
          'Error',
          error.toString() ==
                  "Failed host lookup: 'fagopay-coreapi-development.herokuapp.com'"
              ? 'No internet connection!'
              : error.toString(), colorText: Colors.white, backgroundColor: fagoSecondaryColor);
      if (kDebugMode) {
        print('Show purse Error ${error.toString()}');
      }
    }
  }

  Future purseDurationlist(String id) async {
    onPurseCategoryListLoadingState = true;
    onPurseCategoryListErrorState = false;
    update();
    try {
      final response = await NetworkProvider().call(path: "/v1/pulse/$id", method: RequestMethod.get);
      final payload = PurseCategoryListResponse.fromJson(response?.data);
      pulseCategoryList = payload.data?.pulseCategoryList;
      onPurseCategoryListLoadingState = false;
      onPurseCategoryListErrorState = false;
      update();
    } catch (error) {
      if (error.toString() == "KYC Not yet verified") {
        pulseCategoryList = [];
        onPurseCategoryListLoadingState = false;
        onPurseCategoryListErrorState = false;
        update();
        Get.snackbar('Error', 'Go and verify your KYC in other to be able to perform transactions', colorText: Colors.white, backgroundColor: fagoSecondaryColor);
      }else{
        onPurseCategoryListLoadingState = false;
        onPurseCategoryListErrorState = true;
        update();
        Get.snackbar('Error', error.toString() == "Failed host lookup: 'fagopay-coreapi-development.herokuapp.com'"
            ? 'No internet connection!' : error.toString(), colorText: Colors.white, backgroundColor: fagoSecondaryColor);
      }
    }
  }
}
