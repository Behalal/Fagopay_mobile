import 'package:auto_size_text/auto_size_text.dart';
import '../widgets/boxes.dart';
import '../widgets/load_more.dart';
import '../../constants/colors.dart';
import 'add_customers.dart';
import 'customer_details.dart';
import '../../functions.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomerPage extends StatefulWidget {
  const CustomerPage({super.key});

  @override
  State<CustomerPage> createState() => _CustomerPageState();
}

class _CustomerPageState extends State<CustomerPage> {
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
                    // ProgressStyle(
                    //   stage: 0,
                    //   pageName: "My Customers",
                    //   backRoute: BusinessHome(
                    //     userDetails: userFullDetails,
                    //   ),
                    // ),
                    SizedBox(
                      height: 3.h,
                    ),
                    GestureDetector(
                      onTap: () {
                        goToPage(context, const AddCustomer());
                      },
                      child: Padding(
                        padding: EdgeInsets.only(left: 53.w, right: 2.w),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 4.w, vertical: 1.h),
                          decoration: const BoxDecoration(
                              color: fagoSecondaryColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25))),
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
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    CustomerBox(
                      firstBoxImage: "assets/images/customers.png",
                      secondBoxImage: "assets/images/biz_transactions.png",
                      firstBoxDescription: "No. of Customers",
                      firstBoxMainValue: "234",
                      secondBoxMainValue: "234",
                      secondBoxDescription: "Total Transaction Value",
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const AutoSizeText(
                          "My Favorite Customers",
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                              fontFamily: "Work Sans",
                              fontSize: 14,
                              color: inactiveTab,
                              fontWeight: FontWeight.w500),
                        ),
                        Image.asset("assets/images/tranactions.png")
                      ],
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Scrollbar(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (var i = 0; i < 10; i++) ...[
                            Container(
                              decoration: const BoxDecoration(
                                  border: Border(
                                bottom: BorderSide(width: 0.2, color: black),
                              )),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 43.w,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 2.w, vertical: 2.h),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                            "assets/images/customer_pic.png"),
                                        InkWell(
                                          onTap: () {
                                            goToPage(context,
                                                const CustomerDetails());
                                          },
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: 1.h,
                                              ),
                                              const AutoSizeText(
                                                "Obasa Yussuf",
                                                textAlign: TextAlign.justify,
                                                style: TextStyle(
                                                    fontFamily: "Work Sans",
                                                    fontSize: 16,
                                                    color: inactiveTab,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              SizedBox(
                                                height: 1.h,
                                              ),
                                              const AutoSizeText(
                                                "Obasa@gmail.com",
                                                textAlign: TextAlign.justify,
                                                style: TextStyle(
                                                    fontFamily: "Work Sans",
                                                    fontSize: 12,
                                                    color: inactiveTab,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: 43.w,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 2.w, vertical: 2.h),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: 1.h,
                                            ),
                                            RichText(
                                              text: const TextSpan(
                                                style: TextStyle(
                                                  fontFamily: "Work Sans",
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w700,
                                                  color: fagoSecondaryColor,
                                                ),
                                                children: [
                                                  TextSpan(
                                                      text: 'CR:',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w400)),
                                                  TextSpan(
                                                    text: 'NGN 500',
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 0.5.h,
                                            ),
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 1.w,
                                                  vertical: 0.5.h),
                                              decoration: const BoxDecoration(
                                                  color:
                                                      fagoGreenColorWithOpacity10,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(25))),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Image.asset(
                                                      "assets/images/biz_call.png"),
                                                  const AutoSizeText(
                                                    "+447-4543-536-6",
                                                    style: TextStyle(
                                                        fontFamily: "Work Sans",
                                                        fontSize: 10,
                                                        color: fagoGreenColor,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Image.asset("assets/images/edit.png"),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )
                          ]
                        ],
                      ),
                    )
                  ])),
        ),
        bottomNavigationBar: const LoadMore()
        
      );
  }
}


