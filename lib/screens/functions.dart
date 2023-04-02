import '../repository/controllers/bill_controller.dart';
import 'individual/bills/models/bill_post_model.dart';
import 'individual/transactions/transaction_successful.dart';
import 'package:flutter/material.dart';

// void buyAirtime(BuildContext context, WidgetRef ref, String pin) {
//   String amount = buyAirtimeFields.amount;
//   String serviceId = buyAirtimeFields.serviceid;
//   String phone = buyAirtimeFields.getphone;

//   ref
//       .read(billControllerProvider.notifier)
//       .buyAirtime(phone, serviceId, amount, pin)
//       .then((value) {
//     if (value.code != 200) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(value.error!),
//         ),
//       );
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Purchase successful'),
//         ),
//       );

//       Future.delayed(const Duration(seconds: 3), () {
//         // setState(() {
//         Navigator.of(context).pushReplacement(MaterialPageRoute(
//             builder: (BuildContext context) => const TransactionSuccessful()));
//       });
//       // });
//     }
//   });
// }

// void buyData(BuildContext context, WidgetRef ref, String pin) {
//   String amount = buyDataFields.amount;
//   String serviceID = buyDataFields.serviceid;
//   String phone = buyDataFields.getphone;
//   String billerCode = buyDataFields.billersCode;
//   String variationCode = buyDataFields.variationCode;

//   ref
//       .read(billControllerProvider.notifier)
//       .buyData(phone, serviceID, variationCode, billerCode, amount, pin)
//       .then((value) {
//     if (value.code != 200) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(value.error!),
//         ),
//       );
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Purchase successful'),
//         ),
//       );

//       Future.delayed(const Duration(milliseconds: 1000), () {
//         // setState(() {
//         Navigator.of(context).pushReplacement(MaterialPageRoute(
//             builder: (BuildContext context) => TransactionSuccessful(
//                   amount: amount,
//                   number: phone,
//                 )));
//       });
//       // });
//     }
//   });
// }

// void buyElectricity(BuildContext context, WidgetRef ref, String pin) {
//   String amount = buyElectricityFields.amount;
//   String serviceID = buyElectricityFields.serviceid;
//   String phone = buyElectricityFields.getphone;
//   String billerCode = buyElectricityFields.billersCode;
//   String variationCode = buyElectricityFields.variationCode;

//   ref
//       .read(billControllerProvider.notifier)
//       .buyElectricity(phone, serviceID, variationCode, billerCode, amount, pin)
//       .then((value) {
//     if (value.code != 200) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(value.error!),
//         ),
//       );
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Purchase successful'),
//         ),
//       );

//       Future.delayed(const Duration(milliseconds: 1000), () {
//         // setState(() {
//         Navigator.of(context).pushReplacement(MaterialPageRoute(
//             builder: (BuildContext context) => const TransactionSuccessful()));
//       });
//       // });
//     }
//   });
// }

// void cableSubscription(BuildContext context, WidgetRef ref, String pin) {
//   String amount = buyDataFields.amount;
//   String serviceID = buyDataFields.serviceid;
//   String phone = buyDataFields.getphone;
//   String billerCode = buyDataFields.billersCode;
//   String variationCode = buyDataFields.variationCode;

//   ref
//       .read(billControllerProvider.notifier)
//       .cableSubscription(
//           phone, serviceID, variationCode, billerCode, amount, pin)
//       .then((value) {
//     if (value.code != 200) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(value.error!),
//         ),
//       );
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Purchase successful'),
//         ),
//       );

//       Future.delayed(const Duration(milliseconds: 1000), () {
//         // setState(() {
//         Navigator.of(context).pushReplacement(MaterialPageRoute(
//             builder: (BuildContext context) => const TransactionSuccessful()));
//       });
//       // });
//     }
//   });
// }

// void buyInternet(BuildContext context, WidgetRef ref, String pin) {
//   String amount = buyInternetFields.amount;
//   String serviceID = buyInternetFields.serviceid;
//   String phone = buyInternetFields.getphone;
//   String billerCode = buyInternetFields.billersCode;
//   String variationCode = buyInternetFields.variationCode;

//   ref
//       .read(billControllerProvider.notifier)
//       .buyInternet(phone, serviceID, variationCode, billerCode, amount, pin)
//       .then((value) {
//     if (value.code != 200) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(value.error!),
//         ),
//       );
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Purchase successful'),
//         ),
//       );

//       Future.delayed(const Duration(milliseconds: 1000), () {
//         // setState(() {
//         Navigator.of(context).pushReplacement(MaterialPageRoute(
//             builder: (BuildContext context) => const TransactionSuccessful()));
//       });
//       // });
//     }
//   });
// }

void goToPage(BuildContext context, Widget route) {
  Navigator.of(context)
      .push(MaterialPageRoute(builder: (BuildContext context) => route));
}
