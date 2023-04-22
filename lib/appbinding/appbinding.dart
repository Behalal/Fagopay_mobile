import 'package:fagopay/controllers/registration_controller.dart';
import 'package:get/get.dart';

import '../controllers/bill_controller.dart';
import '../controllers/login_controller.dart';
import '../controllers/request_money_controller.dart';
import '../controllers/transaction_controller.dart';
import '../controllers/user_controller.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(RegistrationController(), permanent: true);
    Get.put(LoginController(), permanent: true);
    Get.put(UserController(), permanent: true);
    Get.put(TransactionController(), permanent: true);
    Get.put(BillController(), permanent: true);
    Get.put(RequestMoney(), permanent: true);
    //Get.put(RegistrationController(), permanent: true);
  }
}
