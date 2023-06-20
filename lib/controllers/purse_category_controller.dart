import 'package:fagopay/controllers/purse_controller.dart';
import 'package:fagopay/models/purse/delete_expense_response_model.dart';
import 'package:fagopay/models/purse/purse_category_expenses_response.dart';
import 'package:fagopay/screens/widgets/progress_indicator.dart';
import 'package:fagopay/service/network_services/dio_service_config/dio_client.dart';
import 'package:fagopay/service/network_services/dio_service_config/dio_error.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;

class PurseCategoryController extends GetxController{
  bool? onPurseCategoryLoadingState;
  bool? onPurseCategoryErrorState;
  GetPurseExpensesResponse? getPurseExpensesResponse;

  Future<void> getPurseCategory({required String purseCategoryId})async{
    onPurseCategoryLoadingState = true;
    onPurseCategoryErrorState = false;
    update();
    try{
      final response = await NetworkProvider().call(path: "/v1/pulseexpenses/$purseCategoryId", method: RequestMethod.get);
      final payload = GetPurseExpensesResponse.fromJson(response?.data);
      getPurseExpensesResponse = payload;
      onPurseCategoryLoadingState = false;
      onPurseCategoryErrorState = false;
      update();
    }on dio.DioError catch (err) {
      onPurseCategoryLoadingState = false;
      onPurseCategoryErrorState = false;
      update();
      final errorMessage = Future.error(ApiError.fromDio(err));
      Get.snackbar('Error', err.response?.data['data']['error'] ?? errorMessage.toString());
      throw errorMessage;
    } catch (err) {
      onPurseCategoryLoadingState = false;
      onPurseCategoryErrorState = false;
      update();
      Get.snackbar('Something Went Wrong',err.toString());
      throw err.toString();
    }
  }

  DeleteExpensesResponse? deleteExpensesResponse;
  final _controller = Get.put(PurseController());
  Future<void> deleteExpenses({required String expensesId, required BuildContext context})async{
    progressIndicator(context);
    try{
      final response = await NetworkProvider().call(path: "/v1/pulseexpenses/$expensesId", method: RequestMethod.delete);
      final payload = DeleteExpensesResponse.fromJson(response?.data);
      await _controller.purseList();
      Get.back();
      Get.back();
      Get.snackbar('Success', payload.data?.message ?? "Record Deleted Successfully");
    }on dio.DioError catch (err) {
      final errorMessage = Future.error(ApiError.fromDio(err));
      Get.back();
      update();
      Get.snackbar('Error', err.response?.data['data']['error'] ?? errorMessage.toString());
      throw errorMessage;
    } catch (err) {
      Get.back();
      update();
      Get.snackbar('Something Went Wrong',err.toString());
      throw err.toString();
    }
  }


}