import 'package:auto_size_text/auto_size_text.dart';
import '../widgets/boxes.dart';
import '../../constants/colors.dart';
import 'customer.dart';
import '../../individual/widgets/head_style_extra_pages.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomerDetails extends StatefulWidget {
  const CustomerDetails({super.key});

  @override
  State<CustomerDetails> createState() => _CustomerDetailsState();
}

class _CustomerDetailsState extends State<CustomerDetails> {
  late bool customerDetailsTab;
  late bool transactionDetailsTab;

  @override
  void initState() {
    customerDetailsTab = true;
    transactionDetailsTab = false;
    super.initState();
  }

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
                        // width: 4,
                        pageName: "Obasa Yussuf",
                        backRoute: CustomerPage(),
                        icon: "assets/images/profile-delete.png",
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      CustomerBox(
                        firstBoxDescription: "Transaction Volume",
                        firstBoxMainValue: "50,000",
                        secondBoxMainValue: "14",
                        secondBoxDescription: "No. of Transaction",
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 1.5.h, horizontal: 4.w),
                        decoration: const BoxDecoration(
                            color: fagoSecondaryColorWithOpacity10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 1.h,
                                ),
                                const AutoSizeText(
                                  "Total Debt",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: "Work Sans",
                                      fontSize: 14,
                                      color: inactiveTab,
                                      fontWeight: FontWeight.w500),
                                ),
                                const AutoSizeText(
                                  "50,000",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: "Work Sans",
                                      fontSize: 32,
                                      color: fagoSecondaryColor,
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 2.5.w, vertical: 1.h),
                              decoration: const BoxDecoration(
                                  color: fagoSecondaryColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25))),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "assets/images/biz_call.png",
                                    color: white,
                                  ),
                                  const AutoSizeText(
                                    "+447-4543-536-6",
                                    style: TextStyle(
                                        fontFamily: "Work Sans",
                                        fontSize: 10,
                                        color: white,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                customerDetailsTab = true;
                                transactionDetailsTab = false;
                              });
                            },
                            child: Container(
                              width: 40.w,
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          width: 0.5,
                                          color: (customerDetailsTab)
                                              ? fagoSecondaryColor
                                              : Colors.transparent))),
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 1.h),
                                child: const AutoSizeText(
                                  "Customer Details",
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
                                customerDetailsTab = false;
                                transactionDetailsTab = true;
                              });
                            }),
                            child: Container(
                              width: 40.w,
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          width: 0.5,
                                          color: (transactionDetailsTab)
                                              ? fagoSecondaryColor
                                              : Colors.transparent))),
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 1.h),
                                child: const AutoSizeText(
                                  "Transactions",
                                  textAlign: TextAlign.left,
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
                        height: 2.h,
                      ),
                      if (customerDetailsTab) Column(
                        children: [
                          Container(
                            width: 90.w,
                            padding: EdgeInsets.symmetric(
                                vertical: 2.h, horizontal: 4.w),
                            decoration: const BoxDecoration(
                                color: fagoSecondaryColorWithOpacity10
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 1.h,
                                ),
                                const AutoSizeText(
                                  "Email Address",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: "Work Sans",
                                      fontSize: 14,
                                      color: inactiveTab,
                                      fontWeight: FontWeight.w500),
                                ),
                                const AutoSizeText(
                                  "obasana@gmail.com",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: "Work Sans",
                                      fontSize: 14,
                                      color: fagoSecondaryColor,
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 90.w,
                            padding: EdgeInsets.symmetric(
                                vertical: 2.h, horizontal: 4.w),
                            decoration: const BoxDecoration(
                                border: Border(
                                  top: BorderSide(
                                    color: black,
                                    width: 0.2,
                                  )
                                ),
                                color: fagoSecondaryColorWithOpacity10
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 1.h,
                                ),
                                const AutoSizeText(
                                  "Address",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: "Work Sans",
                                      fontSize: 14,
                                      color: inactiveTab,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  width: 70.w,
                                  child: const AutoSizeText(
                                    "12, adjascent KFC, Ikoyi estate, island Lagos, Nigeria",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontFamily: "Work Sans",
                                        fontSize: 14,
                                        color: fagoSecondaryColor,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      if ( transactionDetailsTab ) SizedBox(
                        width: 90.w,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 1.5.h),
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    width: 0.2,
                                    color: black,
                                  )
                                )
                              ),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const AutoSizeText(
                                      "Transactions",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: "Work Sans",
                                          fontSize: 20,
                                          color: inactiveTab,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    GestureDetector(
                                      child: const AutoSizeText(
                                        "View all",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: "Work Sans",
                                            fontSize: 10,
                                            color: fagoSecondaryColor,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),

                                  ],
                              )                            
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            for( var i = 0; i < 4; i++ ) ...[ 
                              SizedBox(
                              width: 90.w,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 50.w,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Image.asset('assets/images/Group 88.png', width: 8.w, height: 5.h,),
                                        SizedBox(width: 2.w,),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children:  [
                                            const AutoSizeText(
                                              "Website Development",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontFamily: "Work Sans",
                                                  fontSize: 14,
                                                  color: inactiveTab,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            SizedBox(height: 0.5.h,),
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
                                    children:  [
                                      const AutoSizeText(
                                        "NGN 500",
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                            fontFamily: "Work Sans",
                                            fontSize: 10,
                                            color: fagoSecondaryColor,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      SizedBox(height: 0.5.h,),
                                       Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 2.w, vertical: 1.h),
                                        decoration: const BoxDecoration(
                                            color: fagoGreenColorWithOpacity10,
                                            borderRadius:
                                                BorderRadius.all(Radius.circular(25))),
                                        child: const AutoSizeText(
                                            "Fully Paid",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontFamily: "Work Sans",
                                                fontSize: 8,
                                                color: fagoGreenColor,
                                                fontWeight: FontWeight.w400),
                                          ),
                                       )
                                    ],
                                  )
                                ],
                              )
                            ),
                            SizedBox(height: 2.h,)
                            ]

                          ] 
                        ),
                      )

                    ]))));
  }
}
