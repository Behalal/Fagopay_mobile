import 'dart:developer';

import 'package:fagopay/service/constants/constants.dart';
import 'package:fagopay/service/networking/network_helper.dart';
import 'package:fagopay/service/secure_storage/secure_storage.dart';
import 'package:get/get.dart';

class TransactionController extends GetxController {
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

  //   Future<VerifyAccountNo> getBankDetails(
//       String bankCode, String accountNo) async {
//     state = const LoginStateLaoding();

//     VerifyAccountNo response = await ref
//         .read(transactionRepositoryProvider)
//         .getBankDetails(bankCode, accountNo);
//     state = const LoginStateSuccess();
//     // response.printAttributes();
//     return response;
//   }
}
