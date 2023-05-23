import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../constants/colors.dart';

class TermsAndCond extends StatelessWidget {
  const TermsAndCond({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 85.w,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 0.2.w),
        child: Column(
          children: [
            const AutoSizeText(
              "By clicking the continue button, it means you agree to",
              // "hello",
              textAlign: TextAlign.center,
              minFontSize: 10,
              stepGranularity: 10,
              maxLines: 4,
              style: TextStyle(
                fontFamily: "Work Sans",
                fontSize: 11,
                color: termsAndCond,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(
              height: 0.5.h,
            ),
            const AutoSizeText(
              "FagoPay’s Terms and Condition",
              // "hello",
              textAlign: TextAlign.center,
              minFontSize: 10,
              stepGranularity: 10,
              maxLines: 4,
              style: TextStyle(
                fontFamily: "Work Sans",
                fontSize: 12,
                color: fagoSecondaryColor,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
