import 'package:auto_size_text/auto_size_text.dart';
import '../../../constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class InvoiceItemDetailsCard extends StatelessWidget {
  const InvoiceItemDetailsCard({
    super.key,
    required this.itemname,
    required this.price,
    required this.total,
    required this.quantity,
  });

  final String itemname, price, total;
  final int quantity;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 2.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 40.w,
            child: AutoSizeText(
              itemname,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontFamily: "Work Sans",
                fontSize: 12,
                color: inactiveTab,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          AutoSizeText(
            "$quantity * $price",
            style: const TextStyle(
              fontFamily: "Work Sans",
              fontSize: 12,
              color: fagoSecondaryColor,
              fontWeight: FontWeight.w700,
            ),
          ),
          AutoSizeText(
            total,
            style: const TextStyle(
              fontFamily: "Work Sans",
              fontSize: 12,
              color: fagoSecondaryColor,
              fontWeight: FontWeight.w700,
            ),
          ),
          // Image.asset(
          //   "assets/images/archive.png",
          // ),
        ],
      ),
    );
  }
}
