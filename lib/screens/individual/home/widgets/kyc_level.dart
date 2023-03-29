import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../constants/colors.dart';

class KycLevelNotifier extends StatelessWidget {
  final double fullwidth;
  final double kycPercentage;
  final String? username;
  const KycLevelNotifier(
      {super.key,
      required this.fullwidth,
      required this.kycPercentage,
      this.username});

  @override
  Widget build(BuildContext context) {
    double activePercentage = (kycPercentage * fullwidth) / 100;
    double inactivePercentage = fullwidth - activePercentage;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
      decoration: const BoxDecoration(
        color: fagoPrimaryColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Image.asset(
                "assets/images/Ellipse 62.png",
                width: 24,
                height: 24,
              ),
              Image.asset("assets/images/bi_shield-lock2.png"),
            ],
          ),
          SizedBox(
            width: 2.w,
          ),
          SizedBox(
            width: 60.w,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AutoSizeText(
                  "Attention ${username!}!",
                  style: const TextStyle(
                      fontFamily: "Work Sans",
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: white),
                ),
                SizedBox(
                  height: 1.h,
                ),
                const AutoSizeText(
                  "Complete your KYC requirements to access our banking services. It will help secure & protect your account from impersonation.",
                  style: TextStyle(
                      fontFamily: "Work Sans",
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                      color: white),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 2,
                      width: activePercentage,
                      decoration: const BoxDecoration(
                          color: fagoSecondaryColor,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                    Container(
                      height: 2,
                      width: inactivePercentage,
                      decoration: const BoxDecoration(
                          color: fagoSecondaryColorWithOpacity,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                    SizedBox(
                      width: 1.w,
                    ),
                    AutoSizeText(
                      "${kycPercentage.toInt()}%",
                      style: const TextStyle(
                          fontFamily: "Work Sans",
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          color: white),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            width: 3.w,
          ),
          Image.asset("assets/images/arrow-right-white.png"),
        ],
      ),
    );
  }
}
