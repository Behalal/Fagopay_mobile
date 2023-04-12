import 'package:auto_size_text/auto_size_text.dart';
import '../widgets/load_more.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../controllers/user_controller.dart';
import '../../constants/colors.dart';
import '../../constants/currency.dart';
import '../../individual/widgets/head_style_extra_pages.dart';
import '../home/home.dart';

class AllSales extends StatefulWidget {
  const AllSales({super.key});

  @override
  State<AllSales> createState() => _AllSalesState();
}

class _AllSalesState extends State<AllSales> {
  final _userController = Get.find<UserController>();
  List sort = [
    {'type': 'Last 7 Days', 'value': '7'},
    {'type': 'Yesterday', 'value': '1'},
    {'type': 'Last 14 Days', 'value': '14'},
    {'type': '1 Month', 'value': '60'},
    {'type': '6 Month', 'value': '6 mth'},
    {'type': '1 Year', 'value': '1 yr'},
  ];

  bool inflowTab = true;

  String? selectedSort;
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
              ProgressStyle(
                stage: 0,
                pageName: "Sales Account",
                // backRoute: BusinessHome(
                //   userDetails: _userController.user!,
                //   accountDetails: _userController.userAccountDetails!,
                // ),
              ),
              SizedBox(
                height: 1.5.h,
              ),
              const AutoSizeText(
                "Account Details",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: "Work Sans",
                    fontSize: 14,
                    color: inactiveTab,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 1.5.h,
              ),
              SizedBox(
                width: 90.w,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 1.2.h,
                        horizontal: 5.w,
                      ),
                      decoration: const BoxDecoration(
                        color: fagoSecondaryColorWithOpacity10,
                      ),
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
                                  style: TextStyle(
                                      fontFamily: "Work Sans",
                                      fontSize: 12,
                                      color: inactiveTab,
                                      fontWeight: FontWeight.w500),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const AutoSizeText(
                                      "2038173855 | GTB",
                                      style: TextStyle(
                                          fontFamily: "Work Sans",
                                          fontSize: 18,
                                          color: fagoSecondaryColor,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Image.asset(
                                      "assets/images/copy.png",
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 2.5.h,
                                ),
                                const AutoSizeText(
                                  "Total Inflow",
                                  style: TextStyle(
                                    fontFamily: "Work Sans",
                                    fontSize: 12,
                                    color: inactiveTab,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                AutoSizeText(
                                  "${currencySymbol}900,340.00",
                                  style: const TextStyle(
                                    fontFamily: "Work Sans",
                                    fontSize: 18,
                                    color: fagoSecondaryColor,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 35.w,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  width: 30.w,
                                  height: 5.h,
                                  decoration: const BoxDecoration(
                                    color: white,
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: ButtonTheme(
                                      alignedDropdown: true,
                                      child: DropdownButton(
                                        style: const TextStyle(
                                          fontFamily: "Work Sans",
                                          fontWeight: FontWeight.w400,
                                          fontSize: 10,
                                          color: black,
                                        ),
                                        isDense: true,
                                        hint: const Text("All"),
                                        value: selectedSort,
                                        onChanged: (value) {
                                          setState(() {
                                            if (value != null) {
                                              selectedSort = value;
                                            } else {
                                              selectedSort = null;
                                            }
                                          });
                                        },
                                        items: sort.map((eachsort) {
                                          return DropdownMenuItem<String>(
                                            value: eachsort['value'],
                                            child: Text(eachsort['type']),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 1.3.h,
                                ),
                                const AutoSizeText(
                                  "Total Inflow",
                                  style: TextStyle(
                                    fontFamily: "Work Sans",
                                    fontSize: 12,
                                    color: inactiveTab,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                AutoSizeText(
                                  "${currencySymbol}900,340.00",
                                  style: const TextStyle(
                                    fontFamily: "Work Sans",
                                    fontSize: 18,
                                    color: fagoSecondaryColor,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 90.w,
                      padding: EdgeInsets.symmetric(
                        vertical: 1.5.h,
                        horizontal: 5.w,
                      ),
                      decoration: const BoxDecoration(
                        color: fagoSecondaryColorWithOpacity10,
                        border: Border(
                          top: BorderSide(
                            width: 0.2,
                            color: fagoGreyColor,
                          ),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const AutoSizeText(
                            "Total Inflow",
                            style: TextStyle(
                              fontFamily: "Work Sans",
                              fontSize: 12,
                              color: inactiveTab,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          AutoSizeText(
                            "${currencySymbol}700,340.00",
                            style: const TextStyle(
                              fontFamily: "Work Sans",
                              fontSize: 18,
                              color: fagoSecondaryColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 1.5.h,
              ),
              const AutoSizeText(
                "Manage by",
                style: TextStyle(
                  fontFamily: "Work Sans",
                  fontSize: 14,
                  color: inactiveTab,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 1.5.h,
              ),
              Container(
                width: 90.w,
                padding: EdgeInsets.symmetric(
                  vertical: 1.5.h,
                  horizontal: 5.w,
                ),
                decoration: const BoxDecoration(
                  color: fagoSecondaryColorWithOpacity10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 40.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 3.h,
                            child: CircleAvatar(
                              backgroundColor: fagoSecondaryColorWithOpacity10,
                              child: Image.asset("assets/images/gallery.png"),
                            ),
                          ),
                          const AutoSizeText(
                            "Obasa Yussuf",
                            style: TextStyle(
                                fontFamily: "Work Sans",
                                fontSize: 16,
                                color: inactiveTab,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 3.w, vertical: 1.h),
                          decoration: const BoxDecoration(
                              color: fagoSecondaryColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25))),
                          child: const AutoSizeText(
                            "View profile",
                            style: TextStyle(
                              fontFamily: "Work Sans",
                              fontSize: 10,
                              color: white,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (!inflowTab) {
                          inflowTab = !inflowTab;
                        }
                      });
                    },
                    child: Container(
                      width: 40.w,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                              width: 0.3,
                              color: (inflowTab)
                                  ? fagoSecondaryColor
                                  : Colors.transparent),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 1.h),
                        child: const AutoSizeText(
                          "Inflow",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: "Work Sans",
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: inactiveTab,
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (() {
                      setState(() {
                        if (inflowTab) {
                          inflowTab = !inflowTab;
                        }
                      });
                    }),
                    child: Container(
                      width: 40.w,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                              width: 0.3,
                              color: (!inflowTab)
                                  ? fagoSecondaryColor
                                  : Colors.transparent),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 1.h),
                        child: const AutoSizeText(
                          "Outflow",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: "Work Sans",
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: inactiveTab,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 1.5.h,
              ),
              if (inflowTab)
                SizedBox(
                  width: 90.w,
                  height: 50.h,
                  child: ListView(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: const AlwaysScrollableScrollPhysics(),
                    children: [
                      for (var i = 0; i < 10; i++) ...[
                        SizedBox(
                          width: 90.w,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 45.w,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/images/Group 88.png',
                                      // width: 8.w,
                                    ),
                                    SizedBox(
                                      width: 2.w,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const AutoSizeText(
                                          "Website Development",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: "Work Sans",
                                              fontSize: 14,
                                              color: inactiveTab,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        SizedBox(
                                          height: 0.5.h,
                                        ),
                                        const AutoSizeText(
                                          "24 Mar 2023",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: "Work Sans",
                                              fontSize: 12,
                                              color: inactiveTab,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const AutoSizeText(
                                    "NGN 500",
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        fontFamily: "Work Sans",
                                        fontSize: 10,
                                        color: fagoSecondaryColor,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  SizedBox(
                                    height: 0.5.h,
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 2.w, vertical: 1.h),
                                    decoration: const BoxDecoration(
                                        color: fagoGreenColorWithOpacity10,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(25))),
                                    child: const AutoSizeText(
                                      "Fully Paid",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: "Work Sans",
                                          fontSize: 8,
                                          color: fagoGreenColor,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        if (i != 5)
                          SizedBox(
                            height: 2.5.h,
                          ),
                      ],
                    ],
                  ),
                ),
              if (!inflowTab)
                SizedBox(
                  width: 90.w,
                  height: 50.h,
                  child: ListView(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: const AlwaysScrollableScrollPhysics(),
                    children: [
                      for (var i = 0; i < 10; i++) ...[
                        SizedBox(
                          width: 90.w,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 45.w,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/images/Group 88.png',
                                      // width: 8.w,
                                    ),
                                    SizedBox(
                                      width: 2.w,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const AutoSizeText(
                                          "Website Development",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: "Work Sans",
                                              fontSize: 14,
                                              color: inactiveTab,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        SizedBox(
                                          height: 0.5.h,
                                        ),
                                        const AutoSizeText(
                                          "24 Mar 2023",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: "Work Sans",
                                              fontSize: 12,
                                              color: inactiveTab,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const AutoSizeText(
                                    "NGN 500",
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        fontFamily: "Work Sans",
                                        fontSize: 10,
                                        color: fagoSecondaryColor,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  SizedBox(
                                    height: 0.5.h,
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 2.w, vertical: 1.h),
                                    decoration: const BoxDecoration(
                                        color: fagoGreenColorWithOpacity10,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(25))),
                                    child: const AutoSizeText(
                                      "Fully Paid",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: "Work Sans",
                                        fontSize: 8,
                                        color: fagoGreenColor,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        if (i != 5)
                          SizedBox(
                            height: 2.5.h,
                          ),
                      ],
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const LoadMore(),
    );
  }
}
