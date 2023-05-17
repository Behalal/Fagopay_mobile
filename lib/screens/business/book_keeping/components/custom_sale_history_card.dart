import 'package:auto_size_text/auto_size_text.dart';
import '../../../constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomSaleHistoryCard extends StatelessWidget {
  final String customerName,
      salesDescription,
      salesStatus,
      salesAmount,
      salesDate;

  const CustomSaleHistoryCard(
      {super.key,
      required this.customerName,
      required this.salesDescription,
      required this.salesStatus,
      required this.salesAmount,
      required this.salesDate});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 1.h),
      width: 90.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/inflow.png',
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
                    customerName,
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
                      salesDescription,
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
                    salesDate,
                    style: const TextStyle(
                        fontFamily: "Work Sans",
                        fontSize: 12,
                        color: inactiveTab,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AutoSizeText(
                'NGN ${double.parse(salesAmount).toStringAsFixed(1)}',
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
              Container(
                padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.6.h),
                decoration: const BoxDecoration(
                    color: fagoGreenColorWithOpacity10,
                    borderRadius: BorderRadius.all(Radius.circular(25))),
                child: AutoSizeText(
                  salesStatus,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "Work Sans",
                    fontSize: 8,
                    color: salesStatus == 'Fully Paid'
                        ? fagoGreenColor
                        : Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
