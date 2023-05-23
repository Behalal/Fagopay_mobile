import 'package:auto_size_text/auto_size_text.dart';
import 'package:fagopay/screens/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class OrderItemButton extends StatelessWidget {
  const OrderItemButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 30.w),
      decoration: const BoxDecoration(
        color: fagoSecondaryColorWithOpacity10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/addIcon.png",
          ),
          SizedBox(
            width: 1.w,
          ),
          const AutoSizeText(
            "Order Item",
            style: TextStyle(
              fontFamily: "Work Sans",
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: fagoSecondaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
