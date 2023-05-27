import 'package:auto_size_text/auto_size_text.dart';
import '../../../constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class RemoveItem extends StatelessWidget {
  const RemoveItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 70.w,
          height: 0.5,
          color: fagoBlackColorWithOpacity10,
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 0.5.h, horizontal: 2.w),
          decoration: const BoxDecoration(
              color: fagoSecondaryColorWithOpacity10,
              borderRadius: BorderRadius.all(Radius.circular(50))),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/archive.png",
                ),
                SizedBox(
                  width: 0.3.w,
                ),
                const AutoSizeText(
                  "Remove",
                  style: TextStyle(
                    fontFamily: "Work Sans",
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    color: fagoSecondaryColor,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
