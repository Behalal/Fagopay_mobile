// import 'package:fagopay/models/auth_model/auth.dart';
// import 'package:fagopay/models/data_model.dart';
// import 'package:fagopay/repository/bills_repository.dart';
// import 'package:fagopay/repository/login_states/login_states.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class BillController extends StateNotifier<LoginState> {
//   BillController(this.ref) : super(const LoginStateInitial());

//   final Ref ref;

//   Future<Auth> buyAirtime(String phone, String serviceID, String amount,
//       String transactionPin) async {
//     state = const LoginStateLaoding();

//     Auth response = await ref
//         .read(billRepositoryProvider)
//         .buyAirtime(phone, serviceID, amount, transactionPin);
//     state = const LoginStateSuccess();
//     // response.printAttributes();
//     return response;
//   }

//   Future<Data> getDatabyServiceId(String serviceID) async {
//     state = const LoginStateLaoding();

//     Data response =
//         await ref.read(billRepositoryProvider).getDataByServiceId(serviceID);
//     state = const LoginStateSuccess();
//     // response.printAttributes();
//     return response;
//   }

//   Future<Auth> buyData(String phone, String serviceID, String variationCode,
//       String billerCode, String amount, String transactionPin) async {
//     state = const LoginStateLaoding();

//     Auth response = await ref.read(billRepositoryProvider).buyData(
//         phone, serviceID, variationCode, billerCode, amount, transactionPin);
//     state = const LoginStateSuccess();
//     // response.printAttributes();
//     return response;
//   }

//   Future<Auth> verifyInternetNo(String billerCode) async {
//     state = const LoginStateLaoding();

//     Auth response =
//         await ref.read(billRepositoryProvider).verifyInternetNo(billerCode);
//     state = const LoginStateSuccess();
//     // response.printAttributes();
//     return response;
//   }

//   Future<Auth> buyInternet(String phone, String serviceID, String variationCode,
//       String billerCode, String amount, String transactionPin) async {
//     state = const LoginStateLaoding();

//     Auth response = await ref.read(billRepositoryProvider).buyInternet(
//         phone, serviceID, variationCode, billerCode, amount, transactionPin);
//     state = const LoginStateSuccess();
//     // response.printAttributes();
//     return response;
//   }

//   Future<Auth> verifyMeterNo(
//       String serviceID, String billerCode, String type) async {
//     state = const LoginStateLaoding();

//     Auth response = await ref
//         .read(billRepositoryProvider)
//         .verifyMeterNo(serviceID, billerCode, type);
//     state = const LoginStateSuccess();
//     // response.printAttributes();
//     return response;
//   }

//   Future<Auth> buyElectricity(
//       String phone,
//       String serviceID,
//       String variationCode,
//       String billerCode,
//       String amount,
//       String transactionPin) async {
//     state = const LoginStateLaoding();

//     Auth response = await ref.read(billRepositoryProvider).buyElectricity(
//         phone, serviceID, variationCode, billerCode, amount, transactionPin);
//     state = const LoginStateSuccess();
//     // response.printAttributes();
//     return response;
//   }

//   Future<Auth> verifySmartCard(String serviceID, String billerCode) async {
//     state = const LoginStateLaoding();

//     Auth response = await ref
//         .read(billRepositoryProvider)
//         .verifySmartCard(serviceID, billerCode);
//     state = const LoginStateSuccess();
//     // response.printAttributes();
//     return response;
//   }

//   Future<Auth> cableSubscription(
//       String phone,
//       String serviceID,
//       String variationCode,
//       String billerCode,
//       String amount,
//       String transactionPin) async {
//     state = const LoginStateLaoding();

//     Auth response = await ref.read(billRepositoryProvider).cableSubscription(
//         phone, serviceID, variationCode, billerCode, amount, transactionPin);
//     state = const LoginStateSuccess();
//     // response.printAttributes();
//     return response;
//   }
// }

// final billControllerProvider =
//     StateNotifierProvider<BillController, LoginState>((ref) {
//   return BillController(ref);
// });
