// import 'package:fagopay/models/bank_model.dart';
// import 'package:fagopay/models/verify_account_model.dart';
// import 'package:fagopay/service/transactions_service.dart';

// class TransactionRepository {
//   final TransactionService _authService;
//   TransactionRepository(this._authService);

//   Future<Banks> getBanks() async {
//     String response = await _authService.getAllBanks();
//     Banks authResponse = Banks.fromReqBody(response);
//     authResponse.printAttributes();
//     return authResponse;
//   }

//   Future<VerifyAccountNo> getBankDetails(
//       String bankCode, String accountNo) async {
//     Map<String, dynamic> response =
//         await _authService.getAccountDetails(bankCode, accountNo);
//     VerifyAccountNo authResponse = VerifyAccountNo.fromJson(response);

//     return authResponse;
//   }
// }

// // final transactionRepositoryProvider = Provider<TransactionRepository>((ref) {
// //   return TransactionRepository(ref.read(transactionServiceProvider));
// // });
