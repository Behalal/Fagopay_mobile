import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../constants/colors.dart';

class BusinessWarning extends StatelessWidget {
  final Color? boxBackground;
  final String? warningImage;
  final String? warning;

  const BusinessWarning({super.key, this.boxBackground, this.warningImage, this.warning});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: (boxBackground != null)
            ? boxBackground!
            : fagoSecondaryColorWithOpacity10,
      ),
      padding: EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 2.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          (warningImage != null)
              ? Image.asset(warningImage!)
              : Image.asset("assets/images/warning.png"),
          SizedBox(
            width: 3.w,
          ),
          SizedBox(
            width: 70.w,
            child: AutoSizeText(
              (warning != null)? warning! :"Having record about your customer will help you keep track of them and can personalize messages to them.",
              style: const TextStyle(
                  fontFamily: "Work Sans",
                  fontSize: 10,
                  color: inactiveTab,
                  fontWeight: FontWeight.w400),
            ),
          )
        ],
      ),
    );
  }
}
