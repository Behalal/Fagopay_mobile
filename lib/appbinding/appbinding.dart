import 'package:fagopay/controllers/expenses_controller.dart';

import '../controllers/admin_controller.dart';
import '../controllers/company_controller.dart';
import '../controllers/purse_controller.dart';
import '../controllers/sales_controller.dart';

import '../controllers/customers_controller.dart';
import '../controllers/locations_controller.dart';
import '../controllers/registration_controller.dart';
import '../controllers/suppliers_controller.dart';
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
    Get.put(PurseController(), permanent: true);
    Get.lazyPut(() => SupplierController());
    Get.lazyPut(() => CustomerController());
    Get.lazyPut(() => LocationsController());
    Get.lazyPut(() => CompanyController());
    Get.lazyPut(() => AdminController());
    Get.lazyPut(() => SalesController());
    Get.lazyPut(() => ExpensesController());
    Get.put(RegistrationController(), permanent: true);
  }
}
