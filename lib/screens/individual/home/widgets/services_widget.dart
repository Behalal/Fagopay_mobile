import 'package:fagopay/screens/individual/bills/data.dart';
import 'package:fagopay/screens/individual/bills/electricity.dart';
import 'package:fagopay/screens/individual/refer_and_win/refer_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Services {
  final String image;
  final String itemName;
  final Widget? route;
  const Services({required this.image, this.route, required this.itemName});
}

List<Services> services = [
  const Services(
    image: 'assets/icons/new_airtime_icon.svg',
    itemName: 'Airtime',
    route: null,
  ),
  const Services(
    image: 'assets/icons/wifi-square.svg',
    itemName: 'Data',
    route:  BuyData(),
  ),
  const Services(
    image: 'assets/icons/new_swapAirtime_icon.svg',
    itemName: 'Swap Airtime',
    route: null,
  ),
  const Services(
    image: 'assets/icons/new_paymentLink_icon.svg',
    itemName: 'Payment Link',
    route: null,
  ),
  const Services(
    image: 'assets/icons/new_payInternet_icon.svg',
    itemName: 'Pay Internet ',
    route: null,
  ),
  const Services(
    image: 'assets/icons/new_Cable_icon.svg',
    itemName: 'Cable TV',
    route: null,
  ),
  const Services(
    image: 'assets/icons/new_electricity_icon.svg',
    itemName: 'Electricity',
    route: Electricity(),
  ),
  const Services(
    image: 'assets/icons/new_rewardCenter_icon.svg',
    itemName: 'Reward Centre',
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
