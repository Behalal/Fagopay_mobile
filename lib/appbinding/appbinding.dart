import '../controllers/login_controller.dart';
import '../controllers/user_controller.dart';
import 'package:get/get.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    // Get.put(RegistrationController(), permanent: true);
    Get.put(LoginController(), permanent: true);
    Get.put(UserController(), permanent: true);
  }
}
