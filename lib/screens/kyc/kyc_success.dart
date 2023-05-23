// ignore_for_file: camel_case_types

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../controllers/user_controller.dart';
import '../constants/colors.dart';
import '../individual/home/dashboard_home.dart';

class kyc_success extends StatelessWidget {
  const kyc_success({super.key});

  @override
  Widget build(BuildContext context) {
    final userUcontroller = Get.find<UserController>();
    return Scaffold(
      body: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 5.w),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 50.w,
                child: const AutoSizeText(
                  "KYC Successful",
                  style: TextStyle(
                    fontFamily: "Work Sans",
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: fagoSecondaryColor,
                  ),
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
               Text(
                "Hello ${userUcontroller.user!.firstName}! Congratulations ",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  fontFamily: "Work Sans",
                  fontWeight: FontWeight.w700,
                  color: fagoSecondaryColor,
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              const Text(
                "You can now enjoy more services and we encourage you to upgrade to a higher Tier to access more of our product offers.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: "Work Sans",
                  fontWeight: FontWeight.w400,
                  color: black,
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
               Stack(
                alignment: AlignmentDirectional.center,
                children: const [
                  Positioned(
                    child: Image(image: AssetImage("assets/images/Group.png")),
                  ),
                ],
              ),
              SizedBox(
                height: 9.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.w, right: 10.w),
                child: SizedBox(
                  width: 70.w,
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => DashboardHome(
                            userDetails: userUcontroller.user!,
                            accountDetails: userUcontroller.userAccountDetails,
                          ),
                        ),
                        (Route<dynamic> route) => false),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 2.h, horizontal: 3.w),
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                          color: buttonColor,
                          borderRadius: BorderRadius.all(Radius.circular(25))),
                      child:  Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          AutoSizeText(
                            "Continue",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: "Work Sans",
                                fontWeight: FontWeight.w600,
                                color: white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
