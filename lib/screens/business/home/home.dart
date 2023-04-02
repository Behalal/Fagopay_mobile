import 'package:auto_size_text/auto_size_text.dart';
import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../models/user_model/user.dart';
import '../../constants/colors.dart';
import '../../constants/currency.dart';
import '../../functions.dart';
import '../../individual/widgets/navigation_bar.dart';
import 'models/actions.model.dart';
import 'models/sales.model.dart';

class BusinessHome extends StatefulWidget {
  User userDetails;
  BusinessHome({super.key, required this.userDetails});

  @override
  State<BusinessHome> createState() => _BusinessHomeState();
}

class _BusinessHomeState extends State<BusinessHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            // DashBoardDetails(
            //   firstname: widget.userDetails.firstName ,
            //   accountType: 1,
            //   accountDetails: widget.userDetails.accountDetails,
            // ),
            SizedBox(
              height: 2.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 9.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const AutoSizeText(
                    "Accounts",
                    style: TextStyle(
                        fontFamily: "Work Sans",
                        fontSize: 18,
                        color: inactiveTab,
                        fontWeight: FontWeight.w500),
                  ),
                  Container(
                    // width: 106,
                    padding:
                        EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                    decoration: const BoxDecoration(
                        color: fagoSecondaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(25))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset("assets/images/add_grp.png"),
                        SizedBox(
                          width: 1.5.w,
                        ),
                        const AutoSizeText(
                          "Add Account",
                          style: TextStyle(
                              fontFamily: "Work Sans",
                              fontSize: 10,
                              color: white,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 2.w,
            ),
            Padding(
              padding: EdgeInsets.only(left: 4.w),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    for (int i = 0; i < salesContent.length; i++) ...[
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 2.w, vertical: 1.5.h),
                        decoration: const BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            boxShadow: [
                              BoxShadow(
                                  color: blackWithOpacity,
                                  offset: Offset.zero,
                                  spreadRadius: 2,
                                  blurRadius: 8),
                            ]),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset("assets/images/bank_icon.png"),
                            SizedBox(width: 2.w),
                            Container(
                              height: 53,
                              decoration: DottedDecoration(
                                  color: blackWithOpacity5,
                                  dash: [2, 2, 2],
                                  linePosition: LinePosition.right),
                            ),
                            SizedBox(width: 2.w),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const AutoSizeText(
                                  "Sales Account",
                                  style: TextStyle(
                                      fontFamily: "Work Sans",
                                      fontSize: 12,
                                      color: inactiveTab,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(height: 1.h),
                                const AutoSizeText(
                                  "2038173855 | GTB",
                                  style: TextStyle(
                                      fontFamily: "Work Sans",
                                      fontSize: 12,
                                      color: inactiveTab,
                                      fontWeight: FontWeight.w400),
                                ),
                                SizedBox(height: 1.h),
                                AutoSizeText(
                                  "${currencySymbol}900,340.00",
                                  style: const TextStyle(
                                      fontFamily: "Work Sans",
                                      fontSize: 18,
                                      color: black,
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      if (i != (salesContent.length - 1))
                        SizedBox(
                          width: 2.5.w,
                        )
                    ]
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 9.w),
              child: const AutoSizeText(
                "Quick Actions",
                style: TextStyle(
                    fontFamily: "Work Sans",
                    fontSize: 18,
                    color: inactiveTab,
                    fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(
              height: 1.h,
            ),
            SafeArea(
              top: false,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.w),
                child: GridView.count(
                  padding: EdgeInsets.zero, // set padding to zero
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisCount: 3,
                  children: [
                    for (int i = 0; i < actionContents.length; i++) ...[
                      GestureDetector(
                        onTap: () {
                          if (actionContents[i].route != null) {
                            goToPage(context, actionContents[i].route!);
                          }
                        },
                        child: SizedBox(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(actionContents[i].actionImage),
                              SizedBox(
                                height: 1.h,
                              ),
                              AutoSizeText(
                                actionContents[i].actionText,
                                style: const TextStyle(
                                    fontFamily: "Work Sans",
                                    fontSize: 12,
                                    color: inactiveTab,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ]
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 1.h,
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                child: const Image(
                  image: AssetImage("assets/images/Frame 256.png"),
                ))
          ])),
      bottomNavigationBar: const FagoNavigationBar(),
    );
  }
}
