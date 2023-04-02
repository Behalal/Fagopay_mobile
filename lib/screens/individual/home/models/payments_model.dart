import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../controllers/user_controller.dart';
import '../../../constants/colors.dart';
import '../../requests/requests.dart';
import '../../transactions/fago_to_bank.dart';

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

final _userController = Get.find<UserController>();

List<PaymentModel> paymentContents = [
  PaymentModel(
    description: 'Send Money',
    image: SvgPicture.asset(
      'assets/icons/send-bold.svg',
      height: 25,
      width: 25,
      theme: const SvgTheme(
        currentColor: fagoPrimaryColor,
      ),
    ),
    route: Obx(
      () => FagoToBank(
        userDetails: _userController.user!,
      ),
    ),
  ),
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
