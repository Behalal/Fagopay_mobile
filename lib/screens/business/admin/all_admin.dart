import 'package:auto_size_text/auto_size_text.dart';
import 'package:fagopay/screens/business/widgets/load_more.dart';
import '../../../models/user_model/user.dart';
import '../../constants/colors.dart';
import 'add_admin.dart';
import 'admin_details.dart';
import '../customers/add_customers.dart';
import '../home/home.dart';
import '../../individual/widgets/head_style_extra_pages.dart';
import '../../functions.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AllAdmin extends StatefulWidget {
  const AllAdmin({super.key});

  @override
  State<AllAdmin> createState() => _AllAdminState();
}

class _AllAdminState extends State<AllAdmin> {
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
                      //   width: 4,
                      //   pageName: "Account Admins",
                      //   backRoute: BusinessHome(
                      //     userDetails: userFullDetails,
                      //   ),
                      // ),
                      SizedBox(
                        height: 3.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset("assets/images/profile-tick.png"),
                                  const AutoSizeText(
                                    "14",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: fagoSecondaryColor,
                                        fontSize: 32,
                                        fontFamily: "Work Sans",
                                        fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                              const AutoSizeText(
                                "No. of Admins",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: inactiveTab,
                                    fontSize: 12,
                                    fontFamily: "Work Sans",
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              goToPage(context, const AddAdmin());
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 4.w, vertical: 1.h),
                              decoration: const BoxDecoration(
                                  color: fagoSecondaryColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25))),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset("assets/images/add_grp.png"),
                                  SizedBox(
                                    width: 1.5.w,
                                  ),
                                  const AutoSizeText(
                                    "Add Admin",
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
                        ],
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      for (var i = 0; i < 6; i++) ...[
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 1.5.h),
                          decoration: const BoxDecoration(
                              border: Border(
                                  top: BorderSide(
                                      width: 0.5, color: fagoGreyColor))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 50,
                                    height: 50,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: AssetImage(
                                              "assets/images/user_image.png"),
                                          fit: BoxFit.fill),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 2.w,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const AutoSizeText(
                                        "Obasa Yussuff",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: "Nunito",
                                            fontSize: 14,
                                            color: inactiveTab,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      SizedBox(
                                        height: 0.5.h,
                                      ),
                                      const AutoSizeText(
                                        "1 account (Savings)",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: "Nunito",
                                            fontSize: 12,
                                            color: fagoGreyColor,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: () {
                                  goToPage(context, const AdminDetails());
                                },
                                child: const AutoSizeText(
                                  "Details",
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                      fontFamily: "Nunito",
                                      fontSize: 14,
                                      color: fagoSecondaryColor,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 1.5.h,
                        ),
                      ]
                    ]))),
        bottomNavigationBar: const LoadMore());
  }
}

