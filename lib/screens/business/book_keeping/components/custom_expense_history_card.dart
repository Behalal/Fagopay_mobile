import 'package:auto_size_text/auto_size_text.dart';
import '../../../constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SupplierExpenseHistoryCard extends StatelessWidget {
  final String supplierName, note, expenseDate, categoryName, amount;

  const SupplierExpenseHistoryCard(
      {super.key,
      required this.supplierName,
      required this.note,
      required this.expenseDate, required this.categoryName, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 1.h),
      width: 90.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/outflow.png',
            // width: 8.w,
          ),
          SizedBox(
            width: 2.w,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AutoSizeText(
                supplierName,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontFamily: "Work Sans",
                    fontSize: 14,
                    color: inactiveTab,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 0.5.h,
              ),
              SizedBox(
                width: 50.w,
                child: AutoSizeText(
                  note,
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontFamily: "Work Sans",
                      fontSize: 12,
                      color: inactiveTab,
                      fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(
                height: 0.5.h,
              ),
              AutoSizeText(
                expenseDate,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontFamily: "Work Sans",
                    fontSize: 12,
                    color: inactiveTab,
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                AutoSizeText(
                  'NGN ${double.parse(amount).toStringAsFixed(1)}',
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                      fontFamily: "Work Sans",
                      fontSize: 10,
                      color: fagoSecondaryColor,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 0.5.h,
                ),
                AutoSizeText(
                  categoryName,
                  textAlign: TextAlign.right, maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontFamily: "Work Sans",
                      fontSize: 12,
                      color: inactiveTab,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
