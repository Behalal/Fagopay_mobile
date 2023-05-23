import 'package:auto_size_text/auto_size_text.dart';
import '../../../constants/colors.dart';
import '../../../constants/currency.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomInvoiceCard extends StatelessWidget {
  const CustomInvoiceCard({
    Key? key,
    required this.total,
    required this.customerName,
    required this.date,
    required this.status,
    required this.onPressed,
  }) : super(key: key);

  final String customerName, date, status, total;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: EdgeInsets.only(bottom: 2.h),
        child: SizedBox(
          width: 90.w,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 60.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 3.w,
                          backgroundColor: fagoSecondaryColorWithOpacity10,
                          child: Image.asset(
                            "assets/images/stickynote.png",
                            color: status == 'paid'
                                ? inactiveTabWithOpacity30
                                : null,
                          ),
                        ),
                        SizedBox(
                          width: 2.w,
                        ),
                        SizedBox(
                          width: 50.w,
                          child: Column(
                            children: [
                              SizedBox(
                                width: 50.w,
                                child: AutoSizeText(
                                  customerName,
                                  style: TextStyle(
                                      fontFamily: "Work Sans",
                                      fontSize: 14,
                                      color: status == 'paid'
                                          ? inactiveTabWithOpacity30
                                          : inactiveTab,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              SizedBox(
                                width: 50.w,
                                child: AutoSizeText(
                                  "Date Paid: $date",
                                  style: TextStyle(
                                      fontFamily: "Work Sans",
                                      fontSize: 12,
                                      color: status == 'paid'
                                          ? inactiveTabWithOpacity30
                                          : inactiveTab,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Spacer(),
              if (status == 'paid')
                SizedBox(
                    width: 10.w,
                    child: Image.asset("assets/images/paidBanner.png")),
              if (status == 'paid') SizedBox(width: 10.w),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  AutoSizeText(
                    "$currencySymbol ${double.parse(total).toStringAsFixed(1)}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: "Work Sans",
                        fontSize: 12,
                        color: (status == 'paid')
                            ? fagoGreenColorWithOpacity17
                            : fagoSecondaryColor,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 0.5.h,
                  ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 2.w, vertical: .5.h),
                    decoration: BoxDecoration(
                      color: (status == 'paid')
                          ? fagoGreenColorWithOpacity17
                          : fagoSecondaryColorWithOpacity10,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(25),
                      ),
                    ),
                    child: AutoSizeText(
                      status == 'paid' ? "Paid" : "Unpaid",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: "Work Sans",
                          fontSize: 8,
                          color: status == 'paid'
                              ? inactiveTabWithOpacity30
                              : fagoGreenColor,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
