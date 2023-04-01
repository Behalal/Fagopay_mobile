// import 'package:fagopay/models/bank_model.dart';
// import 'package:fagopay/models/verify_account_model.dart';
// import 'package:fagopay/repository/banks_repository.dart';
// import 'package:fagopay/repository/login_states/login_states.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class TransactionController extends StateNotifier<LoginState> {
//   TransactionController(this.ref) : super(const LoginStateInitial());

//   final Ref ref;

//   Future<Banks> getAllBanks() async {
//     state = const LoginStateLaoding();

//     Banks response = await ref.read(transactionRepositoryProvider).getBanks();
//     state = const LoginStateSuccess();
//     // response.printAttributes();
//     return response;
//   }

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
// }

// final transactionControllerProvider =
//     StateNotifierProvider<TransactionController, LoginState>((ref) {
//   return TransactionController(ref);
// });
