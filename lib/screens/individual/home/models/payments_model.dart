import 'package:fagopay/screens/constants/colors.dart';
import 'package:fagopay/screens/individual/requests/requests.dart';
import 'package:fagopay/screens/individual/transactions/fago_to_bank.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../models/user_model/user.dart';

class PaymentModel {
  Widget image;
  String description;
  Widget? route;

  PaymentModel({
    required this.image,
    required this.description,
    required this.route,
  });
}

List<PaymentModel> paymentContents = [
  // PaymentModel(
  //   description: 'Send Money',
  //   image: SvgPicture.asset(
  //     'assets/icons/send-bold.svg',
  //     height: 25,
  //     width: 25,
  //     theme: const SvgTheme(
  //       currentColor: fagoPrimaryColor,
  //     ),
  //   ),
  //   route: FagoToBank(userDetails: userFullDetails,),
  // ),
  PaymentModel(
    description: 'Scan and Pay',
    image: SvgPicture.asset(
      'assets/icons/scan-qr.svg',
      height: 25,
      width: 25,
      theme: const SvgTheme(
        currentColor: fagoPrimaryColor,
      ),
    ),
    route: null,
  ),
  PaymentModel(
    description: 'Withdraw',
    image: SvgPicture.asset(
      'assets/icons/person-tag.svg',
      height: 25,
      width: 25,
      theme: const SvgTheme(
        currentColor: fagoPrimaryColor,
      ),
    ),
    route: null,
  ),
  PaymentModel(
    description: 'Request Money',
    image: SvgPicture.asset(
      'assets/icons/person-tag.svg',
      height: 25,
      width: 25,
      theme: const SvgTheme(
        currentColor: fagoPrimaryColor,
      ),
    ),
    route: const RequestHome(),
  ),
];
