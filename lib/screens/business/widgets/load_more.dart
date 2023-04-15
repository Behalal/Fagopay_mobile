import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../constants/colors.dart';

class LoadMore extends StatelessWidget {
  const LoadMore({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 3.h),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 1.h),
        decoration: const BoxDecoration(
            color: fagoSecondaryColor,
            borderRadius: BorderRadius.all(Radius.circular(25))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("assets/images/chart.png"),
            const AutoSizeText(
              "Load More",
              style: TextStyle(
                  fontFamily: "Work Sans",
                  fontSize: 14,
                  color: white,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}