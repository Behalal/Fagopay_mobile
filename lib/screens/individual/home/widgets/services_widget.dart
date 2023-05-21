import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/user_controller.dart';
import '../../bills/data.dart';
import '../../bills/electricity.dart';
import '../../refer_and_win/refer_page.dart';
import '../../requests/requests.dart';
import '../../transactions/fago_to_bank.dart';
import '../../transactions/fago_to_fago.dart';

class Services {
  final String image;
  final String itemName;
  final Widget? route;
  const Services({required this.image, this.route, required this.itemName});
}

final _userController = Get.find<UserController>();
List<Services> services = [
  Services(
    image: 'assets/icons/new_tansfer_icon.svg',
    itemName: 'Transfer',
    route: FagoToBank(
      userDetails: _userController.user!,
      accountDetails: _userController.userAccountDetails!,
    ),
  ),
  const Services(
    image: 'assets/icons/new_paymentLink_icon.svg',
    itemName: 'Fago2Fago',
    route: FagoToFago(),
  ),
  const Services(
    image: 'assets/icons/new_scanToPay_icon.svg',
    itemName: 'Scan to Pay',
    route: null,
  ),
  const Services(
    image: 'assets/icons/new_requestMoney_icon.svg',
    itemName: 'Request Money',
    route: RequestHome(),
  ),
  const Services(
    image: 'assets/icons/new_airtime_icon.svg',
    itemName: 'Airtime & Data',
    route: BuyData(),
  ),
  const Services(
    image: 'assets/icons/new_payInternet_icon.svg',
    itemName: 'Bills Payment',
    route: Electricity(),
  ),
  const Services(
    image: 'assets/icons/new_swapAirtime_icon.svg',
    itemName: 'Swap Airtime',
    route: BuyData(),
  ),
  const Services(
    image: 'assets/icons/new_payment_link_2.svg',
    itemName: 'Payment Link',
    route: ReferAndEarn(),
  )
];


// class SelectCard extends StatefulWidget {
//   const SelectCard({this.onclick, this.title, this.icon}) : super(key: key);

//   @override
//   State<SelectCard> createState() => _SelectCardState();
// }

// class _SelectCardState extends State<SelectCard> {
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//         color: Colors.orange,
//         child: Center(
//           child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: <Widget>[
//                 Expanded(
//                     child: Icon(widget.choice.icon,
//                         size: 50.0, color: textStyle.color)),
//                 Text(widget.choice.title, style: textStyle),
//               ]),
//         ));
//   }
// }
