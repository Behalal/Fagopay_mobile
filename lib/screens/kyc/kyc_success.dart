import 'package:auto_size_text/auto_size_text.dart';
import 'package:fagopay/controllers/user_controller.dart';
import 'package:fagopay/models/user_model/user.dart';
import 'package:fagopay/screens/individual/home/dashboard_home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../constants/colors.dart';

class kyc_success extends StatelessWidget {
  const kyc_success({super.key});

  @override
  Widget build(BuildContext context) {
    final _userUcontroller = Get.find<UserController>();
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
              const Text(
                "Hello Ibrahim! Congratulations ",
                textAlign: TextAlign.center,
                style: TextStyle(
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
                height: 4.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 22.w),
                child: SizedBox(
                  width: 70.w,
                  child: GestureDetector(
                    onTap: () {
                      Get.to(() => DashboardHome(
                            userDetails: _userUcontroller.user!,
                          ));
                    },
                    child: const AutoSizeText(
                      "Go Back To HomePage",
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontFamily: "Work Sans",
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: fagoSecondaryColor,
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
