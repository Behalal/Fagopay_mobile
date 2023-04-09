import 'package:auto_size_text/auto_size_text.dart';
import '../../constants/colors.dart';
import '../../constants/currency.dart';
import 'all_admin.dart';
import '../../individual/widgets/head_style_extra_pages.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AdminDetails extends StatefulWidget {
  const AdminDetails({super.key});

  @override
  State<AdminDetails> createState() => _AdminDetailsState();
}

class _AdminDetailsState extends State<AdminDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 5.w),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ProgressStyle(
                  stage: 0,
                  pageName: "Admin Accounts",
                  backRoute: AllAdmin(),
                ),
                SizedBox(
                  height: 3.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/customer_ellipse.png"),
                    SizedBox(
                      width: 60.w,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          AutoSizeText(
                            "Obasa Yussuff",
                            // textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: "Work Sans",
                                fontSize: 24,
                                color: inactiveTab,
                                fontWeight: FontWeight.w500),
                          ),
                          AutoSizeText(
                            "Account Manager",
                            // textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: "Work Sans",
                                fontSize: 12,
                                color: inactiveTab,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: const [
                        AutoSizeText(
                          "3",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontFamily: "Work Sans",
                              fontSize: 32,
                              color: fagoSecondaryColor,
                              fontWeight: FontWeight.w700),
                        ),
                        AutoSizeText(
                          "Accounts",
                          // textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: "Work Sans",
                              fontSize: 12,
                              color: inactiveTab,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 2.h,
                ),
                Container(
                  decoration: const BoxDecoration(
                      border: Border(
                    bottom: BorderSide(width: 0.2, color: fagoGreyColor),
                  )),
                ),
                SizedBox(
                  height: 2.h,
                ),
                const AdminAccountBox(),
                SizedBox(height: 2.h,),
                const AdminAccountBox(boxColor: fagoSecondaryColorWithOpacity10,),
                SizedBox(height: 2.h,),
                const AdminAccountBox(boxColor: fagoGreenColorWithOpacity10,),
              ]),
        ),
      ),
    );
  }
}

class AdminAccountBox extends StatelessWidget {
  final Color? boxColor;
  const AdminAccountBox({
    Key? key, this.boxColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
      decoration: BoxDecoration(
          color: (boxColor != null)? boxColor :white,
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          boxShadow: const[
             BoxShadow(
                color: blackWithOpacity,
                offset: Offset.zero,
                spreadRadius: 2,
                blurRadius: 8),
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 20.h,
            decoration: const BoxDecoration(
                border: Border(right: BorderSide(width: 0.2, color: black))),
            child: Image.asset(
              "assets/images/bank_icon.png",
              width: 30,
              height: 30,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 1.h),
                decoration: const BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                  width: 0.2,
                  color: black,
                ))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 45.w,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const AutoSizeText(
                            "Sales Account",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontFamily: "Work Sans",
                                fontSize: 12,
                                color: inactiveTab,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(height: 0.3.h),
                          const AutoSizeText(
                            "2038173855 | GTB",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontFamily: "Work Sans",
                                fontSize: 18,
                                color: inactiveTab,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const AutoSizeText(
                          "No. of Transactions",
                          style: TextStyle(
                              fontFamily: "Work Sans",
                              fontSize: 12,
                              color: inactiveTab,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: 0.3.h),
                        const AutoSizeText(
                          "213",
                          style: TextStyle(
                              fontFamily: "Work Sans",
                              fontSize: 18,
                              color: inactiveTab,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 1.h),
                decoration: const BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                  width: 0.2,
                  color: black,
                ))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 45.w,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const AutoSizeText(
                            "Total Income",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontFamily: "Work Sans",
                                fontSize: 12,
                                color: inactiveTab,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(height: 0.3.h),
                          AutoSizeText(
                            "${currencySymbol}900,340.00",
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                                fontFamily: "Work Sans",
                                fontSize: 18,
                                color: inactiveTab,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const AutoSizeText(
                          "Total Withdraw",
                          style: TextStyle(
                              fontFamily: "Work Sans",
                              fontSize: 12,
                              color: inactiveTab,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: 0.3.h),
                        AutoSizeText(
                          "${currencySymbol}200,340.00",
                          style: const TextStyle(
                              fontFamily: "Work Sans",
                              fontSize: 18,
                              color: inactiveTab,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 1.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 45.w,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const AutoSizeText(
                            "Total Balance",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontFamily: "Work Sans",
                                fontSize: 12,
                                color: inactiveTab,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(height: 0.3.h),
                          AutoSizeText(
                            "${currencySymbol}700,340.00",
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                                fontFamily: "Work Sans",
                                fontSize: 18,
                                color: fagoSecondaryColor,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(height: 0.3.h),
                        const AutoSizeText(
                          "Go to Account",
                          style: TextStyle(
                              fontFamily: "Work Sans",
                              fontSize: 14,
                              color: fagoSecondaryColor,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
