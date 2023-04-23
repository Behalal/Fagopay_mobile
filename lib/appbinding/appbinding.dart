import 'package:fagopay/controllers/customers_controller.dart';
import 'package:fagopay/controllers/locations_controller.dart';
import 'package:fagopay/controllers/suppliers_controller.dart';
import 'package:get/get.dart';

import '../controllers/bill_controller.dart';
import '../controllers/login_controller.dart';
import '../controllers/request_money_controller.dart';
import '../controllers/transaction_controller.dart';
import '../controllers/user_controller.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    // Get.put(RegistrationController(), permanent: true);
    Get.lazyPut(() => LoginController());
    Get.lazyPut(() => UserController());
    Get.lazyPut(() => TransactionController());
    Get.lazyPut(() => BillController());
    Get.lazyPut(() => RequestMoney());
    Get.lazyPut(() => CustomerController());
    Get.lazyPut(() => SupplierController());
    Get.lazyPut(() => LocationsController());
  }
}
