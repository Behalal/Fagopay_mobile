import 'package:get/get.dart';

import '../models/user_model/user.dart';

class UserController extends GetxController {
  final Rx<User?> _user = Rx(null);
  final Rx<AccountDetail?> _userAccountDetails = Rx(null);

  User? get user => _user.value;

  set setUser(User? user) {
    _user(user);
  }

  AccountDetail? get userAccountDetails => _userAccountDetails.value;

  set setUserAccountDetails(AccountDetail? userAccountDetails) {
    _userAccountDetails(userAccountDetails);
  }
}
