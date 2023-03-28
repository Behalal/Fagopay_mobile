import 'package:fagopay/models/user_model/user.dart';
import 'package:fagopay/screens/constants/colors.dart';
import 'package:fagopay/screens/dashboard/bills/data.dart';
import 'package:fagopay/screens/dashboard/bills/electricity.dart';
import 'package:fagopay/screens/dashboard/bills/internet.dart';
import 'package:fagopay/screens/dashboard/bills/tv.dart';
import 'package:fagopay/screens/dashboard/requests/requests.dart';
import 'package:fagopay/screens/dashboard/transactions/fago_to_bank.dart';
import 'package:fagopay/screens/dashboard/transactions/fago_to_fago.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ServiceModel {
  Widget image;
  String? description;
  Widget? route;

  ServiceModel({required this.image, this.description, required this.route});
}

List<ServiceModel> serviceContent = [
  ServiceModel(
    description: 'Bank Transfer',
    image: SvgPicture.asset(
      'assets/icons/bank.svg',
      height: 20,
      width: 20,
      color: fagoPrimaryColor,
    ),
    route: FagoToBank( userDetails: userFullDetails),
  ),
  ServiceModel(
    description: 'Send Fago User',
    image: SvgPicture.asset(
      'assets/icons/send.svg',
      height: 20,
      width: 20,
      color: fagoPrimaryColor,
    ),
    route: const FagoToFago(),
  ),
  ServiceModel(
    description: 'Airtime and Data',
    image: SvgPicture.asset(
      'assets/icons/smartphone.svg',
      height: 20,
      width: 20,
      color: fagoPrimaryColor,
    ),
    route: const BuyData(),
  ),
  ServiceModel(
    description: 'Buy Electricity',
    image: SvgPicture.asset(
      'assets/icons/scroll.svg',
      height: 20,
      width: 20,
      color: fagoPrimaryColor,
    ),
    route: const Electricity(),
  ),
  // ServiceModel(
  //   description: 'Buy internet',
  //   image: SvgPicture.asset(
  //     'assets/icons/scroll.svg',
  //     height: 25,
  //     width: 25,
  //     color: fagoPrimaryColor,
  //   ),
  //   route: const Internrt(),
  // ),
  ServiceModel(
    description: 'Subscribe TV',
    image: SvgPicture.asset(
      'assets/icons/phonebook.svg',
      height: 20,
      width: 20,
      color: fagoPrimaryColor,
    ),
    route: const TVSubscription(),
  ),
  ServiceModel(
    description: 'Subscribe Internet',
    image: SvgPicture.asset(
      'assets/icons/scan-qr.svg',
      height: 20,
      width: 20,
      color: fagoPrimaryColor,
    ),
    route: const Internrt(),
  ),
  ServiceModel(
    description: 'Request Money',
    image: SvgPicture.asset(
      'assets/icons/person-tag.svg',
      height: 20,
      width: 20,
      color: fagoPrimaryColor,
    ),
    route: const RequestHome(),
  ),

  ServiceModel(
    description: "More",
    image: const Icon(
      Icons.more_horiz,
      size: 20,
      color: fagoPrimaryColor,
    ),
    route: const RequestHome(),
  ),
];
