import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

import '../../constants/colors.dart';
import '../../functions.dart';

class NoRecordFound extends StatelessWidget {
  final String recordText;
  final String recordDescription;
  final Widget recordRoute;
  const NoRecordFound({
    super.key, required this.recordText, required this.recordRoute, required this.recordDescription,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90.w,
      padding: EdgeInsets.only(bottom: 4.h, right: 4.w),
      decoration: const BoxDecoration(
        color: fagoSecondaryColorWithOpacity10,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                "assets/images/circles.png",
                width: 30.w,
              ),
              SizedBox(width: 4.w),
              Padding(
                padding: EdgeInsets.only(top: 6.h),
                child: Center(
                  child: SvgPicture.asset(
                    "assets/images/archive-book2.svg",
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 1.5.h,
          ),
          Center(
            child: AutoSizeText(
              "No $recordText yet",
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: "Work Sans",
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: inactiveTab,
              ),
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          SizedBox(
            width: 90.w,
            child: AutoSizeText(
              recordDescription,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: "Work Sans",
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: inactiveTab,
              ),
            ),
          ),
          SizedBox(
            height: 4.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 5.w,
            ),
            child: InkWell(
              onTap: () {
                goToPage(context, recordRoute);
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 1.2.h, horizontal: 3.w),
                decoration: const BoxDecoration(
                  color: fagoSecondaryColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(25),
                  ),
                ),
                child: Center(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          "assets/images/stickynote.svg",
                          color: white,
                        ),
                        AutoSizeText(
                          "Add a $recordText",
                          style: const TextStyle(
                            fontFamily: "Work Sans",
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: white,
                          ),
                        ),
                      ]),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}