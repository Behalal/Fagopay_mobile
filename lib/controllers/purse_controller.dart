import 'dart:convert';
import 'dart:developer';

import 'package:fagopay/models/purse/createPurse_Model.dart';
import 'package:fagopay/models/purse/purse_category.dart';
import 'package:fagopay/models/purse/showPurse_Model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../service/constants/constants.dart';
import '../service/secure_storage/secure_storage.dart';
import 'package:http/http.dart' as http;

enum PurseCategory {
  empty,
  loading,
  error,
  success,
  available,
}

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
  // late final emailController = TextEditingController();
  // late final phoneNumController = TextEditingController();
  // late final houseAdressController = TextEditingController();
  // late final relationshipController = TextEditingController();

  final _createPurseStatus = CreatePurseEnum.empty.obs;

  CreatePurseEnum get nextOfKinStatus => _createPurseStatus.value;

  final Rx<List<PulseCategoryList>> _purseCategoryList = Rx([]);
  List<PulseCategoryList> get purseCategoryList => _purseCategoryList.value;

  final Rx<List<PulseDurationModel>> _purseDurationList = Rx([]);
  List<PulseDurationModel> get purseDurationList => _purseDurationList.value;

  final _purseCategoryStatus = PurseCategory.empty.obs;
  PurseCategory get purseCategoryStatus => _purseCategoryStatus.value;

  final _showPurseStatus = ShowPurseEnum.empty.obs;
  ShowPurseEnum get showPurseStatus => _showPurseStatus.value;

  final Rx<PulseDetail?> userPurse = Rx(null);
  PulseDetail? get userPurseDetails => userPurse.value;

  Future getCategorylist() async {
    final token = await SecureStorage.readUserToken();
    try {
      _purseCategoryStatus(PurseCategory.loading);
      if (kDebugMode) {
        print('getting my request...');
      }
      var response = await http.get(
        Uri.parse(BaseAPI.pulseCategory),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
      );

      var json = jsonDecode(response.body);
      if (kDebugMode) {
        print(response.body);
      }

      // if (response.statusCode == 200) {
      //   throw (json['message']);
      // }

      if (response.statusCode == 200) {
        var list = List.from(json['data']['pulse_category_list']);
        var pursecategorylist =
            list.map((e) => PulseCategoryList.fromJson(e)).toList();
        if (kDebugMode) {
          print("${pursecategorylist.length} request");
          print(" Req ${pursecategorylist.first} request");
        }
        _purseCategoryList(pursecategorylist);
        pursecategorylist.isNotEmpty
            ? _purseCategoryStatus(PurseCategory.available)
            : _purseCategoryStatus(PurseCategory.empty);
        _purseCategoryStatus(PurseCategory.success);
      } else if (response.statusCode == 409) {
        Get.snackbar('Error',
            'Go and verify your KYC in other to be able to perform transactions');
        _purseCategoryStatus(PurseCategory.error);
      }
      return response.body;
    } catch (error) {
      _purseCategoryStatus(PurseCategory.error);
      Get.snackbar(
          'Error',
          error.toString() ==
                  "Failed host lookup: 'fagopay-coreapi-development.herokuapp.com'"
              ? 'No internet connection!'
              : error.toString());
      if (kDebugMode) {
        print('Purse Category listt Error ${error.toString()}');
      }
    }
  }

  Future createPurse(CreatePurseModel createPurseModel) async {
    final token = await SecureStorage.readUserToken();
    try {
      _createPurseStatus(CreatePurseEnum.loading);

      if (kDebugMode) {
        print('creating product...');
        print('product json: ${createPurseModel.toJson()}');
      }
      var response = await http.post(
        Uri.parse(BaseAPI.createPurse),
        body: jsonEncode(createPurseModel.toJson()),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
      );
      var json = jsonDecode(response.body);
      print(response.body);

      if ((response.statusCode == 200)) {
        _createPurseStatus(CreatePurseEnum.success);

        Get.snackbar('Success', 'Next of kin created successfully!');
      }
      print('here');
      return createPurseModelFromJson(response.body);
    } catch (error) {
      _createPurseStatus(CreatePurseEnum.error);
      Get.snackbar(
          'Error',
          error.toString() ==
                  "Failed host lookup: 'fagopay-coreapi-development.herokuapp.com'"
              ? 'No internet connection!'
              : error.toString());
      if (kDebugMode) {
        print('creating purse Error ${error.toString()}');
      }
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
              : error.toString());
      if (kDebugMode) {
        print('Show purse Error ${error.toString()}');
      }
    }
  }

  Future purseDurationlist(String id) async {
    final token = await SecureStorage.readUserToken();
    try {
      _purseCategoryStatus(PurseCategory.loading);
      if (kDebugMode) {
        print('getting purse duration...');
      }
      var response = await http.get(
        Uri.parse(
          "${BaseAPI.showPurse}$id",
        ),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
      );

      var json = jsonDecode(response.body);
      if (kDebugMode) {
        print("categoryDuration data ${response.body}");
      }

      // if (response.statusCode == 200) {
      //   throw (json['message']);
      // }

      if (response.statusCode == 200) {
        var list = List.from(json['data']['pulse_detail']['pulse_detail']);
        var purseDurationlist =
            list.map((e) => PulseDurationModel.fromJson(e)).toList();
        if (kDebugMode) {
          print("Duration lenght${purseDurationlist.length} request");
          print(" Duration ${purseDurationlist.first} request");
        }
        _purseDurationList(purseDurationlist);
        purseDurationlist.isNotEmpty
            ? _purseCategoryStatus(PurseCategory.available)
            : _purseCategoryStatus(PurseCategory.empty);
        _purseCategoryStatus(PurseCategory.success);
      } else if (response.statusCode == 409) {
        Get.snackbar('Error',
            'Go and verify your KYC in other to be able to perform transactions');
        _purseCategoryStatus(PurseCategory.error);
      }
      return response.body;
    } catch (error) {
      _purseCategoryStatus(PurseCategory.error);
      Get.snackbar(
          'Error',
          error.toString() ==
                  "Failed host lookup: 'fagopay-coreapi-development.herokuapp.com'"
              ? 'No internet connection!'
              : error.toString());
      if (kDebugMode) {
        print('Purse DurationList listt Error ${error.toString()}');
      }
    }
  }
}
