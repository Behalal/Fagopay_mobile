import 'package:fagopay/models/notification/mark_notification_as_read_response.dart';
import 'package:fagopay/models/notification/notification_response.dart';
import 'package:fagopay/screens/widgets/progress_indicator.dart';
import 'package:fagopay/service/network_services/dio_service_config/dio_client.dart';
import 'package:fagopay/service/network_services/dio_service_config/dio_error.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;

class NotificationController extends GetxController{
  bool? onLoadingNotification;
  bool? onNotificationResponseError;
  NotificationResponse? notificationResponse;
  int notificationLength = 0;

  Future<void> getNotification()async{
    onLoadingNotification = true;
    onNotificationResponseError = false;
    update();
    try{
      final response = await NetworkProvider().call(path: "/v1/notifications", method: RequestMethod.get);
      notificationResponse = NotificationResponse.fromJson(response?.data);
      if(NotificationResponse.fromJson(response?.data).data?.notifications != null){
        notificationLength = NotificationResponse.fromJson(response?.data).data!.notifications!.where((element) => element.status == "Unread").toList().length;
        update();
      }
      onLoadingNotification = false;
      onNotificationResponseError = false;
      update();
    }on dio.DioError catch (err) {
      onNotificationResponseError = true;
      onLoadingNotification = false;
      update();
      final errorMessage = Future.error(ApiError.fromDio(err));
      throw errorMessage;
    } catch (err) {
      onNotificationResponseError = true;
      onLoadingNotification = false;
      update();
      throw err.toString();
    }
  }

  Future<void> markNotificationAsRead({required String notificationId, required BuildContext context})async{
    progressIndicator(context);
    try{
      final response = await NetworkProvider().call(path: "/v1/notifications/mark-as-read/$notificationId", method: RequestMethod.get);
      await getNotification();
      final payload = MarkAsReadResponse.fromJson(response?.data);
      Get.back();
      Get.snackbar("Success",payload.data?.message ?? "Marked as read");
    }on dio.DioError catch (err) {
      Get.back();
      final errorMessage = Future.error(ApiError.fromDio(err));
      Get.snackbar('Error', err.response?.data['data']['error'] ?? errorMessage.toString());
      throw errorMessage;
    } catch (err) {
      Get.back();
      Get.snackbar('Something Went Wrong',err.toString());
      throw err.toString();
    }
  }
}