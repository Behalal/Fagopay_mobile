import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../constants/colors.dart';

class BusinessCustomerDetails extends StatelessWidget {
  const BusinessCustomerDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 3.w),
      decoration: const BoxDecoration(
        color: fagoSecondaryColorWithOpacity10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 60.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 3.w,
                  backgroundColor: fagoSecondaryColorWithOpacity10,
                  child: Image.asset(
                    "assets/images/gallery.png",
                  ),
                ),
                SizedBox(
                  width: 2.w,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 50.w,
                      child: const AutoSizeText(
                        "Obasa Yussuf",
                        style: TextStyle(
                          fontFamily: "Work Sans",
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: inactiveTab,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    SizedBox(
                      width: 50.w,
                      child: const AutoSizeText(
                        "obasana@gmail.com",
                        style: TextStyle(
                          fontFamily: "Work Sans",
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: inactiveTab,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          const AutoSizeText(
            "Change",
            style: TextStyle(
              fontFamily: "Work Sans",
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: fagoSecondaryColor,
            ),
          ),
        ],
      ),
    );
  }
}