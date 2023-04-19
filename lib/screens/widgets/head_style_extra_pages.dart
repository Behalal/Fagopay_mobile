// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fagopay/screens/functions.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../constants/colors.dart';

class ProgressStyle extends StatelessWidget {
  final Widget? backRoute;
  final String pageName;
  final int stage;
  final double? width;
  final String? icon;
  
  const ProgressStyle({
    Key? key,
    this.backRoute,
    required this.pageName,
    required this.stage,
    this.width,
    this.icon,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        mainAxisAlignment: (icon != null)
            ? MainAxisAlignment.spaceBetween
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              if (backRoute != null) {
                goToPage(context, backRoute!);
              } else {
                Navigator.of(context).pop();
              }
            },
            icon: const Image(image: AssetImage("assets/images/Icon.png")),
            iconSize: 20,
          ),
          if (icon == null)
            SizedBox(
              width: 8.w,
            ),
          Text(
            pageName,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: "Work Sans",
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: fagoSecondaryColor,
            ),
          ),
          if (icon != null) Image.asset(icon!),
        ],
      ),
      const SizedBox(
        height: 10,
      ),
      Row(
        children: [
          Container(
            height: (width != null) ? width : 2,
            width: (stage > 0) ? ((stage == 100) ? 90.w : 45.w) : 0,
            decoration: const BoxDecoration(
                color: fagoSecondaryColor,
                borderRadius: BorderRadius.all(Radius.circular(10))),
          ),
          Container(
            height: 2,
            width: (stage > 0) ? ((stage == 50) ? 45.w : 0) : 90.w,
            decoration: const BoxDecoration(
                color: fagoSecondaryColorWithOpacity,
                borderRadius: BorderRadius.all(Radius.circular(10))),
          ),
        ],
      ),
    ]);
  }
}
